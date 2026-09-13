; Timer entry through the sprite-update handoff.
; The code is structurally shared; Rev A is shifted by $12 because its serial
; layout is shorter.

IF DEF(_REV0)
    ASSERT @ == $0D9A
ELIF DEF(_REVA)
    ASSERT @ == $0D88
ENDC
Timer::
    reti

PlayDefaultMusic::
    call BANK00_WAIT_FOR_SOUND_ADDR
    xor a
    ld c, a
    ld d, a
    ld [wLastMusicSoundID], a
    jr PlayDefaultMusicCommon

IF DEF(_REV0)
    ASSERT @ == $0DA6
ELIF DEF(_REVA)
    ASSERT @ == $0D94
ENDC
PlayDefaultMusicFadeOutCurrent::
    ld c, 10
    ld d, 0
    ld a, [wStatusFlags4]
    bit BIT_BATTLE_OVER_OR_BLACKOUT, a
    jr z, PlayDefaultMusicCommon
    xor a
    ld [wLastMusicSoundID], a
    ld c, 8
    ld d, c

IF DEF(_REV0)
    ASSERT @ == $0DB8
ELIF DEF(_REVA)
    ASSERT @ == $0DA6
ENDC
PlayDefaultMusicCommon::
    ld a, [wWalkBikeSurfState]
    and a
    jr z, .walking
    cp 2
    jr z, .surfing
    ld a, MUSIC_BIKE_RIDING
    jr .next

.surfing
    ld a, MUSIC_SURFING

.next
    ld b, a
    ld a, d
    and a
    ld a, AUDIO_BANK_BIKE_SURF
    jr nz, .next2
    ld [wAudioROMBank], a
.next2
    ld [wAudioSavedROMBank], a
    jr .next3

.walking
    ld a, [wMapMusicSoundID]
    ld b, a
    call CompareMapMusicBankWithCurrentBank
    jr c, .next4

.next3
    ld a, [wLastMusicSoundID]
    cp b
    ret z
.next4
    ld a, c
    ld [wAudioFadeOutControl], a
    ld a, b
    ld [wLastMusicSoundID], a
    ld [wNewSoundID], a
    jp PlaySound

IF DEF(_REV0)
    ASSERT @ == $0DF3
ELIF DEF(_REVA)
    ASSERT @ == $0DE1
ENDC
UpdateMusic6Times::
    ld a, [wAudioROMBank]
    ld b, a
    cp AUDIO_BANK_1
    jr nz, .checkForAudio2
    ld hl, BANK00_AUDIO1_UPDATE_ADDR
    jr .next
.checkForAudio2
    cp AUDIO_BANK_2
    jr nz, .audio3
    ld hl, BANK00_AUDIO2_UPDATE_ADDR
    jr .next
.audio3
    ld hl, BANK00_AUDIO3_UPDATE_ADDR
.next
    ld c, 6
.loop
    push bc
    push hl
    call BANK00_FARCALL_ADDR
    pop hl
    pop bc
    dec c
    jr nz, .loop
    ret

IF DEF(_REV0)
    ASSERT @ == $0E19
ELIF DEF(_REVA)
    ASSERT @ == $0E07
ENDC
CompareMapMusicBankWithCurrentBank::
    ld a, [wMapMusicROMBank]
    ld e, a
    ld a, [wAudioROMBank]
    cp e
    jr nz, .differentBanks
    ld [wAudioSavedROMBank], a
    and a
    ret
.differentBanks
    ld a, c
    and a
    ld a, e
    jr nz, .next
    ld [wAudioROMBank], a
.next
    ld [wAudioSavedROMBank], a
    scf
    ret

IF DEF(_REV0)
    ASSERT @ == $0E35
ELIF DEF(_REVA)
    ASSERT @ == $0E23
ENDC
PlayMusic::
    ld b, a
    ld [wNewSoundID], a
    xor a
    ld [wAudioFadeOutControl], a
    ld a, c
    ld [wAudioROMBank], a
    ld [wAudioSavedROMBank], a
    ld a, b

IF DEF(_REV0)
    ASSERT @ == $0E45
ELIF DEF(_REVA)
    ASSERT @ == $0E33
ENDC
PlaySound::
    push hl
    push de
    push bc
    ld b, a
    ld a, [wNewSoundID]
    and a
    jr z, .next
    xor a
    ld [wChannelSoundIDs + CHAN5], a
    ld [wChannelSoundIDs + CHAN6], a
    ld [wChannelSoundIDs + CHAN7], a
    ld [wChannelSoundIDs + CHAN8], a
.next
    ld a, [wAudioFadeOutControl]
    and a
    jr z, .noFadeOut
    ld a, [wNewSoundID]
    and a
    jr z, .done
    xor a
    ld [wNewSoundID], a
    ld a, [wLastMusicSoundID]
    cp $FF
    jr nz, .fadeOut
    xor a
    ld [wAudioFadeOutControl], a
.noFadeOut
    xor a
    ld [wNewSoundID], a
    ldh a, [hLoadedROMBank]
    ldh [hSavedROMBank], a
    ld a, [wAudioROMBank]
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    cp AUDIO_BANK_1
    jr nz, .checkForAudio2
    ld a, b
    call BANK00_AUDIO1_PLAY_SOUND_ADDR
    jr .next2
.checkForAudio2
    cp AUDIO_BANK_2
    jr nz, .audio3
    ld a, b
    call BANK00_AUDIO2_PLAY_SOUND_ADDR
    jr .next2
.audio3
    ld a, b
    call BANK00_AUDIO3_PLAY_SOUND_ADDR
.next2
    ldh a, [hSavedROMBank]
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    jr .done
.fadeOut
    ld a, b
    ld [wLastMusicSoundID], a
    ld a, [wAudioFadeOutControl]
    ld [wAudioFadeOutCounterReloadValue], a
    ld [wAudioFadeOutCounter], a
    ld a, b
    ld [wAudioFadeOutControl], a
.done
    pop bc
    pop de
    pop hl
    ret

IF DEF(_REV0)
    ASSERT @ == $0EBD
ELIF DEF(_REVA)
    ASSERT @ == $0EAB
ENDC
