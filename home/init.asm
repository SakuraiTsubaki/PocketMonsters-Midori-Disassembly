; $09CF-$0AAB
; Soft reset, program initialization, VRAM clearing and audio reset.

ASSERT @ == $09CF
SoftReset::
    call StopAllSounds
    call BANK00_GB_PAL_WHITE_OUT_ADDR
    ld c, 32
    call BANK00_DELAY_FRAMES_ADDR
    ; fall through

ASSERT @ == $09DA
Init::
    di

    xor a
    ldh [rIF], a
    ldh [rIE], a
    ldh [rSCX], a
    ldh [rSCY], a
    ldh [rSB], a
    ldh [rSC], a
    ldh [rWX], a
    ldh [rWY], a
    ldh [rTMA], a
    ldh [rTAC], a
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a

    ld a, LCDC_ON
    ldh [rLCDC], a
    call DisableLCD

    ld sp, wStack

    ld hl, $C000
    ld bc, $2000
.loop
    ld [hl], 0
    inc hl
    dec bc
    ld a, b
    or c
    jr nz, .loop

    call ClearVram

    ld hl, $FF80
    ld bc, $007F
    call BANK00_FILL_MEMORY_ADDR

    call ClearSprites

    ld a, $01 ; BANK(WriteDMACodeToHRAM)
    ldh [hLoadedROMBank], a
    ld [rROMB], a
    call BANK00_WRITE_DMA_CODE_ADDR

    xor a
    ldh [hTileAnimations], a
    ldh [rSTAT], a
    ldh [hSCX], a
    ldh [hSCY], a
    ldh [rIF], a
    ld a, IE_VBLANK | IE_TIMER | IE_SERIAL
    ldh [rIE], a

    ld a, 144
    ldh [hWY], a
    ldh [rWY], a
    ld a, 7
    ldh [rWX], a

    ld a, $FF ; CONNECTION_NOT_ESTABLISHED
    ldh [hSerialConnectionStatus], a

    ld h, HIGH(vBGMap0)
    call ClearBgMap
    ld h, HIGH(vBGMap1)
    call ClearBgMap

    ld a, LCDC_DEFAULT
    ldh [rLCDC], a
    ld a, 16
    ldh [hSoftReset], a
    call StopAllSounds

    ei

    ld a, $40 ; PREDEF LoadSGB
    call BANK00_PREDEF_ADDR

    ld a, $1F ; BANK(SFX_Shooting_Star)
    ld [wAudioROMBank], a
    ld [wAudioSavedROMBank], a
    ld a, HIGH(vBGMap1)
    ld [hAutoBGTransferDest + 1], a
    xor a
    ld [hAutoBGTransferDest], a
    dec a
    ld [wUpdateSpritesEnabled], a

    ld a, $32 ; PREDEF PlayIntro
    call BANK00_PREDEF_ADDR

    call DisableLCD
    call ClearVram
    call BANK00_GB_PAL_NORMAL_ADDR
    call ClearSprites
    ld a, LCDC_DEFAULT
    ldh [rLCDC], a

    jp BANK00_PREPARE_TITLE_SCREEN_ADDR

ASSERT @ == $0A8C
ClearVram::
    ld hl, $8000
    ld bc, $2000
    xor a
    jp BANK00_FILL_MEMORY_ADDR

ASSERT @ == $0A96
StopAllSounds::
    ld a, $02 ; BANK("Audio Engine 1")
    ld [wAudioROMBank], a
    ld [wAudioSavedROMBank], a
    xor a
    ld [wAudioFadeOutControl], a
    ld [wNewSoundID], a
    ld [wLastMusicSoundID], a
    dec a
    jp BANK00_PLAY_SOUND_ADDR

ASSERT @ == $0AAC
