; Map header pointer table for Pocket Monsters Midori.
;
; The 248 pointer values are byte-identical in Rev 0 and Rev A.
; Map names are cross-checked against the public Japanese Red/Green
; disassembly. Numeric pointer values are kept here until the
; corresponding map-header sections are restored as labels in this repo.

MapHeaderPointers::
    dw $42A1 ; $00 PalletTown_h
    dw $4357 ; $01 ViridianCity_h
    dw $4554 ; $02 PewterCity_h
    dw $474E ; $03 CeruleanCity_h
    dw $402C ; $04 LavenderTown_h
    dw $4998 ; $05 VermilionCity_h
    dw $4000 ; $06 CeladonCity_h
    dw $4BA7 ; $07 FuchsiaCity_h
    dw $406E ; $08 CinnabarIsland_h
    dw $491E ; $09 IndigoPlateau_h
    dw $49A4 ; $0A SaffronCity_h
    dw $49A4 ; $0B SaffronCity_h ; UNUSED_MAP_0B
    dw $4131 ; $0C Route1_h
    dw $4020 ; $0D Route2_h
    dw $4206 ; $0E Route3_h
    dw $43B0 ; $0F Route4_h
    dw $45A1 ; $10 Route5_h
    dw $401C ; $11 Route6_h
    dw $4040 ; $12 Route7_h
    dw $4149 ; $13 Route8_h
    dw $46A6 ; $14 Route9_h
    dw $42F0 ; $15 Route10_h
    dw $44DA ; $16 Route11_h
    dw $4689 ; $17 Route12_h
    dw $482C ; $18 Route13_h
    dw $49B9 ; $19 Route14_h
    dw $4948 ; $1A Route15_h
    dw $4AF6 ; $1B Route16_h
    dw $4B40 ; $1C Route17_h
    dw $4C54 ; $1D Route18_h
    dw $4E98 ; $1E Route19_h
    dw $40F1 ; $1F Route20_h
    dw $501F ; $20 Route21_h
    dw $4000 ; $21 Route22_h
    dw $433F ; $22 Route23_h
    dw $4682 ; $23 Route24_h
    dw $479B ; $24 Route25_h
    dw $4172 ; $25 RedsHouse1F_h
    dw $40A4 ; $26 RedsHouse2F_h
    dw $6E71 ; $27 BluesHouse_h
    dw $4540 ; $28 OaksLab_h
    dw $45CE ; $29 ViridianPokecenter_h
    dw $55FE ; $2A ViridianMart_h
    dw $5770 ; $2B ViridianSchoolHouse_h
    dw $57DE ; $2C ViridianNicknameHouse_h
    dw $40D4 ; $2D ViridianGym_h
    dw $6A2F ; $2E DiglettsCaveRoute2_h
    dw $6F78 ; $2F ViridianForestNorthGate_h
    dw $6A9A ; $30 Route2TradeHouse_h
    dw $7024 ; $31 Route2Gate_h
    dw $70ED ; $32 ViridianForestSouthGate_h
    dw $5928 ; $33 ViridianForest_h
    dw $40EB ; $34 Museum1F_h
    dw $4525 ; $35 Museum2F_h
    dw $4677 ; $36 PewterGym_h
    dw $58B0 ; $37 PewterNidoranHouse_h
    dw $4937 ; $38 PewterMart_h
    dw $596D ; $39 PewterSpeechHouse_h
    dw $4C14 ; $3A PewterPokecenter_h
    dw $70C0 ; $3B MtMoon1F_h
    dw $67A7 ; $3C MtMoonB1F_h
    dw $75AD ; $3D MtMoonB2F_h
    dw $5A18 ; $3E CeruleanTrashedHouse_h
    dw $5B5D ; $3F CeruleanTradeHouse_h
    dw $4D04 ; $40 CeruleanPokecenter_h
    dw $4E08 ; $41 CeruleanGym_h
    dw $5BE1 ; $42 BikeShop_h
    dw $528A ; $43 CeruleanMart_h
    dw $647B ; $44 MtMoonPokecenter_h
    dw $5A18 ; $45 CeruleanTrashedHouse_h ; CERULEAN_TRASHED_HOUSE_COPY
    dw $6B18 ; $46 Route5Gate_h
    dw $718D ; $47 UndergroundPathRoute5_h
    dw $7249 ; $48 Daycare_h
    dw $6CD7 ; $49 Route6Gate_h
    dw $71D3 ; $4A UndergroundPathRoute6_h
    dw $71D3 ; $4B UndergroundPathRoute6_h ; UNDERGROUND_PATH_ROUTE_6_COPY
    dw $6D9A ; $4C Route7Gate_h
    dw $722A ; $4D UndergroundPathRoute7_h
    dw $728D ; $4E UndergroundPathRoute7Copy_h
    dw $6E61 ; $4F Route8Gate_h
    dw $6F23 ; $50 UndergroundPathRoute8_h
    dw $663A ; $51 RockTunnelPokecenter_h
    dw $4920 ; $52 RockTunnel1F_h
    dw $6F88 ; $53 PowerPlant_h
    dw $66D2 ; $54 Route11Gate1F_h
    dw $7280 ; $55 DiglettsCaveRoute11_h
    dw $6788 ; $56 Route11Gate2F_h
    dw $690F ; $57 Route12Gate1F_h
    dw $7562 ; $58 BillsHouse_h
    dw $551C ; $59 VermilionPokecenter_h
    dw $6B43 ; $5A PokemonFanClub_h
    dw $55C8 ; $5B VermilionMart_h
    dw $56A5 ; $5C VermilionGym_h
    dw $645C ; $5D VermilionPidgeyHouse_h
    dw $651B ; $5E VermilionDock_h
    dw $5CBC ; $5F SSAnne1F_h
    dw $5E70 ; $60 SSAnne2F_h
    dw $4F0C ; $61 SSAnne3F_h
    dw $628E ; $62 SSAnneB1F_h
    dw $630E ; $63 SSAnneBow_h
    dw $64F0 ; $64 SSAnneKitchen_h
    dw $6727 ; $65 SSAnneCaptainsRoom_h
    dw $6993 ; $66 SSAnne1FRooms_h
    dw $6D13 ; $67 SSAnne2FRooms_h
    dw $710A ; $68 SSAnneB1FRooms_h
    dw $783C ; $69 LancesRoom_h ; UNUSED_MAP_69
    dw $783C ; $6A LancesRoom_h ; UNUSED_MAP_6A
    dw $783C ; $6B LancesRoom_h ; UNUSED_MAP_6B
    dw $76F8 ; $6C VictoryRoad1F_h
    dw $783C ; $6D LancesRoom_h ; UNUSED_MAP_6D
    dw $783C ; $6E LancesRoom_h ; UNUSED_MAP_6E
    dw $783C ; $6F LancesRoom_h ; UNUSED_MAP_6F
    dw $783C ; $70 LancesRoom_h ; UNUSED_MAP_70
    dw $783C ; $71 LancesRoom_h
    dw $783C ; $72 LancesRoom_h ; UNUSED_MAP_72
    dw $783C ; $73 LancesRoom_h ; UNUSED_MAP_73
    dw $783C ; $74 LancesRoom_h ; UNUSED_MAP_74
    dw $783C ; $75 LancesRoom_h ; UNUSED_MAP_75
    dw $7BBB ; $76 HallOfFame_h
    dw $7499 ; $77 UndergroundPathNorthSouth_h
    dw $6F76 ; $78 ChampionsRoom_h
    dw $74BD ; $79 UndergroundPathWestEast_h
    dw $5657 ; $7A CeladonMart1F_h
    dw $6FE1 ; $7B CeladonMart2F_h
    dw $430A ; $7C CeladonMart3F_h
    dw $45E9 ; $7D CeladonMart4F_h
    dw $4719 ; $7E CeladonMartRoof_h
    dw $4B38 ; $7F CeladonMartElevator_h
    dw $4BCC ; $80 CeladonMansion1F_h
    dw $4CD5 ; $81 CeladonMansion2F_h
    dw $4D37 ; $82 CeladonMansion3F_h
    dw $4F38 ; $83 CeladonMansionRoof_h
    dw $6700 ; $84 CeladonMansionRoofHouse_h
    dw $4F91 ; $85 CeladonPokecenter_h
    dw $503F ; $86 CeladonGym_h
    dw $56D1 ; $87 GameCorner_h
    dw $5EF4 ; $88 CeladonMart5F_h
    dw $6017 ; $89 GameCornerPrizeRoom_h
    dw $60CB ; $8A CeladonDiner_h
    dw $62B6 ; $8B CeladonChiefHouse_h
    dw $6395 ; $8C CeladonHotel_h
    dw $5343 ; $8D LavenderPokecenter_h
    dw $4420 ; $8E PokemonTower1F_h
    dw $4585 ; $8F PokemonTower2F_h
    dw $48E6 ; $90 PokemonTower3F_h
    dw $4ABF ; $91 PokemonTower4F_h
    dw $4C72 ; $92 PokemonTower5F_h
    dw $4F16 ; $93 PokemonTower6F_h
    dw $523F ; $94 PokemonTower7F_h
    dw $5EA5 ; $95 MrFujisHouse_h
    dw $53EB ; $96 LavenderMart_h
    dw $616D ; $97 LavenderCuboneHouse_h
    dw $67A4 ; $98 FuchsiaMart_h
    dw $4F82 ; $99 FuchsiaBillsGrandpasHouse_h
    dw $5074 ; $9A FuchsiaPokecenter_h
    dw $5139 ; $9B WardensHouse_h
    dw $5418 ; $9C SafariZoneGate_h
    dw $5851 ; $9D FuchsiaGym_h
    dw $5F32 ; $9E FuchsiaMeetingRoom_h
    dw $720C ; $9F SeafoamIslandsB1F_h
    dw $7348 ; $A0 SeafoamIslandsB2F_h
    dw $7484 ; $A1 SeafoamIslandsB3F_h
    dw $7690 ; $A2 SeafoamIslandsB4F_h
    dw $6E84 ; $A3 VermilionOldRodHouse_h
    dw $70CC ; $A4 FuchsiaGoodRodHouse_h
    dw $4691 ; $A5 PokemonMansion1F_h
    dw $6014 ; $A6 CinnabarGym_h
    dw $681F ; $A7 CinnabarLab_h
    dw $6928 ; $A8 CinnabarLabTradeRoom_h
    dw $69BE ; $A9 CinnabarLabMetronomeRoom_h
    dw $6BB3 ; $AA CinnabarLabFossilRoom_h
    dw $6D49 ; $AB CinnabarPokecenter_h
    dw $6E21 ; $AC CinnabarMart_h
    dw $6E21 ; $AD CinnabarMart_h ; CINNABAR_MART_COPY
    dw $706A ; $AE IndigoPlateauLobby_h
    dw $6EA6 ; $AF CopycatsHouse1F_h
    dw $5C87 ; $B0 CopycatsHouse2F_h
    dw $5F65 ; $B1 FightingDojo_h
    dw $6450 ; $B2 SaffronGym_h
    dw $684C ; $B3 SaffronPidgeyHouse_h
    dw $6D2D ; $B4 SaffronMart_h
    dw $6DC3 ; $B5 SilphCo1F_h
    dw $6ED3 ; $B6 SaffronPokecenter_h
    dw $694D ; $B7 MrPsychicsHouse_h
    dw $6B02 ; $B8 Route15Gate1F_h
    dw $6B72 ; $B9 Route15Gate2F_h
    dw $6C69 ; $BA Route16Gate1F_h
    dw $6E21 ; $BB Route16Gate2F_h
    dw $72F6 ; $BC Route16FlyHouse_h
    dw $75BF ; $BD Route12SuperRodHouse_h
    dw $6EFA ; $BE Route18Gate1F_h
    dw $7037 ; $BF Route18Gate2F_h
    dw $4DBD ; $C0 SeafoamIslands1F_h
    dw $740D ; $C1 Route22Gate_h
    dw $63FA ; $C2 VictoryRoad2F_h
    dw $6983 ; $C3 Route12Gate2F_h
    dw $7021 ; $C4 VermilionTradeHouse_h
    dw $74E1 ; $C5 DiglettsCave_h
    dw $4F89 ; $C6 VictoryRoad3F_h
    dw $52BE ; $C7 RocketHideoutB1F_h
    dw $55F4 ; $C8 RocketHideoutB2F_h
    dw $5A3A ; $C9 RocketHideoutB3F_h
    dw $5D12 ; $CA RocketHideoutB4F_h
    dw $614E ; $CB RocketHideoutElevator_h
    dw $614E ; $CC RocketHideoutElevator_h ; UNUSED_MAP_CC
    dw $614E ; $CD RocketHideoutElevator_h ; UNUSED_MAP_CD
    dw $614E ; $CE RocketHideoutElevator_h ; UNUSED_MAP_CE
    dw $6FD0 ; $CF SilphCo2F_h
    dw $73B5 ; $D0 SilphCo3F_h
    dw $71B3 ; $D1 SilphCo4F_h
    dw $7492 ; $D2 SilphCo5F_h
    dw $78C4 ; $D3 SilphCo6F_h
    dw $68C3 ; $D4 SilphCo7F_h
    dw $774C ; $D5 SilphCo8F_h
    dw $714C ; $D6 PokemonMansion2F_h
    dw $7428 ; $D7 PokemonMansion3F_h
    dw $7694 ; $D8 PokemonMansionB1F_h
    dw $62B5 ; $D9 SafariZoneEast_h
    dw $643B ; $DA SafariZoneNorth_h
    dw $7C1D ; $DB SafariZoneWest_h
    dw $66E8 ; $DC SafariZoneCenter_h
    dw $6856 ; $DD SafariZoneCenterRestHouse_h
    dw $7E24 ; $DE SafariZoneSecretHouse_h
    dw $68C8 ; $DF SafariZoneWestRestHouse_h
    dw $6981 ; $E0 SafariZoneEastRestHouse_h
    dw $6A22 ; $E1 SafariZoneNorthRestHouse_h
    dw $6B11 ; $E2 CeruleanCave2F_h
    dw $6BF6 ; $E3 CeruleanCaveB1F_h
    dw $49EC ; $E4 CeruleanCave1F_h
    dw $6249 ; $E5 NameRatersHouse_h
    dw $4AE9 ; $E6 CeruleanBadgeHouse_h
    dw $6C69 ; $E7 Route16Gate1F_h ; UNUSED_MAP_E7
    dw $6CF2 ; $E8 RockTunnelB1F_h
    dw $73C8 ; $E9 SilphCo9F_h
    dw $7643 ; $EA SilphCo10F_h
    dw $766D ; $EB SilphCo11F_h
    dw $620A ; $EC SilphCoElevator_h
    dw $6FD0 ; $ED SilphCo2F_h ; UNUSED_MAP_ED
    dw $6FD0 ; $EE SilphCo2F_h ; UNUSED_MAP_EE
    dw $7D04 ; $EF TradeCenter_h
    dw $7D6F ; $F0 Colosseum_h
    dw $6FD0 ; $F1 SilphCo2F_h ; UNUSED_MAP_F1
    dw $6FD0 ; $F2 SilphCo2F_h ; UNUSED_MAP_F2
    dw $6FD0 ; $F3 SilphCo2F_h ; UNUSED_MAP_F3
    dw $6FD0 ; $F4 SilphCo2F_h ; UNUSED_MAP_F4
    dw $756C ; $F5 LoreleisRoom_h
    dw $77BC ; $F6 BrunosRoom_h
    dw $79E4 ; $F7 AgathasRoom_h

ASSERT (@ - MapHeaderPointers) == 248 * 2
