; $0AAC-$0B3B
; VBlank interrupt handler and one-frame delay helper.

ASSERT @ == $0AAC
VBlank::
    push af
    push bc
    push de
    push hl

    ldh a, [hLoadedROMBank]
    ld [wVBlankSavedROMBank], a

    ldh a, [hSCX]
    ldh [rSCX], a
    ldh a, [hSCY]
    ldh [rSCY], a

    ld a, [wDisableVBlankWYUpdate]
    and a
    jr nz, .ok
    ldh a, [hWY]
    ldh [rWY], a
.ok
    call AutoBgMapTransfer
    call VBlankCopyBgMap
    call RedrawRowOrColumn
    call VBlankCopy
    call VBlankCopyDouble
    call UpdateMovingBgTiles
    call hDMARoutine

    ld a, $01 ; BANK(PrepareOAMData)
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    call BANK00_PREPARE_OAM_DATA_ADDR

    call BANK00_RANDOM_ADDR

    ldh a, [hVBlankOccurred]
    and a
    jr z, .skipZeroing
    xor a
    ldh [hVBlankOccurred], a
.skipZeroing
    ldh a, [hFrameCounter]
    and a
    jr z, .skipDec
    dec a
    ldh [hFrameCounter], a
.skipDec
    call BANK00_FADE_OUT_AUDIO_ADDR

    ld a, [wAudioROMBank]
    ldh [hLoadedROMBank], a
    ld [rROMB], a

    cp $02 ; BANK(Audio1_UpdateMusic)
    jr nz, .checkForAudio2
.audio1
    call BANK00_AUDIO1_UPDATE_ADDR
    jr .afterMusic
.checkForAudio2
    cp $08 ; BANK(Audio2_UpdateMusic)
    jr nz, .audio3
.audio2
    call BANK00_MUSIC_LOW_HEALTH_ADDR
    call BANK00_AUDIO2_UPDATE_ADDR
    jr .afterMusic
.audio3
    call BANK00_AUDIO3_UPDATE_ADDR
.afterMusic

    ; farcall TrackPlayTime: bank 6, address $4DEE.
    ld b, $06
    ld hl, BANK00_TRACK_PLAY_TIME_ADDR
    call BANK00_TRACK_PLAY_TIME_FARCALL_ADDR

    ld a, [wVBlankSavedROMBank]
    ldh [hLoadedROMBank], a
    ld [rROMB], a

    pop hl
    pop de
    pop bc
    pop af
    reti

ASSERT @ == $0B31
DelayFrame::
    ld a, 1
    ldh [hVBlankOccurred], a
.halt
    halt
    ldh a, [hVBlankOccurred]
    and a
    jr nz, .halt
    ret

ASSERT @ == $0B3C
