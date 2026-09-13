; Audio fade controller.

IF DEF(_REV0)
    ASSERT @ == $139C
ELIF DEF(_REVA)
    ASSERT @ == $138A
ENDC
FadeOutAudio::
    ld a, [wAudioFadeOutControl]
    and a
    jr nz, .fadingOut
    ld a, [wStatusFlags2]
    bit BIT_NO_AUDIO_FADE_OUT, a
    ret nz
    ld a, $77
    ldh [rAUDVOL], a
    ret
.fadingOut
    ld a, [wAudioFadeOutCounter]
    and a
    jr z, .counterReachedZero
    dec a
    ld [wAudioFadeOutCounter], a
    ret
.counterReachedZero
    ld a, [wAudioFadeOutCounterReloadValue]
    ld [wAudioFadeOutCounter], a
    ldh a, [rAUDVOL]
    and a
    jr z, .fadeOutComplete
    ld b, a
    and $0F
    dec a
    ld c, a
    ld a, b
    and $F0
    swap a
    dec a
    swap a
    or c
    ldh [rAUDVOL], a
    ret
.fadeOutComplete
    ld a, [wAudioFadeOutControl]
    ld b, a
    xor a
    ld [wAudioFadeOutControl], a
    ld a, SFX_STOP_ALL_MUSIC
    ld [wNewSoundID], a
    call PlaySound
    ld a, [wAudioSavedROMBank]
    ld [wAudioROMBank], a
    ld a, b
    ld [wNewSoundID], a
    jp PlaySound

IF DEF(_REV0)
    ASSERT @ == $13F1
ELIF DEF(_REVA)
    ASSERT @ == $13DF
ENDC
