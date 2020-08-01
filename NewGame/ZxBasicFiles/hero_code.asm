	org 32768
	; Defines HEAP SIZE
ZXBASIC_HEAP_SIZE EQU 128
__START_PROGRAM:
	di
	push ix
	push iy
	exx
	push hl
	exx
	ld hl, 0
	add hl, sp
	ld (__CALL_BACK__), hl
	ei
	call __MEM_INIT
	call __PRINT_INIT
	ld hl, 168
	call _allocate
	ld (23675), hl
#line 7
		ld hl, ZXBASIC_MEM_HEAP
#line 8
	ld hl, __LABEL0
	call __LOADSTR
	push hl
	ld hl, 24278
	push hl
	ld hl, 0
	push hl
	ld a, 1
	push af
	call LOAD_CODE
	call _initTable
	xor a
	call BORDER
__LABEL1:
	ld a, (_state)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL3
	call _intro
	ld a, 1
	ld (_state), a
	ld a, 1
	ld (_currentMap), a
	ld hl, 1
	ld (_currentMapIndex), hl
	ld hl, 1
	ld (_currentEntryIndex), hl
	ld a, 1
	ld (_entryScreen), a
	ld a, 4
	ld (_lifes), a
	ld a, 4
	ld (_dynamites), a
	ld a, 255
	ld (_dynaCounter), a
	xor a
	ld (_playerX), a
	xor a
	ld (_playerY), a
	ld hl, 5120
	ld (_power), hl
	ld hl, 0
	ld (_score), hl
	jp __LABEL4
__LABEL3:
	ld a, (_state)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL5
	xor a
	ld (_lampX), a
	xor a
	ld (_lampY), a
	ld a, 1
	ld (_lightOn), a
	xor a
	ld (_prevShotX), a
	xor a
	ld (_prevShotY), a
	xor a
	ld (_shotX), a
	xor a
	ld (_shotY), a
	xor a
	ld (_personX), a
	xor a
	ld (_personY), a
	ld a, (_entryScreen)
	or a
	jp z, __LABEL7
	call _entrance
	jp __LABEL8
__LABEL7:
	call _decodeCurrentScreen
__LABEL8:
	xor a
	ld (_updateResult), a
	ld a, (_playerX)
	ld (_playerXEnter), a
	ld a, (_playerY)
	ld (_playerYEnter), a
	ld a, (_playerDir)
	ld (_playerEnterDir), a
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	ld l, a
	ld h, 0
	push hl
	ld hl, (_lastHead)
	call _drawSprite
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	add a, 8
	ld l, a
	ld h, 0
	push hl
	ld hl, (_lastBody)
	call _drawSprite
	call _dumpScreenCenter
	ld a, 2
	ld (_state), a
	jp __LABEL6
__LABEL5:
	ld a, (_state)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL9
	ld hl, _frameCounter
	inc (hl)
	xor a
	ld (_updateResult), a
	ld hl, (_power)
	dec hl
	ld (_power), hl
	ld de, 511
	ld hl, (_power)
	call __BAND16
	push hl
	ld de, 0
	pop hl
	call __EQ16
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL12
	ld hl, (_power)
	ld de, 512
	call __DIVU16
	inc hl
	ld a, l
	ld (_tmpX), a
	ld a, 71
	push af
	ld a, (_tmpX)
	add a, 13
	push af
	ld a, 19
	push af
	call _setattr
	ld de, 0
	ld hl, (_power)
	call __EQ16
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL14
	call _gameOver
	xor a
	ld (_state), a
	jp __LABEL1
__LABEL14:
__LABEL12:
	call _movePlayer
	ld h, a
	ld a, (_updateResult)
	or h
	ld (_updateResult), a
	call _moveEnemies
	ld h, a
	ld a, (_updateResult)
	or h
	ld (_updateResult), a
	call _checkFire
	ld a, (_updateResult)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL16
	call _checkDynamite
	ld (_updateResult), a
__LABEL16:
	call _checkLight
	call _render
	ld a, (_updateResult)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL17
	call _processDeath
	ld (_updateResult), a
	or a
	jp z, __LABEL19
	ld a, (_playerXEnter)
	ld (_playerX), a
	ld a, (_playerYEnter)
	ld (_playerY), a
	ld a, (_playerEnterDir)
	ld (_playerDir), a
	ld a, (_dynaCounter)
	sub 255
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL22
	ld a, 255
	ld (_dynaCounter), a
	ld a, (_dynaX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_dynaY)
	ld l, a
	ld h, 0
	push hl
	ld hl, (_lastDyna)
	call _drawSprite
__LABEL22:
	ld a, (_playerDir)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL23
	ld hl, _head1l.__DATA__
	ld (_lastHead), hl
	ld hl, _body2l.__DATA__
	ld (_lastBody), hl
	jp __LABEL24
__LABEL23:
	ld hl, _head1r.__DATA__
	ld (_lastHead), hl
	ld hl, _body2r.__DATA__
	ld (_lastBody), hl
__LABEL24:
	ld a, 1
	ld (_lightOn), a
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	ld l, a
	ld h, 0
	push hl
	ld hl, (_lastHead)
	call _drawSprite
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	add a, 8
	ld l, a
	ld h, 0
	push hl
	ld hl, (_lastBody)
	call _drawSprite
	call _dumpScreenCenter
	jp __LABEL20
__LABEL19:
	call _gameOver
	xor a
	ld (_state), a
__LABEL20:
	jp __LABEL18
__LABEL17:
	ld a, (_updateResult)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL25
	ld a, 4
	ld (_state), a
	jp __LABEL26
__LABEL25:
	ld a, (_updateResult)
	sub 3
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL28
	ld a, 3
	ld (_state), a
__LABEL28:
__LABEL26:
__LABEL18:
	jp __LABEL10
__LABEL9:
	ld a, (_state)
	sub 3
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL29
	call _personSaved
	ld hl, (_power)
	ld de, 10
	call __DIVU16
	ld de, 500
	add hl, de
	push hl
	call _updateScore
	ld hl, (_currentMapIndex)
	inc hl
	ld (_currentMapIndex), hl
	ld a, 1
	ld (_state), a
	xor a
	ld (_playerX), a
	xor a
	ld (_playerY), a
	ld a, 1
	ld (_entryScreen), a
	ld a, 4
	ld (_dynamites), a
	ld hl, 5120
	ld (_power), hl
	ld a, 1
	ld (_tmpX), a
	jp __LABEL31
__LABEL34:
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 2
	call _createAttrib
	push af
	ld a, (_tmpX)
	add a, a
	add a, 23
	push af
	ld a, 21
	push af
	call _setattr
__LABEL35:
	ld hl, _tmpX
	inc (hl)
__LABEL31:
	ld a, 4
	ld hl, (_tmpX - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL34
__LABEL33:
	ld a, 1
	ld (_tmpX), a
	jp __LABEL36
__LABEL39:
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 4
	call _createAttrib
	push af
	ld a, (_tmpX)
	add a, 14
	push af
	ld a, 19
	push af
	call _setattr
__LABEL40:
	ld hl, _tmpX
	inc (hl)
__LABEL36:
	ld a, 10
	ld hl, (_tmpX - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL39
__LABEL38:
	ld hl, (_currentMapIndex)
	dec hl
	push hl
	ld hl, _maps
	call __ARRAY
	ld a, (hl)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL42
	call _presentEnd
	xor a
	ld (_state), a
__LABEL42:
	jp __LABEL30
__LABEL29:
	ld a, (_state)
	sub 4
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL44
	xor a
	ld (_exitResult), a
	ld a, (_currentMapExit)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_playerY)
	sub 40
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL669
	ld a, h
__LABEL669:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL45
	ld a, 136
	ld (_playerY), a
	ld a, 1
	ld (_exitResult), a
	jp __LABEL46
__LABEL45:
	ld a, (_currentMapExit)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_playerY)
	sub 136
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL670
	ld a, h
__LABEL670:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL47
	ld a, 40
	ld (_playerY), a
	ld a, 1
	ld (_exitResult), a
	jp __LABEL48
__LABEL47:
	ld a, (_currentMapExit)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_playerX)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL671
	ld a, h
__LABEL671:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL49
	ld a, 248
	ld (_playerX), a
	ld a, 1
	ld (_exitResult), a
	jp __LABEL50
__LABEL49:
	ld a, (_currentMapExit)
	sub 3
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_playerX)
	sub 248
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL672
	ld a, h
__LABEL672:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL51
	xor a
	ld (_playerX), a
	ld a, 1
	ld (_exitResult), a
	jp __LABEL52
__LABEL51:
	ld a, (_playerY)
	sub 40
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL53
	ld a, 136
	ld (_playerY), a
	jp __LABEL54
__LABEL53:
	ld a, (_playerY)
	sub 136
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL55
	ld a, 40
	ld (_playerY), a
	jp __LABEL56
__LABEL55:
	ld a, (_playerX)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL57
	ld a, 248
	ld (_playerX), a
	jp __LABEL58
__LABEL57:
	ld a, (_playerX)
	sub 248
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL60
	xor a
	ld (_playerX), a
__LABEL60:
__LABEL58:
__LABEL56:
__LABEL54:
__LABEL52:
__LABEL50:
__LABEL48:
__LABEL46:
	ld a, (_exitResult)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL61
	ld a, (_entryScreen)
	or a
	jp z, __LABEL63
	xor a
	ld (_entryScreen), a
	jp __LABEL64
__LABEL63:
	ld hl, (_currentMapIndex)
	inc hl
	ld (_currentMapIndex), hl
__LABEL64:
	jp __LABEL62
__LABEL61:
	ld de, (_currentMapIndex)
	ld hl, (_currentEntryIndex)
	call __EQ16
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL65
	ld a, 1
	ld (_entryScreen), a
	jp __LABEL66
__LABEL65:
	ld hl, (_currentMapIndex)
	dec hl
	ld (_currentMapIndex), hl
__LABEL66:
__LABEL62:
	ld a, 1
	ld (_state), a
__LABEL44:
__LABEL30:
__LABEL10:
__LABEL6:
__LABEL4:
	jp __LABEL1
__LABEL2:
	ld hl, 0
	ld b, h
	ld c, l
__END_PROGRAM:
	di
	ld hl, (__CALL_BACK__)
	ld sp, hl
	exx
	pop hl
	exx
	pop iy
	pop ix
	ei
	ret
__CALL_BACK__:
	DEFW 0
_attr:
	push ix
	ld ix, 0
	add ix, sp
#line 27
		PROC
		LOCAL __ATTR_END
		ld e, (ix+7)
		ld d, (ix+5)
		call __IN_SCREEN
		jr nc, __ATTR_END
		call __ATTR_ADDR
		ld a, (hl)
__ATTR_END:
		ENDP
#line 37
_attr__leave:
	ld sp, ix
	pop ix
	exx
	pop hl
	pop bc
	ex (sp), hl
	exx
	ret
_setattr:
	push ix
	ld ix, 0
	add ix, sp
#line 63
		PROC
		LOCAL __ATTR_END
		ld e, (ix+7)
		ld d, (ix+5)
		call __IN_SCREEN
		jr nc, __ATTR_END
		call __ATTR_ADDR
		ld a, (ix+9)
		ld (hl), a
__ATTR_END:
		ENDP
#line 74
_setattr__leave:
	ld sp, ix
	pop ix
	exx
	pop hl
	pop bc
	pop bc
	ex (sp), hl
	exx
	ret
_attraddr:
#line 97
		pop hl
		ex (sp), hl
		ld d, a
		ld e, h
		jp __ATTR_ADDR
#line 102
_attraddr__leave:
	ret
_point:
	push ix
	ld ix, 0
	add ix, sp
#line 27
		PROC
		LOCAL PIXEL_ADDR
		LOCAL POINT_LOOP
		LOCAL POINT_END
		LOCAL POINT_1
		PIXEL_ADDR EQU (22AAh + 6)
		ld b, (ix+7)
		ld c, (ix+5)
		ld a, 191
		sub b
		jp nc, POINT_1
		ld a, -1
		jr POINT_END
POINT_1:
		call PIXEL_ADDR
		ld b, a
		inc b
		ld a, (hl)
POINT_LOOP:
		rlca
		djnz POINT_LOOP
		and 1
POINT_END:
		ENDP
#line 51
_point__leave:
	ld sp, ix
	pop ix
	exx
	pop hl
	pop bc
	ex (sp), hl
	exx
	ret
_screen:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
#line 34
		PROC
		LOCAL __SCREEN_END
		LOCAL __S_SCRNS_BC
		LOCAL STK_END
		LOCAL RECLAIM2
		__S_SCRNS_BC EQU 2538h
		STK_END EQU 5C65h
		RECLAIM2 EQU 19E8h
		ld bc, 4
		call __MEM_ALLOC
		push hl
		ld a, h
		or l
		jr z, __SCREEN_END
		ld hl, (STK_END)
		push hl
		ld b, (ix+7)
		ld c, (ix+5)
		call __S_SCRNS_BC
		call __FPSTACK_POP
		pop hl
		ld (STK_END), hl
		pop hl
		push hl
		ld (hl), c
		inc hl
		ld (hl), b
		inc hl
		ld a, (de)
		ld (hl), a
		ex de, hl
		call RECLAIM2
__SCREEN_END:
		pop hl
		ld (ix-2), l
		ld (ix-1), h
		ENDP
#line 71
	ld l, (ix-2)
	ld h, (ix-1)
	call __LOADSTR
_screen__leave:
	ex af, af'
	exx
	ld l, (ix-2)
	ld h, (ix-1)
	call __MEM_FREE
	ex af, af'
	exx
	ld sp, ix
	pop ix
	exx
	pop hl
	pop bc
	ex (sp), hl
	exx
	ret
_pos:
#line 27
		PROC
		call __LOAD_S_POSN
		ld a, e
		ENDP
#line 31
_pos__leave:
	ret
_csrlin:
#line 25
		PROC
		call __LOAD_S_POSN
		ld a, d
		ENDP
#line 29
_csrlin__leave:
	ret
_input:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	push hl
	ld de, __LABEL0
	ld bc, -2
	call __PSTORE_STR
	ld a, (23611)
	push af
	ld h, 8
	pop af
	or h
	ld (23611), a
__LABEL67:
	call _PRIVATEInputShowCursor
	xor a
	ld (_input_LastK), a
__LABEL70:
__LABEL72:
	ld a, (_input_LastK)
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL70
__LABEL71:
	call _PRIVATEInputHideCursor
	ld a, (_input_LastK)
	sub 12
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL73
	ld l, (ix-2)
	ld h, (ix-1)
	call __STRLEN
	ld a, h
	or l
	jp z, __LABEL76
	ld l, (ix-2)
	ld h, (ix-1)
	call __STRLEN
	push hl
	ld de, 1
	pop hl
	call __EQ16
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL77
	ld de, __LABEL0
	ld bc, -2
	call __PSTORE_STR
	jp __LABEL78
__LABEL77:
	ld l, (ix-2)
	ld h, (ix-1)
	push hl
	ld hl, 0
	push hl
	ld l, (ix-2)
	ld h, (ix-1)
	call __STRLEN
	dec hl
	dec hl
	dec hl
	push hl
	xor a
	call __STRSLICE
	ld d, h
	ld e, l
	ld bc, -2
	call __PSTORE_STR2
__LABEL78:
	ld hl, __LABEL79
	xor a
	call __PRINTSTR
__LABEL76:
	jp __LABEL74
__LABEL73:
	ld a, (_input_LastK)
	sub 32
	ccf
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld l, (ix-2)
	ld h, (ix-1)
	call __STRLEN
	push hl
	ld l, (ix+4)
	ld h, (ix+5)
	ex de, hl
	pop hl
	or a
	sbc hl, de
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL673
	ld a, h
__LABEL673:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL81
	ld l, (ix-2)
	ld h, (ix-1)
	push hl
	ld a, (_input_LastK)
	push af
	ld hl, 1
	call CHR
	ex de, hl
	pop hl
	push de
	call __ADDSTR
	ex (sp), hl
	call __MEM_FREE
	pop hl
	ld d, h
	ld e, l
	ld bc, -2
	call __PSTORE_STR2
	ld a, (_input_LastK)
	push af
	ld hl, 1
	call CHR
	ld a, 1
	call __PRINTSTR
__LABEL81:
__LABEL74:
__LABEL69:
	ld a, (_input_LastK)
	sub 13
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL67
__LABEL68:
	ld (ix-4), 1
	ld (ix-3), 0
	jp __LABEL82
__LABEL85:
	xor a
	call OVER_TMP
	ld a, 8
	push af
	ld hl, 1
	call CHR
	push hl
	ld de, __LABEL87
	pop hl
	push hl
	call __ADDSTR
	ex (sp), hl
	call __MEM_FREE
	pop hl
	push hl
	ld a, 8
	push af
	ld hl, 1
	call CHR
	ex de, hl
	pop hl
	push hl
	push de
	call __ADDSTR
	pop de
	ex (sp), hl
	push de
	call __MEM_FREE
	pop hl
	call __MEM_FREE
	pop hl
	ld a, 1
	call __PRINTSTR
	call COPY_ATTR
__LABEL86:
	ld l, (ix-4)
	ld h, (ix-3)
	inc hl
	ld (ix-4), l
	ld (ix-3), h
__LABEL82:
	ld l, (ix-4)
	ld h, (ix-3)
	push hl
	ld l, (ix-2)
	ld h, (ix-1)
	call __STRLEN
	pop de
	or a
	sbc hl, de
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL85
__LABEL84:
	ld l, (ix-2)
	ld h, (ix-1)
	call __LOADSTR
_input__leave:
	ex af, af'
	exx
	ld l, (ix-2)
	ld h, (ix-1)
	call __MEM_FREE
	ex af, af'
	exx
	ld sp, ix
	pop ix
	exx
	pop hl
	ex (sp), hl
	exx
	ret
_PRIVATEInputShowCursor:
	call _csrlin
	push af
	call _pos
	call PRINT_AT
	xor a
	call OVER_TMP
	ld a, 1
	call FLASH_TMP
	ld de, __LABEL79
	ld hl, __LABEL87
	call __ADDSTR
	ld a, 1
	call __PRINTSTR
	call COPY_ATTR
_PRIVATEInputShowCursor__leave:
	ret
_PRIVATEInputHideCursor:
	call _csrlin
	push af
	call _pos
	call PRINT_AT
	xor a
	call OVER_TMP
	xor a
	call FLASH_TMP
	ld de, __LABEL79
	ld hl, __LABEL87
	call __ADDSTR
	ld a, 1
	call __PRINTSTR
	call COPY_ATTR
_PRIVATEInputHideCursor__leave:
	ret
_allocate:
#line 35
		ld b, h
		ld c, l
		jp __MEM_ALLOC
#line 38
_allocate__leave:
	ret
_callocate:
#line 63
		ld b, h
		ld c, l
		jp __MEM_CALLOC
#line 66
_callocate__leave:
	ret
_deallocate:
#line 81
		jp __MEM_FREE
#line 82
_deallocate__leave:
	ret
_reallocate:
#line 107
		ex de, hl
		pop hl
		ex (sp), hl
		ld b, h
		ld c, l
		ex de, hl
		jp __REALLOC
#line 114
_reallocate__leave:
	ret
_memavail:
#line 126
		PROC
		LOCAL LOOP
		ld hl, ZXBASIC_MEM_HEAP
		ld de, 0
LOOP:
		ld c, (hl)
		inc hl
		ld b, (hl)
		inc hl
		ld a, (hl)
		inc hl
		ld h, (hl)
		ld l, a
		ex de, hl
		add hl, bc
		ex de, hl
		ld a, h
		or l
		jr nz, LOOP
		ex de, hl
		ENDP
#line 147
_memavail__leave:
	ret
_maxavail:
#line 170
		PROC
		LOCAL LOOP, CONT
		ld hl, ZXBASIC_MEM_HEAP
		ld de, 0
LOOP:
		ld c, (hl)
		inc hl
		ld b, (hl)
		inc hl
		ld a, (hl)
		inc hl
		ld h, (hl)
		ld l, a
		ex de, hl
		or a
		sbc hl, bc
		add hl, bc
		ex de, hl
		jr nc, CONT
		ld d, b
		ld e, c
CONT:
		ld a, h
		or l
		jr nz, LOOP
		ex de, hl
		ENDP
#line 197
_maxavail__leave:
	ret
_initTable:
	push ix
	ld ix, 0
	add ix, sp
#line 16
		ld b, 0
		ld de, _tableCP.__DATA__
table_loop:
		push bc
		LD A,B
		AND %00000111
		OR %01000000
		LD H,A
		LD A,B
		RRA
		RRA
		RRA
		AND %00011000
		OR H
		LD H,A
		LD A,B
		RLA
		RLA
		AND %11100000
		ld l, a
		ld bc, 16
		add hl, bc
		ld a, l
		ld (de), a
		inc de
		ld a, h
		ld (de), a
		inc de
		add hl, bc
		ld a,l
		ld (de), a
		inc de
		ld a, h
		ld (de), a
		inc de
		pop bc
		inc b
		ld a,b
		cp 192
		jr nz, table_loop
#line 56
_initTable__leave:
	ld sp, ix
	pop ix
	ret
_printRepeatColorChar:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	inc sp
	ld a, (ix+9)
	ld (ix-1), a
	jp __LABEL88
__LABEL91:
	ld a, (ix+13)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix+7)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix+4)
	ld h, (ix+5)
	call _printColorChar
__LABEL92:
	inc (ix-1)
__LABEL88:
	ld a, (ix-1)
	push af
	ld a, (ix+9)
	add a, (ix+11)
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL91
__LABEL90:
_printRepeatColorChar__leave:
	ld sp, ix
	pop ix
	exx
	pop hl
	pop bc
	pop bc
	pop bc
	pop bc
	ex (sp), hl
	exx
	ret
_ZXCharAddress:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	ld l, (ix+4)
	ld h, (ix+5)
	push hl
	ld hl, 0
	push hl
	ld hl, 0
	push hl
	xor a
	call __STRSLICE
	ld a, 1
	call __ASC
	ld l, a
	ld h, 0
	ld (ix-2), l
	ld (ix-1), h
	ld l, (ix-2)
	ld h, (ix-1)
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, 15360
	add hl, de
	ld (ix-2), l
	ld (ix-1), h
	ld l, (ix-2)
	ld h, (ix-1)
_ZXCharAddress__leave:
	ex af, af'
	exx
	ld l, (ix+4)
	ld h, (ix+5)
	call __MEM_FREE
	ex af, af'
	exx
	ld sp, ix
	pop ix
	exx
	pop hl
	ex (sp), hl
	exx
	ret
_printZXString:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	push hl
	inc sp
	ld a, (ix+9)
	ld (ix-1), a
	jp __LABEL93
__LABEL96:
	ld l, (ix+4)
	ld h, (ix+5)
	push hl
	ld a, (ix-1)
	sub (ix+9)
	inc a
	dec a
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-1)
	sub (ix+9)
	inc a
	dec a
	ld l, a
	ld h, 0
	push hl
	xor a
	call __STRSLICE
	ld a, 1
	call __ASC
	ld l, a
	ld h, 0
	ld (ix-3), l
	ld (ix-2), h
	ld l, (ix-3)
	ld h, (ix-2)
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, 15360
	add hl, de
	ld (ix-3), l
	ld (ix-2), h
	ld a, (ix+11)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix+7)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-3)
	ld h, (ix-2)
	call _printColorChar
__LABEL97:
	inc (ix-1)
__LABEL93:
	ld a, (ix-1)
	push af
	ld a, (ix+9)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix+4)
	ld h, (ix+5)
	call __STRLEN
	ex de, hl
	pop hl
	add hl, de
	dec hl
	ld a, l
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL96
__LABEL95:
_printZXString__leave:
	ex af, af'
	exx
	ld l, (ix+4)
	ld h, (ix+5)
	call __MEM_FREE
	ex af, af'
	exx
	ld sp, ix
	pop ix
	exx
	pop hl
	pop bc
	pop bc
	pop bc
	ex (sp), hl
	exx
	ret
_createAttrib:
#line 102
		exx
		pop hl
		exx
		pop bc
		pop de
		pop hl
		exx
		push hl
		exx
		and 7
		ld c, a
		ld a, b
		rla
		rla
		rla
		and 56
		or c
		ld c, a
		ld a, d
		cp 0
		jr z, noBrightAttrib
		ld a, c
		or 64
		ld c, a
noBrightAttrib:
		ld a, h
		cp 0
		jr z, noFlash
		ld a, c
		or 128
		or c
		ld c, a
noFlash:
		ld a,c
#line 136
_createAttrib__leave:
	ret
_setAttrib:
#line 146
		exx
		pop hl
		exx
		pop de
		pop bc
		exx
		push hl
		exx
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, de
		ld de, _attribBuffer.__DATA__
		add hl, de
		ld (hl), c
#line 163
_setAttrib__leave:
	ret
_clearScreen:
#line 174
		ld de, _bitmapBuffer.__DATA__ + 1
		ld hl, _bitmapBuffer.__DATA__
		ld (hl), 0
		ld bc, 6143
		ldir
		ld de, _attribBuffer.__DATA__ + 1
		ld hl, _attribBuffer.__DATA__
		ld (hl), a
		ld bc, 767
		ldir
#line 184
_clearScreen__leave:
	ret
_clearScreenTop:
#line 194
		ld de, _bitmapBuffer.__DATA__ + 1
		ld hl, _bitmapBuffer.__DATA__
		ld (hl), 0
		ld bc, 1535
		ldir
		ld de, _attribBuffer.__DATA__ + 1
		ld hl, _attribBuffer.__DATA__
		ld (hl), a
		ld bc, 191
		ldir
#line 204
_clearScreenTop__leave:
	ret
_clearScreenCenter:
#line 214
		ld de, _bitmapBuffer.__DATA__ + 1 + 1536
		ld hl, _bitmapBuffer.__DATA__ + 1536
		ld (hl), 0
		ld bc, 3071
		ldir
		ld de, _attribBuffer.__DATA__ + 1 + 192
		ld hl, _attribBuffer.__DATA__ + 192
		ld (hl), a
		ld bc, 383
		ldir
#line 224
_clearScreenCenter__leave:
	ret
_clearScreenBottom:
#line 234
		ld de, _bitmapBuffer.__DATA__ + 1 + 4608
		ld hl, _bitmapBuffer.__DATA__ + 4608
		ld (hl), 0
		ld bc, 1535
		ldir
		ld de, _attribBuffer.__DATA__ + 1 + 576
		ld hl, _attribBuffer.__DATA__ + 576
		ld (hl), a
		ld bc, 383
		ldir
#line 244
_clearScreenBottom__leave:
	ret
_clearPixels:
	push ix
	ld ix, 0
	add ix, sp
#line 255
		ld de, _bitmapBuffer.__DATA__ + 1
		ld hl, _bitmapBuffer.__DATA__
		ld (hl), 0
		ld bc, 6143
		ldir
#line 260
_clearPixels__leave:
	ld sp, ix
	pop ix
	ret
_clearPixelsTop:
	push ix
	ld ix, 0
	add ix, sp
#line 269
		ld de, _bitmapBuffer.__DATA__ + 1
		ld hl, _bitmapBuffer.__DATA__
		ld (hl), 0
		ld bc, 1535
		ldir
#line 274
_clearPixelsTop__leave:
	ld sp, ix
	pop ix
	ret
_clearPixelsCenter:
	push ix
	ld ix, 0
	add ix, sp
#line 283
		ld de, _bitmapBuffer.__DATA__ + 1 + 1536
		ld hl, _bitmapBuffer.__DATA__ + 1536
		ld (hl), 0
		ld bc, 3071
		ldir
#line 288
_clearPixelsCenter__leave:
	ld sp, ix
	pop ix
	ret
_clearPixelsBottom:
	push ix
	ld ix, 0
	add ix, sp
#line 297
		ld de, _bitmapBuffer.__DATA__ + 1 + 4608
		ld hl, _bitmapBuffer.__DATA__ + 4608
		ld (hl), 0
		ld bc, 1535
		ldir
#line 302
_clearPixelsBottom__leave:
	ld sp, ix
	pop ix
	ret
_clearAttribs:
#line 311
		ld de, _attribBuffer.__DATA__ + 1
		ld hl, _attribBuffer.__DATA__
		ld (hl), a
		ld bc, 767
		ldir
#line 316
_clearAttribs__leave:
	ret
_clearAttribsTop:
#line 325
		ld de, _attribBuffer.__DATA__ + 1
		ld hl, _attribBuffer.__DATA__
		ld (hl), a
		ld bc, 191
		ldir
#line 330
_clearAttribsTop__leave:
	ret
_clearAttribsCenter:
#line 339
		ld de, _attribBuffer.__DATA__ + 1 + 192
		ld hl, _attribBuffer.__DATA__ + 192
		ld (hl), a
		ld bc, 383
		ldir
#line 344
_clearAttribsCenter__leave:
	ret
_clearAttribsBottom:
#line 353
		ld de, _bitmapBuffer.__DATA__ + 1 + 4608
		ld hl, _bitmapBuffer.__DATA__ + 4608
		ld (hl), 0
		ld bc, 1535
		ldir
		ld de, _attribBuffer.__DATA__ + 1 + 576
		ld hl, _attribBuffer.__DATA__ + 576
		ld (hl), a
		ld bc, 383
		ldir
#line 363
_clearAttribsBottom__leave:
	ret
_printColorChar:
#line 373
		exx
		pop hl
		exx
		pop de
		pop bc
		exx
		pop de
		push hl
		exx
		ex de, hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		push bc
		push hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, bc
		exx
		pop bc
		pop hl
		add hl, bc
		ld bc, _attribBuffer.__DATA__
		add hl, bc
		ld (hl), e
		exx
		ld bc, _bitmapBuffer.__DATA__
		add hl, bc
		ld a, (de)
		ld (hl), a
		inc de
		ld bc, 32
		add hl, bc
		ld a, (de)
		ld (hl), a
		inc de
		ld bc, 32
		add hl, bc
		ld a, (de)
		ld (hl), a
		inc de
		ld bc, 32
		add hl, bc
		ld a, (de)
		ld (hl), a
		inc de
		ld bc, 32
		add hl, bc
		ld a, (de)
		ld (hl), a
		inc de
		ld bc, 32
		add hl, bc
		ld a, (de)
		ld (hl), a
		inc de
		ld bc, 32
		add hl, bc
		ld a, (de)
		ld (hl), a
		inc de
		ld bc, 32
		add hl, bc
		ld a, (de)
		ld (hl), a
#line 441
_printColorChar__leave:
	ret
_drawColorSprite:
#line 464
		exx
		pop hl
		exx
		pop de
		pop bc
		exx
		pop de
		push hl
		push de
		exx
		ex de, hl
		ld a, c
		srl a
		srl a
		srl a
		push af
		push hl
		push af
		ld a, c
		and 7
		jp nz, dcs_print_ext
dcs_print_simple:
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		ld bc, _bitmapBuffer.__DATA__
		add hl, bc
		pop af
		ld c, a
		ld b, 0
		add hl, bc
		ld bc, 32
		ld a, (hl)
		ex de, hl
		xor (hl)
		ex de, hl
		ld (hl), a
		inc de
		add hl, bc
		ld a, (hl)
		ex de, hl
		xor (hl)
		ex de, hl
		ld (hl), a
		inc de
		add hl, bc
		ld a, (hl)
		ex de, hl
		xor (hl)
		ex de, hl
		ld (hl), a
		inc de
		add hl, bc
		ld a, (hl)
		ex de, hl
		xor (hl)
		ex de, hl
		ld (hl), a
		inc de
		add hl, bc
		ld a, (hl)
		ex de, hl
		xor (hl)
		ex de, hl
		ld (hl), a
		inc de
		add hl, bc
		ld a, (hl)
		ex de, hl
		xor (hl)
		ex de, hl
		ld (hl), a
		inc de
		add hl, bc
		ld a, (hl)
		ex de, hl
		xor (hl)
		ex de, hl
		ld (hl), a
		inc de
		add hl, bc
		ld a, (hl)
		ex de, hl
		xor (hl)
		ex de, hl
		ld (hl), a
		pop hl
		ld a, l
		ex af, af'
		srl l
		srl l
		srl l
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		pop af
		ld e, a
		ld d, 0
		add hl, de
		ld de, _attribBuffer.__DATA__
		add hl, de
		pop de
		ld (hl), e
		ex af, af'
		and 7
		jp z, dcs_print_exit
		ld bc, 32
		add hl, bc
		ld (hl), e
		jp dcs_print_exit
dcs_print_ext:
		ld a, 8
		ld (dcs_loopCounter), a
		push bc
		exx
		pop bc
		pop af
		ld l, a
		ld h, 0
		push hl
		add hl, hl
		add hl, hl
		add hl, hl
		push de
		push bc
		pop de
		ex de, hl
		sbc hl, de
		pop de
		pop bc
		push hl
		push bc
		exx
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		ld bc, _bitmapBuffer.__DATA__
		add hl, bc
		pop bc
		add hl, bc
		ex de, hl
		pop bc
		push bc
		push hl
dcs_ext_loop:
		ld a, (hl)
		call dcs_rshift
		push de
		pop hl
		xor (hl)
		ld (hl), a
		pop hl
		pop bc
		push bc
		push hl
		inc de
		ld a, 8
		sub c
		ld c, a
		ld a, (hl)
		call dcs_lshift
		push de
		pop hl
		xor (hl)
		ld (hl), a
		ld bc, 31
		add hl, bc
		push hl
		pop de
		pop hl
		pop bc
		inc hl
		push bc
		push hl
		ld a, (dcs_loopCounter)
		dec a
		ld (dcs_loopCounter), a
		jp nz, dcs_ext_loop
		pop hl
		pop hl
		pop hl
		ld a, l
		ex af, af'
		srl l
		srl l
		srl l
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		pop af
		ld e, a
		ld d, 0
		add hl, de
		ld de, _attribBuffer.__DATA__
		add hl, de
		pop de
		ld (hl), e
		inc hl
		ld (hl), e
		ex af, af'
		and 7
		jp z, dcs_print_exit
		ld bc, 31
		add hl, bc
		ld (hl), e
		inc hl
		ld (hl), e
		jp dcs_print_exit
dcs_rshift:
		srl a
		dec c
		jr nz, dcs_rshift
		ret
dcs_lshift:
		sla a
		dec c
		jr nz, dcs_lshift
		ret
dcs_print_exit:
		ret
dcs_loopCounter:
		defb 0
#line 694
_drawColorSprite__leave:
	ret
_printChar:
#line 805
		exx
		pop hl
		exx
		pop de
		pop bc
		exx
		push hl
		exx
		ex de, hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, bc
		ld bc, _bitmapBuffer.__DATA__
		add hl, bc
		ld a, (de)
		ld (hl), a
		inc de
		ld bc, 32
		add hl, bc
		ld a, (de)
		ld (hl), a
		inc de
		ld bc, 32
		add hl, bc
		ld a, (de)
		ld (hl), a
		inc de
		ld bc, 32
		add hl, bc
		ld a, (de)
		ld (hl), a
		inc de
		ld bc, 32
		add hl, bc
		ld a, (de)
		ld (hl), a
		inc de
		ld bc, 32
		add hl, bc
		ld a, (de)
		ld (hl), a
		inc de
		ld bc, 32
		add hl, bc
		ld a, (de)
		ld (hl), a
		inc de
		ld bc, 32
		add hl, bc
		ld a, (de)
		ld (hl), a
#line 862
_printChar__leave:
	ret
_drawSprite:
#line 882
		exx
		pop hl
		exx
		pop de
		pop bc
		exx
		push hl
		exx
		ex de, hl
		ld a, c
		srl a
		srl a
		srl a
		push af
		ld a, c
		and 7
		jp nz, ds_print_ext
ds_print_simple:
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		ld bc, _bitmapBuffer.__DATA__
		add hl, bc
		pop af
		ld c, a
		ld b, 0
		add hl, bc
		ld bc, 32
		ld a, (hl)
		ex de, hl
		xor (hl)
		ex de, hl
		ld (hl), a
		inc de
		add hl, bc
		ld a, (hl)
		ex de, hl
		xor (hl)
		ex de, hl
		ld (hl), a
		inc de
		add hl, bc
		ld a, (hl)
		ex de, hl
		xor (hl)
		ex de, hl
		ld (hl), a
		inc de
		add hl, bc
		ld a, (hl)
		ex de, hl
		xor (hl)
		ex de, hl
		ld (hl), a
		inc de
		add hl, bc
		ld a, (hl)
		ex de, hl
		xor (hl)
		ex de, hl
		ld (hl), a
		inc de
		add hl, bc
		ld a, (hl)
		ex de, hl
		xor (hl)
		ex de, hl
		ld (hl), a
		inc de
		add hl, bc
		ld a, (hl)
		ex de, hl
		xor (hl)
		ex de, hl
		ld (hl), a
		inc de
		add hl, bc
		ld a, (hl)
		ex de, hl
		xor (hl)
		ex de, hl
		ld (hl), a
		jp ds_print_exit
ds_print_ext:
		ld a, 8
		ld (ds_loopCounter), a
		push bc
		exx
		pop bc
		pop af
		ld l, a
		ld h, 0
		push hl
		add hl, hl
		add hl, hl
		add hl, hl
		push de
		push bc
		pop de
		ex de, hl
		sbc hl, de
		pop de
		pop bc
		push hl
		push bc
		exx
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		add hl, hl
		ld bc, _bitmapBuffer.__DATA__
		add hl, bc
		pop bc
		add hl, bc
		ex de, hl
		pop bc
		push bc
		push hl
ds_ext_loop:
		ld a, (hl)
		call ds_rshift
		push de
		pop hl
		xor (hl)
		ld (hl), a
		pop hl
		pop bc
		push bc
		push hl
		inc de
		ld a, 8
		sub c
		ld c, a
		ld a, (hl)
		call ds_lshift
		push de
		pop hl
		xor (hl)
		ld (hl), a
		ld bc, 31
		add hl, bc
		push hl
		pop de
		pop hl
		pop bc
		inc hl
		push bc
		push hl
		ld a, (ds_loopCounter)
		dec a
		ld (ds_loopCounter), a
		jp nz, ds_ext_loop
		pop hl
		pop hl
		jp ds_print_exit
ds_rshift:
		srl a
		dec c
		jr nz, ds_rshift
		ret
ds_lshift:
		sla a
		dec c
		jr nz, ds_lshift
		ret
ds_print_exit:
		ret
ds_loopCounter:
		defb 0
#line 1054
_drawSprite__leave:
	ret
_dumpScreen:
	push ix
	ld ix, 0
	add ix, sp
#line 1148
		push ix
		push iy
		ld (dsc_restore_stack + 1), sp
		ld de, 384
		ld (dsc_counter), de
		ld hl, _bitmapBuffer.__DATA__
		ld (dsc_copy + 1), hl
		ld hl, _tableCP.__DATA__
		ld (dsc_target + 1), hl
dsc_copy:
		ld sp, 0
		pop bc
		pop de
		pop hl
		pop ix
		pop iy
		exx
		pop bc
		pop de
		pop af
		ld (dsc_copy+1), sp
dsc_target:
		ld sp, 0
		pop hl
		ld (dsc_target + 1), sp
		ld sp, hl
		push af
		push de
		push bc
		exx
		push iy
		push ix
		push hl
		push de
		push bc
		ld hl, (dsc_counter)
		ld de, 1
		xor a
		sbc hl, de
		ld (dsc_counter), hl
		jp nz, dsc_copy
		jp dsc_restore_stack
dsc_counter:
		defw 0
dsc_restore_stack:
		ld sp, 0
		ld hl, _attribBuffer.__DATA__
		ld de, 22528
		ld bc, 768
		ldir
		pop iy
		pop ix
#line 1200
_dumpScreen__leave:
	ld sp, ix
	pop ix
	ret
_dumpPixels:
	push ix
	ld ix, 0
	add ix, sp
#line 1222
		push ix
		push iy
		ld de, 384
		ld (dpx_counter), de
		ld (dpx_restore_stack + 1), sp
		ld hl, _bitmapBuffer.__DATA__
		ld (dpx_copy + 1), hl
		ld hl, _tableCP.__DATA__
		ld (dpx_target + 1), hl
dpx_copy:
		ld sp, 0
		pop bc
		pop de
		pop hl
		pop ix
		pop iy
		exx
		pop bc
		pop de
		pop af
		ld (dpx_copy+1), sp
dpx_target:
		ld sp, 0
		pop hl
		ld (dpx_target + 1), sp
		ld sp, hl
		push af
		push de
		push bc
		exx
		push iy
		push ix
		push hl
		push de
		push bc
		ld hl, (dpx_counter)
		ld de, 1
		xor a
		sbc hl, de
		ld (dpx_counter), hl
		jp nz, dpx_copy
		jp dpx_restore_stack
dpx_counter:
		defw 0
dpx_restore_stack:
		ld sp, 0
		pop iy
		pop ix
#line 1270
_dumpPixels__leave:
	ld sp, ix
	pop ix
	ret
_dumpPixelsTop:
	push ix
	ld ix, 0
	add ix, sp
#line 1289
		push ix
		push iy
		ld a, 96
		ld (dpt_counter), a
		ld (dpt_restore_stack + 1), sp
		ld hl, _bitmapBuffer.__DATA__
		ld (dpt_copy + 1), hl
		ld hl, _tableCP.__DATA__
		ld (dpt_target + 1), hl
dpt_copy:
		ld sp, 0
		pop bc
		pop de
		pop hl
		pop ix
		pop iy
		exx
		pop bc
		pop de
		pop af
		ld (dpt_copy+1), sp
dpt_target:
		ld sp, 0
		pop hl
		ld (dpt_target + 1), sp
		ld sp, hl
		push af
		push de
		push bc
		exx
		push iy
		push ix
		push hl
		push de
		push bc
		ld a, (dpt_counter)
		dec a
		ld (dpt_counter), a
		jp nz, dpt_copy
		jp dpt_restore_stack
dpt_counter:
		defb 0
dpt_restore_stack:
		ld sp, 0
		pop iy
		pop ix
#line 1335
_dumpPixelsTop__leave:
	ld sp, ix
	pop ix
	ret
_dumpPixelsCenter:
	push ix
	ld ix, 0
	add ix, sp
#line 1356
		push ix
		push iy
		ld a, 192
		ld (dph_counter), a
		ld (dph_restore_stack + 1), sp
		ld hl, _bitmapBuffer.__DATA__ + 1536
		ld (dph_copy + 1), hl
		ld hl, _tableCP.__DATA__ + 192
		ld (dph_target + 1), hl
dph_copy:
		ld sp, 0
		pop bc
		pop de
		pop hl
		pop ix
		pop iy
		exx
		pop bc
		pop de
		pop af
		ld (dph_copy+1), sp
dph_target:
		ld sp, 0
		pop hl
		ld (dph_target + 1), sp
		ld sp, hl
		push af
		push de
		push bc
		exx
		push iy
		push ix
		push hl
		push de
		push bc
		ld a, (dph_counter)
		dec a
		ld (dph_counter), a
		jp nz, dph_copy
		jp dph_restore_stack
dph_counter:
		defb 0
dph_restore_stack:
		ld sp, 0
		pop iy
		pop ix
#line 1402
_dumpPixelsCenter__leave:
	ld sp, ix
	pop ix
	ret
_dumpPixelsBottom:
	push ix
	ld ix, 0
	add ix, sp
#line 1421
		push ix
		push iy
		ld a, 96
		ld (dpb_counter), a
		ld (dpb_restore_stack + 1), sp
		ld hl, _bitmapBuffer.__DATA__ + 4096
		ld (dpb_copy + 1), hl
		ld hl, _tableCP.__DATA__ + 576
		ld (dpb_target + 1), hl
dpb_copy:
		ld sp, 0
		pop bc
		pop de
		pop hl
		pop ix
		pop iy
		exx
		pop bc
		pop de
		pop af
		ld (dpb_copy+1), sp
dpb_target:
		ld sp, 0
		pop hl
		ld (dpb_target + 1), sp
		ld sp, hl
		push af
		push de
		push bc
		exx
		push iy
		push ix
		push hl
		push de
		push bc
		ld a, (dpb_counter)
		dec a
		ld (dpb_counter), a
		jp nz, dpb_copy
		jp dpb_restore_stack
dpb_counter:
		defb 0
dpb_restore_stack:
		ld sp, 0
		pop iy
		pop ix
#line 1467
_dumpPixelsBottom__leave:
	ld sp, ix
	pop ix
	ret
_dumpScreenTop:
	push ix
	ld ix, 0
	add ix, sp
#line 1486
		push ix
		push iy
		ld a, 96
		ld (dst_counter), a
		ld (dst_restore_stack + 1), sp
		ld hl, _bitmapBuffer.__DATA__
		ld (dst_copy + 1), hl
		ld hl, _tableCP.__DATA__
		ld (dst_target + 1), hl
dst_copy:
		ld sp, 0
		pop bc
		pop de
		pop hl
		pop ix
		pop iy
		exx
		pop bc
		pop de
		pop af
		ld (dst_copy+1), sp
dst_target:
		ld sp, 0
		pop hl
		ld (dst_target + 1), sp
		ld sp, hl
		push af
		push de
		push bc
		exx
		push iy
		push ix
		push hl
		push de
		push bc
		ld a, (dst_counter)
		dec a
		ld (dst_counter), a
		jp nz, dst_copy
		jp dst_restore_stack
dst_counter:
		defb 0
dst_restore_stack:
		ld sp, 0
		ld hl, _attribBuffer.__DATA__
		ld de, 22528
		ld bc, 192
		ldir
		pop iy
		pop ix
#line 1536
_dumpScreenTop__leave:
	ld sp, ix
	pop ix
	ret
_dumpScreenCenter:
	push ix
	ld ix, 0
	add ix, sp
#line 1558
		push ix
		push iy
		ld a, 192
		ld (dsh_counter), a
		ld (dsh_restore_stack + 1), sp
		ld hl, _bitmapBuffer.__DATA__ + 1536
		ld (dsh_copy + 1), hl
		ld hl, _tableCP.__DATA__ + 192
		ld (dsh_target + 1), hl
dsh_copy:
		ld sp, 0
		pop bc
		pop de
		pop hl
		pop ix
		pop iy
		exx
		pop bc
		pop de
		pop af
		ld (dsh_copy+1), sp
dsh_target:
		ld sp, 0
		pop hl
		ld (dsh_target + 1), sp
		ld sp, hl
		push af
		push de
		push bc
		exx
		push iy
		push ix
		push hl
		push de
		push bc
		ld a, (dsh_counter)
		dec a
		ld (dsh_counter), a
		jp nz, dsh_copy
		jp dsh_restore_stack
dsh_counter:
		defb 0
dsh_restore_stack:
		ld sp, 0
		ld hl, _attribBuffer.__DATA__ + 192
		ld de, 22528 + 192
		ld bc, 384
		ldir
		pop iy
		pop ix
#line 1608
_dumpScreenCenter__leave:
	ld sp, ix
	pop ix
	ret
_dumpScreenBottom:
	push ix
	ld ix, 0
	add ix, sp
#line 1630
		push ix
		push iy
		ld a, 96
		ld (dsb_counter), a
		ld (dsb_restore_stack + 1), sp
		ld hl, _bitmapBuffer.__DATA__ + 4608
		ld (dsb_copy + 1), hl
		ld hl, _tableCP.__DATA__ + 576
		ld (dsb_target + 1), hl
dsb_copy:
		ld sp, 0
		pop bc
		pop de
		pop hl
		pop ix
		pop iy
		exx
		pop bc
		pop de
		pop af
		ld (dsb_copy+1), sp
dsb_target:
		ld sp, 0
		pop hl
		ld (dsb_target + 1), sp
		ld sp, hl
		push af
		push de
		push bc
		exx
		push iy
		push ix
		push hl
		push de
		push bc
		ld a, (dsb_counter)
		dec a
		ld (dsb_counter), a
		jp nz, dsb_copy
		jp dsb_restore_stack
dsb_counter:
		defb 0
dsb_restore_stack:
		ld sp, 0
		ld hl, _attribBuffer.__DATA__ + 576
		ld de, 22528 + 576
		ld bc, 192
		ldir
		pop iy
		pop ix
#line 1680
_dumpScreenBottom__leave:
	ld sp, ix
	pop ix
	ret
_dumpAttribs:
	push ix
	ld ix, 0
	add ix, sp
#line 1703
		xor a
		ld de, 22528
		ld hl, _attribBuffer.__DATA__
		ld bc, 768
		ldir
#line 1708
_dumpAttribs__leave:
	ld sp, ix
	pop ix
	ret
_dumpAttribsTop:
	push ix
	ld ix, 0
	add ix, sp
#line 1717
		xor a
		ld de, 22528
		ld hl, _attribBuffer.__DATA__
		ld bc, 192
		ldir
#line 1722
_dumpAttribsTop__leave:
	ld sp, ix
	pop ix
	ret
_dumpAttribsCenter:
	push ix
	ld ix, 0
	add ix, sp
#line 1731
		xor a
		ld de, 22528 + 192
		ld hl, _attribBuffer.__DATA__ + 192
		ld bc, 384
		ldir
#line 1736
_dumpAttribsCenter__leave:
	ld sp, ix
	pop ix
	ret
_dumpAttribsBottom:
	push ix
	ld ix, 0
	add ix, sp
#line 1745
		xor a
		ld de, 22528 + 576
		ld hl, _attribBuffer.__DATA__ + 576
		ld bc, 192
		ldir
#line 1750
_dumpAttribsBottom__leave:
	ld sp, ix
	pop ix
	ret
_dumpAttrib:
#line 1759
		ld de, 22529
		ld hl, 22528
		ld (hl), a
		ld bc, 767
		ldir
#line 1764
_dumpAttrib__leave:
	ret
_dumpAttribTop:
#line 1773
		ld de, 22529
		ld hl, 22528
		ld (hl), a
		ld bc, 191
		ldir
#line 1778
_dumpAttribTop__leave:
	ret
_dumpAttribCenter:
#line 1788
		ld de, 22529 + 192
		ld hl, 22528 + 192
		ld (hl), a
		ld bc, 383
		ldir
#line 1793
_dumpAttribCenter__leave:
	ret
_dumpAttribBottom:
#line 1802
		ld de, 22529 + 576
		ld hl, 22528 + 576
		ld (hl), a
		ld bc, 191
		ldir
#line 1807
_dumpAttribBottom__leave:
	ret
_waitSpace:
	push ix
	ld ix, 0
	add ix, sp
#line 222
		ei
#line 223
	xor a
	ld (_keyStates.__DATA__ + 4), a
__LABEL98:
	ld a, (_keyStates.__DATA__ + 4)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL99
	call _keybScan
	jp __LABEL98
__LABEL99:
#line 230
		di
#line 231
_waitSpace__leave:
	ld sp, ix
	pop ix
	ret
_title:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	inc sp
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 7
	call _createAttrib
	ld (ix-1), a
	ld l, a
	ld h, 0
	push hl
	ld hl, 8
	push hl
	ld hl, 1
	push hl
	ld hl, _tlc.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 8
	push hl
	ld hl, 2
	push hl
	ld hl, _mlor.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 8
	push hl
	ld hl, 3
	push hl
	ld hl, _blc.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 9
	push hl
	ld hl, 2
	push hl
	ld hl, _mlo.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 10
	push hl
	ld hl, 1
	push hl
	ld hl, _tlc.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 10
	push hl
	ld hl, 2
	push hl
	ld hl, _mlol.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 10
	push hl
	ld hl, 3
	push hl
	ld hl, _blc.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 11
	push hl
	ld hl, 3
	push hl
	ld hl, _dot.__DATA__
	call _printColorChar
	call _dumpScreenTop
	ld a, 7
	call _playAudio
#line 255
		di
#line 256
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 12
	push hl
	ld hl, 1
	push hl
	ld hl, _tlcc.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 12
	push hl
	ld hl, 2
	push hl
	ld hl, _mlor.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 12
	push hl
	ld hl, 3
	push hl
	ld hl, _blcc.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 13
	push hl
	ld hl, 1
	push hl
	ld hl, _mlo.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 13
	push hl
	ld hl, 2
	push hl
	ld hl, _mlo.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 13
	push hl
	ld hl, 3
	push hl
	ld hl, _mlo.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 14
	push hl
	ld hl, 1
	push hl
	ld hl, _rec.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 14
	push hl
	ld hl, 2
	push hl
	ld hl, _rec.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 14
	push hl
	ld hl, 3
	push hl
	ld hl, _rec.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 15
	push hl
	ld hl, 3
	push hl
	ld hl, _dot.__DATA__
	call _printColorChar
	call _dumpScreenTop
	ld a, 7
	call _playAudio
#line 275
		di
#line 276
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 16
	push hl
	ld hl, 1
	push hl
	ld hl, _tlcc.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 16
	push hl
	ld hl, 2
	push hl
	ld hl, _mlor.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 16
	push hl
	ld hl, 3
	push hl
	ld hl, _blc.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 17
	push hl
	ld hl, 1
	push hl
	ld hl, _mlo.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 17
	push hl
	ld hl, 2
	push hl
	ld hl, _mlob.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 17
	push hl
	ld hl, 3
	push hl
	ld hl, _dgl.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 18
	push hl
	ld hl, 1
	push hl
	ld hl, _rct.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 18
	push hl
	ld hl, 2
	push hl
	ld hl, _rcbs.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 18
	push hl
	ld hl, 3
	push hl
	ld hl, _dglc.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 19
	push hl
	ld hl, 3
	push hl
	ld hl, _dot.__DATA__
	call _printColorChar
	call _dumpScreenTop
	ld a, 7
	call _playAudio
#line 295
		di
#line 296
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 20
	push hl
	ld hl, 1
	push hl
	ld hl, _tlcc.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 20
	push hl
	ld hl, 2
	push hl
	ld hl, _mlc.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 20
	push hl
	ld hl, 3
	push hl
	ld hl, _blcc.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 21
	push hl
	ld hl, 1
	push hl
	ld hl, _mlo.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 21
	push hl
	ld hl, 3
	push hl
	ld hl, _mlo.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 22
	push hl
	ld hl, 1
	push hl
	ld hl, _rct.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 22
	push hl
	ld hl, 2
	push hl
	ld hl, _mlc.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 22
	push hl
	ld hl, 3
	push hl
	ld hl, _rcb.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 23
	push hl
	ld hl, 3
	push hl
	ld hl, _dot.__DATA__
	call _printColorChar
	call _dumpScreenTop
	ld a, 7
	call _playAudio
#line 314
		di
#line 315
	ld a, 1
	ld (_tmpX), a
	jp __LABEL100
__LABEL103:
	ld a, (_tmpX)
	push af
	ld a, 9
	push af
	ld a, 5
	push af
	ld hl, __LABEL105
	call __LOADSTR
	push hl
	call _printZXString
	call _dumpScreenTop
#line 323
		ei
		halt
		halt
		halt
		halt
		di
#line 329
__LABEL104:
	ld hl, _tmpX
	inc (hl)
__LABEL100:
	ld a, 7
	ld hl, (_tmpX - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL103
__LABEL102:
_title__leave:
	ld sp, ix
	pop ix
	ret
_interface:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	inc sp
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 4
	call _createAttrib
	push af
	ld a, 9
	push af
	ld a, 14
	push af
	ld a, 19
	push af
	ld hl, _energy.__DATA__
	push hl
	call _printRepeatColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 5
	call _createAttrib
	ld (ix-1), a
	ld l, a
	ld h, 0
	push hl
	ld hl, 0
	push hl
	ld hl, 21
	push hl
	ld hl, _head1r.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 0
	push hl
	ld hl, 22
	push hl
	ld hl, _body1r.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 2
	push hl
	ld hl, 21
	push hl
	ld hl, _head1r.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 2
	push hl
	ld hl, 22
	push hl
	ld hl, _body1r.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 4
	push hl
	ld hl, 21
	push hl
	ld hl, _head1r.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 4
	push hl
	ld hl, 22
	push hl
	ld hl, _body1r.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 6
	push hl
	ld hl, 21
	push hl
	ld hl, _head1r.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 6
	push hl
	ld hl, 22
	push hl
	ld hl, _body1r.__DATA__
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 2
	call _createAttrib
	ld (ix-1), a
	ld l, a
	ld h, 0
	push hl
	ld hl, 25
	push hl
	ld hl, 21
	push hl
	ld hl, _dynamite1.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 27
	push hl
	ld hl, 21
	push hl
	ld hl, _dynamite2.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 29
	push hl
	ld hl, 21
	push hl
	ld hl, _dynamite1.__DATA__
	call _printColorChar
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 31
	push hl
	ld hl, 21
	push hl
	ld hl, _dynamite2.__DATA__
	call _printColorChar
	xor a
	push af
	xor a
	push af
	xor a
	push af
	ld a, 7
	call _createAttrib
	ld (ix-1), a
	push af
	ld a, 8
	push af
	ld a, 19
	push af
	ld hl, __LABEL106
	call __LOADSTR
	push hl
	call _printZXString
	ld a, (ix-1)
	push af
	ld a, 2
	push af
	ld a, 19
	push af
	ld hl, __LABEL107
	call __LOADSTR
	push hl
	call _printZXString
	ld a, (ix-1)
	push af
	ld a, 26
	push af
	ld a, 19
	push af
	ld hl, __LABEL108
	call __LOADSTR
	push hl
	call _printZXString
	ld a, (ix-1)
	push af
	ld a, 7
	push af
	ld a, 23
	push af
	ld hl, __LABEL109
	call __LOADSTR
	push hl
	call _printZXString
	ld a, (ix-1)
	push af
	ld a, 10
	push af
	ld a, 21
	push af
	ld hl, __LABEL110
	call __LOADSTR
	push hl
	call _printZXString
_interface__leave:
	ld sp, ix
	pop ix
	ret
_intro:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	push ix
	pop hl
	ld bc, -1
	add hl, bc
	ex de, hl
	ld hl, __LABEL674
	ld bc, 1
	ldir
	xor a
	call _clearScreen
	call _dumpScreen
	call _title
	ld a, 1
	push af
	ld a, 1
	push af
	ld a, 5
	push af
	xor a
	call _createAttrib
	push af
	ld a, 9
	push af
	ld a, 11
	push af
	ld hl, __LABEL111
	call __LOADSTR
	push hl
	call _printZXString
#line 399
		ei
		halt
		di
#line 402
	call _dumpScreen
	call _waitSpace
	call _interface
	call _dumpScreenBottom
_intro__leave:
	ld sp, ix
	pop ix
	ret
_transformSolids:
	push ix
	ld ix, 0
	add ix, sp
	ld a, (ix+5)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL112
	ld hl, _pattern1.__DATA__
	ld (_tmpPattern), hl
	jp __LABEL113
__LABEL112:
	ld a, (ix+5)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL114
	ld hl, _pattern2.__DATA__
	ld (_tmpPattern), hl
	jp __LABEL115
__LABEL114:
	ld hl, _pattern3.__DATA__
	ld (_tmpPattern), hl
__LABEL115:
__LABEL113:
#line 427
		push ix
		ld hl, _wallt.__DATA__
		ld hl, solidTable
solidOuterLoop:
		push hl
		push hl
		pop ix
		ld l, (ix)
		ld h, (ix+1)
		ld a, h
		or l
		jp z, solidTransformEnd
		ld b, 0
		ld de, (_tmpPattern)
solidInnerLoop:
		ld a, (de)
		xor (hl)
		ld (hl), a
		inc hl
		inc de
		inc b
		ld a, b
		cp 8
		jp nz, solidInnerLoop
		pop hl
		inc hl
		inc hl
		jp solidOuterLoop
solidTable:
		defw _solid.__DATA__
		defw _wallt.__DATA__
		defw _wallb.__DATA__
		defw _walll.__DATA__
		defw _wallr.__DATA__
		defw _singleWallH.__DATA__
		defw _singleWallV.__DATA__
		defw _wallbr.__DATA__
		defw _walltr.__DATA__
		defw _wallbl.__DATA__
		defw _walltl.__DATA__
		defw _rockR.__DATA__
		defw _rockL.__DATA__
		defw _rockB.__DATA__
		defw _rockT.__DATA__
		defw 00
solidTransformEnd:
		pop hl
		pop ix
#line 475
_transformSolids__leave:
	ld sp, ix
	pop ix
	exx
	pop hl
	ex (sp), hl
	exx
	ret
_decodeCurrentScreen:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, -20
	add hl, sp
	ld sp, hl
	ld (hl), 0
	ld bc, 19
	ld d, h
	ld e, l
	inc de
	ldir
	ld hl, (_currentMapIndex)
	dec hl
	push hl
	ld hl, _maps
	call __ARRAY
	ld a, (hl)
	ld l, a
	ld h, 0
	ld (ix-14), l
	ld (ix-13), h
	ld hl, 114
	push hl
	ld l, (ix-14)
	ld h, (ix-13)
	dec hl
	push hl
	ld hl, _screens
	call __ARRAY
	ld a, (hl)
	ld (ix-2), a
	xor a
	push af
	xor a
	push af
	ld a, (ix-2)
	push af
	ld h, 7
	pop af
	and h
	push af
	ld a, (ix-2)
	srl a
	srl a
	srl a
	push af
	ld h, 7
	pop af
	and h
	call _createAttrib
	ld (_emptyAttrib), a
	ld a, (ix-2)
	ld b, 6
__LABEL675:
	srl a
	djnz __LABEL675
	push af
	ld h, 3
	pop af
	and h
	ld (_currentMapExit), a
	ld a, (ix-2)
	push af
	ld h, 7
	pop af
	and h
	call BORDER
	ld a, (_emptyAttrib)
	call _clearScreenCenter
	ld hl, 115
	push hl
	ld l, (ix-14)
	ld h, (ix-13)
	dec hl
	push hl
	ld hl, _screens
	call __ARRAY
	ld a, (hl)
	ld (ix-2), a
	xor a
	push af
	xor a
	push af
	ld a, (ix-2)
	push af
	ld h, 7
	pop af
	and h
	push af
	ld a, (ix-2)
	srl a
	srl a
	srl a
	push af
	ld h, 7
	pop af
	and h
	call _createAttrib
	ld (ix-3), a
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 7
	call _createAttrib
	ld (ix-4), a
	xor a
	push af
	xor a
	push af
	ld a, 6
	push af
	ld a, 2
	call _createAttrib
	ld (ix-5), a
	ld a, 1
	push af
	xor a
	push af
	ld a, 5
	push af
	ld a, 1
	call _createAttrib
	ld (ix-6), a
	ld a, (ix-2)
	ld b, 6
__LABEL676:
	srl a
	djnz __LABEL676
	push af
	ld h, 3
	pop af
	and h
	ld (_tmpX), a
	or a
	jp z, __LABEL117
	ld a, (_tmpX)
	push af
	call _transformSolids
__LABEL117:
	ld (ix-1), 1
	jp __LABEL118
__LABEL121:
	ld a, (ix-1)
	dec a
	ld h, 8
	call __DIVU8_FAST
	ld l, a
	ld h, 0
	ld (ix-16), l
	ld (ix-15), h
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-16)
	ld h, (ix-15)
	add hl, hl
	add hl, hl
	add hl, hl
	ex de, hl
	pop hl
	or a
	sbc hl, de
	dec hl
	add hl, hl
	add hl, hl
	ld (ix-18), l
	ld (ix-17), h
	ld a, (ix-1)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld l, (ix-14)
	ld h, (ix-13)
	dec hl
	push hl
	ld hl, _screens
	call __ARRAY
	ld a, (hl)
	ld (ix-2), a
	push af
	ld h, 3
	pop af
	and h
	push af
	ld l, (ix-16)
	ld h, (ix-15)
	inc hl
	dec hl
	push hl
	ld l, (ix-18)
	ld h, (ix-17)
	inc hl
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix-2)
	srl a
	srl a
	push af
	ld h, 3
	pop af
	and h
	push af
	ld l, (ix-16)
	ld h, (ix-15)
	inc hl
	dec hl
	push hl
	ld l, (ix-18)
	ld h, (ix-17)
	inc hl
	inc hl
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix-2)
	ld b, 4
__LABEL677:
	srl a
	djnz __LABEL677
	push af
	ld h, 3
	pop af
	and h
	push af
	ld l, (ix-16)
	ld h, (ix-15)
	inc hl
	dec hl
	push hl
	ld l, (ix-18)
	ld h, (ix-17)
	inc hl
	inc hl
	inc hl
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix-2)
	ld b, 6
__LABEL678:
	srl a
	djnz __LABEL678
	push af
	ld h, 3
	pop af
	and h
	push af
	ld l, (ix-16)
	ld h, (ix-15)
	inc hl
	dec hl
	push hl
	ld l, (ix-18)
	ld h, (ix-17)
	ld de, 4
	add hl, de
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	pop af
	ld (hl), a
__LABEL122:
	inc (ix-1)
__LABEL118:
	ld a, (ix-1)
	push af
	ld a, 96
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL121
__LABEL120:
	ld (ix-16), 12
	ld (ix-15), 0
	jp __LABEL123
__LABEL126:
	ld (ix-12), 1
	ld (ix-18), 1
	ld (ix-17), 0
	jp __LABEL128
__LABEL131:
	ld l, (ix-18)
	ld h, (ix-17)
	push hl
	ld de, 1
	pop hl
	call __EQ16
	call __NORMALIZE_BOOLEAN
	push af
	ld l, (ix-16)
	ld h, (ix-15)
	dec hl
	push hl
	ld l, (ix-18)
	ld h, (ix-17)
	dec hl
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	ld (ix-9), a
	ld l, (ix-18)
	ld h, (ix-17)
	push hl
	ld de, 32
	pop hl
	call __EQ16
	call __NORMALIZE_BOOLEAN
	push af
	ld l, (ix-16)
	ld h, (ix-15)
	dec hl
	push hl
	ld l, (ix-18)
	ld h, (ix-17)
	inc hl
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	ld (ix-10), a
	ld l, (ix-16)
	ld h, (ix-15)
	push hl
	ld de, 1
	pop hl
	call __EQ16
	call __NORMALIZE_BOOLEAN
	push af
	ld l, (ix-16)
	ld h, (ix-15)
	dec hl
	dec hl
	push hl
	ld l, (ix-18)
	ld h, (ix-17)
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	ld (ix-7), a
	ld l, (ix-16)
	ld h, (ix-15)
	push hl
	ld de, 12
	pop hl
	call __EQ16
	call __NORMALIZE_BOOLEAN
	push af
	ld l, (ix-16)
	ld h, (ix-15)
	inc hl
	dec hl
	push hl
	ld l, (ix-18)
	ld h, (ix-17)
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	ld (ix-8), a
	ld l, (ix-16)
	ld h, (ix-15)
	dec hl
	push hl
	ld l, (ix-18)
	ld h, (ix-17)
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-11), a
	or a
	jp z, __LABEL133
	ld a, (ix-11)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL135
	ld a, (ix-3)
	ld (ix-11), a
	ld (ix-12), 1
	jp __LABEL136
__LABEL135:
	ld a, (ix-11)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL137
	ld a, (ix-9)
	ld h, (ix-8)
	or a
	jr z, __LABEL679
	ld a, h
__LABEL679:
	call __NORMALIZE_BOOLEAN
	ld h, (ix-10)
	or a
	jr z, __LABEL680
	ld a, h
__LABEL680:
	call __NORMALIZE_BOOLEAN
	ld h, (ix-12)
	or a
	jr z, __LABEL681
	ld a, h
__LABEL681:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL139
	ld a, (ix-6)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-18)
	ld h, (ix-17)
	dec hl
	push hl
	ld l, (ix-16)
	ld h, (ix-15)
	ld de, 5
	add hl, de
	push hl
	ld hl, _water.__DATA__
	call _printColorChar
	jp __LABEL132
__LABEL139:
	ld a, (ix-5)
	ld (ix-11), a
__LABEL140:
	jp __LABEL138
__LABEL137:
	ld a, (ix-7)
	ld h, (ix-8)
	or a
	jr z, __LABEL682
	ld a, h
__LABEL682:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL141
	ld a, (ix-4)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-18)
	ld h, (ix-17)
	dec hl
	push hl
	ld l, (ix-16)
	ld h, (ix-15)
	ld de, 5
	add hl, de
	push hl
	ld hl, _destructibleWallV.__DATA__
	call _printColorChar
	jp __LABEL132
__LABEL141:
	ld a, (ix-9)
	ld h, (ix-10)
	or a
	jr z, __LABEL683
	ld a, h
__LABEL683:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL144
	ld a, (ix-4)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-18)
	ld h, (ix-17)
	dec hl
	push hl
	ld l, (ix-16)
	ld h, (ix-15)
	ld de, 5
	add hl, de
	push hl
	ld hl, _destructibleWallH.__DATA__
	call _printColorChar
	jp __LABEL132
__LABEL144:
__LABEL142:
	jp __LABEL132
__LABEL138:
__LABEL136:
	ld a, (ix-9)
	ld h, (ix-10)
	or a
	jr z, __LABEL684
	ld a, h
__LABEL684:
	call __NORMALIZE_BOOLEAN
	ld h, (ix-7)
	or a
	jr z, __LABEL685
	ld a, h
__LABEL685:
	call __NORMALIZE_BOOLEAN
	ld h, (ix-8)
	or a
	jr z, __LABEL686
	ld a, h
__LABEL686:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL145
	ld hl, _solid.__DATA__
	ld (ix-20), l
	ld (ix-19), h
	jp __LABEL146
__LABEL145:
	ld a, (ix-9)
	ld h, (ix-10)
	or a
	jr z, __LABEL687
	ld a, h
__LABEL687:
	call __NORMALIZE_BOOLEAN
	ld h, (ix-7)
	or a
	jr z, __LABEL688
	ld a, h
__LABEL688:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL147
	ld hl, _wallt.__DATA__
	ld (ix-20), l
	ld (ix-19), h
	jp __LABEL148
__LABEL147:
	ld a, (ix-9)
	ld h, (ix-10)
	or a
	jr z, __LABEL689
	ld a, h
__LABEL689:
	call __NORMALIZE_BOOLEAN
	ld h, (ix-8)
	or a
	jr z, __LABEL690
	ld a, h
__LABEL690:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL149
	ld hl, _wallb.__DATA__
	ld (ix-20), l
	ld (ix-19), h
	jp __LABEL150
__LABEL149:
	ld a, (ix-9)
	ld h, (ix-7)
	or a
	jr z, __LABEL691
	ld a, h
__LABEL691:
	call __NORMALIZE_BOOLEAN
	ld h, (ix-8)
	or a
	jr z, __LABEL692
	ld a, h
__LABEL692:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL151
	ld hl, _walll.__DATA__
	ld (ix-20), l
	ld (ix-19), h
	jp __LABEL152
__LABEL151:
	ld a, (ix-10)
	ld h, (ix-7)
	or a
	jr z, __LABEL693
	ld a, h
__LABEL693:
	call __NORMALIZE_BOOLEAN
	ld h, (ix-8)
	or a
	jr z, __LABEL694
	ld a, h
__LABEL694:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL153
	ld hl, _wallr.__DATA__
	ld (ix-20), l
	ld (ix-19), h
	jp __LABEL154
__LABEL153:
	ld a, (ix-9)
	ld h, (ix-10)
	or a
	jr z, __LABEL695
	ld a, h
__LABEL695:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL155
	ld hl, _singleWallH.__DATA__
	ld (ix-20), l
	ld (ix-19), h
	jp __LABEL156
__LABEL155:
	ld a, (ix-7)
	ld h, (ix-8)
	or a
	jr z, __LABEL696
	ld a, h
__LABEL696:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL157
	ld hl, _singleWallV.__DATA__
	ld (ix-20), l
	ld (ix-19), h
	jp __LABEL158
__LABEL157:
	ld a, (ix-9)
	ld h, (ix-7)
	or a
	jr z, __LABEL697
	ld a, h
__LABEL697:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL159
	ld hl, _wallbr.__DATA__
	ld (ix-20), l
	ld (ix-19), h
	jp __LABEL160
__LABEL159:
	ld a, (ix-9)
	ld h, (ix-8)
	or a
	jr z, __LABEL698
	ld a, h
__LABEL698:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL161
	ld hl, _walltr.__DATA__
	ld (ix-20), l
	ld (ix-19), h
	jp __LABEL162
__LABEL161:
	ld a, (ix-10)
	ld h, (ix-7)
	or a
	jr z, __LABEL699
	ld a, h
__LABEL699:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL163
	ld hl, _wallbl.__DATA__
	ld (ix-20), l
	ld (ix-19), h
	jp __LABEL164
__LABEL163:
	ld a, (ix-10)
	ld h, (ix-8)
	or a
	jr z, __LABEL700
	ld a, h
__LABEL700:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL165
	ld hl, _walltl.__DATA__
	ld (ix-20), l
	ld (ix-19), h
	jp __LABEL166
__LABEL165:
	ld a, (ix-9)
	or a
	jp z, __LABEL167
	ld hl, _rockR.__DATA__
	ld (ix-20), l
	ld (ix-19), h
	jp __LABEL168
__LABEL167:
	ld a, (ix-10)
	or a
	jp z, __LABEL169
	ld hl, _rockL.__DATA__
	ld (ix-20), l
	ld (ix-19), h
	jp __LABEL170
__LABEL169:
	ld a, (ix-7)
	or a
	jp z, __LABEL171
	ld hl, _rockB.__DATA__
	ld (ix-20), l
	ld (ix-19), h
	jp __LABEL172
__LABEL171:
	ld a, (ix-8)
	or a
	jp z, __LABEL174
	ld hl, _rockT.__DATA__
	ld (ix-20), l
	ld (ix-19), h
__LABEL174:
__LABEL172:
__LABEL170:
__LABEL168:
__LABEL166:
__LABEL164:
__LABEL162:
__LABEL160:
__LABEL158:
__LABEL156:
__LABEL154:
__LABEL152:
__LABEL150:
__LABEL148:
__LABEL146:
	ld a, (ix-11)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-18)
	ld h, (ix-17)
	dec hl
	push hl
	ld l, (ix-16)
	ld h, (ix-15)
	ld de, 5
	add hl, de
	push hl
	ld l, (ix-20)
	ld h, (ix-19)
	call _printColorChar
	jp __LABEL134
__LABEL133:
	ld (ix-12), 0
__LABEL134:
__LABEL132:
	ld l, (ix-18)
	ld h, (ix-17)
	inc hl
	ld (ix-18), l
	ld (ix-17), h
__LABEL128:
	ld l, (ix-18)
	ld h, (ix-17)
	push hl
	ld hl, 32
	pop de
	or a
	sbc hl, de
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL131
__LABEL130:
__LABEL127:
	ld l, (ix-16)
	ld h, (ix-15)
	dec hl
	ld (ix-16), l
	ld (ix-15), h
__LABEL123:
	ld l, (ix-16)
	ld h, (ix-15)
	push hl
	ld de, 1
	pop hl
	or a
	sbc hl, de
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL126
__LABEL125:
	ld a, (_tmpX)
	or a
	jp z, __LABEL176
	ld a, (_tmpX)
	push af
	call _transformSolids
__LABEL176:
	xor a
	ld (_enemyCount), a
	xor a
	ld (_frameCounter), a
	ld a, 1
	ld (_tmpX), a
	jp __LABEL177
__LABEL180:
	ld a, 1
	ld (_tmpY), a
	jp __LABEL182
__LABEL185:
	ld a, (_tmpY)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (_tmpX)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 0
__LABEL186:
	ld hl, _tmpY
	inc (hl)
__LABEL182:
	ld a, 11
	ld hl, (_tmpY - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL185
__LABEL184:
__LABEL181:
	ld hl, _tmpX
	inc (hl)
__LABEL177:
	ld a, 6
	ld hl, (_tmpX - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL180
__LABEL179:
	xor a
	push af
	xor a
	push af
	ld a, (_emptyAttrib)
	and 56
	srl a
	srl a
	srl a
	push af
	ld a, 2
	call _createAttrib
	ld (_dynaColor), a
	ld (ix-18), 97
	ld (ix-17), 0
	jp __LABEL187
__LABEL190:
	ld l, (ix-18)
	ld h, (ix-17)
	dec hl
	push hl
	ld l, (ix-14)
	ld h, (ix-13)
	dec hl
	push hl
	ld hl, _screens
	call __ARRAY
	ld a, (hl)
	ld (ix-2), a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp nz, __LABEL189
__LABEL193:
	ld a, (ix-3)
	ld (_tmpColor), a
	ld l, (ix-18)
	ld h, (ix-17)
	inc hl
	inc hl
	dec hl
	push hl
	ld l, (ix-14)
	ld h, (ix-13)
	dec hl
	push hl
	ld hl, _screens
	call __ARRAY
	ld a, (hl)
	add a, 5
	ld h, 8
	call __MUL8_FAST
	push af
	ld l, (ix-18)
	ld h, (ix-17)
	inc hl
	dec hl
	push hl
	ld l, (ix-14)
	ld h, (ix-13)
	dec hl
	push hl
	ld hl, _screens
	call __ARRAY
	ld a, (hl)
	dec a
	ld h, 8
	call __MUL8_FAST
	push af
	ld a, (ix-2)
	push af
	ld h, 15
	pop af
	and h
	push af
	call _loadItem
__LABEL191:
	ld l, (ix-18)
	ld h, (ix-17)
	inc hl
	inc hl
	inc hl
	ld (ix-18), l
	ld (ix-17), h
__LABEL187:
	ld l, (ix-18)
	ld h, (ix-17)
	push hl
	ld hl, 115
	pop de
	or a
	sbc hl, de
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL190
__LABEL189:
_decodeCurrentScreen__leave:
	ld sp, ix
	pop ix
	ret
_loadItem:
	push ix
	ld ix, 0
	add ix, sp
	ld a, (ix+5)
	push af
	ld h, 7
	pop af
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL194
	ld hl, _enemyCount
	inc (hl)
	ld a, (ix+5)
	push af
	ld hl, 0
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+7)
	push af
	ld hl, 1
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+9)
	push af
	ld hl, 2
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+7)
	push af
	ld hl, 3
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+9)
	push af
	ld hl, 4
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+5)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL196
	ld a, (ix+7)
	push af
	ld hl, 5
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+9)
	sub 8
	push af
	ld hl, 6
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+7)
	push af
	ld hl, 7
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+9)
	add a, 8
	push af
	ld hl, 8
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld hl, 9
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 0
	ld hl, 10
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 2
	xor a
	push af
	xor a
	push af
	ld a, (_emptyAttrib)
	and 56
	srl a
	srl a
	srl a
	push af
	ld a, 3
	call _createAttrib
	ld (_vampColor), a
	ld (_tmpColor), a
	ld hl, _vampUp.__DATA__
	ld (_tmpItem), hl
	jp __LABEL197
__LABEL196:
	ld a, (ix+5)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL198
	ld a, (ix+7)
	push af
	ld hl, 5
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+9)
	sub 2
	push af
	ld hl, 6
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+7)
	push af
	ld hl, 7
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+9)
	add a, 2
	push af
	ld hl, 8
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld hl, 9
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 0
	ld hl, 10
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 1
	xor a
	push af
	xor a
	push af
	ld a, (_emptyAttrib)
	and 56
	srl a
	srl a
	srl a
	push af
	ld a, 7
	call _createAttrib
	ld (_spiderColor), a
	ld (_tmpColor), a
	ld hl, _spider.__DATA__
	ld (_tmpItem), hl
	jp __LABEL199
__LABEL198:
	ld a, (ix+5)
	sub 3
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL200
	ld a, (ix+7)
	sub 16
	push af
	ld hl, 5
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+9)
	push af
	ld hl, 6
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+7)
	add a, 16
	push af
	ld hl, 7
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+9)
	push af
	ld hl, 8
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld hl, 9
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 2
	ld hl, 10
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 0
	xor a
	push af
	xor a
	push af
	ld a, (_emptyAttrib)
	and 56
	srl a
	srl a
	srl a
	push af
	ld a, 7
	call _createAttrib
	ld (_flyColor), a
	ld (_tmpColor), a
	ld hl, _fly1.__DATA__
	ld (_tmpItem), hl
	jp __LABEL201
__LABEL200:
	ld a, (ix+5)
	sub 4
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL202
	ld a, (ix+7)
	sub 16
	push af
	ld hl, 5
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+9)
	sub 16
	push af
	ld hl, 6
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+7)
	add a, 16
	push af
	ld hl, 7
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+9)
	add a, 16
	push af
	ld hl, 8
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld hl, 9
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 2
	ld hl, 10
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 1
	xor a
	push af
	xor a
	push af
	ld a, (_emptyAttrib)
	and 56
	srl a
	srl a
	srl a
	push af
	ld a, 2
	call _createAttrib
	ld (_bugColor), a
	ld (_tmpColor), a
	ld hl, _bug1.__DATA__
	ld (_tmpItem), hl
	jp __LABEL203
__LABEL202:
	ld a, (ix+5)
	sub 5
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL204
	ld a, (_tmpColor)
	ld (_snakeColor), a
	xor a
	ld (_tmpX), a
	xor a
	ld (_tmpY), a
	ld a, (ix+9)
	ld h, 8
	call __DIVU8_FAST
	sub 5
	ld (_tmpColor), a
	ld a, (ix+7)
	ld h, 8
	call __DIVU8_FAST
	inc a
	ld (_tmpZ), a
	jp __LABEL206
__LABEL209:
	ld a, (_tmpColor)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (_tmpZ)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	or a
	jp z, __LABEL212
	ld a, (_tmpZ)
	sub 2
	ld h, 8
	call __MUL8_FAST
	ld (_tmpX), a
	jp __LABEL208
__LABEL212:
__LABEL210:
	ld hl, _tmpZ
	inc (hl)
__LABEL206:
	ld a, 32
	ld hl, (_tmpZ - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL209
__LABEL208:
	ld a, (ix+7)
	ld h, 8
	call __DIVU8_FAST
	inc a
	ld (_tmpZ), a
	jp __LABEL213
__LABEL216:
	ld a, (_tmpColor)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (_tmpZ)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	or a
	jp z, __LABEL219
	ld a, (_tmpZ)
	ld h, 8
	call __MUL8_FAST
	ld (_tmpY), a
	jp __LABEL215
__LABEL219:
__LABEL217:
	ld hl, _tmpZ
	dec (hl)
__LABEL213:
	ld a, (_tmpZ)
	cp 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL216
__LABEL215:
	ld hl, 5
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (_tmpY)
	ld (hl), a
	ld a, (ix+9)
	push af
	ld hl, 6
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld hl, 7
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (_tmpX)
	ld (hl), a
	ld a, (ix+9)
	push af
	ld hl, 8
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld hl, 9
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 2
	ld hl, 10
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 0
	xor a
	push af
	xor a
	push af
	ld a, (_emptyAttrib)
	and 56
	srl a
	srl a
	srl a
	push af
	ld a, 6
	call _createAttrib
	ld (_crabColor), a
	ld (_tmpColor), a
	ld hl, _crab1.__DATA__
	ld (_tmpItem), hl
	jp __LABEL205
__LABEL204:
	ld a, (ix+9)
	push af
	ld hl, 6
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+9)
	push af
	ld hl, 8
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld hl, 9
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 1
	ld hl, 10
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 0
	ld a, (_tmpColor)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix+7)
	ld h, 8
	call __DIVU8_FAST
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	or a
	jp z, __LABEL220
	ld a, (ix+7)
	push af
	ld hl, 5
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+7)
	add a, 8
	push af
	ld hl, 7
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld hl, _skh1.__DATA__
	ld (_tmpItem), hl
	jp __LABEL221
__LABEL220:
	ld a, (ix+7)
	sub 8
	push af
	ld hl, 5
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+7)
	push af
	ld hl, 7
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld hl, _skh2.__DATA__
	ld (_tmpItem), hl
__LABEL221:
	ld a, (_snakeColor)
	ld (_tmpColor), a
__LABEL205:
__LABEL203:
__LABEL201:
__LABEL199:
__LABEL197:
	ld a, (_tmpColor)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix+7)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix+9)
	ld l, a
	ld h, 0
	push hl
	ld hl, (_tmpItem)
	call _drawColorSprite
	jp __LABEL195
__LABEL194:
	ld a, (ix+5)
	sub 7
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL222
	ld hl, _enemyCount
	inc (hl)
	ld a, (ix+5)
	push af
	ld hl, 0
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+7)
	push af
	ld hl, 1
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld a, (ix+9)
	push af
	ld hl, 2
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
	ld hl, 3
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 0
	ld hl, 4
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 60
	ld hl, 5
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 1
	ld hl, 6
	push hl
	ld a, (_enemyCount)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 0
	xor a
	push af
	xor a
	push af
	ld a, (_emptyAttrib)
	and 56
	srl a
	srl a
	srl a
	push af
	ld a, 4
	call _createAttrib
	ld (_crocoColor), a
	jp __LABEL223
__LABEL222:
	ld a, (ix+5)
	sub 8
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL224
	ld a, (ix+7)
	ld (_lampX), a
	ld a, (ix+9)
	ld (_lampY), a
	ld a, (ix+9)
	ld h, 8
	call __DIVU8_FAST
	add a, 5
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix+7)
	ld h, 8
	call __DIVU8_FAST
	add a, 2
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	or a
	jp z, __LABEL226
	xor a
	push af
	xor a
	push af
	ld a, (_emptyAttrib)
	and 56
	srl a
	srl a
	srl a
	push af
	ld a, 6
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld a, (ix+7)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix+9)
	ld l, a
	ld h, 0
	push hl
	ld hl, _lampl.__DATA__
	call _drawColorSprite
	jp __LABEL227
__LABEL226:
	xor a
	push af
	xor a
	push af
	ld a, (_emptyAttrib)
	and 56
	srl a
	srl a
	srl a
	push af
	ld a, 6
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld a, (ix+7)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix+9)
	ld l, a
	ld h, 0
	push hl
	ld hl, _lampr.__DATA__
	call _drawColorSprite
__LABEL227:
	jp __LABEL225
__LABEL224:
	ld a, (ix+5)
	sub 9
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL229
	ld a, (ix+7)
	ld (_personX), a
	ld a, (ix+9)
	ld (_personY), a
	xor a
	push af
	xor a
	push af
	ld a, (_emptyAttrib)
	and 56
	srl a
	srl a
	srl a
	push af
	ld a, 7
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld a, (ix+7)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix+9)
	ld l, a
	ld h, 0
	push hl
	ld hl, _personT.__DATA__
	call _drawColorSprite
	xor a
	push af
	xor a
	push af
	ld a, (_emptyAttrib)
	and 56
	srl a
	srl a
	srl a
	push af
	ld a, 7
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld a, (ix+7)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix+9)
	add a, 8
	ld l, a
	ld h, 0
	push hl
	ld hl, _personB.__DATA__
	call _drawColorSprite
__LABEL229:
__LABEL225:
__LABEL223:
__LABEL195:
_loadItem__leave:
	ld sp, ix
	pop ix
	exx
	pop hl
	pop bc
	pop bc
	ex (sp), hl
	exx
	ret
_checkPlayerCollision:
	push ix
	ld ix, 0
	add ix, sp
	ld a, (ix+5)
	add a, 8
	ld h, a
	ld a, (_playerX)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_playerX)
	add a, 8
	push af
	ld a, (ix+5)
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL701
	ld a, h
__LABEL701:
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix+7)
	add a, 8
	ld h, a
	ld a, (_playerY)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL702
	ld a, h
__LABEL702:
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_playerY)
	add a, 16
	push af
	ld a, (ix+7)
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL703
	ld a, h
__LABEL703:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL231
	ld a, 1
	jp _checkPlayerCollision__leave
__LABEL231:
	xor a
_checkPlayerCollision__leave:
	ld sp, ix
	pop ix
	exx
	pop hl
	pop bc
	ex (sp), hl
	exx
	ret
_moveEnemy:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 1
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld (_tmpX), a
	ld hl, 2
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld (_tmpY), a
	ld hl, 3
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (_tmpX)
	ld (hl), a
	ld hl, 4
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (_tmpY)
	ld (hl), a
	ld hl, 9
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld (_tmpDisplace), a
	ld a, (_tmpX)
	ld h, a
	ld a, (_tmpDisplace)
	add a, h
	ld (_tmpX), a
	ld hl, 5
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (_tmpX)
	cp (hl)
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld hl, 7
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld hl, (_tmpX - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL233
	ld a, (_tmpX)
	push af
	ld hl, (_tmpDisplace - 1)
	ld a, (_tmpDisplace)
	add a, h
	ld h, a
	pop af
	sub h
	ld (_tmpX), a
	ld a, (_tmpDisplace)
	neg
	push af
	ld hl, 9
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
__LABEL233:
	ld hl, 10
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld (_tmpDisplace), a
	ld a, (_tmpY)
	ld h, a
	ld a, (_tmpDisplace)
	add a, h
	ld (_tmpY), a
	ld hl, 6
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (_tmpY)
	cp (hl)
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld hl, 8
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld hl, (_tmpY - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL235
	ld a, (_tmpY)
	push af
	ld hl, (_tmpDisplace - 1)
	ld a, (_tmpDisplace)
	add a, h
	ld h, a
	pop af
	sub h
	ld (_tmpY), a
	ld a, (_tmpDisplace)
	neg
	push af
	ld hl, 10
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	pop af
	ld (hl), a
__LABEL235:
	ld hl, 1
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (_tmpX)
	ld (hl), a
	ld hl, 2
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (_tmpY)
	ld (hl), a
	ld a, (_tmpY)
	push af
	ld a, (_tmpX)
	push af
	call _checkPlayerCollision
_moveEnemy__leave:
	ld sp, ix
	pop ix
	exx
	pop hl
	ex (sp), hl
	exx
	ret
_updateCrocodile:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 4
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld (_tmpX), a
	ld hl, 3
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld (_tmpY), a
	ld hl, 7
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (_tmpY)
	ld (hl), a
	ld hl, _tmpX
	dec (hl)
	ld a, (_tmpX)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL237
	ld a, (_tmpY)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL238
	ld a, 1
	ld (_tmpY), a
	ld a, 30
	ld (_tmpX), a
	ld hl, 5
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 1
	ld hl, 6
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 1
	jp __LABEL239
__LABEL238:
	ld a, (_tmpY)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL240
	ld hl, 5
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	or a
	jp z, __LABEL242
	ld a, 2
	ld (_tmpY), a
	ld a, 10
	ld (_tmpX), a
	ld hl, 6
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 1
	jp __LABEL243
__LABEL242:
	xor a
	ld (_tmpY), a
	ld a, 60
	ld (_tmpX), a
__LABEL243:
	jp __LABEL241
__LABEL240:
	ld a, 1
	ld (_tmpY), a
	ld a, 30
	ld (_tmpX), a
	ld hl, 5
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 0
	ld hl, 6
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 1
__LABEL241:
__LABEL239:
	ld hl, 3
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (_tmpY)
	ld (hl), a
__LABEL237:
	ld hl, 4
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (_tmpX)
	ld (hl), a
	ld a, (_tmpY)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL245
	xor a
	jp _updateCrocodile__leave
__LABEL245:
	ld hl, 1
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld (_tmpX), a
	ld hl, 2
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld (_tmpY), a
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL246
	ld a, (_tmpY)
	add a, 4
	ld (_tmpY), a
	ld a, (_tmpX)
	add a, 8
	ld h, a
	ld a, (_playerX)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_playerX)
	add a, 8
	push af
	ld a, (_tmpX)
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL704
	ld a, h
__LABEL704:
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_tmpY)
	add a, 4
	ld h, a
	ld a, (_playerY)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL705
	ld a, h
__LABEL705:
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_playerY)
	add a, 16
	push af
	ld a, (_tmpY)
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL706
	ld a, h
__LABEL706:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL249
	ld a, 1
	jp _updateCrocodile__leave
__LABEL249:
	jp __LABEL247
__LABEL246:
	ld a, (_tmpY)
	push af
	ld a, (_tmpX)
	push af
	call _checkPlayerCollision
	jp _updateCrocodile__leave
__LABEL247:
_updateCrocodile__leave:
	ld sp, ix
	pop ix
	exx
	pop hl
	ex (sp), hl
	exx
	ret
_moveEnemies:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	inc sp
	xor a
	ld (_tmpResult), a
	ld a, (_frameCounter)
	and 1
	jp z, __LABEL250
	ld a, 1
	ld (_tmpZ), a
	jp __LABEL251
__LABEL250:
	ld a, 2
	ld (_tmpZ), a
__LABEL251:
	ld a, (_tmpZ)
	ld (ix-1), a
	jp __LABEL252
__LABEL255:
	ld hl, 0
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld (_tmpX), a
	xor a
	ld hl, (_tmpX - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_tmpX)
	cp 7
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL707
	ld a, h
__LABEL707:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL257
	ld a, (ix-1)
	push af
	call _moveEnemy
	ld h, a
	ld a, (_tmpResult)
	or h
	ld (_tmpResult), a
	jp __LABEL258
__LABEL257:
	ld a, (_tmpX)
	sub 7
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL260
	ld a, (ix-1)
	push af
	call _updateCrocodile
	ld h, a
	ld a, (_tmpResult)
	or h
	ld (_tmpResult), a
__LABEL260:
__LABEL258:
__LABEL256:
	ld a, (ix-1)
	add a, 2
	ld (ix-1), a
__LABEL252:
	ld a, (ix-1)
	push af
	ld a, (_enemyCount)
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL255
__LABEL254:
	ld a, (_tmpResult)
_moveEnemies__leave:
	ld sp, ix
	pop ix
	ret
_drawEnemies:
	push ix
	ld ix, 0
	add ix, sp
	ld a, (_frameCounter)
	and 1
	jp z, __LABEL261
	ld a, 1
	ld (_tmpZ), a
	jp __LABEL263
__LABEL266:
	ld a, (_tmpZ)
	push af
	call _drawEnemy
__LABEL267:
	ld a, (_tmpZ)
	add a, 2
	ld (_tmpZ), a
__LABEL263:
	ld a, (_enemyCount)
	ld hl, (_tmpZ - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL266
__LABEL265:
	jp __LABEL262
__LABEL261:
	ld a, 2
	ld (_tmpZ), a
	jp __LABEL268
__LABEL271:
	ld a, (_tmpZ)
	push af
	call _drawEnemy
__LABEL272:
	ld a, (_tmpZ)
	add a, 2
	ld (_tmpZ), a
__LABEL268:
	ld a, (_enemyCount)
	ld hl, (_tmpZ - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL271
__LABEL270:
__LABEL262:
_drawEnemies__leave:
	ld sp, ix
	pop ix
	ret
_drawEnemy:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld (_tmpX), a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp nz, _drawEnemy__leave
__LABEL274:
	ld a, (_tmpX)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL275
	ld hl, 2
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	push af
	ld h, 2
	pop af
	and h
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL277
	ld hl, _vampUp.__DATA__
	ld (_tmpItem), hl
	ld hl, _vampDown.__DATA__
	ld (_tmpPrevItem), hl
	jp __LABEL278
__LABEL277:
	ld hl, _vampDown.__DATA__
	ld (_tmpItem), hl
	ld hl, _vampUp.__DATA__
	ld (_tmpPrevItem), hl
__LABEL278:
	ld a, (_vampColor)
	ld (_tmpColor), a
	jp __LABEL276
__LABEL275:
	ld a, (_tmpX)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL279
	ld hl, _spider.__DATA__
	ld (_tmpItem), hl
	ld hl, _spider.__DATA__
	ld (_tmpPrevItem), hl
	ld a, (_spiderColor)
	ld (_tmpColor), a
	jp __LABEL280
__LABEL279:
	ld a, (_tmpX)
	sub 3
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL281
	ld hl, 1
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	push af
	ld h, 2
	pop af
	and h
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL283
	ld hl, _fly1.__DATA__
	ld (_tmpItem), hl
	ld hl, _fly2.__DATA__
	ld (_tmpPrevItem), hl
	jp __LABEL284
__LABEL283:
	ld hl, _fly2.__DATA__
	ld (_tmpItem), hl
	ld hl, _fly1.__DATA__
	ld (_tmpPrevItem), hl
__LABEL284:
	ld a, (_flyColor)
	ld (_tmpColor), a
	jp __LABEL282
__LABEL281:
	ld a, (_tmpX)
	sub 4
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL285
	ld hl, 1
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	push af
	ld h, 2
	pop af
	and h
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL287
	ld hl, _bug1.__DATA__
	ld (_tmpItem), hl
	ld hl, _bug2.__DATA__
	ld (_tmpPrevItem), hl
	jp __LABEL288
__LABEL287:
	ld hl, _bug2.__DATA__
	ld (_tmpItem), hl
	ld hl, _bug1.__DATA__
	ld (_tmpPrevItem), hl
__LABEL288:
	ld a, (_bugColor)
	ld (_tmpColor), a
	jp __LABEL286
__LABEL285:
	ld a, (_tmpX)
	sub 5
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL289
	ld hl, 1
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	push af
	ld h, 2
	pop af
	and h
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL291
	ld hl, _crab1.__DATA__
	ld (_tmpItem), hl
	ld hl, _crab2.__DATA__
	ld (_tmpPrevItem), hl
	jp __LABEL292
__LABEL291:
	ld hl, _crab2.__DATA__
	ld (_tmpItem), hl
	ld hl, _crab1.__DATA__
	ld (_tmpPrevItem), hl
__LABEL292:
	ld a, (_crabColor)
	ld (_tmpColor), a
	jp __LABEL290
__LABEL289:
	ld a, (_tmpX)
	sub 6
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL293
	ld a, (_tmpColor)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, 1
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld h, 8
	call __DIVU8_FAST
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	or a
	jp z, __LABEL295
	ld hl, _skh1.__DATA__
	ld (_tmpItem), hl
	ld hl, _skh1.__DATA__
	ld (_tmpPrevItem), hl
	jp __LABEL296
__LABEL295:
	ld hl, _skh2.__DATA__
	ld (_tmpItem), hl
	ld hl, _skh2.__DATA__
	ld (_tmpPrevItem), hl
__LABEL296:
	ld a, (_snakeColor)
	ld (_tmpColor), a
	jp __LABEL294
__LABEL293:
	ld a, (_tmpX)
	sub 7
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL298
	ld hl, 6
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	or a
	jp z, __LABEL300
	ld hl, 7
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld (_tmpY), a
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL301
	ld hl, _crock1.__DATA__
	ld (_tmpPrevItem), hl
	jp __LABEL302
__LABEL301:
	ld a, (_tmpY)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL304
	ld hl, _crock2.__DATA__
	ld (_tmpPrevItem), hl
__LABEL304:
__LABEL302:
	ld a, (_tmpY)
	or a
	jp z, __LABEL306
	ld a, (_emptyAttrib)
	ld l, a
	ld h, 0
	push hl
	ld hl, 1
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld l, a
	ld h, 0
	push hl
	ld hl, 2
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld l, a
	ld h, 0
	push hl
	ld hl, (_tmpPrevItem)
	call _drawColorSprite
__LABEL306:
	ld hl, 3
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld (_tmpY), a
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL307
	ld hl, _crock1.__DATA__
	ld (_tmpItem), hl
	jp __LABEL308
__LABEL307:
	ld a, (_tmpY)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL310
	ld hl, _crock2.__DATA__
	ld (_tmpItem), hl
__LABEL310:
__LABEL308:
	ld a, (_tmpY)
	or a
	jp z, __LABEL312
	ld a, (_crocoColor)
	ld l, a
	ld h, 0
	push hl
	ld hl, 1
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld l, a
	ld h, 0
	push hl
	ld hl, 2
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld l, a
	ld h, 0
	push hl
	ld hl, (_tmpItem)
	call _drawColorSprite
__LABEL312:
__LABEL300:
	jp _drawEnemy__leave
__LABEL298:
__LABEL294:
__LABEL290:
__LABEL286:
__LABEL282:
__LABEL280:
__LABEL276:
	ld a, (_tmpX)
	sub 6
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL313
	ld a, (_snakeColor)
	ld l, a
	ld h, 0
	push hl
	ld hl, 3
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld l, a
	ld h, 0
	push hl
	ld hl, 4
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld l, a
	ld h, 0
	push hl
	ld hl, (_tmpPrevItem)
	call _drawColorSprite
	jp __LABEL314
__LABEL313:
	ld a, (_emptyAttrib)
	ld l, a
	ld h, 0
	push hl
	ld hl, 3
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld l, a
	ld h, 0
	push hl
	ld hl, 4
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld l, a
	ld h, 0
	push hl
	ld hl, (_tmpPrevItem)
	call _drawColorSprite
__LABEL314:
	ld a, (_deadEnemy)
	sub (ix+5)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL315
	xor a
	ld (_deadEnemy), a
	ld hl, 0
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 0
	ld a, 4
	call _playAudio
	ld hl, 100
	push hl
	call _updateScore
	jp __LABEL316
__LABEL315:
	ld a, (_tmpColor)
	ld l, a
	ld h, 0
	push hl
	ld hl, 1
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld l, a
	ld h, 0
	push hl
	ld hl, 2
	push hl
	ld a, (ix+5)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld l, a
	ld h, 0
	push hl
	ld hl, (_tmpItem)
	call _drawColorSprite
__LABEL316:
_drawEnemy__leave:
	ld sp, ix
	pop ix
	exx
	pop hl
	ex (sp), hl
	exx
	ret
_drawShot:
	push ix
	ld ix, 0
	add ix, sp
	ld a, (_prevShotX)
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL318
	ld a, (_prevShotX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_prevShotY)
	ld l, a
	ld h, 0
	push hl
	ld hl, _shot.__DATA__
	call _drawSprite
__LABEL318:
	ld a, (_shotX)
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL320
	ld a, (_shotX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_shotY)
	ld l, a
	ld h, 0
	push hl
	ld hl, _shot.__DATA__
	call _drawSprite
__LABEL320:
_drawShot__leave:
	ld sp, ix
	pop ix
	ret
_movePlayer:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, -11
	add hl, sp
	ld sp, hl
	ld (hl), 0
	ld bc, 10
	ld d, h
	ld e, l
	inc de
	ldir
	call _keybScan
	ld a, (_playerX)
	ld h, 8
	call __DIVU8_FAST
	inc a
	ld (ix-1), a
	ld a, (_playerY)
	ld h, 8
	call __DIVU8_FAST
	sub 5
	ld (ix-2), a
	ld a, (_keyStates.__DATA__ + 0)
	or a
	jp z, __LABEL322
	ld (ix-3), 254
__LABEL322:
	ld a, (_keyStates.__DATA__ + 1)
	or a
	jp z, __LABEL324
	ld (ix-3), 2
__LABEL324:
	ld a, (_keyStates.__DATA__ + 2)
	or a
	jp z, __LABEL325
	ld (ix-4), 254
	jp __LABEL326
__LABEL325:
	ld (ix-4), 2
__LABEL326:
	ld a, (_playerY)
	and 7
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld (ix-5), a
	ld a, (_playerX)
	and 7
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld (ix-6), a
	ld a, (ix-5)
	or a
	jp z, __LABEL328
	ld a, (ix-6)
	or a
	jp z, __LABEL329
	ld a, (ix-4)
	sub 254
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL331
	ld a, (ix-2)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL333
	ld (ix-10), 1
	jp __LABEL334
__LABEL333:
	ld a, (ix-2)
	push af
	ld a, 1
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL336
	ld a, (ix-2)
	dec a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-7), a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL338
	ld (ix-4), 0
	ld a, (ix-7)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL340
	ld (ix-11), 1
__LABEL340:
__LABEL338:
__LABEL336:
__LABEL334:
	jp __LABEL332
__LABEL331:
	ld a, (ix-2)
	sub 12
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL341
	ld (ix-10), 1
	jp __LABEL342
__LABEL341:
	ld a, (ix-2)
	push af
	ld h, 11
	pop af
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL344
	ld a, (ix-2)
	add a, 2
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-7), a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL346
	ld (ix-4), 0
	ld a, (ix-7)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL348
	ld (ix-11), 1
__LABEL348:
__LABEL346:
__LABEL344:
__LABEL342:
__LABEL332:
	jp __LABEL330
__LABEL329:
	ld a, (ix-4)
	sub 254
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL349
	ld a, (ix-2)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL351
	ld (ix-10), 1
	jp __LABEL352
__LABEL351:
	ld a, (ix-2)
	push af
	ld a, 1
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL354
	ld a, (ix-2)
	dec a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-7), a
	ld a, (ix-2)
	dec a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-8), a
	ld a, (ix-7)
	or (ix-8)
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL356
	ld (ix-4), 0
	ld a, (ix-7)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-8)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL358
	ld (ix-11), 1
__LABEL358:
__LABEL356:
__LABEL354:
__LABEL352:
	jp __LABEL350
__LABEL349:
	ld a, (ix-2)
	sub 12
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL359
	ld (ix-10), 1
	jp __LABEL360
__LABEL359:
	ld a, (ix-2)
	push af
	ld h, 11
	pop af
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL362
	ld a, (ix-2)
	add a, 2
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-7), a
	ld a, (ix-2)
	add a, 2
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-8), a
	ld a, (ix-7)
	or (ix-8)
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL364
	ld (ix-4), 0
	ld a, (ix-7)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-8)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL366
	ld (ix-11), 1
__LABEL366:
__LABEL364:
__LABEL362:
__LABEL360:
__LABEL350:
__LABEL330:
__LABEL328:
	ld a, (ix-4)
	or a
	jp z, __LABEL368
	ld a, (_playerY)
	add a, (ix-4)
	push af
	ld h, 7
	pop af
	and h
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld (ix-5), a
	ld a, (_playerY)
	add a, (ix-4)
	ld h, 8
	call __DIVI8_FAST
	sub 5
	ld (ix-2), a
__LABEL368:
	ld a, (ix-6)
	ld h, (ix-3)
	or a
	jr z, __LABEL708
	ld a, h
__LABEL708:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL370
	ld a, (ix-5)
	or a
	jp z, __LABEL371
	ld a, (ix-3)
	sub 254
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL373
	ld a, (ix-1)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL375
	ld (ix-10), 1
	jp __LABEL376
__LABEL375:
	ld a, (ix-2)
	push af
	xor a
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL377
	ld a, (ix-2)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	dec a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-7), a
	jp __LABEL378
__LABEL377:
	ld (ix-7), 0
__LABEL378:
	ld a, (ix-2)
	push af
	ld h, 12
	pop af
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL379
	ld a, (ix-2)
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	dec a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-8), a
	jp __LABEL380
__LABEL379:
	ld (ix-8), 0
__LABEL380:
	ld a, (ix-7)
	or (ix-8)
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL382
	ld (ix-3), 0
	ld a, (ix-7)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-8)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL384
	ld (ix-11), 1
__LABEL384:
__LABEL382:
__LABEL376:
	jp __LABEL374
__LABEL373:
	ld a, (ix-1)
	sub 32
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL385
	ld (ix-10), 1
	jp __LABEL386
__LABEL385:
	ld a, (ix-2)
	push af
	xor a
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL387
	ld a, (ix-2)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-7), a
	jp __LABEL388
__LABEL387:
	ld (ix-7), 0
__LABEL388:
	ld a, (ix-2)
	push af
	ld h, 12
	pop af
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL389
	ld a, (ix-2)
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-8), a
	jp __LABEL390
__LABEL389:
	ld (ix-8), 0
__LABEL390:
	ld a, (ix-7)
	or (ix-8)
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL392
	ld (ix-3), 0
	ld a, (ix-7)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-8)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL394
	ld (ix-11), 1
__LABEL394:
__LABEL392:
__LABEL386:
__LABEL374:
	jp __LABEL372
__LABEL371:
	ld a, (ix-3)
	sub 254
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL395
	ld a, (ix-1)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL397
	ld (ix-10), 1
	jp __LABEL398
__LABEL397:
	ld a, (ix-2)
	push af
	xor a
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL399
	ld a, (ix-2)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	dec a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-7), a
	jp __LABEL400
__LABEL399:
	ld (ix-7), 0
__LABEL400:
	ld a, (ix-2)
	push af
	ld h, 12
	pop af
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL401
	ld a, (ix-2)
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	dec a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-8), a
	jp __LABEL402
__LABEL401:
	ld (ix-8), 0
__LABEL402:
	ld a, (ix-2)
	push af
	ld h, 11
	pop af
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL403
	ld a, (ix-2)
	add a, 2
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	dec a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-9), a
	jp __LABEL404
__LABEL403:
	ld (ix-9), 0
__LABEL404:
	ld a, (ix-7)
	or (ix-8)
	or (ix-9)
	jp z, __LABEL406
	ld (ix-3), 0
	ld a, (ix-7)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-8)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-9)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL408
	ld (ix-11), 1
__LABEL408:
__LABEL406:
__LABEL398:
	jp __LABEL396
__LABEL395:
	ld a, (ix-1)
	sub 32
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL409
	ld (ix-10), 1
	jp __LABEL410
__LABEL409:
	ld a, (ix-2)
	push af
	xor a
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL411
	ld a, (ix-2)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-7), a
	jp __LABEL412
__LABEL411:
	ld (ix-7), 0
__LABEL412:
	ld a, (ix-2)
	push af
	ld h, 12
	pop af
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL413
	ld a, (ix-2)
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-8), a
	jp __LABEL414
__LABEL413:
	ld (ix-8), 0
__LABEL414:
	ld a, (ix-2)
	push af
	ld h, 11
	pop af
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL415
	ld a, (ix-2)
	add a, 2
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-9), a
	jp __LABEL416
__LABEL415:
	ld (ix-9), 0
__LABEL416:
	ld a, (ix-7)
	or (ix-8)
	or (ix-9)
	jp z, __LABEL418
	ld (ix-3), 0
	ld a, (ix-7)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-8)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-9)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL420
	ld (ix-11), 1
__LABEL420:
__LABEL418:
__LABEL410:
__LABEL396:
__LABEL372:
__LABEL370:
	xor a
	ld (_playerMoved), a
	ld a, (ix-10)
	or a
	jp z, __LABEL421
	ld a, 2
	jp _movePlayer__leave
__LABEL421:
	ld a, (ix-11)
	or a
	jp z, __LABEL423
	ld a, 1
	jp _movePlayer__leave
__LABEL423:
	ld a, (ix-3)
	or (ix-4)
	jp z, __LABEL426
	ld a, (_playerX)
	ld (_prevPlayerX), a
	ld a, (_playerY)
	ld (_prevPlayerY), a
	ld a, (_playerX)
	add a, (ix-3)
	ld (_playerX), a
	ld a, (_playerY)
	add a, (ix-4)
	ld (_playerY), a
	ld a, (ix-3)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL427
	ld a, 1
	ld (_playerDir), a
	jp __LABEL428
__LABEL427:
	ld a, (ix-3)
	sub 254
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL430
	ld a, 255
	ld (_playerDir), a
__LABEL430:
__LABEL428:
	ld a, 1
	ld (_playerMoved), a
__LABEL426:
	ld a, (_personX)
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_personY)
	push af
	ld a, (_personX)
	push af
	call _checkPlayerCollision
	ld h, a
	pop af
	or a
	jr z, __LABEL709
	ld a, h
__LABEL709:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL432
	ld a, 3
	jp _movePlayer__leave
__LABEL432:
	xor a
	jp _movePlayer__leave
__LABEL424:
__LABEL422:
_movePlayer__leave:
	ld sp, ix
	pop ix
	ret
_drawPlayer:
	push ix
	ld ix, 0
	add ix, sp
	ld a, (_playerMoved)
	or a
	jp z, __LABEL433
	ld a, (_prevPlayerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_prevPlayerY)
	ld l, a
	ld h, 0
	push hl
	ld hl, (_lastHead)
	call _drawSprite
	ld a, (_prevPlayerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_prevPlayerY)
	add a, 8
	ld l, a
	ld h, 0
	push hl
	ld hl, (_lastBody)
	call _drawSprite
	ld a, (_playerDir)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL435
	ld hl, _body2r.__DATA__
	ld (_lastBody), hl
	jp __LABEL436
__LABEL435:
	ld hl, _body2l.__DATA__
	ld (_lastBody), hl
__LABEL436:
	jp __LABEL434
__LABEL433:
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	ld l, a
	ld h, 0
	push hl
	ld hl, (_lastHead)
	call _drawSprite
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	add a, 8
	ld l, a
	ld h, 0
	push hl
	ld hl, (_lastBody)
	call _drawSprite
	ld a, (_playerDir)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL437
	ld hl, _body1r.__DATA__
	ld (_lastBody), hl
	jp __LABEL438
__LABEL437:
	ld hl, _body1l.__DATA__
	ld (_lastBody), hl
__LABEL438:
__LABEL434:
	ld a, (_playerDir)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL439
	ld de, _head1r.__DATA__
	ld hl, (_lastHead)
	call __EQ16
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL441
	ld hl, _head2r.__DATA__
	ld (_lastHead), hl
	jp __LABEL442
__LABEL441:
	ld hl, _head1r.__DATA__
	ld (_lastHead), hl
__LABEL442:
	jp __LABEL440
__LABEL439:
	ld de, _head1l.__DATA__
	ld hl, (_lastHead)
	call __EQ16
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL443
	ld hl, _head2l.__DATA__
	ld (_lastHead), hl
	jp __LABEL444
__LABEL443:
	ld hl, _head1l.__DATA__
	ld (_lastHead), hl
__LABEL444:
__LABEL440:
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	ld l, a
	ld h, 0
	push hl
	ld hl, (_lastHead)
	call _drawSprite
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	add a, 8
	ld l, a
	ld h, 0
	push hl
	ld hl, (_lastBody)
	call _drawSprite
_drawPlayer__leave:
	ld sp, ix
	pop ix
	ret
_keybScan:
	push ix
	ld ix, 0
	add ix, sp
#line 1471
		push ix
		ld ix, _keyStates.__DATA__
		ld (ix+0), 0
		ld (ix+1), 0
		ld (ix+2), 0
		ld (ix+3), 0
		ld (ix+4), 0
		ld bc, 57342
		in a, (c)
		rra
		jp c, key_test_o
		ld (ix +1), 1
key_test_o:
		rra
		jp c, key_test_q
		ld (ix+0), 1
key_test_q:
		ld bc, 64510
		in a, (c)
		rra
		jp c, key_test_a
		ld (ix + 2), 1
		key_test_a
		ld bc, 65022
		in a, (c)
		rra
		jp c, key_test_fire
		ld (ix + 3), 1
		key_test_fire
		ld bc, 32766
		in a, (c)
		and 31
		xor 31
		jp z, end_keyscan
		ld (ix + 4), 1
		end_keyscan
		pop ix
#line 1508
_keybScan__leave:
	ld sp, ix
	pop ix
	ret
_longPause:
	push ix
	ld ix, 0
	add ix, sp
#line 1519
		di
		ei
		ld a, 20
pause_loop:
		halt
		dec a
		jr nz, pause_loop
		di
#line 1527
_longPause__leave:
	ld sp, ix
	pop ix
	ret
_processDeath:
	push ix
	ld ix, 0
	add ix, sp
#line 1537
		di
		ei
		halt
		di
#line 1541
	xor a
	push af
	ld a, 1
	push af
	ld a, 2
	push af
	xor a
	call _createAttrib
	call _dumpAttribCenter
#line 1546
		di
		ei
		halt
		halt
		halt
		halt
		di
#line 1553
	call _dumpAttribsCenter
	ld a, 1
	call _playAudio
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	ld l, a
	ld h, 0
	push hl
	ld hl, (_lastHead)
	call _drawSprite
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	add a, 8
	ld l, a
	ld h, 0
	push hl
	ld hl, (_lastBody)
	call _drawSprite
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	ld l, a
	ld h, 0
	push hl
	ld hl, _death1u.__DATA__
	call _drawSprite
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	add a, 8
	ld l, a
	ld h, 0
	push hl
	ld hl, _death1d.__DATA__
	call _drawSprite
	call _dumpScreenCenter
	call _longPause
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	ld l, a
	ld h, 0
	push hl
	ld hl, _death1u.__DATA__
	call _drawSprite
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	add a, 8
	ld l, a
	ld h, 0
	push hl
	ld hl, _death1d.__DATA__
	call _drawSprite
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	ld l, a
	ld h, 0
	push hl
	ld hl, _death2u.__DATA__
	call _drawSprite
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	add a, 8
	ld l, a
	ld h, 0
	push hl
	ld hl, _death2d.__DATA__
	call _drawSprite
	call _dumpScreenCenter
	call _longPause
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	ld l, a
	ld h, 0
	push hl
	ld hl, _death2u.__DATA__
	call _drawSprite
	ld a, (_playerX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_playerY)
	add a, 8
	ld l, a
	ld h, 0
	push hl
	ld hl, _death2d.__DATA__
	call _drawSprite
	ld hl, _lifes
	dec (hl)
	xor a
	push af
	ld a, (_lifes)
	add a, a
	push af
	ld a, 21
	push af
	call _setattr
	xor a
	push af
	ld a, (_lifes)
	add a, a
	push af
	ld a, 22
	push af
	call _setattr
	call _dumpScreenCenter
	call _longPause
	xor a
	ld hl, (_lifes - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
_processDeath__leave:
	ld sp, ix
	pop ix
	ret
_render:
	push ix
	ld ix, 0
	add ix, sp
	call _drawPlayer
	call _drawShot
	call _drawEnemies
	call _drawDynamite
	ld a, (_enemyCount)
	cp 5
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_shotX)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL710
	ld a, h
__LABEL710:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL446
#line 1615
		di
		ei
		halt
		di
#line 1619
__LABEL446:
	ld a, (_lightOn)
	or a
	jp z, __LABEL447
	call _dumpScreenCenter
	jp __LABEL448
__LABEL447:
	call _dumpPixelsCenter
__LABEL448:
_render__leave:
	ld sp, ix
	pop ix
	ret
_gameOver:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	inc sp
	ld (ix-1), 10
	jp __LABEL449
__LABEL452:
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 7
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 10
	push hl
	ld hl, _skull.__DATA__
	call _printColorChar
#line 1640
		di
		ei
		halt
		di
#line 1644
	call _dumpScreenCenter
__LABEL453:
	inc (ix-1)
__LABEL449:
	ld a, (ix-1)
	push af
	ld a, 21
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL452
__LABEL451:
	ld (ix-1), 11
	jp __LABEL454
__LABEL457:
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 7
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 21
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, _skull.__DATA__
	call _printColorChar
#line 1654
		di
		ei
		halt
		di
#line 1658
	call _dumpScreenCenter
__LABEL458:
	inc (ix-1)
__LABEL454:
	ld a, (ix-1)
	push af
	ld a, 13
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL457
__LABEL456:
	ld (ix-1), 21
	jp __LABEL459
__LABEL462:
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 7
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, 14
	push hl
	ld hl, _skull.__DATA__
	call _printColorChar
#line 1668
		di
		ei
		halt
		di
#line 1672
	call _dumpScreenCenter
__LABEL463:
	dec (ix-1)
__LABEL459:
	ld a, (ix-1)
	push af
	ld h, 10
	pop af
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL462
__LABEL461:
	ld (ix-1), 13
	jp __LABEL464
__LABEL467:
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 7
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 10
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld hl, _skull.__DATA__
	call _printColorChar
#line 1682
		di
		ei
		halt
		di
#line 1686
	call _dumpScreenCenter
__LABEL468:
	dec (ix-1)
__LABEL464:
	ld a, (ix-1)
	push af
	ld h, 11
	pop af
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL467
__LABEL466:
	xor a
	push af
	ld a, 11
	push af
	ld a, 11
	push af
	ld hl, __LABEL469
	call __LOADSTR
	push hl
	call _printZXString
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 2
	call _createAttrib
	push af
	ld a, 11
	push af
	ld a, 12
	push af
	ld hl, __LABEL470
	call __LOADSTR
	push hl
	call _printZXString
	xor a
	push af
	ld a, 11
	push af
	ld a, 13
	push af
	ld hl, __LABEL469
	call __LOADSTR
	push hl
	call _printZXString
#line 1696
		di
		ei
		halt
		di
#line 1700
	call _dumpScreenCenter
	ld a, 6
	call _playAudio
	call _waitSpace
_gameOver__leave:
	ld sp, ix
	pop ix
	ret
_checkDynamite:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	push hl
	push hl
	ld a, (_dynaCounter)
	cp 25
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL471
	ld hl, _dynaCounter
	dec (hl)
	ld a, (_dynaCounter)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL474
	ld a, (_dynaX)
	and 1
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL475
	ld a, (_dynaX)
	ld h, 8
	call __DIVU8_FAST
	inc a
	add a, 2
	ld (_xEnd), a
	ld a, 4
	ld hl, (_xEnd - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL477
	ld a, (_xEnd)
	sub 4
	ld (_xStart), a
	jp __LABEL478
__LABEL477:
	ld a, 1
	ld (_xStart), a
__LABEL478:
	ld a, 32
	ld hl, (_xEnd - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL480
	ld a, 32
	ld (_xEnd), a
__LABEL480:
	jp __LABEL476
__LABEL475:
	ld a, (_dynaX)
	ld h, 8
	call __DIVU8_FAST
	inc a
	add a, 3
	ld (_xEnd), a
	ld a, 5
	ld hl, (_xEnd - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL481
	ld a, (_xEnd)
	sub 5
	ld (_xStart), a
	jp __LABEL482
__LABEL481:
	ld a, 1
	ld (_xStart), a
__LABEL482:
	ld a, 32
	ld hl, (_xEnd - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL484
	ld a, 32
	ld (_xEnd), a
__LABEL484:
__LABEL476:
	ld a, (_dynaY)
	ld h, 8
	call __DIVU8_FAST
	sub 5
	add a, 2
	ld (_yEnd), a
	ld a, 4
	ld hl, (_yEnd - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL485
	ld a, (_yEnd)
	sub 4
	ld (_yStart), a
	jp __LABEL486
__LABEL485:
	ld a, 1
	ld (_yStart), a
__LABEL486:
	ld a, 12
	ld hl, (_yEnd - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL488
	ld a, 12
	ld (_yEnd), a
__LABEL488:
	ld a, (_yStart)
	ld (ix-2), a
	jp __LABEL489
__LABEL492:
	ld a, (_xStart)
	ld (ix-1), a
	jp __LABEL494
__LABEL497:
	ld a, (ix-2)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	sub 3
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL500
	ld a, (ix-2)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld (hl), 0
	ld a, (_emptyAttrib)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-1)
	dec a
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-2)
	add a, 5
	ld l, a
	ld h, 0
	push hl
	ld hl, _empty.__DATA__
	call _printColorChar
__LABEL500:
__LABEL498:
	inc (ix-1)
__LABEL494:
	ld a, (ix-1)
	push af
	ld a, (_xEnd)
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL497
__LABEL496:
__LABEL493:
	inc (ix-2)
__LABEL489:
	ld a, (ix-2)
	push af
	ld a, (_yEnd)
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL492
__LABEL491:
	ld a, (_playerX)
	ld l, a
	ld h, 0
	ld (ix-4), l
	ld (ix-3), h
	ld l, (ix-4)
	ld h, (ix-3)
	push hl
	ld a, (_dynaX)
	ld l, a
	ld h, 0
	ex de, hl
	pop hl
	or a
	sbc hl, de
	ld (ix-4), l
	ld (ix-3), h
	ld l, (ix-4)
	ld h, (ix-3)
	push hl
	ld de, 0
	pop hl
	call __LTI16
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL502
	ld l, (ix-4)
	ld h, (ix-3)
	call __NEGHL
	ld (ix-4), l
	ld (ix-3), h
__LABEL502:
	ld a, (_playerY)
	ld l, a
	ld h, 0
	ld (ix-6), l
	ld (ix-5), h
	ld l, (ix-6)
	ld h, (ix-5)
	push hl
	ld a, (_dynaY)
	sub 4
	ld l, a
	ld h, 0
	ex de, hl
	pop hl
	or a
	sbc hl, de
	ld (ix-6), l
	ld (ix-5), h
	ld l, (ix-6)
	ld h, (ix-5)
	push hl
	ld de, 0
	pop hl
	call __LTI16
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL504
	ld l, (ix-6)
	ld h, (ix-5)
	call __NEGHL
	ld (ix-6), l
	ld (ix-5), h
__LABEL504:
	ld l, (ix-6)
	ld h, (ix-5)
	push hl
	ld de, 27
	pop hl
	call __LTI16
	call __NORMALIZE_BOOLEAN
	push af
	ld l, (ix-4)
	ld h, (ix-3)
	push hl
	ld de, 23
	pop hl
	call __LTI16
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL711
	ld a, h
__LABEL711:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL506
	ld a, 1
	jp _checkDynamite__leave
__LABEL506:
__LABEL474:
	jp __LABEL472
__LABEL471:
	ld a, (_keyStates.__DATA__ + 3)
	push af
	xor a
	ld hl, (_dynamites - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL712
	ld a, h
__LABEL712:
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_entryScreen)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL713
	ld a, h
__LABEL713:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL508
	ld a, (_playerY)
	and 7
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL510
	ld a, (_playerX)
	ld h, 8
	call __DIVU8_FAST
	inc a
	ld (_xStart), a
	ld a, (_playerX)
	and 7
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_playerX)
	cp 248
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL714
	ld a, h
__LABEL714:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL511
	ld a, (_xStart)
	inc a
	ld (_xEnd), a
	jp __LABEL512
__LABEL511:
	ld a, (_xStart)
	ld (_xEnd), a
__LABEL512:
	ld a, (_playerY)
	ld h, 8
	call __DIVU8_FAST
	sub 3
	ld (_yStart), a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (_xStart)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	push af
	ld a, (_yStart)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (_xEnd)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	pop af
	or (hl)
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL514
	ld hl, _dynamites
	dec (hl)
	xor a
	push af
	ld a, (_dynamites)
	add a, a
	add a, 25
	push af
	ld a, 21
	push af
	call _setattr
	ld a, 24
	ld (_dynaCounter), a
	ld a, (_playerX)
	ld (_dynaX), a
	ld a, (_playerY)
	add a, 8
	ld (_dynaY), a
	ld hl, 0
	ld (_lastDyna), hl
__LABEL514:
__LABEL510:
__LABEL508:
__LABEL472:
	xor a
_checkDynamite__leave:
	ld sp, ix
	pop ix
	ret
_drawDynamite:
	push ix
	ld ix, 0
	add ix, sp
	ld a, (_dynaCounter)
	cp 25
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL516
	ld a, (_dynaCounter)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL517
	ld a, 255
	ld (_dynaCounter), a
	ld a, (_emptyAttrib)
	ld l, a
	ld h, 0
	push hl
	ld a, (_dynaX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_dynaY)
	ld l, a
	ld h, 0
	push hl
	ld hl, (_lastDyna)
	call _drawColorSprite
	call _dumpScreenCenter
#line 1799
		di
		ei
		halt
		halt
		halt
		halt
		di
#line 1806
	xor a
	push af
	ld a, 1
	push af
	ld a, 6
	push af
	ld a, 2
	call _createAttrib
	call _dumpAttribCenter
	xor a
	call _playAudio
	ld a, (_lightOn)
	or a
	jp z, __LABEL519
	call _dumpAttribsCenter
	jp __LABEL520
__LABEL519:
	call _turnLightOff
__LABEL520:
	ld hl, 50
	push hl
	call _updateScore
	jp __LABEL518
__LABEL517:
	ld a, (_dynaCounter)
	and 7
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL522
	ld de, 0
	ld hl, (_lastDyna)
	or a
	sbc hl, de
	ld a, h
	or l
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL524
	ld a, (_dynaX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_dynaY)
	ld l, a
	ld h, 0
	push hl
	ld hl, (_lastDyna)
	call _drawSprite
__LABEL524:
	ld de, _dynamite1.__DATA__
	ld hl, (_lastDyna)
	call __EQ16
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL525
	ld hl, _dynamite2.__DATA__
	ld (_lastDyna), hl
	jp __LABEL526
__LABEL525:
	ld hl, _dynamite1.__DATA__
	ld (_lastDyna), hl
__LABEL526:
	ld a, (_dynaColor)
	ld l, a
	ld h, 0
	push hl
	ld a, (_dynaX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_dynaY)
	ld l, a
	ld h, 0
	push hl
	ld hl, (_lastDyna)
	call _drawColorSprite
__LABEL522:
__LABEL518:
__LABEL516:
_drawDynamite__leave:
	ld sp, ix
	pop ix
	ret
_playAudio:
#line 1834
playBasic:
		push ix
play:
		ld hl,sfxData
		push ix
		push iy
		ld b,0
		ld c,a
		add hl,bc
		add hl,bc
		ld e,(hl)
		inc hl
		ld d,(hl)
		push de
		pop ix
		ld a,(23624)
		rra
		rra
		rra
		and 7
		ld (sfxRoutineToneBorder  +1),a
		ld (sfxRoutineNoiseBorder +1),a
		ld (sfxRoutineSampleBorder+1),a
readData:
		ld a,(ix+0)
		ld c,(ix+1)
		ld b,(ix+2)
		ld e,(ix+3)
		ld d,(ix+4)
		push de
		pop iy
		dec a
		jr z,sfxRoutineTone
		dec a
		jr z,sfxRoutineNoise
		dec a
		jr z,sfxRoutineSample
		pop iy
		pop ix
		pop ix
		jp end_audio
sfxRoutineSample:
		ex de,hl
sfxRS0:
		ld e,8
		ld d,(hl)
		inc hl
sfxRS1:
		ld a,(ix+5)
sfxRS2:
		dec a
		jr nz,sfxRS2
		rl d
		sbc a,a
		and 16
sfxRoutineSampleBorder:
		or 0
		out (254),a
		dec e
		jr nz,sfxRS1
		dec bc
		ld a,b
		or c
		jr nz,sfxRS0
		ld c,6
nextData:
		add ix,bc
		jr readData
sfxRoutineTone:
		ld e,(ix+5)
		ld d,(ix+6)
		ld a,(ix+9)
		ld (sfxRoutineToneDuty+1),a
		ld hl,0
sfxRT0:
		push bc
		push iy
		pop bc
sfxRT1:
		add hl,de
		ld a,h
sfxRoutineToneDuty:
		cp 0
		sbc a,a
		and 16
sfxRoutineToneBorder:
		or 0
		out (254),a
		dec bc
		ld a,b
		or c
		jr nz,sfxRT1
		ld a,(sfxRoutineToneDuty+1)
		add a,(ix+10)
		ld (sfxRoutineToneDuty+1),a
		ld c,(ix+7)
		ld b,(ix+8)
		ex de,hl
		add hl,bc
		ex de,hl
		pop bc
		dec bc
		ld a,b
		or c
		jr nz,sfxRT0
		ld c,11
		jr nextData
sfxRoutineNoise:
		ld e,(ix+5)
		ld d,1
		ld h,d
		ld l,d
sfxRN0:
		push bc
		push iy
		pop bc
sfxRN1:
		ld a,(hl)
		and 16
sfxRoutineNoiseBorder:
		or 0
		out (254),a
		dec d
		jr nz,sfxRN2
		ld d,e
		inc hl
		ld a,h
		and 31
		ld h,a
sfxRN2:
		dec bc
		ld a,b
		or c
		jr nz,sfxRN1
		ld a,e
		add a,(ix+6)
		ld e,a
		pop bc
		dec bc
		ld a,b
		or c
		jr nz,sfxRN0
		ld c,7
		jr nextData
sfxData:
SoundEffectsData:
		defw SoundEffect0Data
		defw SoundEffect1Data
		defw SoundEffect2Data
		defw SoundEffect3Data
		defw SoundEffect4Data
		defw SoundEffect5Data
		defw SoundEffect6Data
		defw SoundEffect7Data
SoundEffect0Data:
		defb 2
		defw 20,250,2730
		defb 0
SoundEffect1Data:
		defb 2
		defw 8,250,65330
		defb 1
		defw 32,150,512,65528,65344
		defb 0
SoundEffect2Data:
		defb 2
		defw 4,500,65285
		defb 1
		defw 32,150,4096,8,65088
		defb 0
SoundEffect3Data:
		defb 2
		defw 50,50,65330
		defb 0
SoundEffect4Data:
		defb 1
		defw 50,50,4096,65436,128
		defb 0
SoundEffect5Data:
		defb 1
		defw 50,100,400,0,32
		defb 1
		defw 10,500,0,0,0
		defb 1
		defw 200,50,500,2,64
		defb 1
		defw 200,50,500,65535,64
		defb 0
SoundEffect6Data:
		defb 1
		defw 10,1000,220,0,128
		defb 1
		defw 10,1000,165,0,128
		defb 1
		defw 10,1000,110,0,128
		defb 1
		defw 20,1000,104,0,128
		defb 0
SoundEffect7Data:
		defb 2
		defw 10,1000,4107
		defb 0
end_audio:
#line 2037
_playAudio__leave:
	ret
_turnLightOff:
	push ix
	ld ix, 0
	add ix, sp
	ld a, 7
	push af
	ld a, (_lampX)
	dec a
	push af
	ld a, (_lampY)
	add a, 5
	push af
	call _setattr
	ld a, 1
	ld (_xStart), a
	jp __LABEL527
__LABEL530:
	ld a, 1
	ld (_yStart), a
	jp __LABEL532
__LABEL535:
	ld a, (_yStart)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (_xStart)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	or a
	jp z, __LABEL537
	xor a
	push af
	ld a, (_xStart)
	dec a
	push af
	ld a, (_yStart)
	add a, 5
	push af
	call _setattr
	jp __LABEL538
__LABEL537:
	ld a, 7
	push af
	ld a, (_xStart)
	dec a
	push af
	ld a, (_yStart)
	add a, 5
	push af
	call _setattr
__LABEL538:
__LABEL536:
	ld hl, _yStart
	inc (hl)
__LABEL532:
	ld a, 12
	ld hl, (_yStart - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL535
__LABEL534:
__LABEL531:
	ld hl, _xStart
	inc (hl)
__LABEL527:
	ld a, 32
	ld hl, (_xStart - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL530
__LABEL529:
_turnLightOff__leave:
	ld sp, ix
	pop ix
	ret
_checkLight:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, (_lightOn - 1)
	ld a, (_lampX)
	or a
	jr z, __LABEL715
	ld a, h
__LABEL715:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL540
	ld a, (_lampY)
	push af
	ld a, (_lampX)
	push af
	call _checkPlayerCollision
	or a
	jp z, __LABEL542
	ld a, 2
	call _playAudio
	call _turnLightOff
	xor a
	ld (_lightOn), a
__LABEL542:
__LABEL540:
_checkLight__leave:
	ld sp, ix
	pop ix
	ret
_entrance:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, -16
	add hl, sp
	ld sp, hl
	ld (hl), 0
	ld bc, 15
	ld d, h
	ld e, l
	inc de
	ldir
	ld hl, -16
	ld de, __LABEL716
	ld bc, 32
	call __ALLOC_LOCAL_ARRAY
	ld a, 5
	call BORDER
	ld a, 1
	ld (_tmpX), a
	jp __LABEL543
__LABEL546:
	ld a, 1
	ld (_tmpY), a
	jp __LABEL548
__LABEL551:
	ld a, (_tmpY)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (_tmpX)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld (hl), 0
__LABEL552:
	ld hl, _tmpY
	inc (hl)
__LABEL548:
	ld a, 11
	ld hl, (_tmpY - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL551
__LABEL550:
__LABEL547:
	ld hl, _tmpX
	inc (hl)
__LABEL543:
	ld a, 6
	ld hl, (_tmpX - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL546
__LABEL545:
	xor a
	push af
	xor a
	push af
	ld a, 5
	push af
	xor a
	call _createAttrib
	ld (ix-1), a
	xor a
	push af
	ld a, 1
	push af
	ld a, 4
	push af
	ld a, 2
	call _createAttrib
	ld (ix-4), a
	ld a, (ix-1)
	call _clearScreenCenter
	ld hl, (_currentMapIndex)
	dec hl
	push hl
	ld hl, _maps
	call __ARRAY
	ld a, (hl)
	ld l, a
	ld h, 0
	ld (ix-12), l
	ld (ix-11), h
	ld hl, 114
	push hl
	ld l, (ix-12)
	ld h, (ix-11)
	dec hl
	push hl
	ld hl, _screens
	call __ARRAY
	ld a, (hl)
	ld (ix-5), a
	ld b, 6
__LABEL717:
	srl a
	djnz __LABEL717
	push af
	ld h, 3
	pop af
	and h
	ld (ix-5), a
	ld (ix-3), 1
	jp __LABEL553
__LABEL556:
	ld (ix-2), 1
	jp __LABEL558
__LABEL561:
	ld a, (ix-2)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-2)
	sub 32
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-3)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-3)
	sub 12
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL563
	ld a, (ix-3)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-2)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld (hl), 1
	jp __LABEL564
__LABEL563:
	ld a, (ix-3)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-2)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld (hl), 0
__LABEL564:
__LABEL562:
	inc (ix-2)
__LABEL558:
	ld a, (ix-2)
	push af
	ld a, 32
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL561
__LABEL560:
__LABEL557:
	inc (ix-3)
__LABEL553:
	ld a, (ix-3)
	push af
	ld a, 12
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL556
__LABEL555:
	ld a, (ix-5)
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL566
	ld (ix-2), 0
	jp __LABEL567
__LABEL570:
	ld a, (ix-2)
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld l, (ix-12)
	ld h, (ix-11)
	dec hl
	push hl
	ld hl, _screens
	call __ARRAY
	ld a, (hl)
	ld (ix-6), a
	ld (ix-3), 0
	jp __LABEL572
__LABEL575:
	ld a, (ix-6)
	push af
	ld a, (ix-3)
	add a, a
	ld h, 3
	or a
	ld b, a
	ld a, h
	jr z, __LABEL719
__LABEL718:
	add a, a
	djnz __LABEL718
__LABEL719:
	pop de
	and d
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL578
	ld hl, 11
	push hl
	ld a, (ix-2)
	add a, a
	add a, a
	add a, (ix-3)
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld (hl), 0
	ld (ix-7), 1
	ld a, (ix-8)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL580
	ld a, (ix-2)
	add a, a
	add a, a
	add a, (ix-3)
	inc a
	ld (ix-8), a
__LABEL580:
	ld a, 1
	ld (_currentMapExit), a
__LABEL578:
__LABEL576:
	inc (ix-3)
__LABEL572:
	ld a, (ix-3)
	push af
	ld a, 3
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL575
__LABEL574:
__LABEL571:
	inc (ix-2)
__LABEL567:
	ld a, (ix-2)
	push af
	ld a, 7
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL570
__LABEL569:
__LABEL566:
	ld a, (ix-5)
	dec a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-7)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL720
	ld a, h
__LABEL720:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL582
	ld (ix-2), 0
	jp __LABEL583
__LABEL586:
	ld a, (ix-2)
	add a, 89
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld l, (ix-12)
	ld h, (ix-11)
	dec hl
	push hl
	ld hl, _screens
	call __ARRAY
	ld a, (hl)
	ld (ix-6), a
	ld (ix-3), 0
	jp __LABEL588
__LABEL591:
	ld a, (ix-6)
	push af
	ld a, (ix-3)
	add a, a
	ld h, 3
	or a
	ld b, a
	ld a, h
	jr z, __LABEL722
__LABEL721:
	add a, a
	djnz __LABEL721
__LABEL722:
	pop de
	and d
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL594
	ld hl, 0
	push hl
	ld a, (ix-2)
	add a, a
	add a, a
	add a, (ix-3)
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld (hl), 0
	ld (ix-7), 2
	ld a, (ix-8)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL596
	ld a, (ix-2)
	add a, a
	add a, a
	add a, (ix-3)
	inc a
	ld (ix-8), a
__LABEL596:
	xor a
	ld (_currentMapExit), a
__LABEL594:
__LABEL592:
	inc (ix-3)
__LABEL588:
	ld a, (ix-3)
	push af
	ld a, 3
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL591
__LABEL590:
__LABEL587:
	inc (ix-2)
__LABEL583:
	ld a, (ix-2)
	push af
	ld a, 7
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL586
__LABEL585:
__LABEL582:
	ld a, (ix-5)
	sub 2
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-7)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL723
	ld a, h
__LABEL723:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL598
	ld (ix-3), 0
	jp __LABEL599
__LABEL602:
	ld a, (ix-3)
	ld h, 8
	call __MUL8_FAST
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld l, (ix-12)
	ld h, (ix-11)
	dec hl
	push hl
	ld hl, _screens
	call __ARRAY
	ld a, (hl)
	ld (ix-6), a
	push af
	ld h, 3
	pop af
	and h
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL605
	ld a, (ix-3)
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, 31
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld (hl), 0
	ld (ix-7), 3
	ld (ix-8), 32
	ld a, 3
	ld (_currentMapExit), a
__LABEL605:
__LABEL603:
	inc (ix-3)
__LABEL599:
	ld a, (ix-3)
	push af
	ld a, 11
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL602
__LABEL601:
__LABEL598:
	ld a, (ix-5)
	sub 3
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-7)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL724
	ld a, h
__LABEL724:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL607
	ld (ix-3), 0
	jp __LABEL608
__LABEL611:
	ld a, (ix-3)
	ld h, 8
	call __MUL8_FAST
	add a, 8
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld l, (ix-12)
	ld h, (ix-11)
	dec hl
	push hl
	ld hl, _screens
	call __ARRAY
	ld a, (hl)
	ld (ix-6), a
	push af
	ld h, 192
	pop af
	and h
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL614
	ld a, (ix-3)
	inc a
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, 0
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld (hl), 0
	ld (ix-7), 4
	ld (ix-8), 1
	ld a, 2
	ld (_currentMapExit), a
__LABEL614:
__LABEL612:
	inc (ix-3)
__LABEL608:
	ld a, (ix-3)
	push af
	ld a, 11
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL611
__LABEL610:
__LABEL607:
	ld (ix-3), 1
	jp __LABEL615
__LABEL618:
	ld (ix-2), 1
	jp __LABEL620
__LABEL623:
	ld a, (ix-3)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld a, (ix-2)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL626
	ld a, (ix-3)
	sub 12
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-3)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_currentMapExit)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL725
	ld a, h
__LABEL725:
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-2)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_currentMapExit)
	sub 2
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL726
	ld a, h
__LABEL726:
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (ix-2)
	sub 32
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_currentMapExit)
	sub 3
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL727
	ld a, h
__LABEL727:
	call __NORMALIZE_BOOLEAN
	pop de
	or d
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL628
	ld a, (ix-4)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-2)
	dec a
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-3)
	add a, 5
	ld l, a
	ld h, 0
	push hl
	ld hl, _outWall.__DATA__
	call _printColorChar
__LABEL628:
__LABEL626:
__LABEL624:
	inc (ix-2)
__LABEL620:
	ld a, (ix-2)
	push af
	ld a, 32
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL623
__LABEL622:
__LABEL619:
	inc (ix-3)
__LABEL615:
	ld a, (ix-3)
	push af
	ld a, 12
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL618
__LABEL617:
	ld a, (_playerX)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_playerY)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL728
	ld a, h
__LABEL728:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL630
	ld a, 120
	ld (_playerY), a
	ld a, (ix-8)
	push af
	ld a, 16
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL631
	ld a, 8
	ld (_playerX), a
	ld hl, _head1r.__DATA__
	ld (_lastHead), hl
	ld hl, _body1r.__DATA__
	ld (_lastBody), hl
	ld a, 1
	ld (_playerDir), a
	jp __LABEL632
__LABEL631:
	ld a, 240
	ld (_playerX), a
	ld hl, _head1l.__DATA__
	ld (_lastHead), hl
	ld hl, _body1l.__DATA__
	ld (_lastBody), hl
	xor a
	ld (_playerDir), a
__LABEL632:
__LABEL630:
	ld a, (ix-1)
	push af
	ld a, 12
	push af
	ld a, 10
	push af
	ld hl, (_currentMapIndex)
	ld de, 0
	call __U32TOFREG
	call __STR_FAST
	ex de, hl
	ld hl, __LABEL633
	push de
	call __ADDSTR
	ex (sp), hl
	call __MEM_FREE
	pop hl
	push hl
	call _printZXString
_entrance__leave:
	ex af, af'
	exx
	ld l, (ix-14)
	ld h, (ix-13)
	call __MEM_FREE
	ex af, af'
	exx
	ld sp, ix
	pop ix
	ret
_checkFire:
	push ix
	ld ix, 0
	add ix, sp
	ld a, (_shotX)
	ld (_prevShotX), a
	ld a, (_shotY)
	ld (_prevShotY), a
	ld a, (_keyStates.__DATA__ + 4)
	push af
	ld a, (_frameCounter)
	and 1
	ld h, a
	pop af
	or a
	jr z, __LABEL729
	ld a, h
__LABEL729:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL634
	ld a, (_playerDir)
	dec a
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL636
	ld a, (_playerX)
	cp 248
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL639
	ld a, (_playerX)
	add a, 8
	ld (_shotX), a
__LABEL639:
	jp __LABEL637
__LABEL636:
	ld a, 8
	ld hl, (_playerX - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL641
	ld a, (_playerX)
	sub 8
	ld (_shotX), a
__LABEL641:
__LABEL637:
	ld a, (_playerY)
	add a, 4
	ld (_shotY), a
	add a, 5
	ld (_tmpZ), a
	ld a, 1
	ld (_tmpResult), a
	jp __LABEL642
__LABEL645:
	ld hl, 0
	push hl
	ld a, (_tmpResult)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL648
	ld hl, 1
	push hl
	ld a, (_tmpResult)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld (_tmpX), a
	ld hl, 2
	push hl
	ld a, (_tmpResult)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld hl, _enemyStates
	call __ARRAY
	ld a, (hl)
	ld (_tmpY), a
	ld a, (_shotX)
	add a, 8
	ld h, a
	ld a, (_tmpX)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_tmpX)
	add a, 8
	push af
	ld a, (_shotX)
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL730
	ld a, h
__LABEL730:
	call __NORMALIZE_BOOLEAN
	push af
	ld hl, (_tmpZ - 1)
	ld a, (_tmpY)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL731
	ld a, h
__LABEL731:
	call __NORMALIZE_BOOLEAN
	push af
	ld a, (_tmpY)
	add a, 8
	push af
	ld a, (_tmpZ)
	pop hl
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	ld h, a
	pop af
	or a
	jr z, __LABEL732
	ld a, h
__LABEL732:
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL650
	ld a, (_tmpResult)
	ld (_deadEnemy), a
	jp __LABEL644
__LABEL650:
__LABEL648:
__LABEL646:
	ld hl, _tmpResult
	inc (hl)
__LABEL642:
	ld a, (_enemyCount)
	ld hl, (_tmpResult - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL645
__LABEL644:
	ld a, 3
	call _playAudio
	jp __LABEL635
__LABEL634:
	xor a
	ld (_shotX), a
	xor a
	ld (_shotY), a
__LABEL635:
_checkFire__leave:
	ld sp, ix
	pop ix
	ret
_personSaved:
	push ix
	ld ix, 0
	add ix, sp
	ld a, 7
	push af
	ld a, 10
	push af
	ld a, 10
	push af
	ld hl, __LABEL469
	call __LOADSTR
	push hl
	call _printZXString
	ld a, 7
	push af
	ld a, 10
	push af
	ld a, 11
	push af
	ld hl, __LABEL651
	call __LOADSTR
	push hl
	call _printZXString
	ld a, 7
	push af
	ld a, 10
	push af
	ld a, 12
	push af
	ld hl, __LABEL469
	call __LOADSTR
	push hl
	call _printZXString
	call _dumpScreenCenter
	ld a, 5
	call _playAudio
	call _longPause
	call _longPause
_personSaved__leave:
	ld sp, ix
	pop ix
	ret
_updateScore:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	ld l, (ix+4)
	ld h, (ix+5)
	ex de, hl
	ld hl, (_score)
	add hl, de
	ld (_score), hl
	ld de, 0
	call __U32TOFREG
	call __STR_FAST
	ld d, h
	ld e, l
	ld bc, -2
	call __PSTORE_STR2
	ld a, 21
	push af
	ld l, (ix-2)
	ld h, (ix-1)
	call __STRLEN
	ex de, hl
	ld hl, 5
	or a
	sbc hl, de
	ld de, 17
	add hl, de
	ld a, l
	call PRINT_AT
	ld a, 7
	call INK_TMP
	xor a
	call PAPER_TMP
	ld l, (ix-2)
	ld h, (ix-1)
	xor a
	call __PRINTSTR
	call PRINT_EOL_ATTR
_updateScore__leave:
	ex af, af'
	exx
	ld l, (ix-2)
	ld h, (ix-1)
	call __MEM_FREE
	ex af, af'
	exx
	ld sp, ix
	pop ix
	exx
	pop hl
	ex (sp), hl
	exx
	ret
_presentEnd:
	push ix
	ld ix, 0
	add ix, sp
	ld a, 7
	call _clearScreen
	ld a, 7
	push af
	ld a, 3
	push af
	ld a, 5
	push af
	ld hl, __LABEL652
	call __LOADSTR
	push hl
	call _printZXString
	ld a, 7
	push af
	ld a, 8
	push af
	ld a, 7
	push af
	ld hl, __LABEL653
	call __LOADSTR
	push hl
	call _printZXString
	ld a, 7
	push af
	ld a, 8
	push af
	ld a, 9
	push af
	ld hl, (_score)
	ld de, 0
	call __U32TOFREG
	call __STR_FAST
	ex de, hl
	ld hl, __LABEL654
	push de
	call __ADDSTR
	ex (sp), hl
	call __MEM_FREE
	pop hl
	push hl
	call _printZXString
#line 2347
		di
#line 2348
	call _dumpScreen
	ld a, 80
	ld (_tmpColor), a
__LABEL655:
	ld a, (_keyStates.__DATA__ + 4)
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL656
	xor a
	ld (_tmpY), a
	jp __LABEL657
__LABEL660:
	xor a
	ld (_tmpX), a
	jp __LABEL662
__LABEL665:
	ld a, (_tmpColor)
	ld l, a
	ld h, 0
	push hl
	ld a, (_tmpX)
	ld l, a
	ld h, 0
	push hl
	ld a, (_tmpY)
	ld l, a
	ld h, 0
	call _setAttrib
__LABEL666:
	ld hl, _tmpX
	inc (hl)
__LABEL662:
	ld a, 31
	ld hl, (_tmpX - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL665
__LABEL664:
	ld a, (_tmpColor)
	add a, 8
	ld (_tmpColor), a
	sub 120
	sub 1
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL668
	ld a, 80
	ld (_tmpColor), a
__LABEL668:
__LABEL661:
	ld hl, _tmpY
	inc (hl)
__LABEL657:
	ld a, 23
	ld hl, (_tmpY - 1)
	cp h
	sbc a, a
	call __NORMALIZE_BOOLEAN
	or a
	jp z, __LABEL660
__LABEL659:
#line 2367
		ei
		halt
		di
#line 2370
	call _dumpAttribs
	call _keybScan
	jp __LABEL655
__LABEL656:
_presentEnd__leave:
	ld sp, ix
	pop ix
	ret
__LABEL0:
	DEFW 0000h
__LABEL79:
	DEFW 0001h
	DEFB 08h
__LABEL87:
	DEFW 0001h
	DEFB 20h
__LABEL105:
	DEFW 000Dh
	DEFB 52h
	DEFB 20h
	DEFB 45h
	DEFB 20h
	DEFB 54h
	DEFB 20h
	DEFB 55h
	DEFB 20h
	DEFB 52h
	DEFB 20h
	DEFB 4Eh
	DEFB 20h
	DEFB 53h
__LABEL106:
	DEFW 0005h
	DEFB 50h
	DEFB 4Fh
	DEFB 57h
	DEFB 45h
	DEFB 52h
__LABEL107:
	DEFW 0004h
	DEFB 4Ch
	DEFB 49h
	DEFB 46h
	DEFB 45h
__LABEL108:
	DEFW 0004h
	DEFB 42h
	DEFB 4Fh
	DEFB 4Dh
	DEFB 42h
__LABEL109:
	DEFW 0012h
	DEFB 28h
	DEFB 43h
	DEFB 29h
	DEFB 47h
	DEFB 75h
	DEFB 73h
	DEFB 69h
	DEFB 76h
	DEFB 69h
	DEFB 73h
	DEFB 69h
	DEFB 6Fh
	DEFB 6Eh
	DEFB 20h
	DEFB 32h
	DEFB 30h
	DEFB 32h
	DEFB 30h
__LABEL110:
	DEFW 000Ch
	DEFB 53h
	DEFB 43h
	DEFB 4Fh
	DEFB 52h
	DEFB 45h
	DEFB 3Ah
	DEFB 20h
	DEFB 30h
	DEFB 30h
	DEFB 30h
	DEFB 30h
	DEFB 30h
__LABEL111:
	DEFW 000Dh
	DEFB 46h
	DEFB 49h
	DEFB 52h
	DEFB 45h
	DEFB 20h
	DEFB 54h
	DEFB 4Fh
	DEFB 20h
	DEFB 53h
	DEFB 54h
	DEFB 41h
	DEFB 52h
	DEFB 54h
__LABEL469:
	DEFW 000Ah
	DEFB 20h
	DEFB 20h
	DEFB 20h
	DEFB 20h
	DEFB 20h
	DEFB 20h
	DEFB 20h
	DEFB 20h
	DEFB 20h
	DEFB 20h
__LABEL470:
	DEFW 000Ah
	DEFB 20h
	DEFB 59h
	DEFB 4Fh
	DEFB 55h
	DEFB 20h
	DEFB 44h
	DEFB 49h
	DEFB 45h
	DEFB 44h
	DEFB 20h
__LABEL633:
	DEFW 0006h
	DEFB 4Ch
	DEFB 45h
	DEFB 56h
	DEFB 45h
	DEFB 4Ch
	DEFB 20h
__LABEL651:
	DEFW 000Ah
	DEFB 20h
	DEFB 4Dh
	DEFB 59h
	DEFB 20h
	DEFB 48h
	DEFB 45h
	DEFB 52h
	DEFB 4Fh
	DEFB 21h
	DEFB 20h
__LABEL652:
	DEFW 001Ah
	DEFB 59h
	DEFB 6Fh
	DEFB 75h
	DEFB 20h
	DEFB 68h
	DEFB 61h
	DEFB 76h
	DEFB 65h
	DEFB 20h
	DEFB 72h
	DEFB 65h
	DEFB 73h
	DEFB 63h
	DEFB 75h
	DEFB 65h
	DEFB 64h
	DEFB 20h
	DEFB 65h
	DEFB 76h
	DEFB 65h
	DEFB 72h
	DEFB 79h
	DEFB 62h
	DEFB 6Fh
	DEFB 64h
	DEFB 79h
__LABEL653:
	DEFW 0010h
	DEFB 59h
	DEFB 4Fh
	DEFB 55h
	DEFB 20h
	DEFB 41h
	DEFB 52h
	DEFB 45h
	DEFB 20h
	DEFB 54h
	DEFB 48h
	DEFB 45h
	DEFB 20h
	DEFB 48h
	DEFB 45h
	DEFB 52h
	DEFB 4Fh
__LABEL654:
	DEFW 000Ch
	DEFB 59h
	DEFB 6Fh
	DEFB 75h
	DEFB 72h
	DEFB 20h
	DEFB 73h
	DEFB 63h
	DEFB 6Fh
	DEFB 72h
	DEFB 65h
	DEFB 3Ah
	DEFB 20h
#line 1 "alloc.asm"

; vim: ts=4:et:sw=4:
	; Copyleft (K) by Jose M. Rodriguez de la Rosa
	;  (a.k.a. Boriel)
;  http://www.boriel.com
	;
	; This ASM library is licensed under the MIT license
	; you can use it for any purpose (even for commercial
	; closed source programs).
	;
	; Please read the MIT license on the internet

	; ----- IMPLEMENTATION NOTES ------
	; The heap is implemented as a linked list of free blocks.

; Each free block contains this info:
	;
	; +----------------+ <-- HEAP START
	; | Size (2 bytes) |
	; |        0       | <-- Size = 0 => DUMMY HEADER BLOCK
	; +----------------+
	; | Next (2 bytes) |---+
	; +----------------+ <-+
	; | Size (2 bytes) |
	; +----------------+
	; | Next (2 bytes) |---+
	; +----------------+   |
	; | <free bytes...>|   | <-- If Size > 4, then this contains (size - 4) bytes
	; | (0 if Size = 4)|   |
	; +----------------+ <-+
	; | Size (2 bytes) |
	; +----------------+
	; | Next (2 bytes) |---+
	; +----------------+   |
	; | <free bytes...>|   |
	; | (0 if Size = 4)|   |
	; +----------------+   |
	;   <Allocated>        | <-- This zone is in use (Already allocated)
	; +----------------+ <-+
	; | Size (2 bytes) |
	; +----------------+
	; | Next (2 bytes) |---+
	; +----------------+   |
	; | <free bytes...>|   |
	; | (0 if Size = 4)|   |
	; +----------------+ <-+
	; | Next (2 bytes) |--> NULL => END OF LIST
	; |    0 = NULL    |
	; +----------------+
	; | <free bytes...>|
	; | (0 if Size = 4)|
	; +----------------+


	; When a block is FREED, the previous and next pointers are examined to see
	; if we can defragment the heap. If the block to be freed is just next to the
	; previous, or to the next (or both) they will be converted into a single
	; block (so defragmented).


	;   MEMORY MANAGER
	;
	; This library must be initialized calling __MEM_INIT with
	; HL = BLOCK Start & DE = Length.

	; An init directive is useful for initialization routines.
	; They will be added automatically if needed.

#line 1 "error.asm"

	; Simple error control routines
; vim:ts=4:et:

	ERR_NR    EQU    23610    ; Error code system variable


	; Error code definitions (as in ZX spectrum manual)

; Set error code with:
	;    ld a, ERROR_CODE
	;    ld (ERR_NR), a


	ERROR_Ok                EQU    -1
	ERROR_SubscriptWrong    EQU     2
	ERROR_OutOfMemory       EQU     3
	ERROR_OutOfScreen       EQU     4
	ERROR_NumberTooBig      EQU     5
	ERROR_InvalidArg        EQU     9
	ERROR_IntOutOfRange     EQU    10
	ERROR_NonsenseInBasic   EQU    11
	ERROR_InvalidFileName   EQU    14
	ERROR_InvalidColour     EQU    19
	ERROR_BreakIntoProgram  EQU    20
	ERROR_TapeLoadingErr    EQU    26


	; Raises error using RST #8
__ERROR:
	    ld (__ERROR_CODE), a
	    rst 8
__ERROR_CODE:
	    nop
	    ret

	; Sets the error system variable, but keeps running.
	; Usually this instruction if followed by the END intermediate instruction.
__STOP:
	    ld (ERR_NR), a
	    ret
#line 69 "alloc.asm"
#line 1 "heapinit.asm"

; vim: ts=4:et:sw=4:
	; Copyleft (K) by Jose M. Rodriguez de la Rosa
	;  (a.k.a. Boriel)
;  http://www.boriel.com
	;
	; This ASM library is licensed under the BSD license
	; you can use it for any purpose (even for commercial
	; closed source programs).
	;
	; Please read the BSD license on the internet

	; ----- IMPLEMENTATION NOTES ------
	; The heap is implemented as a linked list of free blocks.

; Each free block contains this info:
	;
	; +----------------+ <-- HEAP START
	; | Size (2 bytes) |
	; |        0       | <-- Size = 0 => DUMMY HEADER BLOCK
	; +----------------+
	; | Next (2 bytes) |---+
	; +----------------+ <-+
	; | Size (2 bytes) |
	; +----------------+
	; | Next (2 bytes) |---+
	; +----------------+   |
	; | <free bytes...>|   | <-- If Size > 4, then this contains (size - 4) bytes
	; | (0 if Size = 4)|   |
	; +----------------+ <-+
	; | Size (2 bytes) |
	; +----------------+
	; | Next (2 bytes) |---+
	; +----------------+   |
	; | <free bytes...>|   |
	; | (0 if Size = 4)|   |
	; +----------------+   |
	;   <Allocated>        | <-- This zone is in use (Already allocated)
	; +----------------+ <-+
	; | Size (2 bytes) |
	; +----------------+
	; | Next (2 bytes) |---+
	; +----------------+   |
	; | <free bytes...>|   |
	; | (0 if Size = 4)|   |
	; +----------------+ <-+
	; | Next (2 bytes) |--> NULL => END OF LIST
	; |    0 = NULL    |
	; +----------------+
	; | <free bytes...>|
	; | (0 if Size = 4)|
	; +----------------+


	; When a block is FREED, the previous and next pointers are examined to see
	; if we can defragment the heap. If the block to be breed is just next to the
	; previous, or to the next (or both) they will be converted into a single
	; block (so defragmented).


	;   MEMORY MANAGER
	;
	; This library must be initialized calling __MEM_INIT with
	; HL = BLOCK Start & DE = Length.

	; An init directive is useful for initialization routines.
	; They will be added automatically if needed.




	; ---------------------------------------------------------------------
	;  __MEM_INIT must be called to initalize this library with the
	; standard parameters
	; ---------------------------------------------------------------------
__MEM_INIT: ; Initializes the library using (RAMTOP) as start, and
	        ld hl, ZXBASIC_MEM_HEAP  ; Change this with other address of heap start
	        ld de, ZXBASIC_HEAP_SIZE ; Change this with your size

	; ---------------------------------------------------------------------
	;  __MEM_INIT2 initalizes this library
; Parameters:
;   HL : Memory address of 1st byte of the memory heap
;   DE : Length in bytes of the Memory Heap
	; ---------------------------------------------------------------------
__MEM_INIT2:
	        ; HL as TOP
	        PROC

	        dec de
	        dec de
	        dec de
	        dec de        ; DE = length - 4; HL = start
	        ; This is done, because we require 4 bytes for the empty dummy-header block

	        xor a
	        ld (hl), a
	        inc hl
        ld (hl), a ; First "free" block is a header: size=0, Pointer=&(Block) + 4
	        inc hl

	        ld b, h
	        ld c, l
	        inc bc
	        inc bc      ; BC = starts of next block

	        ld (hl), c
	        inc hl
	        ld (hl), b
	        inc hl      ; Pointer to next block

	        ld (hl), e
	        inc hl
	        ld (hl), d
	        inc hl      ; Block size (should be length - 4 at start); This block contains all the available memory

	        ld (hl), a ; NULL (0000h) ; No more blocks (a list with a single block)
	        inc hl
	        ld (hl), a

	        ld a, 201
	        ld (__MEM_INIT), a; "Pokes" with a RET so ensure this routine is not called again
	        ret

	        ENDP

#line 70 "alloc.asm"


	; ---------------------------------------------------------------------
	; MEM_ALLOC
	;  Allocates a block of memory in the heap.
	;
	; Parameters
	;  BC = Length of requested memory block
	;
; Returns:
	;  HL = Pointer to the allocated block in memory. Returns 0 (NULL)
	;       if the block could not be allocated (out of memory)
	; ---------------------------------------------------------------------

MEM_ALLOC:
__MEM_ALLOC: ; Returns the 1st free block found of the given length (in BC)
	        PROC

	        LOCAL __MEM_LOOP
	        LOCAL __MEM_DONE
	        LOCAL __MEM_SUBTRACT
	        LOCAL __MEM_START
	        LOCAL TEMP, TEMP0

	TEMP EQU TEMP0 + 1

	        ld hl, 0
	        ld (TEMP), hl

__MEM_START:
	        ld hl, ZXBASIC_MEM_HEAP  ; This label point to the heap start
	        inc bc
	        inc bc  ; BC = BC + 2 ; block size needs 2 extra bytes for hidden pointer

__MEM_LOOP:  ; Loads lengh at (HL, HL+). If Lenght >= BC, jump to __MEM_DONE
	        ld a, h ;  HL = NULL (No memory available?)
	        or l
#line 111 "C:/zxbasic/library-asm/alloc.asm"
	        ret z ; NULL
#line 113 "C:/zxbasic/library-asm/alloc.asm"
	        ; HL = Pointer to Free block
	        ld e, (hl)
	        inc hl
	        ld d, (hl)
	        inc hl          ; DE = Block Length

	        push hl         ; HL = *pointer to -> next block
	        ex de, hl
	        or a            ; CF = 0
	        sbc hl, bc      ; FREE >= BC (Length)  (HL = BlockLength - Length)
	        jp nc, __MEM_DONE
	        pop hl
	        ld (TEMP), hl

	        ex de, hl
	        ld e, (hl)
	        inc hl
	        ld d, (hl)
	        ex de, hl
	        jp __MEM_LOOP

__MEM_DONE:  ; A free block has been found.
	             ; Check if at least 4 bytes remains free (HL >= 4)
	        push hl
	        exx  ; exx to preserve bc
	        pop hl
	        ld bc, 4
	        or a
	        sbc hl, bc
	        exx
	        jp nc, __MEM_SUBTRACT
	        ; At this point...
	        ; less than 4 bytes remains free. So we return this block entirely
	        ; We must link the previous block with the next to this one
	        ; (DE) => Pointer to next block
	        ; (TEMP) => &(previous->next)
	        pop hl     ; Discard current block pointer
	        push de
	        ex de, hl  ; DE = Previous block pointer; (HL) = Next block pointer
	        ld a, (hl)
	        inc hl
	        ld h, (hl)
	        ld l, a    ; HL = (HL)
	        ex de, hl  ; HL = Previous block pointer; DE = Next block pointer
TEMP0:
	        ld hl, 0   ; Pre-previous block pointer

	        ld (hl), e
	        inc hl
	        ld (hl), d ; LINKED
	        pop hl ; Returning block.

	        ret

__MEM_SUBTRACT:
	        ; At this point we have to store HL value (Length - BC) into (DE - 2)
	        ex de, hl
	        dec hl
	        ld (hl), d
	        dec hl
	        ld (hl), e ; Store new block length

	        add hl, de ; New length + DE => free-block start
	        pop de     ; Remove previous HL off the stack

	        ld (hl), c ; Store length on its 1st word
	        inc hl
	        ld (hl), b
	        inc hl     ; Return hl
	        ret

	        ENDP

#line 10820 "Program.zxbas"
#line 1 "array.asm"

; vim: ts=4:et:sw=4:
	; Copyleft (K) by Jose M. Rodriguez de la Rosa
	;  (a.k.a. Boriel)
;  http://www.boriel.com
	; -------------------------------------------------------------------
	; Simple array Index routine
	; Number of total indexes dimensions - 1 at beginning of memory
	; HL = Start of array memory (First two bytes contains N-1 dimensions)
	; Dimension values on the stack, (top of the stack, highest dimension)
	; E.g. A(2, 4) -> PUSH <4>; PUSH <2>

	; For any array of N dimension A(aN-1, ..., a1, a0)
	; and dimensions D[bN-1, ..., b1, b0], the offset is calculated as
	; O = [a0 + b0 * (a1 + b1 * (a2 + ... bN-2(aN-1)))]
; What I will do here is to calculate the following sequence:
	; ((aN-1 * bN-2) + aN-2) * bN-3 + ...


#line 1 "mul16.asm"

__MUL16:	; Mutiplies HL with the last value stored into de stack
				; Works for both signed and unsigned

			PROC

			LOCAL __MUL16LOOP
	        LOCAL __MUL16NOADD

			ex de, hl
			pop hl		; Return address
			ex (sp), hl ; CALLEE caller convention

__MUL16_FAST:
	        ld b, 16
	        ld a, h
	        ld c, l
	        ld hl, 0

__MUL16LOOP:
	        add hl, hl  ; hl << 1
	        sla c
	        rla         ; a,c << 1
	        jp nc, __MUL16NOADD
	        add hl, de

__MUL16NOADD:
	        djnz __MUL16LOOP

			ret	; Result in hl (16 lower bits)

			ENDP

#line 20 "array.asm"

#line 24 "C:/zxbasic/library-asm/array.asm"

__ARRAY_PTR:   ;; computes an array offset from a pointer
	    ld c, (hl)
	    inc hl
	    ld h, (hl)
	    ld l, c

__ARRAY:
		PROC

		LOCAL LOOP
		LOCAL ARRAY_END
		LOCAL RET_ADDRESS ; Stores return address
		LOCAL TMP_ARR_PTR ; Stores pointer temporarily

	    ld e, (hl)
	    inc hl
	    ld d, (hl)
	    inc hl
	    ld (TMP_ARR_PTR), hl
	    ex de, hl
		ex (sp), hl	; Return address in HL, array address in the stack
		ld (RET_ADDRESS + 1), hl ; Stores it for later

		exx
		pop hl		; Will use H'L' as the pointer
		ld c, (hl)	; Loads Number of dimensions from (hl)
		inc hl
		ld b, (hl)
		inc hl		; Ready
		exx

		ld hl, 0	; HL = Offset "accumulator"

LOOP:
#line 62 "C:/zxbasic/library-asm/array.asm"
		pop bc		; Get next index (Ai) from the stack

#line 72 "C:/zxbasic/library-asm/array.asm"

		add hl, bc	; Adds current index

		exx			; Checks if B'C' = 0
		ld a, b		; Which means we must exit (last element is not multiplied by anything)
		or c
		jr z, ARRAY_END		; if B'Ci == 0 we are done

		ld e, (hl)			; Loads next dimension into D'E'
		inc hl
		ld d, (hl)
		inc hl
		push de
		dec bc				; Decrements loop counter
		exx
		pop de				; DE = Max bound Number (i-th dimension)

	    call __FNMUL
		jp LOOP

ARRAY_END:
		ld a, (hl)
		exx

#line 101 "C:/zxbasic/library-asm/array.asm"
	    LOCAL ARRAY_SIZE_LOOP

	    ex de, hl
	    ld hl, 0
	    ld b, a
ARRAY_SIZE_LOOP:
	    add hl, de
	    djnz ARRAY_SIZE_LOOP

#line 111 "C:/zxbasic/library-asm/array.asm"

	    ex de, hl
		ld hl, (TMP_ARR_PTR)
		ld a, (hl)
		inc hl
		ld h, (hl)
		ld l, a
		add hl, de  ; Adds element start

RET_ADDRESS:
		jp 0

	    ;; Performs a faster multiply for little 16bit numbs
	    LOCAL __FNMUL, __FNMUL2

__FNMUL:
	    xor a
	    or h
	    jp nz, __MUL16_FAST
	    or l
	    ret z

	    cp 33
	    jp nc, __MUL16_FAST

	    ld b, l
	    ld l, h  ; HL = 0

__FNMUL2:
	    add hl, de
	    djnz __FNMUL2
	    ret

TMP_ARR_PTR:
	    DW 0  ; temporary storage for pointer to tables

		ENDP

#line 10821 "Program.zxbas"
#line 1 "arrayalloc.asm"


#line 1 "calloc.asm"

; vim: ts=4:et:sw=4:
	; Copyleft (K) by Jose M. Rodriguez de la Rosa
	;  (a.k.a. Boriel)
;  http://www.boriel.com
	;
	; This ASM library is licensed under the MIT license
	; you can use it for any purpose (even for commercial
	; closed source programs).
	;
	; Please read the MIT license on the internet




	; ---------------------------------------------------------------------
	; MEM_CALLOC
	;  Allocates a block of memory in the heap, and clears it filling it
	;  with 0 bytes
	;
	; Parameters
	;  BC = Length of requested memory block
	;
; Returns:
	;  HL = Pointer to the allocated block in memory. Returns 0 (NULL)
	;       if the block could not be allocated (out of memory)
	; ---------------------------------------------------------------------
__MEM_CALLOC:
	        push bc
	        call __MEM_ALLOC
	        pop bc
	        ld a, h
	        or l
	        ret z  ; No memory
	        ld (hl), 0
	        dec bc
	        ld a, b
	        or c
	        ret z  ; Already filled (1 byte-length block)
	        ld d, h
	        ld e, l
	        inc de
	        push hl
	        ldir
	        pop hl
	        ret
#line 3 "arrayalloc.asm"


	; ---------------------------------------------------------------------
	; __ALLOC_LOCAL_ARRAY
	;  Allocates an array element area in the heap, and clears it filling it
	;  with 0 bytes
	;
	; Parameters
	;  HL = Offset to be added to IX => HL = IX + HL
	;  BC = Length of the element area = n.elements * size(element)
	;  DE = PTR to the index table
	;
; Returns:
	;  HL = (IX + HL) + 4
	; ---------------------------------------------------------------------

__ALLOC_LOCAL_ARRAY:
	    push de
	    push ix
	    pop de
	    add hl, de  ; hl = ix + hl
	    pop de
	    ld (hl), e
	    inc hl
	    ld (hl), d
	    inc hl
	    push hl
	    call __MEM_CALLOC
	    pop de
	    ex de, hl
	    ld (hl), e
	    inc hl
	    ld (hl), d
	    ret


	; ---------------------------------------------------------------------
	; __ALLOC_INITIALIZED_LOCAL_ARRAY
	;  Allocates an array element area in the heap, and clears it filling it
	;  with 0 bytes
	;
	; Parameters
	;  HL = Offset to be added to IX => HL = IX + HL
	;  BC = Length of the element area = n.elements * size(element)
	;  DE = PTR to the index table
	;  TOP of the stack = PTR to the element area
; Returns:
	;  Nothing
	; ---------------------------------------------------------------------

__ALLOC_INITIALIZED_LOCAL_ARRAY:
	    push bc
	    call __ALLOC_LOCAL_ARRAY
	    pop bc
	    pop hl
	    ex (sp), hl
	    ; HL = data table
	    ; BC = length
	    ; DE = new data area
	    ldir
	    ret
#line 10822 "Program.zxbas"
#line 1 "asc.asm"

	; Returns the ascii code for the given str
#line 1 "free.asm"

; vim: ts=4:et:sw=4:
	; Copyleft (K) by Jose M. Rodriguez de la Rosa
	;  (a.k.a. Boriel)
;  http://www.boriel.com
	;
	; This ASM library is licensed under the BSD license
	; you can use it for any purpose (even for commercial
	; closed source programs).
	;
	; Please read the BSD license on the internet

	; ----- IMPLEMENTATION NOTES ------
	; The heap is implemented as a linked list of free blocks.

; Each free block contains this info:
	;
	; +----------------+ <-- HEAP START
	; | Size (2 bytes) |
	; |        0       | <-- Size = 0 => DUMMY HEADER BLOCK
	; +----------------+
	; | Next (2 bytes) |---+
	; +----------------+ <-+
	; | Size (2 bytes) |
	; +----------------+
	; | Next (2 bytes) |---+
	; +----------------+   |
	; | <free bytes...>|   | <-- If Size > 4, then this contains (size - 4) bytes
	; | (0 if Size = 4)|   |
	; +----------------+ <-+
	; | Size (2 bytes) |
	; +----------------+
	; | Next (2 bytes) |---+
	; +----------------+   |
	; | <free bytes...>|   |
	; | (0 if Size = 4)|   |
	; +----------------+   |
	;   <Allocated>        | <-- This zone is in use (Already allocated)
	; +----------------+ <-+
	; | Size (2 bytes) |
	; +----------------+
	; | Next (2 bytes) |---+
	; +----------------+   |
	; | <free bytes...>|   |
	; | (0 if Size = 4)|   |
	; +----------------+ <-+
	; | Next (2 bytes) |--> NULL => END OF LIST
	; |    0 = NULL    |
	; +----------------+
	; | <free bytes...>|
	; | (0 if Size = 4)|
	; +----------------+


	; When a block is FREED, the previous and next pointers are examined to see
	; if we can defragment the heap. If the block to be breed is just next to the
	; previous, or to the next (or both) they will be converted into a single
	; block (so defragmented).


	;   MEMORY MANAGER
	;
	; This library must be initialized calling __MEM_INIT with
	; HL = BLOCK Start & DE = Length.

	; An init directive is useful for initialization routines.
	; They will be added automatically if needed.



	; ---------------------------------------------------------------------
	; MEM_FREE
	;  Frees a block of memory
	;
; Parameters:
	;  HL = Pointer to the block to be freed. If HL is NULL (0) nothing
	;  is done
	; ---------------------------------------------------------------------

MEM_FREE:
__MEM_FREE: ; Frees the block pointed by HL
	            ; HL DE BC & AF modified
	        PROC

	        LOCAL __MEM_LOOP2
	        LOCAL __MEM_LINK_PREV
	        LOCAL __MEM_JOIN_TEST
	        LOCAL __MEM_BLOCK_JOIN

	        ld a, h
	        or l
	        ret z       ; Return if NULL pointer

	        dec hl
	        dec hl
	        ld b, h
	        ld c, l    ; BC = Block pointer

	        ld hl, ZXBASIC_MEM_HEAP  ; This label point to the heap start

__MEM_LOOP2:
	        inc hl
	        inc hl     ; Next block ptr

	        ld e, (hl)
	        inc hl
	        ld d, (hl) ; Block next ptr
	        ex de, hl  ; DE = &(block->next); HL = block->next

	        ld a, h    ; HL == NULL?
	        or l
	        jp z, __MEM_LINK_PREV; if so, link with previous

	        or a       ; Clear carry flag
	        sbc hl, bc ; Carry if BC > HL => This block if before
	        add hl, bc ; Restores HL, preserving Carry flag
	        jp c, __MEM_LOOP2 ; This block is before. Keep searching PASS the block

	;------ At this point current HL is PAST BC, so we must link (DE) with BC, and HL in BC->next

__MEM_LINK_PREV:    ; Link (DE) with BC, and BC->next with HL
	        ex de, hl
	        push hl
	        dec hl

	        ld (hl), c
	        inc hl
	        ld (hl), b ; (DE) <- BC

	        ld h, b    ; HL <- BC (Free block ptr)
	        ld l, c
	        inc hl     ; Skip block length (2 bytes)
	        inc hl
	        ld (hl), e ; Block->next = DE
	        inc hl
	        ld (hl), d
	        ; --- LINKED ; HL = &(BC->next) + 2

	        call __MEM_JOIN_TEST
	        pop hl

__MEM_JOIN_TEST:   ; Checks for fragmented contiguous blocks and joins them
	                   ; hl = Ptr to current block + 2
	        ld d, (hl)
	        dec hl
	        ld e, (hl)
	        dec hl
	        ld b, (hl) ; Loads block length into BC
	        dec hl
	        ld c, (hl) ;

	        push hl    ; Saves it for later
	        add hl, bc ; Adds its length. If HL == DE now, it must be joined
	        or a
	        sbc hl, de ; If Z, then HL == DE => We must join
	        pop hl
	        ret nz

__MEM_BLOCK_JOIN:  ; Joins current block (pointed by HL) with next one (pointed by DE). HL->length already in BC
	        push hl    ; Saves it for later
	        ex de, hl

	        ld e, (hl) ; DE -> block->next->length
	        inc hl
	        ld d, (hl)
	        inc hl

	        ex de, hl  ; DE = &(block->next)
	        add hl, bc ; HL = Total Length

	        ld b, h
	        ld c, l    ; BC = Total Length

	        ex de, hl
	        ld e, (hl)
	        inc hl
	        ld d, (hl) ; DE = block->next

	        pop hl     ; Recovers Pointer to block
	        ld (hl), c
	        inc hl
	        ld (hl), b ; Length Saved
	        inc hl
	        ld (hl), e
	        inc hl
	        ld (hl), d ; Next saved
	        ret

	        ENDP

#line 3 "asc.asm"

__ASC:
		PROC
		LOCAL __ASC_END

		ex af, af'	; Saves free_mem flag

		ld a, h
		or l
		ret z		; NULL? return

		ld c, (hl)
		inc hl
		ld b, (hl)

		ld a, b
		or c
		jr z, __ASC_END		; No length? return

		inc hl
		ld a, (hl)
	    dec hl

__ASC_END:
		dec hl
		ex af, af'
		or a
		call nz, __MEM_FREE	; Free memory if needed

		ex af, af'	; Recover result

		ret
		ENDP
#line 10823 "Program.zxbas"
#line 1 "attr.asm"

	; Attribute routines
; vim:ts=4:et:sw:

#line 1 "sposn.asm"

	; Printing positioning library.
			PROC
			LOCAL ECHO_E

__LOAD_S_POSN:		; Loads into DE current ROW, COL print position from S_POSN mem var.
			ld de, (S_POSN)
			ld hl, (MAXX)
			or a
			sbc hl, de
			ex de, hl
			ret


__SAVE_S_POSN:		; Saves ROW, COL from DE into S_POSN mem var.
			ld hl, (MAXX)
			or a
			sbc hl, de
			ld (S_POSN), hl ; saves it again
			ret


	ECHO_E	EQU 23682
	MAXX	EQU ECHO_E   ; Max X position + 1
	MAXY	EQU MAXX + 1 ; Max Y position + 1

	S_POSN	EQU 23688
	POSX	EQU S_POSN		; Current POS X
	POSY	EQU S_POSN + 1	; Current POS Y

			ENDP

#line 5 "attr.asm"

#line 1 "in_screen.asm"




__IN_SCREEN:
		; Returns NO carry if current coords (D, E)
		; are OUT of the screen limits (MAXX, MAXY)

		PROC
		LOCAL __IN_SCREEN_ERR

		ld hl, MAXX
		ld a, e
		cp (hl)
		jr nc, __IN_SCREEN_ERR	; Do nothing and return if out of range

		ld a, d
		inc hl
		cp (hl)
		;; jr nc, __IN_SCREEN_ERR	; Do nothing and return if out of range
		;; ret
	    ret c                       ; Return if carry (OK)

__IN_SCREEN_ERR:
__OUT_OF_SCREEN_ERR:
		; Jumps here if out of screen
		ld a, ERROR_OutOfScreen
	    jp __STOP   ; Saves error code and exits

		ENDP
#line 7 "attr.asm"
#line 1 "const.asm"

	; Global constants

	P_FLAG	EQU 23697
	FLAGS2	EQU 23681
	ATTR_P	EQU 23693	; permanet ATTRIBUTES
	ATTR_T	EQU 23695	; temporary ATTRIBUTES
	CHARS	EQU 23606 ; Pointer to ROM/RAM Charset
	UDG	EQU 23675 ; Pointer to UDG Charset
	MEM0	EQU 5C92h ; Temporary memory buffer used by ROM chars

#line 8 "attr.asm"
#line 1 "cls.asm"

	; JUMPS directly to spectrum CLS
	; This routine does not clear lower screen

	;CLS	EQU	0DAFh

	; Our faster implementation



CLS:
		PROC

		LOCAL COORDS
		LOCAL __CLS_SCR
		LOCAL ATTR_P
		LOCAL SCREEN

		ld hl, 0
		ld (COORDS), hl
	    ld hl, 1821h
		ld (S_POSN), hl
__CLS_SCR:
		ld hl, SCREEN
		ld (hl), 0
		ld d, h
		ld e, l
		inc de
		ld bc, 6144
		ldir

		; Now clear attributes

		ld a, (ATTR_P)
		ld (hl), a
		ld bc, 767
		ldir
		ret

	COORDS	EQU	23677
	SCREEN	EQU 16384 ; Default start of the screen (can be changed)
	ATTR_P	EQU 23693
	;you can poke (SCREEN_SCRADDR) to change CLS, DRAW & PRINTing address

	SCREEN_ADDR EQU (__CLS_SCR + 1) ; Address used by print and other screen routines
								    ; to get the start of the screen
		ENDP

#line 9 "attr.asm"

__ATTR_ADDR:
	    ; calc start address in DE (as (32 * d) + e)
    ; Contributed by Santiago Romero at http://www.speccy.org
	    ld h, 0                     ;  7 T-States
	    ld a, d                     ;  4 T-States
	    add a, a     ; a * 2        ;  4 T-States
	    add a, a     ; a * 4        ;  4 T-States
	    ld l, a      ; HL = A * 4   ;  4 T-States

	    add hl, hl   ; HL = A * 8   ; 15 T-States
	    add hl, hl   ; HL = A * 16  ; 15 T-States
	    add hl, hl   ; HL = A * 32  ; 15 T-States

    ld d, 18h ; DE = 6144 + E. Note: 6144 is the screen size (before attr zone)
	    add hl, de

	    ld de, (SCREEN_ADDR)    ; Adds the screen address
	    add hl, de

	    ; Return current screen address in HL
	    ret


	; Sets the attribute at a given screen coordinate (D, E).
	; The attribute is taken from the ATTR_T memory variable
	; Used by PRINT routines
SET_ATTR:

	    ; Checks for valid coords
	    call __IN_SCREEN
	    ret nc

__SET_ATTR:
	    ; Internal __FASTCALL__ Entry used by printing routines
	    PROC

	    call __ATTR_ADDR

__SET_ATTR2:  ; Sets attr from ATTR_T to (HL) which points to the scr address
	    ld de, (ATTR_T)    ; E = ATTR_T, D = MASK_T

	    ld a, d
	    and (hl)
	    ld c, a    ; C = current screen color, masked

	    ld a, d
	    cpl        ; Negate mask
	    and e    ; Mask current attributes
	    or c    ; Mix them
	    ld (hl), a ; Store result in screen

	    ret

	    ENDP


	; Sets the attribute at a given screen pixel address in hl
	; HL contains the address in RAM for a given pixel (not a coordinate)
SET_PIXEL_ADDR_ATTR:
	    ;; gets ATTR position with offset given in SCREEN_ADDR
	    ld a, h
	    rrca
	    rrca
	    rrca
	    and 3
	    or 18h
	    ld h, a
	    ld de, (SCREEN_ADDR)
	    add hl, de  ;; Final screen addr
	    jp __SET_ATTR2
#line 10824 "Program.zxbas"
#line 1 "band16.asm"

; vim:ts=4:et:
	; FASTCALL bitwise and16 version.
	; result in hl
; __FASTCALL__ version (operands: A, H)
	; Performs 16bit or 16bit and returns the boolean
; Input: HL, DE
; Output: HL <- HL AND DE

__BAND16:
		ld a, h
		and d
	    ld h, a

	    ld a, l
	    and e
	    ld l, a

	    ret

#line 10825 "Program.zxbas"
#line 1 "border.asm"

	; __FASTCALL__ Routine to change de border
	; Parameter (color) specified in A register

	BORDER EQU 229Bh

	; Nothing to do! (Directly from the ZX Spectrum ROM)

#line 10826 "Program.zxbas"

#line 1 "chr.asm"

	; CHR$(x, y, x) returns the string CHR$(x) + CHR$(y) + CHR$(z)
	;



CHR:	; Returns HL = Pointer to STRING (NULL if no memory)
			; Requires alloc.asm for dynamic memory heap.
		; Parameters: HL = Number of bytes to insert (already push onto the stack)
			; STACK => parameters (16 bit, only the High byte is considered)
			; Used registers A, A', BC, DE, HL, H'L'

			PROC

			LOCAL __POPOUT
			LOCAL TMP

	TMP		EQU 23629 ; (DEST System variable)

			ld a, h
			or l
			ret z	; If Number of parameters is ZERO, return NULL STRING

			ld b, h
			ld c, l

			pop hl	; Return address
			ld (TMP), hl

			push bc
			inc bc
			inc bc	; BC = BC + 2 => (2 bytes for the length number)
			call __MEM_ALLOC
			pop bc

			ld d, h
			ld e, l			; Saves HL in DE

			ld a, h
			or l
			jr z, __POPOUT	; No Memory, return

			ld (hl), c
			inc hl
			ld (hl), b
			inc hl

__POPOUT:	; Removes out of the stack every byte and return
				; If Zero Flag is set, don't store bytes in memory
			ex af, af' ; Save Zero Flag

			ld a, b
			or c
			jr z, __CHR_END

			dec bc
			pop af 	   ; Next byte

			ex af, af' ; Recovers Zero flag
			jr z, __POPOUT

			ex af, af' ; Saves Zero flag
			ld (hl), a
			inc hl
	        ex af, af' ; Recovers Zero Flag

			jp __POPOUT

__CHR_END:
			ld hl, (TMP)
			push hl		; Restores return addr
			ex de, hl	; Recovers original HL ptr
			ret

			ENDP

#line 10828 "Program.zxbas"
#line 1 "copy_attr.asm"


#line 1 "print.asm"

; vim:ts=4:sw=4:et:
	; PRINT command routine
	; Does not print attribute. Use PRINT_STR or PRINT_NUM for that




#line 1 "table_jump.asm"


JUMP_HL_PLUS_2A: ; Does JP (HL + A*2) Modifies DE. Modifies A
		add a, a

JUMP_HL_PLUS_A:	 ; Does JP (HL + A) Modifies DE
		ld e, a
		ld d, 0

JUMP_HL_PLUS_DE: ; Does JP (HL + DE)
		add hl, de
		ld e, (hl)
		inc hl
		ld d, (hl)
		ex de, hl
CALL_HL:
		jp (hl)

#line 9 "print.asm"
#line 1 "ink.asm"

	; Sets ink color in ATTR_P permanently
; Parameter: Paper color in A register



INK:
		PROC
		LOCAL __SET_INK
		LOCAL __SET_INK2

		ld de, ATTR_P

__SET_INK:
		cp 8
		jr nz, __SET_INK2

		inc de ; Points DE to MASK_T or MASK_P
		ld a, (de)
		or 7 ; Set bits 0,1,2 to enable transparency
		ld (de), a
		ret

__SET_INK2:
		; Another entry. This will set the ink color at location pointer by DE
		and 7	; # Gets color mod 8
		ld b, a	; Saves the color
		ld a, (de)
		and 0F8h ; Clears previous value
		or b
		ld (de), a
		inc de ; Points DE to MASK_T or MASK_P
		ld a, (de)
		and 0F8h ; Reset bits 0,1,2 sign to disable transparency
		ld (de), a ; Store new attr
		ret

	; Sets the INK color passed in A register in the ATTR_T variable
INK_TMP:
		ld de, ATTR_T
		jp __SET_INK

		ENDP

#line 10 "print.asm"
#line 1 "paper.asm"

	; Sets paper color in ATTR_P permanently
; Parameter: Paper color in A register



PAPER:
		PROC
		LOCAL __SET_PAPER
		LOCAL __SET_PAPER2

		ld de, ATTR_P

__SET_PAPER:
		cp 8
		jr nz, __SET_PAPER2
		inc de
		ld a, (de)
		or 038h
		ld (de), a
		ret

		; Another entry. This will set the paper color at location pointer by DE
__SET_PAPER2:
		and 7	; # Remove
		rlca
		rlca
		rlca		; a *= 8

		ld b, a	; Saves the color
		ld a, (de)
		and 0C7h ; Clears previous value
		or b
		ld (de), a
		inc de ; Points to MASK_T or MASK_P accordingly
		ld a, (de)
		and 0C7h  ; Resets bits 3,4,5
		ld (de), a
		ret


	; Sets the PAPER color passed in A register in the ATTR_T variable
PAPER_TMP:
		ld de, ATTR_T
		jp __SET_PAPER
		ENDP

#line 11 "print.asm"
#line 1 "flash.asm"

	; Sets flash flag in ATTR_P permanently
; Parameter: Paper color in A register



FLASH:
		ld hl, ATTR_P

	    PROC
	    LOCAL IS_TR
	    LOCAL IS_ZERO

__SET_FLASH:
		; Another entry. This will set the flash flag at location pointer by DE
		cp 8
		jr z, IS_TR

		; # Convert to 0/1
		or a
		jr z, IS_ZERO
		ld a, 0x80

IS_ZERO:
		ld b, a	; Saves the color
		ld a, (hl)
		and 07Fh ; Clears previous value
		or b
		ld (hl), a
		inc hl
		res 7, (hl)  ;Reset bit 7 to disable transparency
		ret

IS_TR:  ; transparent
		inc hl ; Points DE to MASK_T or MASK_P
		set 7, (hl)  ;Set bit 7 to enable transparency
		ret

	; Sets the FLASH flag passed in A register in the ATTR_T variable
FLASH_TMP:
		ld hl, ATTR_T
		jr __SET_FLASH
	    ENDP

#line 12 "print.asm"
#line 1 "bright.asm"

	; Sets bright flag in ATTR_P permanently
; Parameter: Paper color in A register



BRIGHT:
		ld hl, ATTR_P

	    PROC
	    LOCAL IS_TR
	    LOCAL IS_ZERO

__SET_BRIGHT:
		; Another entry. This will set the bright flag at location pointer by DE
		cp 8
		jr z, IS_TR

		; # Convert to 0/1
		or a
		jr z, IS_ZERO
		ld a, 0x40

IS_ZERO:
		ld b, a	; Saves the color
		ld a, (hl)
		and 0BFh ; Clears previous value
		or b
		ld (hl), a
		inc hl
		res 6, (hl)  ;Reset bit 6 to disable transparency
		ret

IS_TR:  ; transparent
		inc hl ; Points DE to MASK_T or MASK_P
	    set 6, (hl)  ;Set bit 6 to enable transparency
		ret

	; Sets the BRIGHT flag passed in A register in the ATTR_T variable
BRIGHT_TMP:
		ld hl, ATTR_T
		jr __SET_BRIGHT
	    ENDP
#line 13 "print.asm"
#line 1 "over.asm"

	; Sets OVER flag in P_FLAG permanently
; Parameter: OVER flag in bit 0 of A register



OVER:
		PROC

		ld c, a ; saves it for later
		and 2
		ld hl, FLAGS2
		res 1, (HL)
		or (hl)
		ld (hl), a

		ld a, c	; Recovers previous value
		and 1	; # Convert to 0/1
		add a, a; # Shift left 1 bit for permanent

		ld hl, P_FLAG
		res 1, (hl)
		or (hl)
		ld (hl), a
		ret

	; Sets OVER flag in P_FLAG temporarily
OVER_TMP:
		ld c, a ; saves it for later
		and 2	; gets bit 1; clears carry
		rra
		ld hl, FLAGS2
		res 0, (hl)
		or (hl)
		ld (hl), a

		ld a, c	; Recovers previous value
		and 1
		ld hl, P_FLAG
		res 0, (hl)
	    or (hl)
		ld (hl), a
		jp __SET_ATTR_MODE

		ENDP

#line 14 "print.asm"
#line 1 "inverse.asm"

	; Sets INVERSE flag in P_FLAG permanently
; Parameter: INVERSE flag in bit 0 of A register



INVERSE:
		PROC

		and 1	; # Convert to 0/1
		add a, a; # Shift left 3 bits for permanent
		add a, a
		add a, a
		ld hl, P_FLAG
		res 3, (hl)
		or (hl)
		ld (hl), a
		ret

	; Sets INVERSE flag in P_FLAG temporarily
INVERSE_TMP:
		and 1
		add a, a
		add a, a; # Shift left 2 bits for temporary
		ld hl, P_FLAG
		res 2, (hl)
		or (hl)
		ld (hl), a
		jp __SET_ATTR_MODE

		ENDP

#line 15 "print.asm"
#line 1 "bold.asm"

	; Sets BOLD flag in P_FLAG permanently
; Parameter: BOLD flag in bit 0 of A register


BOLD:
		PROC

		and 1
		rlca
	    rlca
	    rlca
		ld hl, FLAGS2
		res 3, (HL)
		or (hl)
		ld (hl), a
		ret

	; Sets BOLD flag in P_FLAG temporarily
BOLD_TMP:
		and 1
		rlca
		rlca
		ld hl, FLAGS2
		res 2, (hl)
		or (hl)
		ld (hl), a
		ret

		ENDP

#line 16 "print.asm"
#line 1 "italic.asm"

	; Sets ITALIC flag in P_FLAG permanently
; Parameter: ITALIC flag in bit 0 of A register


ITALIC:
		PROC

		and 1
	    rrca
	    rrca
	    rrca
		ld hl, FLAGS2
		res 5, (HL)
		or (hl)
		ld (hl), a
		ret

	; Sets ITALIC flag in P_FLAG temporarily
ITALIC_TMP:
		and 1
		rrca
		rrca
		rrca
		rrca
		ld hl, FLAGS2
		res 4, (hl)
		or (hl)
		ld (hl), a
		ret

		ENDP

#line 17 "print.asm"



	; Putting a comment starting with @INIT <address>
	; will make the compiler to add a CALL to <address>
	; It is useful for initialization routines.


__PRINT_INIT: ; To be called before program starts (initializes library)
	        PROC

	        ld hl, __PRINT_START
	        ld (PRINT_JUMP_STATE), hl

	        ld hl, 1821h
	        ld (MAXX), hl  ; Sets current maxX and maxY

	        xor a
	        ld (FLAGS2), a

	        ret


__PRINTCHAR: ; Print character store in accumulator (A register)
	             ; Modifies H'L', B'C', A'F', D'E', A

	        LOCAL PO_GR_1

	        LOCAL __PRCHAR
	        LOCAL __PRINT_CONT
	        LOCAL __PRINT_CONT2
	        LOCAL __PRINT_JUMP
	        LOCAL __SRCADDR
	        LOCAL __PRINT_UDG
	        LOCAL __PRGRAPH
	        LOCAL __PRINT_START
	        LOCAL __ROM_SCROLL_SCR
	        LOCAL __TVFLAGS

	        __ROM_SCROLL_SCR EQU 0DFEh
	        __TVFLAGS EQU 5C3Ch

	PRINT_JUMP_STATE EQU __PRINT_JUMP + 1

__PRINT_JUMP:
	        jp __PRINT_START    ; Where to jump. If we print 22 (AT), next two calls jumps to AT1 and AT2 respectively


	        LOCAL __SCROLL
__SCROLL:  ; Scroll?
	        ld hl, __TVFLAGS
	        bit 1, (hl)
	        ret z
	        call __ROM_SCROLL_SCR
	        ld hl, __TVFLAGS
	        res 1, (hl)
	        ret
#line 75 "C:/zxbasic/library-asm/print.asm"

__PRINT_START:
	        cp ' '
	        jp c, __PRINT_SPECIAL    ; Characters below ' ' are special ones

	        exx               ; Switch to alternative registers
	        ex af, af'        ; Saves a value (char to print) for later


	        call __SCROLL
#line 86 "C:/zxbasic/library-asm/print.asm"
	        call __LOAD_S_POSN

	; At this point we have the new coord
	        ld hl, (SCREEN_ADDR)

	        ld a, d
	        ld c, a     ; Saves it for later

	        and 0F8h    ; Masks 3 lower bit ; zy
	        ld d, a

	        ld a, c     ; Recovers it
	        and 07h     ; MOD 7 ; y1
	        rrca
	        rrca
	        rrca

	        or e
	        ld e, a
	        add hl, de    ; HL = Screen address + DE
	        ex de, hl     ; DE = Screen address

	        ex af, af'

	        cp 80h    ; Is it an UDG or a ?
	        jp c, __SRCADDR

	        cp 90h
	        jp nc, __PRINT_UDG

	        ; Print a 8 bit pattern (80h to 8Fh)

	        ld b, a
	        call PO_GR_1 ; This ROM routine will generate the bit pattern at MEM0
	        ld hl, MEM0
	        jp __PRGRAPH

	PO_GR_1 EQU 0B38h

__PRINT_UDG:
	        sub 90h ; Sub ASC code
	        ld bc, (UDG)
	        jp __PRGRAPH0

	__SOURCEADDR EQU (__SRCADDR + 1)    ; Address of the pointer to chars source
__SRCADDR:
	        ld bc, (CHARS)

__PRGRAPH0:
        add a, a   ; A = a * 2 (since a < 80h) ; Thanks to Metalbrain at http://foro.speccy.org
	        ld l, a
	        ld h, 0    ; HL = a * 2 (accumulator)
	        add hl, hl
	        add hl, hl ; HL = a * 8
	        add hl, bc ; HL = CHARS address

__PRGRAPH:
	        ex de, hl  ; HL = Write Address, DE = CHARS address
	        bit 2, (iy + $47)
	        call nz, __BOLD
	        bit 4, (iy + $47)
	        call nz, __ITALIC
	        ld b, 8 ; 8 bytes per char
__PRCHAR:
	        ld a, (de) ; DE *must* be ALWAYS source, and HL destiny

PRINT_MODE:     ; Which operation is used to write on the screen
                ; Set it with:
	                ; LD A, <OPERATION>
	                ; LD (PRINT_MODE), A
	                ;
                ; Available opertions:
                ; NORMAL : 0h  --> NOP         ; OVER 0
                ; XOR    : AEh --> XOR (HL)    ; OVER 1
                ; OR     : B6h --> OR (HL)     ; PUTSPRITE
                ; AND    : A6h --> AND (HL)    ; PUTMASK
	        nop     ;

INVERSE_MODE:   ; 00 -> NOP -> INVERSE 0
	        nop     ; 2F -> CPL -> INVERSE 1

	        ld (hl), a

	        inc de
	        inc h     ; Next line
	        djnz __PRCHAR

	        call __LOAD_S_POSN
	        push de
	        call __SET_ATTR
	        pop de
	        inc e            ; COL = COL + 1
	        ld hl, (MAXX)
	        ld a, e
	        dec l            ; l = MAXX
	        cp l            ; Lower than max?
	        jp c, __PRINT_CONT; Nothing to do
	        call __PRINT_EOL1
	        exx            ; counteracts __PRINT_EOL1 exx
	        jp __PRINT_CONT2

__PRINT_CONT:
	        call __SAVE_S_POSN

__PRINT_CONT2:
	        exx
	        ret

	; ------------- SPECIAL CHARS (< 32) -----------------

__PRINT_SPECIAL:    ; Jumps here if it is a special char
	        exx
	        ld hl, __PRINT_TABLE
	        jp JUMP_HL_PLUS_2A


PRINT_EOL:        ; Called WHENEVER there is no ";" at end of PRINT sentence
	        exx

__PRINT_0Dh:        ; Called WHEN printing CHR$(13)

	        call __SCROLL
#line 209 "C:/zxbasic/library-asm/print.asm"
	        call __LOAD_S_POSN

__PRINT_EOL1:        ; Another entry called from PRINT when next line required
	        ld e, 0

__PRINT_EOL2:
	        ld a, d
	        inc a

__PRINT_AT1_END:
	        ld hl, (MAXY)
	        cp l
	        jr c, __PRINT_EOL_END    ; Carry if (MAXY) < d
	        ld hl, __TVFLAGS
	        set 1, (hl)
	        ld a, d

__PRINT_EOL_END:
	        ld d, a

__PRINT_AT2_END:
	        call __SAVE_S_POSN
	        exx
	        ret

__PRINT_COM:
	        exx
	        push hl
	        push de
	        push bc
	        call PRINT_COMMA
	        pop bc
	        pop de
	        pop hl
	        ret

__PRINT_TAB:
	        ld hl, __PRINT_TAB1
	        jp __PRINT_SET_STATE

__PRINT_TAB1:
	        ld (MEM0), a
	        ld hl, __PRINT_TAB2
	        ld (PRINT_JUMP_STATE), hl
	        ret

__PRINT_TAB2:
	        ld a, (MEM0)        ; Load tab code (ignore the current one)
	        push hl
	        push de
	        push bc
	        ld hl, __PRINT_START
	        ld (PRINT_JUMP_STATE), hl
	        call PRINT_TAB
	        pop bc
	        pop de
	        pop hl
	        ret

__PRINT_NOP:
__PRINT_RESTART:
	        ld hl, __PRINT_START
	        jp __PRINT_SET_STATE

__PRINT_AT:
	        ld hl, __PRINT_AT1

__PRINT_SET_STATE:
	        ld (PRINT_JUMP_STATE), hl    ; Saves next entry call
	        exx
	        ret

__PRINT_AT1:    ; Jumps here if waiting for 1st parameter
	        exx
	        ld hl, __PRINT_AT2
	        ld (PRINT_JUMP_STATE), hl    ; Saves next entry call
	        call __LOAD_S_POSN
	        jp __PRINT_AT1_END

__PRINT_AT2:
	        exx
	        ld hl, __PRINT_START
	        ld (PRINT_JUMP_STATE), hl    ; Saves next entry call
	        call __LOAD_S_POSN
	        ld e, a
	        ld hl, (MAXX)
	        cp (hl)
	        jr c, __PRINT_AT2_END
	        jr __PRINT_EOL1

__PRINT_DEL:
	        call __LOAD_S_POSN        ; Gets current screen position
	        dec e
	        ld a, -1
	        cp e
	        jp nz, __PRINT_AT2_END
	        ld hl, (MAXX)
	        ld e, l
	        dec e
	        dec e
	        dec d
	        cp d
	        jp nz, __PRINT_AT2_END
	        ld d, h
	        dec d
	        jp __PRINT_AT2_END

__PRINT_INK:
	        ld hl, __PRINT_INK2
	        jp __PRINT_SET_STATE

__PRINT_INK2:
	        exx
	        call INK_TMP
	        jp __PRINT_RESTART

__PRINT_PAP:
	        ld hl, __PRINT_PAP2
	        jp __PRINT_SET_STATE

__PRINT_PAP2:
	        exx
	        call PAPER_TMP
	        jp __PRINT_RESTART

__PRINT_FLA:
	        ld hl, __PRINT_FLA2
	        jp __PRINT_SET_STATE

__PRINT_FLA2:
	        exx
	        call FLASH_TMP
	        jp __PRINT_RESTART

__PRINT_BRI:
	        ld hl, __PRINT_BRI2
	        jp __PRINT_SET_STATE

__PRINT_BRI2:
	        exx
	        call BRIGHT_TMP
	        jp __PRINT_RESTART

__PRINT_INV:
	        ld hl, __PRINT_INV2
	        jp __PRINT_SET_STATE

__PRINT_INV2:
	        exx
	        call INVERSE_TMP
	        jp __PRINT_RESTART

__PRINT_OVR:
	        ld hl, __PRINT_OVR2
	        jp __PRINT_SET_STATE

__PRINT_OVR2:
	        exx
	        call OVER_TMP
	        jp __PRINT_RESTART

__PRINT_BOLD:
	        ld hl, __PRINT_BOLD2
	        jp __PRINT_SET_STATE

__PRINT_BOLD2:
	        exx
	        call BOLD_TMP
	        jp __PRINT_RESTART

__PRINT_ITA:
	        ld hl, __PRINT_ITA2
	        jp __PRINT_SET_STATE

__PRINT_ITA2:
	        exx
	        call ITALIC_TMP
	        jp __PRINT_RESTART


__BOLD:
	        push hl
	        ld hl, MEM0
	        ld b, 8
__BOLD_LOOP:
	        ld a, (de)
	        ld c, a
	        rlca
	        or c
	        ld (hl), a
	        inc hl
	        inc de
	        djnz __BOLD_LOOP
	        pop hl
	        ld de, MEM0
	        ret


__ITALIC:
	        push hl
	        ld hl, MEM0
	        ex de, hl
	        ld bc, 8
	        ldir
	        ld hl, MEM0
	        srl (hl)
	        inc hl
	        srl (hl)
	        inc hl
	        srl (hl)
	        inc hl
	        inc hl
	        inc hl
	        sla (hl)
	        inc hl
	        sla (hl)
	        inc hl
	        sla (hl)
	        pop hl
	        ld de, MEM0
	        ret

PRINT_COMMA:
	        call __LOAD_S_POSN
	        ld a, e
	        and 16
	        add a, 16

PRINT_TAB:
	        PROC
	        LOCAL LOOP, CONTINUE

	        inc a
	        call __LOAD_S_POSN ; e = current row
	        ld d, a
	        ld a, e
	        cp 21h
	        jr nz, CONTINUE
	        ld e, -1
CONTINUE:
	        ld a, d
	        inc e
	        sub e  ; A = A - E
	        and 31 ;
	        ret z  ; Already at position E
	        ld b, a
LOOP:
	        ld a, ' '
	        call __PRINTCHAR
	        djnz LOOP
	        ret
	        ENDP

PRINT_AT: ; Changes cursor to ROW, COL
	         ; COL in A register
	         ; ROW in stack

	        pop hl    ; Ret address
	        ex (sp), hl ; callee H = ROW
	        ld l, a
	        ex de, hl

	        call __IN_SCREEN
	        ret nc    ; Return if out of screen
	        ld hl, __TVFLAGS
	        res 1, (hl)
	        jp __SAVE_S_POSN

	        LOCAL __PRINT_COM
	        LOCAL __BOLD
	        LOCAL __BOLD_LOOP
	        LOCAL __ITALIC
	        LOCAL __PRINT_EOL1
	        LOCAL __PRINT_EOL2
	        LOCAL __PRINT_AT1
	        LOCAL __PRINT_AT2
	        LOCAL __PRINT_AT2_END
	        LOCAL __PRINT_BOLD
	        LOCAL __PRINT_BOLD2
	        LOCAL __PRINT_ITA
	        LOCAL __PRINT_ITA2
	        LOCAL __PRINT_INK
	        LOCAL __PRINT_PAP
	        LOCAL __PRINT_SET_STATE
	        LOCAL __PRINT_TABLE
	        LOCAL __PRINT_TAB, __PRINT_TAB1, __PRINT_TAB2

__PRINT_TABLE:    ; Jump table for 0 .. 22 codes

	        DW __PRINT_NOP    ;  0
	        DW __PRINT_NOP    ;  1
	        DW __PRINT_NOP    ;  2
	        DW __PRINT_NOP    ;  3
	        DW __PRINT_NOP    ;  4
	        DW __PRINT_NOP    ;  5
	        DW __PRINT_COM    ;  6 COMMA
	        DW __PRINT_NOP    ;  7
	        DW __PRINT_DEL    ;  8 DEL
	        DW __PRINT_NOP    ;  9
	        DW __PRINT_NOP    ; 10
	        DW __PRINT_NOP    ; 11
	        DW __PRINT_NOP    ; 12
	        DW __PRINT_0Dh    ; 13
	        DW __PRINT_BOLD   ; 14
	        DW __PRINT_ITA    ; 15
	        DW __PRINT_INK    ; 16
	        DW __PRINT_PAP    ; 17
	        DW __PRINT_FLA    ; 18
	        DW __PRINT_BRI    ; 19
	        DW __PRINT_INV    ; 20
	        DW __PRINT_OVR    ; 21
	        DW __PRINT_AT     ; 22 AT
	        DW __PRINT_TAB    ; 23 TAB

	        ENDP


#line 3 "copy_attr.asm"
#line 4 "C:/zxbasic/library-asm/copy_attr.asm"



COPY_ATTR:
		; Just copies current permanent attribs to temporal attribs
		; and sets print mode
		PROC

		LOCAL INVERSE1
		LOCAL __REFRESH_TMP

	INVERSE1 EQU 02Fh

		ld hl, (ATTR_P)
		ld (ATTR_T), hl

		ld hl, FLAGS2
		call __REFRESH_TMP

		ld hl, P_FLAG
		call __REFRESH_TMP


__SET_ATTR_MODE:		; Another entry to set print modes. A contains (P_FLAG)


		LOCAL TABLE
		LOCAL CONT2

		rra					; Over bit to carry
		ld a, (FLAGS2)
		rla					; Over bit in bit 1, Over2 bit in bit 2
		and 3				; Only bit 0 and 1 (OVER flag)

		ld c, a
		ld b, 0

		ld hl, TABLE
		add hl, bc
		ld a, (hl)
		ld (PRINT_MODE), a

		ld hl, (P_FLAG)
		xor a			; NOP -> INVERSE0
		bit 2, l
		jr z, CONT2
		ld a, INVERSE1 	; CPL -> INVERSE1

CONT2:
		ld (INVERSE_MODE), a
		ret

TABLE:
		nop				; NORMAL MODE
		xor (hl)		; OVER 1 MODE
		and (hl)		; OVER 2 MODE
		or  (hl)		; OVER 3 MODE

#line 65 "C:/zxbasic/library-asm/copy_attr.asm"

__REFRESH_TMP:
		ld a, (hl)
		and 10101010b
		ld c, a
		rra
		or c
		ld (hl), a
		ret

		ENDP

#line 10829 "Program.zxbas"
#line 1 "div16.asm"

	; 16 bit division and modulo functions
	; for both signed and unsigned values

#line 1 "neg16.asm"

	; Negates HL value (16 bit)
__ABS16:
		bit 7, h
		ret z

__NEGHL:
		ld a, l			; HL = -HL
		cpl
		ld l, a
		ld a, h
		cpl
		ld h, a
		inc hl
		ret

#line 5 "div16.asm"

__DIVU16:    ; 16 bit unsigned division
	             ; HL = Dividend, Stack Top = Divisor

		;   -- OBSOLETE ; Now uses FASTCALL convention
		;   ex de, hl
	    ;	pop hl      ; Return address
	    ;	ex (sp), hl ; CALLEE Convention

__DIVU16_FAST:
	    ld a, h
	    ld c, l
	    ld hl, 0
	    ld b, 16

__DIV16LOOP:
	    sll c
	    rla
	    adc hl,hl
	    sbc hl,de
	    jr  nc, __DIV16NOADD
	    add hl,de
	    dec c

__DIV16NOADD:
	    djnz __DIV16LOOP

	    ex de, hl
	    ld h, a
	    ld l, c

	    ret     ; HL = quotient, DE = Mudulus



__MODU16:    ; 16 bit modulus
	             ; HL = Dividend, Stack Top = Divisor

	    ;ex de, hl
	    ;pop hl
	    ;ex (sp), hl ; CALLEE Convention

	    call __DIVU16_FAST
	    ex de, hl	; hl = reminder (modulus)
					; de = quotient

	    ret


__DIVI16:	; 16 bit signed division
		;	--- The following is OBSOLETE ---
		;	ex de, hl
		;	pop hl
		;	ex (sp), hl 	; CALLEE Convention

__DIVI16_FAST:
		ld a, d
		xor h
		ex af, af'		; BIT 7 of a contains result

		bit 7, d		; DE is negative?
		jr z, __DIVI16A

		ld a, e			; DE = -DE
		cpl
		ld e, a
		ld a, d
		cpl
		ld d, a
		inc de

__DIVI16A:
		bit 7, h		; HL is negative?
		call nz, __NEGHL

__DIVI16B:
		call __DIVU16_FAST
		ex af, af'

		or a
		ret p	; return if positive
	    jp __NEGHL


__MODI16:    ; 16 bit modulus
	             ; HL = Dividend, Stack Top = Divisor

	    ;ex de, hl
	    ;pop hl
	    ;ex (sp), hl ; CALLEE Convention

	    call __DIVI16_FAST
	    ex de, hl	; hl = reminder (modulus)
					; de = quotient

	    ret

#line 10830 "Program.zxbas"
#line 1 "div8.asm"

				; --------------------------------
__DIVU8:	; 8 bit unsigned integer division
				; Divides (Top of stack, High Byte) / A
		pop hl	; --------------------------------
		ex (sp), hl	; CALLEE

__DIVU8_FAST:	; Does A / H
		ld l, h
		ld h, a		; At this point do H / L

		ld b, 8
		xor a		; A = 0, Carry Flag = 0

__DIV8LOOP:
		sla	h
		rla
		cp	l
		jr	c, __DIV8NOSUB
		sub	l
		inc	h

__DIV8NOSUB:
		djnz __DIV8LOOP

		ld	l, a		; save remainder
		ld	a, h		;

		ret			; a = Quotient,


					; --------------------------------
__DIVI8:		; 8 bit signed integer division Divides (Top of stack) / A
		pop hl		; --------------------------------
		ex (sp), hl

__DIVI8_FAST:
		ld e, a		; store operands for later
		ld c, h

		or a		; negative?
		jp p, __DIV8A
		neg			; Make it positive

__DIV8A:
		ex af, af'
		ld a, h
		or a
		jp p, __DIV8B
		neg
		ld h, a		; make it positive

__DIV8B:
		ex af, af'

		call __DIVU8_FAST

		ld a, c
		xor l		; bit 7 of A = 1 if result is negative

		ld a, h		; Quotient
		ret p		; return if positive

		neg
		ret


__MODU8:		; 8 bit module. REturns A mod (Top of stack) (unsigned operands)
		pop hl
		ex (sp), hl	; CALLEE

__MODU8_FAST:	; __FASTCALL__ entry
		call __DIVU8_FAST
		ld a, l		; Remainder

		ret		; a = Modulus


__MODI8:		; 8 bit module. REturns A mod (Top of stack) (For singed operands)
		pop hl
		ex (sp), hl	; CALLEE

__MODI8_FAST:	; __FASTCALL__ entry
		call __DIVI8_FAST
		ld a, l		; remainder

		ret		; a = Modulus

#line 10831 "Program.zxbas"
#line 1 "eq16.asm"

__EQ16:	; Test if 16bit values HL == DE
		; Returns result in A: 0 = False, FF = True
			xor a	; Reset carry flag
			sbc hl, de
			ret nz
			inc a
			ret

#line 10832 "Program.zxbas"




#line 1 "load.asm"





LOAD_CODE:
	; This function will implement the LOAD CODE Routine
	; Parameters in the stack are HL => String with LOAD name
	; (only first 12 chars will be taken into account)
	; DE = START address of CODE to save
	; BC = Length of data in bytes
	; A = 1 => LOAD 0 => Verify

	    PROC

	    LOCAL LOAD_CONT, LOAD_CONT2, LOAD_CONT3
	    LOCAL LD_BYTES
	    LOCAL LOAD_HEADER
	    LOCAL LD_LOOK_H
	    LOCAL HEAD1
	    LOCAL TMP_HEADER
	    LOCAL LD_NAME
	    LOCAL LD_CH_PR
	    LOCAL LOAD_END
	    LOCAL VR_CONTROL, VR_CONT_1, VR_CONT_2

	HEAD1 EQU MEM0 + 8 ; Uses CALC Mem for temporary storage
	               ; Must skip first 8 bytes used by
	               ; PRINT routine
	TMP_HEADER EQU HEAD1 + 17 ; Temporary HEADER2 pointer storage

	LD_BYTES EQU 0556h ; ROM Routine LD-BYTES
	TMP_FLAG EQU 23655 ; Uses BREG as a Temporary FLAG

	    pop hl         ; Return address
	    pop af         ; A = 1 => LOAD; A = 0 => VERIFY
	    pop bc         ; data length in bytes
	    pop de         ; address start
	    ex (sp), hl    ; CALLE => now hl = String

__LOAD_CODE: ; INLINE version
	    push ix ; saves IX
	    ld (TMP_FLAG), a ; Stores verify/load flag

	    ; Prepares temporary 1st header descriptor
	    ld ix, HEAD1
	    ld (ix + 0), 3     ; ZXBASIC ALWAYS uses CODE
	    ld (ix + 1), 0FFh  ; Wildcard for empty string

	    ld (ix + 11), c
	    ld (ix + 12), b ; Store length in bytes
	    ld (ix + 13), e
	    ld (ix + 14), d ; Store address in bytes

	    ld a, h
	    or l
	    ld b, h
	    ld c, l
	    jr z, LOAD_HEADER ; NULL STRING => LOAD ""

	    ld c, (hl)
	    inc hl
	    ld b, (hl)
	    inc hl

	    ld a, b
	    or c
	    jr z, LOAD_CONT2 ; NULL STRING => LOAD ""

	    ; Fill with blanks
	    push hl
	    push bc
	    ld hl, HEAD1 + 2
	    ld de, HEAD1 + 3
	    ld bc, 8
	    ld (hl), ' '
	    ldir
	    pop bc
	    pop hl

LOAD_HEADER:
	    ex de, hl  ; Saves HL in DE
	    ld hl, 10
	    or a
	    sbc hl, bc ; Test BC > 10?
	    ex de, hl  ; Retrieve HL
	    jr nc, LOAD_CONT ; Ok BC <= 10
	    ld bc, 10 ; BC at most 10 chars

LOAD_CONT:
	    ld de, HEAD1 + 1
	    ldir     ; Copy String block NAME in header

LOAD_CONT2:
	    ld bc, 17; 2nd Header
	    call __MEM_ALLOC

	    ld a, h
	    or l
	    jr nz, LOAD_CONT3; there's memory

	    ld a, ERROR_OutOfMemory
	    jp __ERROR

LOAD_CONT3:
	    ld (TMP_HEADER), hl
	    push hl
	    pop ix

	;; LD-LOOK-H --- RIPPED FROM ROM at 0x767
LD_LOOK_H:
	    push ix                 ; save IX
	    ld de, 17               ; seventeen bytes
	    xor a                   ; reset zero flag
	    scf                     ; set carry flag

	    call LD_BYTES           ; routine LD-BYTES loads a header from tape
	                            ; to second descriptor.
	    pop ix                  ; restore IX
	    jr nc, LD_LOOK_H        ; loop back to LD-LOOK-H until header found.

	    ld c, 80h               ; C has bit 7 set to indicate header type mismatch as
	                            ; a default startpoint.

	    ld a, (ix + 0)          ; compare loaded type
	    cp 3		            ; with expected bytes header
	    jr nz, LD_TYPE          ; forward to LD-TYPE with mis-match.

	    ld c, -10               ; set C to minus ten - will count characters
	                            ; up to zero.
LD_TYPE:
	    cp 4                    ; check if type in acceptable range 0 - 3.
	    jr nc, LD_LOOK_H        ; back to LD-LOOK-H with 4 and over.
	                            ; else A indicates type 0-3.
	    call PRINT_TAPE_MESSAGES; Print tape msg
	    ld hl, HEAD1 + 1        ; point HL to 1st descriptor.
	    ld de, (TMP_HEADER)     ; point DE to 2nd descriptor.
	    ld b, 10                ; the count will be ten characters for the
	                            ; filename.

	    ld a, (hl)              ; fetch first character and test for
	    inc a                   ; value 255.
	    jr nz, LD_NAME          ; forward to LD-NAME if not the wildcard.

	;   but if it is the wildcard, then add ten to C which is minus ten for a type
	;   match or -128 for a type mismatch. Although characters have to be counted
	;   bit 7 of C will not alter from state set here.

	    ld a, c                 ; transfer $F6 or $80 to A
	    add a, b                ; add 10
	    ld c, a                 ; place result, zero or -118, in C.

	;   At this point we have either a type mismatch, a wildcard match or ten
	;   characters to be counted. The characters must be shown on the screen.

	;; LD-NAME
LD_NAME:
	    inc de                  ; address next input character
	    ld a, (de)              ; fetch character
	    cp (hl)                 ; compare to expected
	    inc hl                  ; address next expected character
	    jr nz, LD_CH_PR         ; forward to LD-CH-PR with mismatch

	    inc c                   ; increment matched character count

	;; LD-CH-PR
LD_CH_PR:
	    call __PRINTCHAR        ; PRINT-A prints character
	    djnz LD_NAME            ; loop back to LD-NAME for ten characters.

	    bit 7, c                ; test if all matched
	    jr nz, LD_LOOK_H        ; back to LD-LOOK-H if not

	;   else print a terminal carriage return.

	    ld a, 0Dh               ; prepare carriage return.
	    call __PRINTCHAR        ; PRINT-A outputs it.

	    ld a, (HEAD1)
    cp 03                   ; Only "bytes:" header is used un ZX BASIC
	    jr nz, LD_LOOK_H

	    ; Ok, ready to check for bytes start and end

VR_CONTROL:
	    ld e, (ix + 11)         ; fetch length of new data
	    ld d, (ix + 12)         ; to DE.

	    ld hl, HEAD1 + 11
	    ld a, (hl)              ; fetch length of old data (orig. header)
	    inc hl
	    ld h, (hl)              ; to HL
	    ld l, a
	    or h                    ; check length of old for zero. (Carry reset)
	    jr z, VR_CONT_1         ; forward to VR-CONT-1 if length unspecified
	                            ; e.g. LOAD "x" CODE
	    sbc hl, de
	    jr nz, LOAD_ERROR       ; Lenghts don't match

VR_CONT_1:
	    ld hl, HEAD1 + 13       ; fetch start of old data (orig. header)
	    ld a, (hl)
	    inc hl
	    ld h, (hl)
	    ld l, a
	    or h                    ; check start for zero (unespecified)
	    jr nz, VR_CONT_2        ; Jump if there was a start

	    ld l, (ix + 13)         ; otherwise use destination in header
	    ld h, (ix + 14)         ; and load code at addr. saved from

VR_CONT_2:
	    push hl
	    pop ix                  ; Transfer load addr to IX

	    ld a, (TMP_FLAG)        ; load verify/load flag
	    sra a                   ; shift bit 0 to Carry (1 => Load, 0 = Verify), A = 0
	    dec a                   ; a = 0xFF (Data)
	    call LD_BYTES
	    jr c, LOAD_END         ; if carry, load/verification was ok

LOAD_ERROR:
	    ; Sets ERR_NR with Tape Loading, and returns
	    ld a, ERROR_TapeLoadingErr
	    ld (ERR_NR), a

LOAD_END:
	    pop ix                  ; Recovers stack frame pointer
	    ld hl, (TMP_HEADER)     ; Recovers tmp_header pointer
	    jp MEM_FREE             ; Returns via FREE_MEM, freeing tmp header

	    ENDP


PRINT_TAPE_MESSAGES:

	    PROC

	    LOCAL LOOK_NEXT_TAPE_MSG
	    LOCAL PRINT_TAPE_MSG

	    ; Print tape messages according to A value
	    ; Each message starts with a carriage return and
	    ; ends with last char having its bit 7 set

    ; A = 0 => '\nProgram: '
    ; A = 1 => '\nNumber array: '
    ; A = 2 => '\nCharacter array: '
    ; A = 3 => '\nBytes: '

	    push bc

	    ld hl, 09C0h            ; address base of last 4 tape messages
	    ld b, a
	    inc b                   ; avoid 256-loop if b == 0
	    ld a, 0Dh               ; Msg start mark

	    ; skip memory bytes looking for next tape msg entry
	    ; each msg ends when 0Dh is fond
LOOK_NEXT_TAPE_MSG:
	    inc hl                  ; Point to next char
	    cp (hl)                 ; Is it 0Dh?
	    jr nz, LOOK_NEXT_TAPE_MSG
	                            ; Ok next message found
	    djnz LOOK_NEXT_TAPE_MSG ; Repeat if more msg to skip

PRINT_TAPE_MSG:
	                            ; Ok. This will print bytes after (HL)
	                            ; until one of them has bit 7 set
	    ld a, (hl)
	    and 7Fh		    ; Clear bit 7 of A
	    call __PRINTCHAR

	    ld a, (hl)
	    inc hl
	    add a, a                ; Carry if A >= 128
	    jr nc, PRINT_TAPE_MSG

	    pop bc
	    ret

	    ENDP
#line 10837 "Program.zxbas"
#line 1 "loadstr.asm"



	; Loads a string (ptr) from HL
	; and duplicates it on dynamic memory again
	; Finally, it returns result pointer in HL

__ILOADSTR:		; This is the indirect pointer entry HL = (HL)
			ld a, h
			or l
			ret z
			ld a, (hl)
			inc hl
			ld h, (hl)
			ld l, a

__LOADSTR:		; __FASTCALL__ entry
			ld a, h
			or l
			ret z	; Return if NULL

			ld c, (hl)
			inc hl
			ld b, (hl)
			dec hl  ; BC = LEN(a$)

			inc bc
			inc bc	; BC = LEN(a$) + 2 (two bytes for length)

			push hl
			push bc
			call __MEM_ALLOC
			pop bc  ; Recover length
			pop de  ; Recover origin

			ld a, h
			or l
			ret z	; Return if NULL (No memory)

			ex de, hl ; ldir takes HL as source, DE as destiny, so SWAP HL,DE
			push de	; Saves destiny start
			ldir	; Copies string (length number included)
			pop hl	; Recovers destiny in hl as result
			ret
#line 10838 "Program.zxbas"
#line 1 "lti16.asm"

#line 1 "lei8.asm"

__LEI8: ; Signed <= comparison for 8bit int
	        ; A <= H (registers)
	    PROC
	    LOCAL checkParity
	    sub h
	    jr nz, __LTI
	    inc a
	    ret

__LTI8:  ; Test 8 bit values A < H
	    sub h

__LTI:   ; Generic signed comparison
	    jp po, checkParity
	    xor 0x80
checkParity:
	    ld a, 0     ; False
	    ret p
	    inc a       ; True
	    ret
	    ENDP
#line 2 "lti16.asm"

__LTI16: ; Test 8 bit values HL < DE
         ; Returns result in A: 0 = False, !0 = True
	    PROC
	    LOCAL checkParity
	    or a
	    sbc hl, de
	    jp po, checkParity
	    ld a, h
	    xor 0x80
checkParity:
	    ld a, 0     ; False
	    ret p
	    inc a       ; True
	    ret
	    ENDP
#line 10839 "Program.zxbas"
#line 1 "mul8.asm"

__MUL8:		; Performs 8bit x 8bit multiplication
		PROC

		;LOCAL __MUL8A
		LOCAL __MUL8LOOP
		LOCAL __MUL8B
				; 1st operand (byte) in A, 2nd operand into the stack (AF)
		pop hl	; return address
		ex (sp), hl ; CALLE convention

;;__MUL8_FAST: ; __FASTCALL__ entry
	;;	ld e, a
	;;	ld d, 0
	;;	ld l, d
	;;
	;;	sla h
	;;	jr nc, __MUL8A
	;;	ld l, e
	;;
;;__MUL8A:
	;;
	;;	ld b, 7
;;__MUL8LOOP:
	;;	add hl, hl
	;;	jr nc, __MUL8B
	;;
	;;	add hl, de
	;;
;;__MUL8B:
	;;	djnz __MUL8LOOP
	;;
	;;	ld a, l ; result = A and HL  (Truncate to lower 8 bits)

__MUL8_FAST: ; __FASTCALL__ entry, a = a * h (8 bit mul) and Carry

	    ld b, 8
	    ld l, a
	    xor a

__MUL8LOOP:
	    add a, a ; a *= 2
	    sla l
	    jp nc, __MUL8B
	    add a, h

__MUL8B:
	    djnz __MUL8LOOP

		ret		; result = HL
		ENDP

#line 10840 "Program.zxbas"




#line 1 "print_eol_attr.asm"

	; Calls PRINT_EOL and then COPY_ATTR, so saves
	; 3 bytes




PRINT_EOL_ATTR:
		call PRINT_EOL
		jp COPY_ATTR
#line 10845 "Program.zxbas"
#line 1 "printstr.asm"






	; PRINT command routine
	; Prints string pointed by HL

PRINT_STR:
__PRINTSTR:		; __FASTCALL__ Entry to print_string
			PROC
			LOCAL __PRINT_STR_LOOP
	        LOCAL __PRINT_STR_END

	        ld d, a ; Saves A reg (Flag) for later

			ld a, h
			or l
			ret z	; Return if the pointer is NULL

	        push hl

			ld c, (hl)
			inc hl
			ld b, (hl)
			inc hl	; BC = LEN(a$); HL = &a$

__PRINT_STR_LOOP:
			ld a, b
			or c
			jr z, __PRINT_STR_END 	; END if BC (counter = 0)

			ld a, (hl)
			call __PRINTCHAR
			inc hl
			dec bc
			jp __PRINT_STR_LOOP

__PRINT_STR_END:
	        pop hl
	        ld a, d ; Recovers A flag
	        or a   ; If not 0 this is a temporary string. Free it
	        ret z
	        jp __MEM_FREE ; Frees str from heap and return from there

__PRINT_STR:
	        ; Fastcall Entry
	        ; It ONLY prints strings
	        ; HL = String start
	        ; BC = String length (Number of chars)
	        push hl ; Push str address for later
	        ld d, a ; Saves a FLAG
	        jp __PRINT_STR_LOOP

			ENDP

#line 10846 "Program.zxbas"
#line 1 "pstorestr.asm"

; vim:ts=4:et:sw=4
	;
	; Stores an string (pointer to the HEAP by DE) into the address pointed
	; by (IX + BC). A new copy of the string is created into the HEAP
	;

#line 1 "storestr.asm"

; vim:ts=4:et:sw=4
	; Stores value of current string pointed by DE register into address pointed by HL
	; Returns DE = Address pointer  (&a$)
	; Returns HL = HL               (b$ => might be needed later to free it from the heap)
	;
	; e.g. => HL = _variableName    (DIM _variableName$)
	;         DE = Address into the HEAP
	;
	; This function will resize (REALLOC) the space pointed by HL
	; before copying the content of b$ into a$


#line 1 "strcpy.asm"

#line 1 "realloc.asm"

; vim: ts=4:et:sw=4:
	; Copyleft (K) by Jose M. Rodriguez de la Rosa
	;  (a.k.a. Boriel)
;  http://www.boriel.com
	;
	; This ASM library is licensed under the BSD license
	; you can use it for any purpose (even for commercial
	; closed source programs).
	;
	; Please read the BSD license on the internet

	; ----- IMPLEMENTATION NOTES ------
	; The heap is implemented as a linked list of free blocks.

; Each free block contains this info:
	;
	; +----------------+ <-- HEAP START
	; | Size (2 bytes) |
	; |        0       | <-- Size = 0 => DUMMY HEADER BLOCK
	; +----------------+
	; | Next (2 bytes) |---+
	; +----------------+ <-+
	; | Size (2 bytes) |
	; +----------------+
	; | Next (2 bytes) |---+
	; +----------------+   |
	; | <free bytes...>|   | <-- If Size > 4, then this contains (size - 4) bytes
	; | (0 if Size = 4)|   |
	; +----------------+ <-+
	; | Size (2 bytes) |
	; +----------------+
	; | Next (2 bytes) |---+
	; +----------------+   |
	; | <free bytes...>|   |
	; | (0 if Size = 4)|   |
	; +----------------+   |
	;   <Allocated>        | <-- This zone is in use (Already allocated)
	; +----------------+ <-+
	; | Size (2 bytes) |
	; +----------------+
	; | Next (2 bytes) |---+
	; +----------------+   |
	; | <free bytes...>|   |
	; | (0 if Size = 4)|   |
	; +----------------+ <-+
	; | Next (2 bytes) |--> NULL => END OF LIST
	; |    0 = NULL    |
	; +----------------+
	; | <free bytes...>|
	; | (0 if Size = 4)|
	; +----------------+


	; When a block is FREED, the previous and next pointers are examined to see
	; if we can defragment the heap. If the block to be breed is just next to the
	; previous, or to the next (or both) they will be converted into a single
	; block (so defragmented).


	;   MEMORY MANAGER
	;
	; This library must be initialized calling __MEM_INIT with
	; HL = BLOCK Start & DE = Length.

	; An init directive is useful for initialization routines.
	; They will be added automatically if needed.







	; ---------------------------------------------------------------------
	; MEM_REALLOC
	;  Reallocates a block of memory in the heap.
	;
	; Parameters
	;  HL = Pointer to the original block
	;  BC = New Length of requested memory block
	;
; Returns:
	;  HL = Pointer to the allocated block in memory. Returns 0 (NULL)
	;       if the block could not be allocated (out of memory)
	;
; Notes:
	;  If BC = 0, the block is freed, otherwise
	;  the content of the original block is copied to the new one, and
	;  the new size is adjusted. If BC < original length, the content
	;  will be truncated. Otherwise, extra block content might contain
	;  memory garbage.
	;
	; ---------------------------------------------------------------------
__REALLOC:    ; Reallocates block pointed by HL, with new length BC
	        PROC

	        LOCAL __REALLOC_END

	        ld a, h
	        or l
	        jp z, __MEM_ALLOC    ; If HL == NULL, just do a malloc

	        ld e, (hl)
	        inc hl
	        ld d, (hl)    ; DE = First 2 bytes of HL block

	        push hl
	        exx
	        pop de
	        inc de        ; DE' <- HL + 2
	        exx            ; DE' <- HL (Saves current pointer into DE')

	        dec hl        ; HL = Block start

	        push de
	        push bc
	        call __MEM_FREE        ; Frees current block
	        pop bc
	        push bc
	        call __MEM_ALLOC    ; Gets a new block of length BC
	        pop bc
	        pop de

	        ld a, h
	        or l
	        ret z        ; Return if HL == NULL (No memory)

	        ld (hl), e
	        inc hl
	        ld (hl), d
	        inc hl        ; Recovers first 2 bytes in HL

	        dec bc
	        dec bc        ; BC = BC - 2 (Two bytes copied)

	        ld a, b
	        or c
	        jp z, __REALLOC_END        ; Ret if nothing to copy (BC == 0)

	        exx
	        push de
	        exx
	        pop de        ; DE <- DE' ; Start of remaining block

	        push hl        ; Saves current Block + 2 start
        ex de, hl    ; Exchanges them: DE is destiny block
	        ldir        ; Copies BC Bytes
	        pop hl        ; Recovers Block + 2 start

__REALLOC_END:

	        dec hl        ; Set HL
	        dec hl        ; To begin of block
	        ret

	        ENDP

#line 2 "strcpy.asm"

	; String library


__STRASSIGN: ; Performs a$ = b$ (HL = address of a$; DE = Address of b$)
			PROC

			LOCAL __STRREALLOC
			LOCAL __STRCONTINUE
			LOCAL __B_IS_NULL
			LOCAL __NOTHING_TO_COPY

			ld b, d
			ld c, e
			ld a, b
			or c
			jr z, __B_IS_NULL

			ex de, hl
			ld c, (hl)
			inc hl
			ld b, (hl)
			dec hl		; BC = LEN(b$)
			ex de, hl	; DE = &b$

__B_IS_NULL:		; Jumps here if B$ pointer is NULL
			inc bc
			inc bc		; BC = BC + 2  ; (LEN(b$) + 2 bytes for storing length)

			push de
			push hl

			ld a, h
			or l
			jr z, __STRREALLOC

			dec hl
			ld d, (hl)
			dec hl
			ld e, (hl)	; DE = MEMBLOCKSIZE(a$)
			dec de
			dec de		; DE = DE - 2  ; (Membloksize takes 2 bytes for memblock length)

			ld h, b
			ld l, c		; HL = LEN(b$) + 2  => Minimum block size required
			ex de, hl	; Now HL = BLOCKSIZE(a$), DE = LEN(b$) + 2

			or a		; Prepare to subtract BLOCKSIZE(a$) - LEN(b$)
			sbc hl, de  ; Carry if len(b$) > Blocklen(a$)
			jr c, __STRREALLOC ; No need to realloc
			; Need to reallocate at least to len(b$) + 2
			ex de, hl	; DE = Remaining bytes in a$ mem block.
			ld hl, 4
			sbc hl, de  ; if remaining bytes < 4 we can continue
			jr nc,__STRCONTINUE ; Otherwise, we realloc, to free some bytes

__STRREALLOC:
			pop hl
			call __REALLOC	; Returns in HL a new pointer with BC bytes allocated
			push hl

__STRCONTINUE:	;   Pops hl and de SWAPPED
			pop de	;	DE = &a$
			pop hl	; 	HL = &b$

			ld a, d		; Return if not enough memory for new length
			or e
			ret z		; Return if DE == NULL (0)

__STRCPY:	; Copies string pointed by HL into string pointed by DE
				; Returns DE as HL (new pointer)
			ld a, h
			or l
			jr z, __NOTHING_TO_COPY
			ld c, (hl)
			inc hl
			ld b, (hl)
			dec hl
			inc bc
			inc bc
			push de
			ldir
			pop hl
			ret

__NOTHING_TO_COPY:
			ex de, hl
			ld (hl), e
			inc hl
			ld (hl), d
			dec hl
			ret

			ENDP

#line 14 "storestr.asm"

__PISTORE_STR:          ; Indirect assignement at (IX + BC)
	    push ix
	    pop hl
	    add hl, bc

__ISTORE_STR:           ; Indirect assignement, hl point to a pointer to a pointer to the heap!
	    ld c, (hl)
	    inc hl
	    ld h, (hl)
	    ld l, c             ; HL = (HL)

__STORE_STR:
	    push de             ; Pointer to b$
	    push hl             ; Array pointer to variable memory address

	    ld c, (hl)
	    inc hl
	    ld h, (hl)
	    ld l, c             ; HL = (HL)

	    call __STRASSIGN    ; HL (a$) = DE (b$); HL changed to a new dynamic memory allocation
	    ex de, hl           ; DE = new address of a$
	    pop hl              ; Recover variable memory address pointer

	    ld (hl), e
	    inc hl
	    ld (hl), d          ; Stores a$ ptr into elemem ptr

	    pop hl              ; Returns ptr to b$ in HL (Caller might needed to free it from memory)
	    ret

#line 8 "pstorestr.asm"

__PSTORE_STR:
	    push ix
	    pop hl
	    add hl, bc
	    jp __STORE_STR

#line 10847 "Program.zxbas"
#line 1 "pstorestr2.asm"

; vim:ts=4:et:sw=4
	;
	; Stores an string (pointer to the HEAP by DE) into the address pointed
	; by (IX + BC). No new copy of the string is created into the HEAP, since
	; it's supposed it's already created (temporary string)
	;

#line 1 "storestr2.asm"

	; Similar to __STORE_STR, but this one is called when
	; the value of B$ if already duplicated onto the stack.
	; So we needn't call STRASSING to create a duplication
	; HL = address of string memory variable
	; DE = address of 2n string. It just copies DE into (HL)
	; 	freeing (HL) previously.



__PISTORE_STR2: ; Indirect store temporary string at (IX + BC)
	    push ix
	    pop hl
	    add hl, bc

__ISTORE_STR2:
		ld c, (hl)  ; Dereferences HL
		inc hl
		ld h, (hl)
		ld l, c		; HL = *HL (real string variable address)

__STORE_STR2:
		push hl
		ld c, (hl)
		inc hl
		ld h, (hl)
		ld l, c		; HL = *HL (real string address)

		push de
		call __MEM_FREE
		pop de

		pop hl
		ld (hl), e
		inc hl
		ld (hl), d
		dec hl		; HL points to mem address variable. This might be useful in the future.

		ret

#line 9 "pstorestr2.asm"

__PSTORE_STR2:
	    push ix
	    pop hl
	    add hl, bc
	    jp __STORE_STR2

#line 10848 "Program.zxbas"


#line 1 "stackf.asm"

	; -------------------------------------------------------------
	; Functions to manage FP-Stack of the ZX Spectrum ROM CALC
	; -------------------------------------------------------------


	__FPSTACK_PUSH EQU 2AB6h	; Stores an FP number into the ROM FP stack (A, ED CB)
	__FPSTACK_POP  EQU 2BF1h	; Pops an FP number out of the ROM FP stack (A, ED CB)

__FPSTACK_PUSH2: ; Pushes Current A ED CB registers and top of the stack on (SP + 4)
	                 ; Second argument to push into the stack calculator is popped out of the stack
	                 ; Since the caller routine also receives the parameters into the top of the stack
	                 ; four bytes must be removed from SP before pop them out

	    call __FPSTACK_PUSH ; Pushes A ED CB into the FP-STACK
	    exx
	    pop hl       ; Caller-Caller return addr
	    exx
	    pop hl       ; Caller return addr

	    pop af
	    pop de
	    pop bc

	    push hl      ; Caller return addr
	    exx
	    push hl      ; Caller-Caller return addr
	    exx

	    jp __FPSTACK_PUSH


__FPSTACK_I16:	; Pushes 16 bits integer in HL into the FP ROM STACK
					; This format is specified in the ZX 48K Manual
					; You can push a 16 bit signed integer as
					; 0 SS LL HH 0, being SS the sign and LL HH the low
					; and High byte respectively
		ld a, h
		rla			; sign to Carry
		sbc	a, a	; 0 if positive, FF if negative
		ld e, a
		ld d, l
		ld c, h
		xor a
		ld b, a
		jp __FPSTACK_PUSH
#line 10851 "Program.zxbas"
#line 1 "str.asm"

	; The STR$( ) BASIC function implementation

	; Given a FP number in C ED LH
	; Returns a pointer (in HL) to the memory heap
	; containing the FP number string representation





__STR:

__STR_FAST:

		PROC
		LOCAL __STR_END
		LOCAL RECLAIM2
		LOCAL STK_END

		ld hl, (STK_END)
		push hl; Stores STK_END
		ld hl, (ATTR_T)	; Saves ATTR_T since it's changed by STR$ due to a ROM BUG
		push hl

	    call __FPSTACK_PUSH ; Push number into stack
		rst 28h		; # Rom Calculator
		defb 2Eh	; # STR$(x)
		defb 38h	; # END CALC
		call __FPSTACK_POP ; Recovers string parameters to A ED CB (Only ED LH are important)

		pop hl
		ld (ATTR_T), hl	; Restores ATTR_T
		pop hl
		ld (STK_END), hl	; Balance STK_END to avoid STR$ bug

		push bc
		push de

		inc bc
		inc bc
		call __MEM_ALLOC ; HL Points to new block

		pop de
		pop bc

		push hl
		ld a, h
		or l
		jr z, __STR_END  ; Return if NO MEMORY (NULL)

		push bc
		push de
		ld (hl), c
		inc hl
		ld (hl), b
		inc hl		; Copies length

		ex de, hl	; HL = start of original string
		ldir		; Copies string content

		pop de		; Original (ROM-CALC) string
		pop bc		; Original Length

__STR_END:
		ex de, hl
		inc bc

		call RECLAIM2 ; Frees TMP Memory
		pop hl		  ; String result

		ret

	RECLAIM2 EQU 19E8h
	STK_END EQU 5C65h

		ENDP

#line 10852 "Program.zxbas"
#line 1 "strcat.asm"


#line 1 "strlen.asm"

	; Returns len if a string
	; If a string is NULL, its len is also 0
	; Result returned in HL

__STRLEN:	; Direct FASTCALL entry
			ld a, h
			or l
			ret z

			ld a, (hl)
			inc hl
			ld h, (hl)  ; LEN(str) in HL
			ld l, a
			ret


#line 3 "strcat.asm"

__ADDSTR:	; Implements c$ = a$ + b$
				; hl = &a$, de = &b$ (pointers)


__STRCAT2:	; This routine creates a new string in dynamic space
				; making room for it. Then copies a$ + b$ into it.
				; HL = a$, DE = b$

			PROC

			LOCAL __STR_CONT
			LOCAL __STRCATEND

			push hl
			call __STRLEN
			ld c, l
			ld b, h		; BC = LEN(a$)
			ex (sp), hl ; (SP) = LEN (a$), HL = a$
			push hl		; Saves pointer to a$

			inc bc
			inc bc		; +2 bytes to store length

			ex de, hl
			push hl
			call __STRLEN
			; HL = len(b$)

			add hl, bc	; Total str length => 2 + len(a$) + len(b$)

			ld c, l
			ld b, h		; BC = Total str length + 2
			call __MEM_ALLOC
			pop de		; HL = c$, DE = b$

			ex de, hl	; HL = b$, DE = c$
			ex (sp), hl ; HL = a$, (SP) = b$

			exx
			pop de		; D'E' = b$
			exx

			pop bc		; LEN(a$)

			ld a, d
			or e
		ret z		; If no memory: RETURN

__STR_CONT:
			push de		; Address of c$

			ld a, h
			or l
			jr nz, __STR_CONT1 ; If len(a$) != 0 do copy

	        ; a$ is NULL => uses HL = DE for transfer
			ld h, d
			ld l, e
			ld (hl), a	; This will copy 00 00 at (DE) location
	        inc de      ;
	        dec bc      ; Ensure BC will be set to 1 in the next step

__STR_CONT1:        ; Copies a$ (HL) into c$ (DE)
			inc bc
			inc bc		; BC = BC + 2
		ldir		; MEMCOPY: c$ = a$
			pop hl		; HL = c$

			exx
			push de		; Recovers b$; A ex hl,hl' would be very handy
			exx

			pop de		; DE = b$

__STRCAT: ; ConCATenate two strings a$ = a$ + b$. HL = ptr to a$, DE = ptr to b$
		  ; NOTE: Both DE, BC and AF are modified and lost
			  ; Returns HL (pointer to a$)
			  ; a$ Must be NOT NULL
			ld a, d
			or e
			ret z		; Returns if de is NULL (nothing to copy)

			push hl		; Saves HL to return it later

			ld c, (hl)
			inc hl
			ld b, (hl)
			inc hl
			add hl, bc	; HL = end of (a$) string ; bc = len(a$)
			push bc		; Saves LEN(a$) for later

			ex de, hl	; DE = end of string (Begin of copy addr)
			ld c, (hl)
			inc hl
			ld b, (hl)	; BC = len(b$)

			ld a, b
			or c
			jr z, __STRCATEND; Return if len(b$) == 0

			push bc			 ; Save LEN(b$)
			inc hl			 ; Skip 2nd byte of len(b$)
			ldir			 ; Concatenate b$

			pop bc			 ; Recovers length (b$)
			pop hl			 ; Recovers length (a$)
			add hl, bc		 ; HL = LEN(a$) + LEN(b$) = LEN(a$+b$)
			ex de, hl		 ; DE = LEN(a$+b$)
			pop hl

			ld (hl), e		 ; Updates new LEN and return
			inc hl
			ld (hl), d
			dec hl
			ret

__STRCATEND:
			pop hl		; Removes Len(a$)
			pop hl		; Restores original HL, so HL = a$
			ret

			ENDP

#line 10853 "Program.zxbas"
#line 1 "strictbool.asm"

	; This routine is called if --strict-boolean was set at the command line.
	; It will make any boolean result to be always 0 or 1

__NORMALIZE_BOOLEAN:
	    or a
	    ret z
	    ld a, 1
	    ret

#line 10854 "Program.zxbas"

#line 1 "strslice.asm"

	; String slicing library
	; HL = Str pointer
	; DE = String start
	; BC = String character end
	; A register => 0 => the HL pointer wont' be freed from the HEAP
	; e.g. a$(5 TO 10) => HL = a$; DE = 5; BC = 10

	; This implements a$(X to Y) being X and Y first and
	; last characters respectively. If X > Y, NULL is returned

	; Otherwise returns a pointer to a$ FROM X to Y (starting from 0)
	; if Y > len(a$), then a$ will be padded with spaces (reallocating
	; it in dynamic memory if needed). Returns pointer (HL) to resulting
	; string. NULL (0) if no memory for padding.
	;





__STRSLICE:			; Callee entry
		pop hl			; Return ADDRESS
		pop bc			; Last char pos
		pop de			; 1st char pos
		ex (sp), hl		; CALLEE. -> String start

__STRSLICE_FAST:	; __FASTCALL__ Entry
		PROC

		LOCAL __CONT
		LOCAL __EMPTY
		LOCAL __FREE_ON_EXIT

		push hl			; Stores original HL pointer to be recovered on exit
		ex af, af'		; Saves A register for later

		push hl
		call __STRLEN
		inc bc			; Last character position + 1 (string starts from 0)
		or a
		sbc hl, bc		; Compares length with last char position
		jr nc, __CONT	; If Carry => We must copy to end of string
		add hl, bc		; Restore back original LEN(a$) in HL
		ld b, h
		ld c, l			; Copy to the end of str
		ccf				; Clears Carry flag for next subtraction

__CONT:
		ld h, b
		ld l, c			; HL = Last char position to copy (1 for char 0, 2 for char 1, etc)
		sbc hl, de		; HL = LEN(a$) - DE => Number of chars to copy
		jr z, __EMPTY	; 0 Chars to copy => Return HL = 0 (NULL STR)
		jr c, __EMPTY	; If Carry => Nothing to return (NULL STR)

		ld b, h
		ld c, l			; BC = Number of chars to copy
		inc bc
		inc bc			; +2 bytes for string length number

		push bc
		push de
		call __MEM_ALLOC
		pop de
		pop bc
		ld a, h
		or l
		jr z, __EMPTY	; Return if NULL (no memory)

		dec bc
		dec bc			; Number of chars to copy (Len of slice)

		ld (hl), c
		inc hl
		ld (hl), b
		inc hl			; Stores new string length

		ex (sp), hl		; Pointer to A$ now in HL; Pointer to new string chars in Stack
		inc hl
		inc hl			; Skip string length
		add hl, de		; Were to start from A$
		pop de			; Start of new string chars
		push de			; Stores it again
		ldir			; Copies BC chars
		pop de
		dec de
		dec de			; Points to String LEN start
		ex de, hl		; Returns it in HL
		jr __FREE_ON_EXIT

__EMPTY:			; Return NULL (empty) string
		pop hl
		ld hl, 0		; Return NULL


__FREE_ON_EXIT:
		ex af, af'		; Recover original A register
		ex (sp), hl		; Original HL pointer

		or a
		call nz, __MEM_FREE

		pop hl			; Recover result
		ret

		ENDP

#line 10856 "Program.zxbas"
#line 1 "u32tofreg.asm"

#line 1 "neg32.asm"

__ABS32:
		bit 7, d
		ret z

__NEG32: ; Negates DEHL (Two's complement)
		ld a, l
		cpl
		ld l, a

		ld a, h
		cpl
		ld h, a

		ld a, e
		cpl
		ld e, a

		ld a, d
		cpl
		ld d, a

		inc l
		ret nz

		inc h
		ret nz

		inc de
		ret

#line 2 "u32tofreg.asm"
__I8TOFREG:
		ld l, a
		rlca
		sbc a, a	; A = SGN(A)
		ld h, a
		ld e, a
		ld d, a

__I32TOFREG:	; Converts a 32bit signed integer (stored in DEHL)
					; to a Floating Point Number returned in (A ED CB)

		ld a, d
		or a		; Test sign

		jp p, __U32TOFREG	; It was positive, proceed as 32bit unsigned

		call __NEG32		; Convert it to positive
		call __U32TOFREG	; Convert it to Floating point

		set 7, e			; Put the sign bit (negative) in the 31bit of mantissa
		ret

__U8TOFREG:
					; Converts an unsigned 8 bit (A) to Floating point
		ld l, a
		ld h, 0
		ld e, h
		ld d, h

__U32TOFREG:	; Converts an unsigned 32 bit integer (DEHL)
					; to a Floating point number returned in A ED CB

	    PROC

	    LOCAL __U32TOFREG_END

		ld a, d
		or e
		or h
		or l
	    ld b, d
		ld c, e		; Returns 00 0000 0000 if ZERO
		ret z

		push de
		push hl

		exx
		pop de  ; Loads integer into B'C' D'E'
		pop bc
		exx

		ld l, 128	; Exponent
		ld bc, 0	; DEBC = 0
		ld d, b
		ld e, c

__U32TOFREG_LOOP: ; Also an entry point for __F16TOFREG
		exx
		ld a, d 	; B'C'D'E' == 0 ?
		or e
		or b
		or c
		jp z, __U32TOFREG_END	; We are done

		srl b ; Shift B'C' D'E' >> 1, output bit stays in Carry
		rr c
		rr d
		rr e
		exx

		rr e ; Shift EDCB >> 1, inserting the carry on the left
		rr d
		rr c
		rr b

		inc l	; Increment exponent
		jp __U32TOFREG_LOOP


__U32TOFREG_END:
		exx
	    ld a, l     ; Puts the exponent in a
		res 7, e	; Sets the sign bit to 0 (positive)

		ret
	    ENDP

#line 10857 "Program.zxbas"

ZXBASIC_USER_DATA:
	_input_LastK EQU 23560
_currentEnemies:
	DEFB 00
_currentMapIndex:
	DEFB 00, 00
_currentMap:
	DEFB 00
_currentMapExit:
	DEFB 00
_enemyCount:
	DEFB 00
_frameCounter:
	DEFB 00
_lampX:
	DEFB 00
_lampY:
	DEFB 00
_lightOn:
	DEFB 00
_playerXEnter:
	DEFB 00
_playerYEnter:
	DEFB 00
_playerX:
	DEFB 00
_playerY:
	DEFB 00
_prevPlayerX:
	DEFB 00
_prevPlayerY:
	DEFB 00
_playerDir:
	DEFB 01h
_playerEnterDir:
	DEFB 01h
_lastHead:
	DEFB 00h
	DEFB 00h
_lastBody:
	DEFB 00h
	DEFB 00h
_playerMoved:
	DEFB 00h
_dynaCounter:
	DEFB 0FFh
_lastDyna:
	DEFB 00, 00
_dynaX:
	DEFB 00
_dynaY:
	DEFB 00
_lifes:
	DEFB 04h
_dynamites:
	DEFB 04h
_entryScreen:
	DEFB 00h
_currentEntryIndex:
	DEFB 00h
	DEFB 00h
_emptyAttrib:
	DEFB 00
_tmpX:
	DEFB 00
_tmpY:
	DEFB 00
_tmpZ:
	DEFB 00
_tmpDisplace:
	DEFB 00
_tmpResult:
	DEFB 00
_prevShotX:
	DEFB 00
_prevShotY:
	DEFB 00
_shotX:
	DEFB 00
_shotY:
	DEFB 00
_deadEnemy:
	DEFB 00
_personX:
	DEFB 00
_personY:
	DEFB 00
_power:
	DEFB 00, 00
_score:
	DEFB 00, 00
_vampColor:
	DEFB 00
_spiderColor:
	DEFB 00
_snakeColor:
	DEFB 00
_bugColor:
	DEFB 00
_crocoColor:
	DEFB 00
_crabColor:
	DEFB 00
_flyColor:
	DEFB 00
_dynaColor:
	DEFB 00
_tmpPattern:
	DEFB 00, 00
_tmpColor:
	DEFB 00
_tmpItem:
	DEFB 00, 00
_tmpPrevItem:
	DEFB 00, 00
_xStart:
	DEFB 00
_yStart:
	DEFB 00
_xEnd:
	DEFB 00
_yEnd:
	DEFB 00
_state:
	DEFB 00h
_updateResult:
	DEFB 00h
_exitResult:
	DEFB 00
_bitmapBuffer:
	DEFW __LABEL733
_bitmapBuffer.__DATA__.__PTR__:
	DEFW _bitmapBuffer.__DATA__
_bitmapBuffer.__DATA__:
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
__LABEL733:
	DEFW 0000h
	DEFB 01h
_attribBuffer:
	DEFW __LABEL734
_attribBuffer.__DATA__.__PTR__:
	DEFW _attribBuffer.__DATA__
_attribBuffer.__DATA__:
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
__LABEL734:
	DEFW 0000h
	DEFB 01h
_tableCP:
	DEFW __LABEL735
_tableCP.__DATA__.__PTR__:
	DEFW _tableCP.__DATA__
_tableCP.__DATA__:
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
__LABEL735:
	DEFW 0000h
	DEFB 02h
_tlc:
	DEFW __LABEL736
_tlc.__DATA__.__PTR__:
	DEFW _tlc.__DATA__
_tlc.__DATA__:
	DEFB 3Ch
	DEFB 42h
	DEFB 0A1h
	DEFB 0A1h
	DEFB 0A1h
	DEFB 0A1h
	DEFB 0A1h
	DEFB 0A1h
__LABEL736:
	DEFW 0000h
	DEFB 01h
_blc:
	DEFW __LABEL737
_blc.__DATA__.__PTR__:
	DEFW _blc.__DATA__
_blc.__DATA__:
	DEFB 0A1h
	DEFB 0A1h
	DEFB 0A1h
	DEFB 0A1h
	DEFB 0A1h
	DEFB 0A1h
	DEFB 42h
	DEFB 3Ch
__LABEL737:
	DEFW 0000h
	DEFB 01h
_mlor:
	DEFW __LABEL738
_mlor.__DATA__.__PTR__:
	DEFW _mlor.__DATA__
_mlor.__DATA__:
	DEFB 0A1h
	DEFB 0A0h
	DEFB 0A0h
	DEFB 0A0h
	DEFB 0A0h
	DEFB 0A0h
	DEFB 0A0h
	DEFB 0A1h
__LABEL738:
	DEFW 0000h
	DEFB 01h
_mlol:
	DEFW __LABEL739
_mlol.__DATA__.__PTR__:
	DEFW _mlol.__DATA__
_mlol.__DATA__:
	DEFB 0A1h
	DEFB 21h
	DEFB 21h
	DEFB 21h
	DEFB 21h
	DEFB 21h
	DEFB 21h
	DEFB 0A1h
__LABEL739:
	DEFW 0000h
	DEFB 01h
_mlo:
	DEFW __LABEL740
_mlo.__DATA__.__PTR__:
	DEFW _mlo.__DATA__
_mlo.__DATA__:
	DEFB 0FFh
	DEFB 00h
	DEFB 0FFh
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 0FFh
__LABEL740:
	DEFW 0000h
	DEFB 01h
_dot:
	DEFW __LABEL741
_dot.__DATA__.__PTR__:
	DEFW _dot.__DATA__
_dot.__DATA__:
	DEFB 00h
	DEFB 00h
	DEFB 18h
	DEFB 24h
	DEFB 5Ah
	DEFB 52h
	DEFB 24h
	DEFB 18h
__LABEL741:
	DEFW 0000h
	DEFB 01h
_tlcc:
	DEFW __LABEL742
_tlcc.__DATA__.__PTR__:
	DEFW _tlcc.__DATA__
_tlcc.__DATA__:
	DEFB 3Fh
	DEFB 40h
	DEFB 80h
	DEFB 0A0h
	DEFB 0A0h
	DEFB 0A0h
	DEFB 0A0h
	DEFB 0A1h
__LABEL742:
	DEFW 0000h
	DEFB 01h
_blcc:
	DEFW __LABEL743
_blcc.__DATA__.__PTR__:
	DEFW _blcc.__DATA__
_blcc.__DATA__:
	DEFB 0A1h
	DEFB 0A0h
	DEFB 0A0h
	DEFB 0A0h
	DEFB 0A0h
	DEFB 80h
	DEFB 40h
	DEFB 3Fh
__LABEL743:
	DEFW 0000h
	DEFB 01h
_rec:
	DEFW __LABEL744
_rec.__DATA__.__PTR__:
	DEFW _rec.__DATA__
_rec.__DATA__:
	DEFB 0FCh
	DEFB 02h
	DEFB 0F9h
	DEFB 01h
	DEFB 01h
	DEFB 01h
	DEFB 02h
	DEFB 0FCh
__LABEL744:
	DEFW 0000h
	DEFB 01h
_rct:
	DEFW __LABEL745
_rct.__DATA__.__PTR__:
	DEFW _rct.__DATA__
_rct.__DATA__:
	DEFB 0FCh
	DEFB 02h
	DEFB 0F9h
	DEFB 01h
	DEFB 01h
	DEFB 01h
	DEFB 01h
	DEFB 81h
__LABEL745:
	DEFW 0000h
	DEFB 01h
_rcbs:
	DEFW __LABEL746
_rcbs.__DATA__.__PTR__:
	DEFW _rcbs.__DATA__
_rcbs.__DATA__:
	DEFB 81h
	DEFB 01h
	DEFB 81h
	DEFB 01h
	DEFB 01h
	DEFB 01h
	DEFB 02h
	DEFB 1Ch
__LABEL746:
	DEFW 0000h
	DEFB 01h
_mlob:
	DEFW __LABEL747
_mlob.__DATA__.__PTR__:
	DEFW _mlob.__DATA__
_mlob.__DATA__:
	DEFB 0FFh
	DEFB 00h
	DEFB 0FFh
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 80h
__LABEL747:
	DEFW 0000h
	DEFB 01h
_dgl:
	DEFW __LABEL748
_dgl.__DATA__.__PTR__:
	DEFW _dgl.__DATA__
_dgl.__DATA__:
	DEFB 60h
	DEFB 10h
	DEFB 08h
	DEFB 04h
	DEFB 02h
	DEFB 01h
	DEFB 00h
	DEFB 00h
__LABEL748:
	DEFW 0000h
	DEFB 01h
_dglc:
	DEFW __LABEL749
_dglc.__DATA__.__PTR__:
	DEFW _dglc.__DATA__
_dglc.__DATA__:
	DEFB 10h
	DEFB 08h
	DEFB 04h
	DEFB 02h
	DEFB 01h
	DEFB 01h
	DEFB 82h
	DEFB 7Ch
__LABEL749:
	DEFW 0000h
	DEFB 01h
_mlc:
	DEFW __LABEL750
_mlc.__DATA__.__PTR__:
	DEFW _mlc.__DATA__
_mlc.__DATA__:
	DEFB 0A1h
	DEFB 0A1h
	DEFB 0A1h
	DEFB 0A1h
	DEFB 0A1h
	DEFB 0A1h
	DEFB 0A1h
	DEFB 0A1h
__LABEL750:
	DEFW 0000h
	DEFB 01h
_rcb:
	DEFW __LABEL751
_rcb.__DATA__.__PTR__:
	DEFW _rcb.__DATA__
_rcb.__DATA__:
	DEFB 0A1h
	DEFB 21h
	DEFB 0C1h
	DEFB 01h
	DEFB 01h
	DEFB 01h
	DEFB 02h
	DEFB 0FCh
__LABEL751:
	DEFW 0000h
	DEFB 01h
_energy:
	DEFW __LABEL752
_energy.__DATA__.__PTR__:
	DEFW _energy.__DATA__
_energy.__DATA__:
	DEFB 7Eh
	DEFB 0D5h
	DEFB 0ABh
	DEFB 0D5h
	DEFB 0ABh
	DEFB 0D5h
	DEFB 0ABh
	DEFB 7Eh
__LABEL752:
	DEFW 0000h
	DEFB 01h
_vampUp:
	DEFW __LABEL753
_vampUp.__DATA__.__PTR__:
	DEFW _vampUp.__DATA__
_vampUp.__DATA__:
	DEFB 00h
	DEFB 0A5h
	DEFB 0DBh
	DEFB 0E7h
	DEFB 0FFh
	DEFB 7Eh
	DEFB 18h
	DEFB 00h
__LABEL753:
	DEFW 0000h
	DEFB 01h
_vampDown:
	DEFW __LABEL754
_vampDown.__DATA__.__PTR__:
	DEFW _vampDown.__DATA__
_vampDown.__DATA__:
	DEFB 00h
	DEFB 24h
	DEFB 5Ah
	DEFB 0E7h
	DEFB 0FFh
	DEFB 0FFh
	DEFB 99h
	DEFB 00h
__LABEL754:
	DEFW 0000h
	DEFB 01h
_lampl:
	DEFW __LABEL755
_lampl.__DATA__.__PTR__:
	DEFW _lampl.__DATA__
_lampl.__DATA__:
	DEFB 1Fh
	DEFB 18h
	DEFB 7Eh
	DEFB 0FFh
	DEFB 42h
	DEFB 7Eh
	DEFB 24h
	DEFB 18h
__LABEL755:
	DEFW 0000h
	DEFB 01h
_lampr:
	DEFW __LABEL756
_lampr.__DATA__.__PTR__:
	DEFW _lampr.__DATA__
_lampr.__DATA__:
	DEFB 0F8h
	DEFB 18h
	DEFB 7Eh
	DEFB 0FFh
	DEFB 42h
	DEFB 7Eh
	DEFB 24h
	DEFB 18h
__LABEL756:
	DEFW 0000h
	DEFB 01h
_spider:
	DEFW __LABEL757
_spider.__DATA__.__PTR__:
	DEFW _spider.__DATA__
_spider.__DATA__:
	DEFB 00h
	DEFB 0DBh
	DEFB 3Ch
	DEFB 0DBh
	DEFB 3Ch
	DEFB 5Ah
	DEFB 42h
	DEFB 00h
__LABEL757:
	DEFW 0000h
	DEFB 01h
_dynamite1:
	DEFW __LABEL758
_dynamite1.__DATA__.__PTR__:
	DEFW _dynamite1.__DATA__
_dynamite1.__DATA__:
	DEFB 28h
	DEFB 10h
	DEFB 08h
	DEFB 3Ch
	DEFB 3Ch
	DEFB 3Ch
	DEFB 3Ch
	DEFB 3Ch
__LABEL758:
	DEFW 0000h
	DEFB 01h
_dynamite2:
	DEFW __LABEL759
_dynamite2.__DATA__.__PTR__:
	DEFW _dynamite2.__DATA__
_dynamite2.__DATA__:
	DEFB 14h
	DEFB 08h
	DEFB 10h
	DEFB 3Ch
	DEFB 3Ch
	DEFB 3Ch
	DEFB 3Ch
	DEFB 3Ch
__LABEL759:
	DEFW 0000h
	DEFB 01h
_skh1:
	DEFW __LABEL760
_skh1.__DATA__.__PTR__:
	DEFW _skh1.__DATA__
_skh1.__DATA__:
	DEFB 00h
	DEFB 06h
	DEFB 0ADh
	DEFB 5Bh
	DEFB 08h
	DEFB 06h
	DEFB 00h
	DEFB 00h
__LABEL760:
	DEFW 0000h
	DEFB 01h
_skh2:
	DEFW __LABEL761
_skh2.__DATA__.__PTR__:
	DEFW _skh2.__DATA__
_skh2.__DATA__:
	DEFB 00h
	DEFB 60h
	DEFB 0B5h
	DEFB 0DAh
	DEFB 10h
	DEFB 60h
	DEFB 00h
	DEFB 00h
__LABEL761:
	DEFW 0000h
	DEFB 01h
_skb:
	DEFW __LABEL762
_skb.__DATA__.__PTR__:
	DEFW _skb.__DATA__
_skb.__DATA__:
	DEFB 00h
	DEFB 0CCh
	DEFB 0FFh
	DEFB 0FFh
	DEFB 33h
	DEFB 00h
	DEFB 00h
	DEFB 00h
__LABEL762:
	DEFW 0000h
	DEFB 01h
_bug1:
	DEFW __LABEL763
_bug1.__DATA__.__PTR__:
	DEFW _bug1.__DATA__
_bug1.__DATA__:
	DEFB 24h
	DEFB 24h
	DEFB 3Ch
	DEFB 0C3h
	DEFB 0C3h
	DEFB 3Ch
	DEFB 24h
	DEFB 24h
__LABEL763:
	DEFW 0000h
	DEFB 01h
_bug2:
	DEFW __LABEL764
_bug2.__DATA__.__PTR__:
	DEFW _bug2.__DATA__
_bug2.__DATA__:
	DEFB 00h
	DEFB 0C3h
	DEFB 3Ch
	DEFB 0C3h
	DEFB 0C3h
	DEFB 3Ch
	DEFB 0C3h
	DEFB 00h
__LABEL764:
	DEFW 0000h
	DEFB 01h
_crock1:
	DEFW __LABEL765
_crock1.__DATA__.__PTR__:
	DEFW _crock1.__DATA__
_crock1.__DATA__:
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 60h
	DEFB 0D0h
	DEFB 0FEh
__LABEL765:
	DEFW 0000h
	DEFB 01h
_crock2:
	DEFW __LABEL766
_crock2.__DATA__.__PTR__:
	DEFW _crock2.__DATA__
_crock2.__DATA__:
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 61h
	DEFB 0D6h
	DEFB 0F8h
	DEFB 0F0h
	DEFB 7Fh
__LABEL766:
	DEFW 0000h
	DEFB 01h
_walll:
	DEFW __LABEL767
_walll.__DATA__.__PTR__:
	DEFW _walll.__DATA__
_walll.__DATA__:
	DEFB 0FDh
	DEFB 0FAh
	DEFB 0FDh
	DEFB 0F9h
	DEFB 0FEh
	DEFB 0FDh
	DEFB 0FAh
	DEFB 0FEh
__LABEL767:
	DEFW 0000h
	DEFB 01h
_wallr:
	DEFW __LABEL768
_wallr.__DATA__.__PTR__:
	DEFW _wallr.__DATA__
_wallr.__DATA__:
	DEFB 0BFh
	DEFB 5Fh
	DEFB 0BFh
	DEFB 9Fh
	DEFB 7Fh
	DEFB 0BFh
	DEFB 5Fh
	DEFB 7Fh
__LABEL768:
	DEFW 0000h
	DEFB 01h
_wallb:
	DEFW __LABEL769
_wallb.__DATA__.__PTR__:
	DEFW _wallb.__DATA__
_wallb.__DATA__:
	DEFB 2Dh
	DEFB 0D2h
	DEFB 0B5h
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0FFh
__LABEL769:
	DEFW 0000h
	DEFB 01h
_wallt:
	DEFW __LABEL770
_wallt.__DATA__.__PTR__:
	DEFW _wallt.__DATA__
_wallt.__DATA__:
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0B5h
	DEFB 0D2h
	DEFB 2Dh
__LABEL770:
	DEFW 0000h
	DEFB 01h
_walltr:
	DEFW __LABEL771
_walltr.__DATA__.__PTR__:
	DEFW _walltr.__DATA__
_walltr.__DATA__:
	DEFB 0B5h
	DEFB 4Ah
	DEFB 0AFh
	DEFB 0FAh
	DEFB 0FEh
	DEFB 0FDh
	DEFB 0FAh
	DEFB 0FDh
__LABEL771:
	DEFW 0000h
	DEFB 01h
_walltl:
	DEFW __LABEL772
_walltl.__DATA__.__PTR__:
	DEFW _walltl.__DATA__
_walltl.__DATA__:
	DEFB 0ADh
	DEFB 52h
	DEFB 0F5h
	DEFB 5Fh
	DEFB 7Fh
	DEFB 0BFh
	DEFB 5Fh
	DEFB 0BFh
__LABEL772:
	DEFW 0000h
	DEFB 01h
_wallbr:
	DEFW __LABEL773
_wallbr.__DATA__.__PTR__:
	DEFW _wallbr.__DATA__
_wallbr.__DATA__:
	DEFB 0FDh
	DEFB 0FAh
	DEFB 0FDh
	DEFB 0FEh
	DEFB 0FAh
	DEFB 0AFh
	DEFB 4Ah
	DEFB 0B5h
__LABEL773:
	DEFW 0000h
	DEFB 01h
_wallbl:
	DEFW __LABEL774
_wallbl.__DATA__.__PTR__:
	DEFW _wallbl.__DATA__
_wallbl.__DATA__:
	DEFB 0BFh
	DEFB 5Fh
	DEFB 0BFh
	DEFB 7Fh
	DEFB 5Fh
	DEFB 0F5h
	DEFB 52h
	DEFB 0ADh
__LABEL774:
	DEFW 0000h
	DEFB 01h
_singleWallV:
	DEFW __LABEL775
_singleWallV.__DATA__.__PTR__:
	DEFW _singleWallV.__DATA__
_singleWallV.__DATA__:
	DEFB 0BEh
	DEFB 5Dh
	DEFB 0BDh
	DEFB 7Eh
	DEFB 9Eh
	DEFB 0BDh
	DEFB 5Eh
	DEFB 0BDh
__LABEL775:
	DEFW 0000h
	DEFB 01h
_singleWallH:
	DEFW __LABEL776
_singleWallH.__DATA__.__PTR__:
	DEFW _singleWallH.__DATA__
_singleWallH.__DATA__:
	DEFB 0B5h
	DEFB 4Ah
	DEFB 0ADh
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0FFh
	DEFB 59h
	DEFB 0A6h
__LABEL776:
	DEFW 0000h
	DEFB 01h
_destructibleWallV:
	DEFW __LABEL777
_destructibleWallV.__DATA__.__PTR__:
	DEFW _destructibleWallV.__DATA__
_destructibleWallV.__DATA__:
	DEFB 0DBh
	DEFB 0BDh
	DEFB 0DBh
	DEFB 0BDh
	DEFB 0DBh
	DEFB 0BDh
	DEFB 0DBh
	DEFB 0BDh
__LABEL777:
	DEFW 0000h
	DEFB 01h
_destructibleWallH:
	DEFW __LABEL778
_destructibleWallH.__DATA__.__PTR__:
	DEFW _destructibleWallH.__DATA__
_destructibleWallH.__DATA__:
	DEFB 0FFh
	DEFB 55h
	DEFB 0AAh
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0AAh
	DEFB 55h
	DEFB 0FFh
__LABEL778:
	DEFW 0000h
	DEFB 01h
_rockT:
	DEFW __LABEL779
_rockT.__DATA__.__PTR__:
	DEFW _rockT.__DATA__
_rockT.__DATA__:
	DEFB 0B5h
	DEFB 6Ah
	DEFB 0BDh
	DEFB 79h
	DEFB 7Eh
	DEFB 0BDh
	DEFB 0FFh
	DEFB 0FFh
__LABEL779:
	DEFW 0000h
	DEFB 01h
_rockB:
	DEFW __LABEL780
_rockB.__DATA__.__PTR__:
	DEFW _rockB.__DATA__
_rockB.__DATA__:
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0BDh
	DEFB 7Eh
	DEFB 9Eh
	DEFB 0BDh
	DEFB 56h
	DEFB 0ADh
__LABEL780:
	DEFW 0000h
	DEFB 01h
_rockL:
	DEFW __LABEL781
_rockL.__DATA__.__PTR__:
	DEFW _rockL.__DATA__
_rockL.__DATA__:
	DEFB 0B7h
	DEFB 4Bh
	DEFB 0AFh
	DEFB 7Fh
	DEFB 0BFh
	DEFB 0FFh
	DEFB 5Bh
	DEFB 0A7h
__LABEL781:
	DEFW 0000h
	DEFB 01h
_rockR:
	DEFW __LABEL782
_rockR.__DATA__.__PTR__:
	DEFW _rockR.__DATA__
_rockR.__DATA__:
	DEFB 0E5h
	DEFB 0DAh
	DEFB 0FFh
	DEFB 0FDh
	DEFB 0FEh
	DEFB 0F5h
	DEFB 0D2h
	DEFB 0EDh
__LABEL782:
	DEFW 0000h
	DEFB 01h
_fly1:
	DEFW __LABEL783
_fly1.__DATA__.__PTR__:
	DEFW _fly1.__DATA__
_fly1.__DATA__:
	DEFB 00h
	DEFB 42h
	DEFB 0BDh
	DEFB 0BDh
	DEFB 0A5h
	DEFB 5Ah
	DEFB 00h
	DEFB 00h
__LABEL783:
	DEFW 0000h
	DEFB 01h
_fly2:
	DEFW __LABEL784
_fly2.__DATA__.__PTR__:
	DEFW _fly2.__DATA__
_fly2.__DATA__:
	DEFB 00h
	DEFB 00h
	DEFB 5Ah
	DEFB 0BDh
	DEFB 0A5h
	DEFB 0BDh
	DEFB 42h
	DEFB 00h
__LABEL784:
	DEFW 0000h
	DEFB 01h
_crab1:
	DEFW __LABEL785
_crab1.__DATA__.__PTR__:
	DEFW _crab1.__DATA__
_crab1.__DATA__:
	DEFB 60h
	DEFB 0A6h
	DEFB 0C5h
	DEFB 0BFh
	DEFB 7Dh
	DEFB 5Ah
	DEFB 3Ch
	DEFB 5Ah
__LABEL785:
	DEFW 0000h
	DEFB 01h
_crab2:
	DEFW __LABEL786
_crab2.__DATA__.__PTR__:
	DEFW _crab2.__DATA__
_crab2.__DATA__:
	DEFB 06h
	DEFB 65h
	DEFB 0A3h
	DEFB 0FDh
	DEFB 0BEh
	DEFB 5Ah
	DEFB 3Ch
	DEFB 24h
__LABEL786:
	DEFW 0000h
	DEFB 01h
_solid:
	DEFW __LABEL787
_solid.__DATA__.__PTR__:
	DEFW _solid.__DATA__
_solid.__DATA__:
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0FFh
__LABEL787:
	DEFW 0000h
	DEFB 01h
_empty:
	DEFW __LABEL788
_empty.__DATA__.__PTR__:
	DEFW _empty.__DATA__
_empty.__DATA__:
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
__LABEL788:
	DEFW 0000h
	DEFB 01h
_water:
	DEFW __LABEL789
_water.__DATA__.__PTR__:
	DEFW _water.__DATA__
_water.__DATA__:
	DEFB 33h
	DEFB 0CCh
	DEFB 33h
	DEFB 0CCh
	DEFB 33h
	DEFB 0CCh
	DEFB 33h
	DEFB 0CCh
__LABEL789:
	DEFW 0000h
	DEFB 01h
_head1r:
	DEFW __LABEL790
_head1r.__DATA__.__PTR__:
	DEFW _head1r.__DATA__
_head1r.__DATA__:
	DEFB 0FFh
	DEFB 18h
	DEFB 3Ch
	DEFB 72h
	DEFB 7Eh
	DEFB 3Ch
	DEFB 98h
	DEFB 0BCh
__LABEL790:
	DEFW 0000h
	DEFB 01h
_head2r:
	DEFW __LABEL791
_head2r.__DATA__.__PTR__:
	DEFW _head2r.__DATA__
_head2r.__DATA__:
	DEFB 18h
	DEFB 18h
	DEFB 3Ch
	DEFB 72h
	DEFB 7Eh
	DEFB 3Ch
	DEFB 98h
	DEFB 0BCh
__LABEL791:
	DEFW 0000h
	DEFB 01h
_body1r:
	DEFW __LABEL792
_body1r.__DATA__.__PTR__:
	DEFW _body1r.__DATA__
_body1r.__DATA__:
	DEFB 0FFh
	DEFB 7Eh
	DEFB 7Ch
	DEFB 3Ch
	DEFB 18h
	DEFB 18h
	DEFB 18h
	DEFB 1Ch
__LABEL792:
	DEFW 0000h
	DEFB 01h
_body2r:
	DEFW __LABEL793
_body2r.__DATA__.__PTR__:
	DEFW _body2r.__DATA__
_body2r.__DATA__:
	DEFB 0FFh
	DEFB 7Eh
	DEFB 7Ch
	DEFB 3Ch
	DEFB 18h
	DEFB 78h
	DEFB 40h
	DEFB 00h
__LABEL793:
	DEFW 0000h
	DEFB 01h
_head1l:
	DEFW __LABEL794
_head1l.__DATA__.__PTR__:
	DEFW _head1l.__DATA__
_head1l.__DATA__:
	DEFB 0FFh
	DEFB 18h
	DEFB 3Ch
	DEFB 4Eh
	DEFB 7Eh
	DEFB 3Ch
	DEFB 19h
	DEFB 3Dh
__LABEL794:
	DEFW 0000h
	DEFB 01h
_head2l:
	DEFW __LABEL795
_head2l.__DATA__.__PTR__:
	DEFW _head2l.__DATA__
_head2l.__DATA__:
	DEFB 18h
	DEFB 18h
	DEFB 3Ch
	DEFB 4Eh
	DEFB 7Eh
	DEFB 3Ch
	DEFB 19h
	DEFB 3Dh
__LABEL795:
	DEFW 0000h
	DEFB 01h
_body1l:
	DEFW __LABEL796
_body1l.__DATA__.__PTR__:
	DEFW _body1l.__DATA__
_body1l.__DATA__:
	DEFB 0FFh
	DEFB 7Eh
	DEFB 3Eh
	DEFB 3Ch
	DEFB 18h
	DEFB 18h
	DEFB 18h
	DEFB 38h
__LABEL796:
	DEFW 0000h
	DEFB 01h
_body2l:
	DEFW __LABEL797
_body2l.__DATA__.__PTR__:
	DEFW _body2l.__DATA__
_body2l.__DATA__:
	DEFB 0FFh
	DEFB 7Eh
	DEFB 3Eh
	DEFB 3Ch
	DEFB 18h
	DEFB 1Eh
	DEFB 02h
	DEFB 00h
__LABEL797:
	DEFW 0000h
	DEFB 01h
_death1u:
	DEFW __LABEL798
_death1u.__DATA__.__PTR__:
	DEFW _death1u.__DATA__
_death1u.__DATA__:
	DEFB 81h
	DEFB 42h
	DEFB 24h
	DEFB 81h
	DEFB 5Ah
	DEFB 3Ch
	DEFB 0FFh
	DEFB 7Eh
__LABEL798:
	DEFW 0000h
	DEFB 01h
_death1d:
	DEFW __LABEL799
_death1d.__DATA__.__PTR__:
	DEFW _death1d.__DATA__
_death1d.__DATA__:
	DEFB 7Eh
	DEFB 0FFh
	DEFB 3Ch
	DEFB 5Ah
	DEFB 81h
	DEFB 24h
	DEFB 42h
	DEFB 81h
__LABEL799:
	DEFW 0000h
	DEFB 01h
_death2u:
	DEFW __LABEL800
_death2u.__DATA__.__PTR__:
	DEFW _death2u.__DATA__
_death2u.__DATA__:
	DEFB 00h
	DEFB 42h
	DEFB 24h
	DEFB 18h
	DEFB 42h
	DEFB 24h
	DEFB 00h
	DEFB 66h
__LABEL800:
	DEFW 0000h
	DEFB 01h
_death2d:
	DEFW __LABEL801
_death2d.__DATA__.__PTR__:
	DEFW _death2d.__DATA__
_death2d.__DATA__:
	DEFB 66h
	DEFB 00h
	DEFB 24h
	DEFB 42h
	DEFB 18h
	DEFB 24h
	DEFB 42h
	DEFB 00h
__LABEL801:
	DEFW 0000h
	DEFB 01h
_skull:
	DEFW __LABEL802
_skull.__DATA__.__PTR__:
	DEFW _skull.__DATA__
_skull.__DATA__:
	DEFB 7Eh
	DEFB 0FFh
	DEFB 99h
	DEFB 99h
	DEFB 0E7h
	DEFB 7Eh
	DEFB 42h
	DEFB 3Ch
__LABEL802:
	DEFW 0000h
	DEFB 01h
_outWall:
	DEFW __LABEL803
_outWall.__DATA__.__PTR__:
	DEFW _outWall.__DATA__
_outWall.__DATA__:
	DEFB 0CCh
	DEFB 55h
	DEFB 0AAh
	DEFB 0AAh
	DEFB 55h
	DEFB 55h
	DEFB 0AAh
	DEFB 33h
__LABEL803:
	DEFW 0000h
	DEFB 01h
_personT:
	DEFW __LABEL804
_personT.__DATA__.__PTR__:
	DEFW _personT.__DATA__
_personT.__DATA__:
	DEFB 3Eh
	DEFB 49h
	DEFB 5Dh
	DEFB 49h
	DEFB 32h
	DEFB 0Ch
	DEFB 68h
	DEFB 0F0h
__LABEL804:
	DEFW 0000h
	DEFB 01h
_personB:
	DEFW __LABEL805
_personB.__DATA__.__PTR__:
	DEFW _personB.__DATA__
_personB.__DATA__:
	DEFB 0D0h
	DEFB 0F0h
	DEFB 60h
	DEFB 0F0h
	DEFB 0B0h
	DEFB 0BCh
	DEFB 0D6h
	DEFB 63h
__LABEL805:
	DEFW 0000h
	DEFB 01h
_shot:
	DEFW __LABEL806
_shot.__DATA__.__PTR__:
	DEFW _shot.__DATA__
_shot.__DATA__:
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 6Ah
	DEFB 00h
	DEFB 00h
	DEFB 00h
__LABEL806:
	DEFW 0000h
	DEFB 01h
_solidMap:
	DEFW __LABEL807
_solidMap.__DATA__.__PTR__:
	DEFW _solidMap.__DATA__
_solidMap.__DATA__:
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
__LABEL807:
	DEFW 0001h
	DEFW 000Ch
	DEFB 01h
_rLt:
	DEFW __LABEL808
_rLt.__DATA__.__PTR__:
	DEFW _rLt.__DATA__
_rLt.__DATA__:
	DEFB 0Eh
	DEFB 09h
	DEFB 09h
	DEFB 1Eh
	DEFB 12h
	DEFB 22h
	DEFB 00h
	DEFB 00h
__LABEL808:
	DEFW 0000h
	DEFB 01h
_etLt:
	DEFW __LABEL809
_etLt.__DATA__.__PTR__:
	DEFW _etLt.__DATA__
_etLt.__DATA__:
	DEFB 04h
	DEFB 67h
	DEFB 94h
	DEFB 0F4h
	DEFB 84h
	DEFB 73h
	DEFB 00h
	DEFB 00h
__LABEL809:
	DEFW 0000h
	DEFB 01h
_urLt:
	DEFW __LABEL810
_urLt.__DATA__.__PTR__:
	DEFW _urLt.__DATA__
_urLt.__DATA__:
	DEFB 00h
	DEFB 95h
	DEFB 96h
	DEFB 94h
	DEFB 94h
	DEFB 74h
	DEFB 00h
	DEFB 00h
__LABEL810:
	DEFW 0000h
	DEFB 01h
_nsLt:
	DEFW __LABEL811
_nsLt.__DATA__.__PTR__:
	DEFW _nsLt.__DATA__
_nsLt.__DATA__:
	DEFB 00h
	DEFB 0E3h
	DEFB 94h
	DEFB 92h
	DEFB 91h
	DEFB 96h
	DEFB 00h
	DEFB 00h
__LABEL811:
	DEFW 0000h
	DEFB 01h
_pattern1:
	DEFW __LABEL812
_pattern1.__DATA__.__PTR__:
	DEFW _pattern1.__DATA__
_pattern1.__DATA__:
	DEFB 00h
	DEFB 0Ch
	DEFB 12h
	DEFB 0Ah
	DEFB 24h
	DEFB 50h
	DEFB 22h
	DEFB 00h
__LABEL812:
	DEFW 0000h
	DEFB 01h
_pattern2:
	DEFW __LABEL813
_pattern2.__DATA__.__PTR__:
	DEFW _pattern2.__DATA__
_pattern2.__DATA__:
	DEFB 00h
	DEFB 20h
	DEFB 52h
	DEFB 20h
	DEFB 04h
	DEFB 0Ah
	DEFB 24h
	DEFB 00h
__LABEL813:
	DEFW 0000h
	DEFB 01h
_pattern3:
	DEFW __LABEL814
_pattern3.__DATA__.__PTR__:
	DEFW _pattern3.__DATA__
_pattern3.__DATA__:
	DEFB 00h
	DEFB 52h
	DEFB 00h
	DEFB 08h
	DEFB 10h
	DEFB 40h
	DEFB 12h
	DEFB 00h
__LABEL814:
	DEFW 0000h
	DEFB 01h
_enemyStates:
	DEFW __LABEL815
_enemyStates.__DATA__.__PTR__:
	DEFW _enemyStates.__DATA__
_enemyStates.__DATA__:
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
__LABEL815:
	DEFW 0001h
	DEFW 000Bh
	DEFB 01h
_keyStates:
	DEFW __LABEL816
_keyStates.__DATA__.__PTR__:
	DEFW _keyStates.__DATA__
_keyStates.__DATA__:
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
__LABEL816:
	DEFW 0000h
	DEFB 01h
	_screens.__DATA__ EQU 24200
_screens:
	DEFW __LABEL817
_screens.__DATA__.__PTR__:
	DEFW 24200
__LABEL817:
	DEFW 0001h
	DEFW 0074h
	DEFB 01h
	_maps.__DATA__ EQU 32320
_maps:
	DEFW __LABEL818
_maps.__DATA__.__PTR__:
	DEFW 32320
__LABEL818:
	DEFW 0000h
	DEFB 01h
__LABEL674:
	DEFB 10h
__LABEL716:
	DEFB 00h
	DEFB 00h
	DEFB 01h
ZXBASIC_MEM_HEAP:
	; Defines DATA END
ZXBASIC_USER_DATA_END EQU ZXBASIC_MEM_HEAP + ZXBASIC_HEAP_SIZE
	; Defines USER DATA Length in bytes
ZXBASIC_USER_DATA_LEN EQU ZXBASIC_USER_DATA_END - ZXBASIC_USER_DATA
	END
