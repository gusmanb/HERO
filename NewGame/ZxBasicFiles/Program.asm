	org 32768
	; Defines HEAP SIZE
ZXBASIC_HEAP_SIZE EQU 4768
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
#line 8
		ld hl, ZXBASIC_MEM_HEAP
#line 9
	ld hl, __LABEL0
	call __LOADSTR
	push hl
	ld hl, 23755
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
	or a
	jp nz, __LABEL3
	call _intro
	ld a, 1
	ld (_state), a
	ld a, 1
	ld (_currentMap), a
	ld hl, 1
	ld (_currentMapIndex), hl
	jp __LABEL4
__LABEL3:
	ld a, (_state)
	dec a
	jp nz, __LABEL5
	call _decodeCurrentScreen
	ld a, 4
	ld (_lifes), a
	ld a, 232
	ld (_playerX), a
	ld a, 48
	ld (_playerY), a
	ld a, (_playerX)
	ld (_playerXEnter), a
	ld a, (_playerY)
	ld (_playerYEnter), a
	ld hl, _head1r.__DATA__
	ld (_lastHead), hl
	ld hl, _body2r.__DATA__
	ld (_lastBody), hl
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
	jp nz, __LABEL8
	call _movePlayer
	ld (_updateResult), a
	cp 2
	jp nc, __LABEL9
	ld a, (_updateResult)
	push af
	call _render
	jp __LABEL10
__LABEL9:
	ld a, (_updateResult)
	sub 2
	jp nz, __LABEL12
	call _processDeath
	ld (_updateResult), a
	or a
	jp z, __LABEL13
	ld a, (_playerXEnter)
	ld (_playerX), a
	ld a, (_playerYEnter)
	ld (_playerY), a
	ld a, (_playerEnterDir)
	ld (_playerDir), a
	dec a
	jp nz, __LABEL15
	ld hl, _head1r.__DATA__
	ld (_lastHead), hl
	ld hl, _body2r.__DATA__
	ld (_lastBody), hl
	jp __LABEL16
__LABEL15:
	ld hl, _head1l.__DATA__
	ld (_lastHead), hl
	ld hl, _body2l.__DATA__
	ld (_lastBody), hl
__LABEL16:
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
	jp __LABEL14
__LABEL13:
	call _gameOver
	ld hl, 0
	call __PAUSE
	xor a
	ld (_state), a
__LABEL14:
__LABEL12:
__LABEL10:
__LABEL8:
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
_asc:
	push ix
	ld ix, 0
	add ix, sp
	ld l, (ix+4)
	ld h, (ix+5)
	call __STRLEN
	push hl
	ld l, (ix+6)
	ld h, (ix+7)
	pop de
	or a
	sbc hl, de
	ccf
	jp nc, __LABEL18
	xor a
	jp _asc__leave
__LABEL18:
	ld l, (ix+4)
	ld h, (ix+5)
	push hl
	ld l, (ix+6)
	ld h, (ix+7)
	push hl
	ld l, (ix+6)
	ld h, (ix+7)
	push hl
	xor a
	call __STRSLICE
	ld a, 1
	call __ASC
_asc__leave:
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
	ex (sp), hl
	exx
	ret
_initTable:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	push hl
	ld (ix-2), 0
	ld (ix-1), 0
	jp __LABEL19
__LABEL22:
	ld l, (ix-2)
	ld h, (ix-1)
	add hl, hl
	add hl, hl
	push hl
	ld de, 224
	pop hl
	call __BAND16
	push hl
	ld l, (ix-2)
	ld h, (ix-1)
	ld b, 8
__LABEL315:
	add hl, hl
	djnz __LABEL315
	push hl
	ld de, 1792
	pop hl
	call __BAND16
	ex de, hl
	pop hl
	call __BOR16
	push hl
	ld l, (ix-2)
	ld h, (ix-1)
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	push hl
	ld de, 6144
	pop hl
	call __BAND16
	ex de, hl
	pop hl
	call __BOR16
	ld (ix-4), l
	ld (ix-3), h
	ld l, (ix-4)
	ld h, (ix-3)
	ld de, 16384
	add hl, de
	ld de, 16
	add hl, de
	push hl
	ld l, (ix-2)
	ld h, (ix-1)
	add hl, hl
	inc hl
	dec hl
	push hl
	ld hl, _tableCP
	call __ARRAY
	pop de
	ld (hl), e
	inc hl
	ld (hl), d
	ld l, (ix-4)
	ld h, (ix-3)
	ld de, 16384
	add hl, de
	ld de, 32
	add hl, de
	push hl
	ld l, (ix-2)
	ld h, (ix-1)
	add hl, hl
	inc hl
	inc hl
	dec hl
	push hl
	ld hl, _tableCP
	call __ARRAY
	pop de
	ld (hl), e
	inc hl
	ld (hl), d
__LABEL23:
	ld l, (ix-2)
	ld h, (ix-1)
	inc hl
	ld (ix-2), l
	ld (ix-1), h
__LABEL19:
	ld l, (ix-2)
	ld h, (ix-1)
	push hl
	ld hl, 191
	pop de
	or a
	sbc hl, de
	jp nc, __LABEL22
__LABEL21:
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
	jp __LABEL24
__LABEL27:
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
__LABEL28:
	inc (ix-1)
__LABEL24:
	ld a, (ix-1)
	push af
	ld a, (ix+9)
	add a, (ix+11)
	pop hl
	cp h
	jp nc, __LABEL27
__LABEL26:
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
_mirrorSprite:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	ld (ix-1), 0
	jp __LABEL29
__LABEL32:
	ld l, (ix+4)
	ld h, (ix+5)
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	ex de, hl
	pop hl
	add hl, de
	ld a, (hl)
	ld (ix-2), a
	push af
	ld h, 240
	pop af
	and h
	ld b, 4
__LABEL316:
	srl a
	djnz __LABEL316
	push af
	ld a, (ix-2)
	push af
	ld h, 15
	pop af
	and h
	add a, a
	add a, a
	add a, a
	add a, a
	pop de
	or d
	ld (ix-2), a
	push af
	ld h, 204
	pop af
	and h
	srl a
	srl a
	push af
	ld a, (ix-2)
	push af
	ld h, 51
	pop af
	and h
	add a, a
	add a, a
	pop de
	or d
	ld (ix-2), a
	push af
	ld h, 170
	pop af
	and h
	srl a
	push af
	ld a, (ix-2)
	push af
	ld h, 85
	pop af
	and h
	add a, a
	pop de
	or d
	ld (ix-2), a
	ld l, (ix+6)
	ld h, (ix+7)
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	ex de, hl
	pop hl
	add hl, de
	push hl
	ld a, (ix-2)
	pop hl
	ld (hl), a
__LABEL33:
	inc (ix-1)
__LABEL29:
	ld a, (ix-1)
	push af
	ld a, 7
	pop hl
	cp h
	jp nc, __LABEL32
__LABEL31:
_mirrorSprite__leave:
	ld sp, ix
	pop ix
	exx
	pop hl
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
	ld hl, 1
	push hl
	ld hl, 1
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
	jp __LABEL34
__LABEL37:
	ld l, (ix+4)
	ld h, (ix+5)
	push hl
	ld a, (ix-1)
	sub (ix+9)
	inc a
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-1)
	sub (ix+9)
	inc a
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
__LABEL38:
	inc (ix-1)
__LABEL34:
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
	jp nc, __LABEL37
__LABEL36:
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
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	inc sp
	ld a, (ix+5)
	push af
	ld h, 7
	pop af
	and h
	ld (ix-1), a
	push af
	ld a, (ix+7)
	add a, a
	add a, a
	add a, a
	push af
	ld h, 56
	pop af
	and h
	pop de
	or d
	ld (ix-1), a
	ld a, (ix+9)
	push af
	xor a
	pop hl
	cp h
	jp nc, __LABEL40
	ld a, (ix-1)
	push af
	ld h, 64
	pop af
	or h
	ld (ix-1), a
__LABEL40:
	ld a, (ix+11)
	push af
	xor a
	pop hl
	cp h
	jp nc, __LABEL42
	ld a, (ix-1)
	push af
	ld h, 128
	pop af
	or h
	ld (ix-1), a
__LABEL42:
	ld a, (ix-1)
_createAttrib__leave:
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
_setAttrib:
#line 97
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
#line 114
_setAttrib__leave:
	ret
_clearScreen:
#line 125
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
#line 135
_clearScreen__leave:
	ret
_clearScreenTop:
#line 145
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
#line 155
_clearScreenTop__leave:
	ret
_clearScreenCenter:
#line 165
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
#line 175
_clearScreenCenter__leave:
	ret
_clearScreenBottom:
#line 185
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
#line 195
_clearScreenBottom__leave:
	ret
_clearPixels:
	push ix
	ld ix, 0
	add ix, sp
#line 206
		ld de, _bitmapBuffer.__DATA__ + 1
		ld hl, _bitmapBuffer.__DATA__
		ld (hl), 0
		ld bc, 6143
		ldir
#line 211
_clearPixels__leave:
	ld sp, ix
	pop ix
	ret
_clearPixelsTop:
	push ix
	ld ix, 0
	add ix, sp
#line 220
		ld de, _bitmapBuffer.__DATA__ + 1
		ld hl, _bitmapBuffer.__DATA__
		ld (hl), 0
		ld bc, 1535
		ldir
#line 225
_clearPixelsTop__leave:
	ld sp, ix
	pop ix
	ret
_clearPixelsCenter:
	push ix
	ld ix, 0
	add ix, sp
#line 234
		ld de, _bitmapBuffer.__DATA__ + 1 + 1536
		ld hl, _bitmapBuffer.__DATA__ + 1536
		ld (hl), 0
		ld bc, 3071
		ldir
#line 239
_clearPixelsCenter__leave:
	ld sp, ix
	pop ix
	ret
_clearPixelsBottom:
	push ix
	ld ix, 0
	add ix, sp
#line 248
		ld de, _bitmapBuffer.__DATA__ + 1 + 4608
		ld hl, _bitmapBuffer.__DATA__ + 4608
		ld (hl), 0
		ld bc, 1535
		ldir
#line 253
_clearPixelsBottom__leave:
	ld sp, ix
	pop ix
	ret
_clearAttribs:
#line 262
		ld de, _attribBuffer.__DATA__ + 1
		ld hl, _attribBuffer.__DATA__
		ld (hl), a
		ld bc, 767
		ldir
#line 267
_clearAttribs__leave:
	ret
_clearAttribsTop:
#line 276
		ld de, _attribBuffer.__DATA__ + 1
		ld hl, _attribBuffer.__DATA__
		ld (hl), a
		ld bc, 191
		ldir
#line 281
_clearAttribsTop__leave:
	ret
_clearAttribsCenter:
#line 290
		ld de, _attribBuffer.__DATA__ + 1 + 192
		ld hl, _attribBuffer.__DATA__ + 192
		ld (hl), a
		ld bc, 383
		ldir
#line 295
_clearAttribsCenter__leave:
	ret
_clearAttribsBottom:
#line 304
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
#line 314
_clearAttribsBottom__leave:
	ret
_printColorChar:
#line 324
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
#line 392
_printColorChar__leave:
	ret
_drawColorSprite:
#line 415
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
#line 645
_drawColorSprite__leave:
	ret
_printChar:
#line 756
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
#line 813
_printChar__leave:
	ret
_drawSprite:
#line 833
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
#line 1005
_drawSprite__leave:
	ret
_dumpScreen:
	push ix
	ld ix, 0
	add ix, sp
#line 1099
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
#line 1151
_dumpScreen__leave:
	ld sp, ix
	pop ix
	ret
_dumpPixels:
	push ix
	ld ix, 0
	add ix, sp
#line 1173
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
#line 1221
_dumpPixels__leave:
	ld sp, ix
	pop ix
	ret
_dumpPixelsTop:
	push ix
	ld ix, 0
	add ix, sp
#line 1240
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
#line 1286
_dumpPixelsTop__leave:
	ld sp, ix
	pop ix
	ret
_dumpPixelsCenter:
	push ix
	ld ix, 0
	add ix, sp
#line 1307
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
#line 1353
_dumpPixelsCenter__leave:
	ld sp, ix
	pop ix
	ret
_dumpPixelsBottom:
	push ix
	ld ix, 0
	add ix, sp
#line 1372
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
#line 1418
_dumpPixelsBottom__leave:
	ld sp, ix
	pop ix
	ret
_dumpScreenTop:
	push ix
	ld ix, 0
	add ix, sp
#line 1437
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
#line 1487
_dumpScreenTop__leave:
	ld sp, ix
	pop ix
	ret
_dumpScreenCenter:
	push ix
	ld ix, 0
	add ix, sp
#line 1509
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
#line 1559
_dumpScreenCenter__leave:
	ld sp, ix
	pop ix
	ret
_dumpScreenBottom:
	push ix
	ld ix, 0
	add ix, sp
#line 1581
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
#line 1631
_dumpScreenBottom__leave:
	ld sp, ix
	pop ix
	ret
_dumpAttribs:
	push ix
	ld ix, 0
	add ix, sp
#line 1654
		xor a
		ld de, 22528
		ld hl, _attribBuffer.__DATA__
		ld bc, 768
		ldir
#line 1659
_dumpAttribs__leave:
	ld sp, ix
	pop ix
	ret
_dumpAttribsTop:
	push ix
	ld ix, 0
	add ix, sp
#line 1668
		xor a
		ld de, 22528
		ld hl, _attribBuffer.__DATA__
		ld bc, 192
		ldir
#line 1673
_dumpAttribsTop__leave:
	ld sp, ix
	pop ix
	ret
_dumpAttribsCenter:
	push ix
	ld ix, 0
	add ix, sp
#line 1682
		xor a
		ld de, 22528 + 192
		ld hl, _attribBuffer.__DATA__ + 192
		ld bc, 384
		ldir
#line 1687
_dumpAttribsCenter__leave:
	ld sp, ix
	pop ix
	ret
_dumpAttribsBottom:
	push ix
	ld ix, 0
	add ix, sp
#line 1696
		xor a
		ld de, 22528 + 576
		ld hl, _attribBuffer.__DATA__ + 576
		ld bc, 192
		ldir
#line 1701
_dumpAttribsBottom__leave:
	ld sp, ix
	pop ix
	ret
_dumpAttrib:
#line 1710
		ld de, 22529
		ld hl, 22528
		ld (hl), a
		ld bc, 767
		ldir
#line 1715
_dumpAttrib__leave:
	ret
_dumpAttribTop:
#line 1724
		ld de, 22529
		ld hl, 22528
		ld (hl), a
		ld bc, 191
		ldir
#line 1729
_dumpAttribTop__leave:
	ret
_dumpAttribCenter:
#line 1739
		ld de, 22529 + 192
		ld hl, 22528 + 192
		ld (hl), a
		ld bc, 383
		ldir
#line 1744
_dumpAttribCenter__leave:
	ret
_dumpAttribBottom:
#line 1753
		ld de, 22529 + 576
		ld hl, 22528 + 576
		ld (hl), a
		ld bc, 191
		ldir
#line 1758
_dumpAttribBottom__leave:
	ret
_intro:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, -21
	add hl, sp
	ld sp, hl
	ld (hl), 0
	ld bc, 20
	ld d, h
	ld e, l
	inc de
	ldir
	push ix
	pop hl
	ld bc, -17
	add hl, bc
	ex de, hl
	ld hl, __LABEL317
	ld bc, 2
	ldir
	push ix
	pop hl
	ld bc, -4
	add hl, bc
	ex de, hl
	ld hl, __LABEL318
	ld bc, 1
	ldir
	push ix
	pop hl
	ld bc, -5
	add hl, bc
	ex de, hl
	ld hl, __LABEL319
	ld bc, 1
	ldir
	push ix
	pop hl
	ld bc, -10
	add hl, bc
	ex de, hl
	ld hl, __LABEL320
	ld bc, 1
	ldir
	push ix
	pop hl
	ld bc, -21
	add hl, bc
	ex de, hl
	ld hl, __LABEL321
	ld bc, 2
	ldir
#line 183
		ei
		halt
		di
#line 186
	xor a
	push af
	xor a
	push af
	ld a, 1
	push af
	ld a, 7
	push af
	call _createAttrib
	ld (ix-7), a
	xor a
	push af
	xor a
	push af
	ld a, 1
	push af
	ld a, 7
	push af
	call _createAttrib
	ld (ix-6), a
	xor a
	call _clearScreen
	xor a
	push af
	ld a, 1
	push af
	ld a, 6
	push af
	ld a, 2
	push af
	call _createAttrib
	ld (ix-13), a
	ld (ix-17), 0
	ld (ix-16), 0
	jp __LABEL43
__LABEL46:
	ld (ix-19), 6
	ld (ix-18), 0
	jp __LABEL48
__LABEL51:
	ld a, (ix-7)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld l, (ix-19)
	ld h, (ix-18)
	call _setAttrib
__LABEL52:
	ld l, (ix-19)
	ld h, (ix-18)
	inc hl
	ld (ix-19), l
	ld (ix-18), h
__LABEL48:
	ld l, (ix-19)
	ld h, (ix-18)
	push hl
	ld hl, 17
	pop de
	or a
	sbc hl, de
	jp nc, __LABEL51
__LABEL50:
__LABEL47:
	ld l, (ix-17)
	ld h, (ix-16)
	inc hl
	ld (ix-17), l
	ld (ix-16), h
__LABEL43:
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld hl, 31
	pop de
	or a
	sbc hl, de
	jp nc, __LABEL46
__LABEL45:
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 7
	push af
	call _createAttrib
	ld (ix-13), a
	ld l, a
	ld h, 0
	push hl
	ld hl, 8
	push hl
	ld hl, 2
	push hl
	ld hl, _tlc.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 8
	push hl
	ld hl, 3
	push hl
	ld hl, _mlor.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 8
	push hl
	ld hl, 4
	push hl
	ld hl, _blc.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 9
	push hl
	ld hl, 3
	push hl
	ld hl, _mlo.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 10
	push hl
	ld hl, 2
	push hl
	ld hl, _tlc.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 10
	push hl
	ld hl, 3
	push hl
	ld hl, _mlol.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 10
	push hl
	ld hl, 4
	push hl
	ld hl, _blc.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 11
	push hl
	ld hl, 4
	push hl
	ld hl, _dot.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 12
	push hl
	ld hl, 2
	push hl
	ld hl, _tlcc.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 12
	push hl
	ld hl, 3
	push hl
	ld hl, _mlor.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 12
	push hl
	ld hl, 4
	push hl
	ld hl, _blcc.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 13
	push hl
	ld hl, 2
	push hl
	ld hl, _mlo.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 13
	push hl
	ld hl, 3
	push hl
	ld hl, _mlo.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 13
	push hl
	ld hl, 4
	push hl
	ld hl, _mlo.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 14
	push hl
	ld hl, 2
	push hl
	ld hl, _rec.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 14
	push hl
	ld hl, 3
	push hl
	ld hl, _rec.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 14
	push hl
	ld hl, 4
	push hl
	ld hl, _rec.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 15
	push hl
	ld hl, 4
	push hl
	ld hl, _dot.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 16
	push hl
	ld hl, 2
	push hl
	ld hl, _tlcc.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 16
	push hl
	ld hl, 3
	push hl
	ld hl, _mlor.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 16
	push hl
	ld hl, 4
	push hl
	ld hl, _blc.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 17
	push hl
	ld hl, 2
	push hl
	ld hl, _mlo.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 17
	push hl
	ld hl, 3
	push hl
	ld hl, _mlob.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 17
	push hl
	ld hl, 4
	push hl
	ld hl, _dgl.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 18
	push hl
	ld hl, 2
	push hl
	ld hl, _rct.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 18
	push hl
	ld hl, 3
	push hl
	ld hl, _rcbs.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 18
	push hl
	ld hl, 4
	push hl
	ld hl, _dglc.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 19
	push hl
	ld hl, 4
	push hl
	ld hl, _dot.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 20
	push hl
	ld hl, 2
	push hl
	ld hl, _tlcc.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 20
	push hl
	ld hl, 3
	push hl
	ld hl, _mlc.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 20
	push hl
	ld hl, 4
	push hl
	ld hl, _blcc.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 21
	push hl
	ld hl, 2
	push hl
	ld hl, _mlo.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 21
	push hl
	ld hl, 4
	push hl
	ld hl, _mlo.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 22
	push hl
	ld hl, 2
	push hl
	ld hl, _rct.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 22
	push hl
	ld hl, 3
	push hl
	ld hl, _mlc.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 22
	push hl
	ld hl, 4
	push hl
	ld hl, _rcb.__DATA__
	call _printColorChar
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 23
	push hl
	ld hl, 4
	push hl
	ld hl, _dot.__DATA__
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 2
	push af
	call _createAttrib
	push af
	ld a, 8
	push af
	ld a, 19
	push af
	ld hl, __LABEL53
	call __LOADSTR
	push hl
	call _printZXString
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 4
	push af
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
	ld a, 7
	push af
	call _createAttrib
	push af
	ld a, 2
	push af
	ld a, 19
	push af
	ld hl, __LABEL54
	call __LOADSTR
	push hl
	call _printZXString
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 5
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 0
	push hl
	ld hl, 21
	push hl
	ld hl, _head1r.__DATA__
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 5
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 0
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
	ld a, 5
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 2
	push hl
	ld hl, 21
	push hl
	ld hl, _head1r.__DATA__
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 5
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 2
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
	ld a, 5
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 4
	push hl
	ld hl, 21
	push hl
	ld hl, _head1r.__DATA__
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 5
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 4
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
	ld a, 5
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 6
	push hl
	ld hl, 21
	push hl
	ld hl, _head1r.__DATA__
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 5
	push af
	call _createAttrib
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
	ld a, 7
	push af
	call _createAttrib
	push af
	ld a, 26
	push af
	ld a, 19
	push af
	ld hl, __LABEL55
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
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 25
	push hl
	ld hl, 21
	push hl
	ld hl, _dinamyte1.__DATA__
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 2
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 27
	push hl
	ld hl, 21
	push hl
	ld hl, _dinamyte2.__DATA__
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 2
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 29
	push hl
	ld hl, 21
	push hl
	ld hl, _dinamyte1.__DATA__
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 2
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 31
	push hl
	ld hl, 21
	push hl
	ld hl, _dinamyte2.__DATA__
	call _printColorChar
	ld a, (ix-13)
	push af
	ld a, 10
	push af
	ld a, 21
	push af
	ld hl, __LABEL56
	call __LOADSTR
	push hl
	call _printZXString
	ld l, (ix-21)
	ld h, (ix-20)
	add hl, hl
	add hl, hl
	add hl, hl
	ld (ix-21), l
	ld (ix-20), h
	ld l, (ix-21)
	ld h, (ix-20)
	ld de, 15360
	add hl, de
	ld (ix-21), l
	ld (ix-20), h
	ld a, (ix-13)
	ld l, a
	ld h, 0
	push hl
	ld hl, 8
	push hl
	ld hl, 23
	push hl
	ld l, (ix-21)
	ld h, (ix-20)
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 1
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 9
	push hl
	ld hl, 23
	push hl
	ld hl, __LABEL57
	call __LOADSTR
	push hl
	call _ZXCharAddress
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 2
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 10
	push hl
	ld hl, 23
	push hl
	ld hl, __LABEL58
	call __LOADSTR
	push hl
	call _ZXCharAddress
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 3
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 11
	push hl
	ld hl, 23
	push hl
	ld hl, __LABEL59
	call __LOADSTR
	push hl
	call _ZXCharAddress
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 4
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 12
	push hl
	ld hl, 23
	push hl
	ld hl, __LABEL60
	call __LOADSTR
	push hl
	call _ZXCharAddress
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 5
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 13
	push hl
	ld hl, 23
	push hl
	ld hl, __LABEL61
	call __LOADSTR
	push hl
	call _ZXCharAddress
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 6
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 14
	push hl
	ld hl, 23
	push hl
	ld hl, __LABEL60
	call __LOADSTR
	push hl
	call _ZXCharAddress
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 7
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 15
	push hl
	ld hl, 23
	push hl
	ld hl, __LABEL59
	call __LOADSTR
	push hl
	call _ZXCharAddress
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 1
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 16
	push hl
	ld hl, 23
	push hl
	ld hl, __LABEL60
	call __LOADSTR
	push hl
	call _ZXCharAddress
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 2
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 17
	push hl
	ld hl, 23
	push hl
	ld hl, __LABEL62
	call __LOADSTR
	push hl
	call _ZXCharAddress
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 3
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 18
	push hl
	ld hl, 23
	push hl
	ld hl, __LABEL63
	call __LOADSTR
	push hl
	call _ZXCharAddress
	call _printColorChar
	ld a, (ix-13)
	push af
	ld a, 20
	push af
	ld a, 23
	push af
	ld hl, __LABEL64
	call __LOADSTR
	push hl
	call _printZXString
	ld a, (ix-7)
	push af
	ld a, 8
	push af
	ld a, 9
	push af
	ld hl, __LABEL65
	call __LOADSTR
	push hl
	call _printZXString
	ld (ix-17), 0
	ld (ix-16), 0
	jp __LABEL66
__LABEL69:
	ld a, 1
	push af
	xor a
	push af
	ld a, 1
	push af
	ld a, 5
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld hl, 17
	push hl
	ld hl, _water.__DATA__
	call _printColorChar
__LABEL70:
	ld l, (ix-17)
	ld h, (ix-16)
	inc hl
	ld (ix-17), l
	ld (ix-16), h
__LABEL66:
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld hl, 31
	pop de
	or a
	sbc hl, de
	jp nc, __LABEL69
__LABEL68:
	xor a
	push af
	ld a, 1
	push af
	ld a, 6
	push af
	ld a, 2
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 0
	push hl
	ld hl, 6
	push hl
	ld hl, _walltl.__DATA__
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	ld a, 6
	push af
	ld a, 2
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 31
	push hl
	ld hl, 6
	push hl
	ld hl, _walltr.__DATA__
	call _printColorChar
	ld (ix-19), 7
	ld (ix-18), 0
	jp __LABEL71
__LABEL74:
	xor a
	push af
	ld a, 1
	push af
	ld a, 6
	push af
	ld a, 2
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 0
	push hl
	ld l, (ix-19)
	ld h, (ix-18)
	push hl
	ld hl, _walll.__DATA__
	call _printColorChar
	xor a
	push af
	ld a, 1
	push af
	ld a, 6
	push af
	ld a, 2
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 31
	push hl
	ld l, (ix-19)
	ld h, (ix-18)
	push hl
	ld hl, _wallr.__DATA__
	call _printColorChar
__LABEL75:
	ld l, (ix-19)
	ld h, (ix-18)
	inc hl
	ld (ix-19), l
	ld (ix-18), h
__LABEL71:
	ld l, (ix-19)
	ld h, (ix-18)
	push hl
	ld hl, 16
	pop de
	or a
	sbc hl, de
	jp nc, __LABEL74
__LABEL73:
	call _dumpScreen
__LABEL76:
#line 348
		ei
		halt
		di
#line 351
	ld a, (ix-3)
	push af
	xor a
	pop hl
	call __LTI8
	or a
	jp z, __LABEL78
	ld a, (ix-8)
	or a
	jp z, __LABEL80
	ld a, (ix-7)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-2)
	ld l, a
	ld h, 0
	push hl
	ld hl, _head1r.__DATA__
	call _drawColorSprite
	jp __LABEL81
__LABEL80:
	ld a, (ix-7)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-2)
	ld l, a
	ld h, 0
	push hl
	ld hl, _head2r.__DATA__
	call _drawColorSprite
__LABEL81:
	ld a, (ix-7)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-2)
	add a, 8
	ld l, a
	ld h, 0
	push hl
	ld hl, _body2r.__DATA__
	call _drawColorSprite
	jp __LABEL79
__LABEL78:
	ld a, (ix-8)
	or a
	jp z, __LABEL82
	ld a, (ix-7)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-2)
	ld l, a
	ld h, 0
	push hl
	ld hl, _head1l.__DATA__
	call _drawColorSprite
	jp __LABEL83
__LABEL82:
	ld a, (ix-7)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-2)
	ld l, a
	ld h, 0
	push hl
	ld hl, _head2l.__DATA__
	call _drawColorSprite
__LABEL83:
	ld a, (ix-7)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld a, (ix-2)
	add a, 8
	ld l, a
	ld h, 0
	push hl
	ld hl, _body2l.__DATA__
	call _drawColorSprite
__LABEL79:
	ld a, (ix-4)
	push af
	xor a
	pop hl
	call __LTI8
	or a
	jp z, __LABEL84
	ld a, (ix-8)
	or a
	jp z, __LABEL86
	ld a, (ix-6)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld l, (ix-19)
	ld h, (ix-18)
	push hl
	ld hl, _head2r.__DATA__
	call _drawColorSprite
	jp __LABEL87
__LABEL86:
	ld a, (ix-6)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld l, (ix-19)
	ld h, (ix-18)
	push hl
	ld hl, _head1r.__DATA__
	call _drawColorSprite
__LABEL87:
	ld a, (ix-6)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld l, (ix-19)
	ld h, (ix-18)
	ld de, 8
	add hl, de
	push hl
	ld hl, _body2r.__DATA__
	call _drawColorSprite
	jp __LABEL85
__LABEL84:
	ld a, (ix-8)
	or a
	jp z, __LABEL88
	ld a, (ix-6)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld l, (ix-19)
	ld h, (ix-18)
	push hl
	ld hl, _head2l.__DATA__
	call _drawColorSprite
	jp __LABEL89
__LABEL88:
	ld a, (ix-6)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld l, (ix-19)
	ld h, (ix-18)
	push hl
	ld hl, _head1l.__DATA__
	call _drawColorSprite
__LABEL89:
	ld a, (ix-6)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld l, (ix-19)
	ld h, (ix-18)
	ld de, 8
	add hl, de
	push hl
	ld hl, _body2l.__DATA__
	call _drawColorSprite
__LABEL85:
	inc (ix-9)
	inc (ix-10)
	ld a, (ix-9)
	sub 255
	jp nz, __LABEL91
	ld a, (ix-11)
	or a
	jp nz, __LABEL92
	ld (ix-9), 192
	xor a
	push af
	xor a
	push af
	ld a, 1
	push af
	ld a, 4
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 184
	push hl
	ld hl, 128
	push hl
	ld hl, _crock1.__DATA__
	call _drawColorSprite
	ld (ix-11), 1
	jp __LABEL93
__LABEL92:
	ld a, (ix-11)
	dec a
	jp nz, __LABEL94
	ld (ix-9), 240
	ld hl, 184
	push hl
	ld hl, 128
	push hl
	ld hl, _crock1.__DATA__
	call _drawSprite
	xor a
	push af
	xor a
	push af
	ld a, 1
	push af
	ld a, 4
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 184
	push hl
	ld hl, 128
	push hl
	ld hl, _crock2.__DATA__
	call _drawColorSprite
	ld (ix-11), 2
	jp __LABEL95
__LABEL94:
	ld a, (ix-11)
	sub 2
	jp nz, __LABEL96
	ld (ix-9), 240
	ld hl, 184
	push hl
	ld hl, 128
	push hl
	ld hl, _crock2.__DATA__
	call _drawSprite
	xor a
	push af
	xor a
	push af
	ld a, 1
	push af
	ld a, 4
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 184
	push hl
	ld hl, 128
	push hl
	ld hl, _crock1.__DATA__
	call _drawColorSprite
	ld (ix-11), 3
	jp __LABEL97
__LABEL96:
	ld (ix-9), 0
	ld a, (ix-7)
	ld l, a
	ld h, 0
	push hl
	ld hl, 184
	push hl
	ld hl, 128
	push hl
	ld hl, _crock1.__DATA__
	call _drawColorSprite
	ld (ix-11), 0
__LABEL97:
__LABEL95:
__LABEL93:
__LABEL91:
	ld a, (ix-10)
	sub 255
	jp nz, __LABEL99
	ld a, (ix-12)
	or a
	jp nz, __LABEL100
	ld (ix-10), 192
	xor a
	push af
	xor a
	push af
	ld a, 1
	push af
	ld a, 4
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 40
	push hl
	ld hl, 128
	push hl
	ld hl, _crock1.__DATA__
	call _drawColorSprite
	ld (ix-12), 1
	jp __LABEL101
__LABEL100:
	ld a, (ix-12)
	dec a
	jp nz, __LABEL102
	ld (ix-10), 240
	ld hl, 40
	push hl
	ld hl, 128
	push hl
	ld hl, _crock1.__DATA__
	call _drawSprite
	xor a
	push af
	xor a
	push af
	ld a, 1
	push af
	ld a, 4
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 40
	push hl
	ld hl, 128
	push hl
	ld hl, _crock2.__DATA__
	call _drawColorSprite
	ld (ix-12), 2
	jp __LABEL103
__LABEL102:
	ld a, (ix-12)
	sub 2
	jp nz, __LABEL104
	ld (ix-10), 240
	ld hl, 40
	push hl
	ld hl, 128
	push hl
	ld hl, _crock2.__DATA__
	call _drawSprite
	xor a
	push af
	xor a
	push af
	ld a, 1
	push af
	ld a, 4
	push af
	call _createAttrib
	ld l, a
	ld h, 0
	push hl
	ld hl, 40
	push hl
	ld hl, 128
	push hl
	ld hl, _crock1.__DATA__
	call _drawColorSprite
	ld (ix-12), 3
	jp __LABEL105
__LABEL104:
	ld (ix-10), 0
	ld a, (ix-7)
	ld l, a
	ld h, 0
	push hl
	ld hl, 40
	push hl
	ld hl, 128
	push hl
	ld hl, _crock1.__DATA__
	call _drawColorSprite
	ld (ix-12), 0
__LABEL105:
__LABEL103:
__LABEL101:
__LABEL99:
	call _dumpScreenCenter
	ld l, (ix-17)
	ld h, (ix-16)
	ld a, l
	ld (ix-1), a
	ld l, (ix-19)
	ld h, (ix-18)
	ld a, l
	ld (ix-2), a
	ld a, (ix-4)
	ld (ix-3), a
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld a, (ix-4)
	ld l, a
	add a, a
	sbc a, a
	ld h, a
	ex de, hl
	pop hl
	add hl, de
	ld (ix-17), l
	ld (ix-16), h
	ld l, (ix-19)
	ld h, (ix-18)
	push hl
	ld a, (ix-5)
	ld l, a
	add a, a
	sbc a, a
	ld h, a
	ex de, hl
	pop hl
	add hl, de
	ld (ix-19), l
	ld (ix-18), h
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld hl, 239
	pop de
	or a
	sbc hl, de
	sbc a, a
	push af
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld de, 8
	pop hl
	or a
	sbc hl, de
	sbc a, a
	pop de
	or d
	jp z, __LABEL107
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld a, (ix-4)
	add a, a
	ld l, a
	add a, a
	sbc a, a
	ld h, a
	ex de, hl
	pop hl
	or a
	sbc hl, de
	ld (ix-17), l
	ld (ix-16), h
	ld a, (ix-4)
	neg
	ld (ix-4), a
__LABEL107:
	ld l, (ix-19)
	ld h, (ix-18)
	push hl
	ld hl, 120
	pop de
	or a
	sbc hl, de
	sbc a, a
	push af
	ld l, (ix-19)
	ld h, (ix-18)
	push hl
	ld de, 0
	pop hl
	or a
	sbc hl, de
	sbc a, a
	pop de
	or d
	jp z, __LABEL109
	ld l, (ix-19)
	ld h, (ix-18)
	push hl
	ld a, (ix-5)
	add a, a
	ld l, a
	add a, a
	sbc a, a
	ld h, a
	ex de, hl
	pop hl
	or a
	sbc hl, de
	ld (ix-19), l
	ld (ix-18), h
	ld a, (ix-5)
	neg
	ld (ix-5), a
__LABEL109:
	ld a, (ix-8)
	sub 1
	sbc a, a
	ld (ix-8), a
	call INKEY
	push hl
	ld de, __LABEL0
	pop hl
	ld a, 1
	call __STRNE
	or a
	jp nz, _intro__leave
__LABEL111:
	jp __LABEL76
__LABEL77:
_intro__leave:
	ld sp, ix
	pop ix
	ret
_decodeCurrentScreen:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, -17
	add hl, sp
	ld sp, hl
	ld (hl), 0
	ld bc, 16
	ld d, h
	ld e, l
	inc de
	ldir
	ld a, 1
	call BORDER
	xor a
	push af
	xor a
	push af
	xor a
	push af
	ld a, 7
	push af
	call _createAttrib
	call _clearScreenCenter
	ld hl, (_currentMapIndex)
	dec hl
	push hl
	ld hl, _maps
	call __ARRAY
	ld a, (hl)
	ld l, a
	ld h, 0
	ld (ix-13), l
	ld (ix-12), h
	ld (ix-1), 1
	jp __LABEL112
__LABEL115:
	ld a, (ix-1)
	dec a
	ld h, 8
	call __DIVU8_FAST
	ld l, a
	ld h, 0
	ld (ix-15), l
	ld (ix-14), h
	ld a, (ix-1)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
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
	ld (ix-17), l
	ld (ix-16), h
	ld a, (ix-1)
	ld l, a
	ld h, 0
	dec hl
	push hl
	ld l, (ix-13)
	ld h, (ix-12)
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
	ld l, (ix-15)
	ld h, (ix-14)
	inc hl
	dec hl
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
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
	ld l, (ix-15)
	ld h, (ix-14)
	inc hl
	dec hl
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
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
__LABEL322:
	srl a
	djnz __LABEL322
	push af
	ld h, 3
	pop af
	and h
	push af
	ld l, (ix-15)
	ld h, (ix-14)
	inc hl
	dec hl
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
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
__LABEL323:
	srl a
	djnz __LABEL323
	push af
	ld h, 3
	pop af
	and h
	push af
	ld l, (ix-15)
	ld h, (ix-14)
	inc hl
	dec hl
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	ld de, 4
	add hl, de
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	pop af
	ld (hl), a
__LABEL116:
	inc (ix-1)
__LABEL112:
	ld a, (ix-1)
	push af
	ld a, 96
	pop hl
	cp h
	jp nc, __LABEL115
__LABEL114:
	xor a
	push af
	xor a
	push af
	ld a, 5
	push af
	ld a, 2
	push af
	call _createAttrib
	ld (ix-3), a
	xor a
	push af
	xor a
	push af
	ld a, 6
	push af
	ld a, 2
	push af
	call _createAttrib
	ld (ix-4), a
	ld a, 1
	push af
	xor a
	push af
	ld a, 5
	push af
	ld a, 1
	push af
	call _createAttrib
	ld (ix-5), a
	ld (ix-15), 12
	ld (ix-14), 0
	jp __LABEL117
__LABEL120:
	ld (ix-11), 1
	ld (ix-17), 1
	ld (ix-16), 0
	jp __LABEL122
__LABEL125:
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld de, 1
	pop hl
	call __EQ16
	push af
	ld l, (ix-15)
	ld h, (ix-14)
	dec hl
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	pop af
	or (hl)
	ld (ix-8), a
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld de, 32
	pop hl
	call __EQ16
	push af
	ld l, (ix-15)
	ld h, (ix-14)
	dec hl
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	inc hl
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	pop af
	or (hl)
	ld (ix-9), a
	ld l, (ix-15)
	ld h, (ix-14)
	push hl
	ld de, 1
	pop hl
	call __EQ16
	push af
	ld l, (ix-15)
	ld h, (ix-14)
	dec hl
	dec hl
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	pop af
	or (hl)
	ld (ix-6), a
	ld l, (ix-15)
	ld h, (ix-14)
	push hl
	ld de, 12
	pop hl
	call __EQ16
	push af
	ld l, (ix-15)
	ld h, (ix-14)
	inc hl
	dec hl
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	pop af
	or (hl)
	ld (ix-7), a
	ld l, (ix-15)
	ld h, (ix-14)
	dec hl
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld hl, _solidMap
	call __ARRAY
	ld a, (hl)
	ld (ix-10), a
	dec a
	sub 1
	sbc a, a
	push af
	ld a, (ix-10)
	sub 2
	sub 1
	sbc a, a
	pop de
	or d
	jp z, __LABEL127
	ld a, (ix-10)
	dec a
	jp nz, __LABEL129
	ld a, (ix-3)
	ld (ix-10), a
	ld (ix-11), 1
	jp __LABEL130
__LABEL129:
	ld a, (ix-8)
	ld h, (ix-7)
	or a
	jr z, __LABEL324
	ld a, h
__LABEL324:
	ld h, (ix-9)
	or a
	jr z, __LABEL325
	ld a, h
__LABEL325:
	ld h, (ix-11)
	or a
	jr z, __LABEL326
	ld a, h
__LABEL326:
	or a
	jp z, __LABEL131
	ld a, (ix-5)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
	ld de, 5
	add hl, de
	push hl
	ld hl, _water.__DATA__
	call _printColorChar
	jp __LABEL126
__LABEL131:
	ld a, (ix-4)
	ld (ix-10), a
__LABEL132:
__LABEL130:
	ld a, (ix-8)
	ld h, (ix-9)
	or a
	jr z, __LABEL327
	ld a, h
__LABEL327:
	ld h, (ix-6)
	or a
	jr z, __LABEL328
	ld a, h
__LABEL328:
	ld h, (ix-7)
	or a
	jr z, __LABEL329
	ld a, h
__LABEL329:
	or a
	jp z, __LABEL133
	ld a, (ix-10)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
	ld de, 5
	add hl, de
	push hl
	ld hl, _solid.__DATA__
	call _printColorChar
	jp __LABEL134
__LABEL133:
	ld a, (ix-8)
	ld h, (ix-9)
	or a
	jr z, __LABEL330
	ld a, h
__LABEL330:
	ld h, (ix-6)
	or a
	jr z, __LABEL331
	ld a, h
__LABEL331:
	or a
	jp z, __LABEL135
	ld a, (ix-10)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
	ld de, 5
	add hl, de
	push hl
	ld hl, _wallt.__DATA__
	call _printColorChar
	jp __LABEL136
__LABEL135:
	ld a, (ix-8)
	ld h, (ix-9)
	or a
	jr z, __LABEL332
	ld a, h
__LABEL332:
	ld h, (ix-7)
	or a
	jr z, __LABEL333
	ld a, h
__LABEL333:
	or a
	jp z, __LABEL137
	ld a, (ix-10)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
	ld de, 5
	add hl, de
	push hl
	ld hl, _wallb.__DATA__
	call _printColorChar
	jp __LABEL138
__LABEL137:
	ld a, (ix-8)
	ld h, (ix-6)
	or a
	jr z, __LABEL334
	ld a, h
__LABEL334:
	ld h, (ix-7)
	or a
	jr z, __LABEL335
	ld a, h
__LABEL335:
	or a
	jp z, __LABEL139
	ld a, (ix-10)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
	ld de, 5
	add hl, de
	push hl
	ld hl, _walll.__DATA__
	call _printColorChar
	jp __LABEL140
__LABEL139:
	ld a, (ix-9)
	ld h, (ix-6)
	or a
	jr z, __LABEL336
	ld a, h
__LABEL336:
	ld h, (ix-7)
	or a
	jr z, __LABEL337
	ld a, h
__LABEL337:
	or a
	jp z, __LABEL141
	ld a, (ix-10)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
	ld de, 5
	add hl, de
	push hl
	ld hl, _wallr.__DATA__
	call _printColorChar
	jp __LABEL142
__LABEL141:
	ld a, (ix-8)
	ld h, (ix-9)
	or a
	jr z, __LABEL338
	ld a, h
__LABEL338:
	or a
	jp z, __LABEL143
	ld a, (ix-10)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
	ld de, 5
	add hl, de
	push hl
	ld hl, _singleWallH.__DATA__
	call _printColorChar
	jp __LABEL144
__LABEL143:
	ld a, (ix-6)
	ld h, (ix-7)
	or a
	jr z, __LABEL339
	ld a, h
__LABEL339:
	or a
	jp z, __LABEL145
	ld a, (ix-10)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
	ld de, 5
	add hl, de
	push hl
	ld hl, _singleWallV.__DATA__
	call _printColorChar
	jp __LABEL146
__LABEL145:
	ld a, (ix-8)
	ld h, (ix-6)
	or a
	jr z, __LABEL340
	ld a, h
__LABEL340:
	or a
	jp z, __LABEL147
	ld a, (ix-10)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
	ld de, 5
	add hl, de
	push hl
	ld hl, _wallbr.__DATA__
	call _printColorChar
	jp __LABEL148
__LABEL147:
	ld a, (ix-8)
	ld h, (ix-7)
	or a
	jr z, __LABEL341
	ld a, h
__LABEL341:
	or a
	jp z, __LABEL149
	ld a, (ix-10)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
	ld de, 5
	add hl, de
	push hl
	ld hl, _walltr.__DATA__
	call _printColorChar
	jp __LABEL150
__LABEL149:
	ld a, (ix-9)
	ld h, (ix-6)
	or a
	jr z, __LABEL342
	ld a, h
__LABEL342:
	or a
	jp z, __LABEL151
	ld a, (ix-10)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
	ld de, 5
	add hl, de
	push hl
	ld hl, _wallbl.__DATA__
	call _printColorChar
	jp __LABEL152
__LABEL151:
	ld a, (ix-9)
	ld h, (ix-7)
	or a
	jr z, __LABEL343
	ld a, h
__LABEL343:
	or a
	jp z, __LABEL153
	ld a, (ix-10)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
	ld de, 5
	add hl, de
	push hl
	ld hl, _walltl.__DATA__
	call _printColorChar
	jp __LABEL154
__LABEL153:
	ld a, (ix-8)
	or a
	jp z, __LABEL155
	ld a, (ix-10)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
	ld de, 5
	add hl, de
	push hl
	ld hl, _rockR.__DATA__
	call _printColorChar
	jp __LABEL156
__LABEL155:
	ld a, (ix-9)
	or a
	jp z, __LABEL157
	ld a, (ix-10)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
	ld de, 5
	add hl, de
	push hl
	ld hl, _rockL.__DATA__
	call _printColorChar
	jp __LABEL158
__LABEL157:
	ld a, (ix-6)
	or a
	jp z, __LABEL159
	ld a, (ix-10)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
	ld de, 5
	add hl, de
	push hl
	ld hl, _rockB.__DATA__
	call _printColorChar
	jp __LABEL160
__LABEL159:
	ld a, (ix-7)
	or a
	jp z, __LABEL162
	ld a, (ix-10)
	ld l, a
	ld h, 0
	push hl
	ld l, (ix-17)
	ld h, (ix-16)
	dec hl
	push hl
	ld l, (ix-15)
	ld h, (ix-14)
	ld de, 5
	add hl, de
	push hl
	ld hl, _rockT.__DATA__
	call _printColorChar
__LABEL162:
__LABEL160:
__LABEL158:
__LABEL156:
__LABEL154:
__LABEL152:
__LABEL150:
__LABEL148:
__LABEL146:
__LABEL144:
__LABEL142:
__LABEL140:
__LABEL138:
__LABEL136:
__LABEL134:
	jp __LABEL128
__LABEL127:
	ld (ix-11), 0
__LABEL128:
__LABEL126:
	ld l, (ix-17)
	ld h, (ix-16)
	inc hl
	ld (ix-17), l
	ld (ix-16), h
__LABEL122:
	ld l, (ix-17)
	ld h, (ix-16)
	push hl
	ld hl, 32
	pop de
	or a
	sbc hl, de
	jp nc, __LABEL125
__LABEL124:
__LABEL121:
	ld l, (ix-15)
	ld h, (ix-14)
	dec hl
	ld (ix-15), l
	ld (ix-14), h
__LABEL117:
	ld l, (ix-15)
	ld h, (ix-14)
	push hl
	ld de, 1
	pop hl
	or a
	sbc hl, de
	jp nc, __LABEL120
__LABEL119:
_decodeCurrentScreen__leave:
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
	jp z, __LABEL164
	ld (ix-3), 254
__LABEL164:
	ld a, (_keyStates.__DATA__ + 1)
	or a
	jp z, __LABEL166
	ld (ix-3), 2
__LABEL166:
	ld a, (_keyStates.__DATA__ + 2)
	or a
	jp z, __LABEL167
	ld (ix-4), 254
	jp __LABEL168
__LABEL167:
	ld (ix-4), 2
__LABEL168:
	ld a, (_playerY)
	and 7
	sub 1
	sbc a, a
	ld (ix-5), a
	ld a, (_playerX)
	and 7
	sub 1
	sbc a, a
	ld (ix-6), a
	ld a, (ix-5)
	or a
	jp z, __LABEL170
	ld a, (ix-6)
	or a
	jp z, __LABEL171
	ld a, (ix-4)
	sub 254
	jp nz, __LABEL173
	ld a, (ix-2)
	or a
	jp nz, __LABEL175
	ld (ix-10), 1
	jp __LABEL176
__LABEL175:
	ld a, (ix-2)
	push af
	ld a, 1
	pop hl
	cp h
	jp nc, __LABEL178
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
	or a
	jp z, __LABEL180
	ld (ix-4), 0
	ld a, (ix-7)
	sub 2
	jp nz, __LABEL182
	ld (ix-11), 1
__LABEL182:
__LABEL180:
__LABEL178:
__LABEL176:
	jp __LABEL174
__LABEL173:
	ld a, (ix-2)
	sub 12
	jp nz, __LABEL183
	ld (ix-10), 1
	jp __LABEL184
__LABEL183:
	ld a, (ix-2)
	push af
	ld h, 11
	pop af
	cp h
	jp nc, __LABEL186
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
	or a
	jp z, __LABEL188
	ld (ix-4), 0
	ld a, (ix-7)
	sub 2
	jp nz, __LABEL190
	ld (ix-11), 1
__LABEL190:
__LABEL188:
__LABEL186:
__LABEL184:
__LABEL174:
	jp __LABEL172
__LABEL171:
	ld a, (ix-4)
	sub 254
	jp nz, __LABEL191
	ld a, (ix-2)
	or a
	jp nz, __LABEL193
	ld (ix-10), 1
	jp __LABEL194
__LABEL193:
	ld a, (ix-2)
	push af
	ld a, 1
	pop hl
	cp h
	jp nc, __LABEL196
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
	jp z, __LABEL198
	ld (ix-4), 0
	ld a, (ix-7)
	sub 2
	sub 1
	sbc a, a
	push af
	ld a, (ix-8)
	sub 2
	sub 1
	sbc a, a
	pop de
	or d
	jp z, __LABEL200
	ld (ix-11), 1
__LABEL200:
__LABEL198:
__LABEL196:
__LABEL194:
	jp __LABEL192
__LABEL191:
	ld a, (ix-2)
	sub 12
	jp nz, __LABEL201
	ld (ix-10), 1
	jp __LABEL202
__LABEL201:
	ld a, (ix-2)
	push af
	ld h, 11
	pop af
	cp h
	jp nc, __LABEL204
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
	jp z, __LABEL206
	ld (ix-4), 0
	ld a, (ix-7)
	sub 2
	sub 1
	sbc a, a
	push af
	ld a, (ix-8)
	sub 2
	sub 1
	sbc a, a
	pop de
	or d
	jp z, __LABEL208
	ld (ix-11), 1
__LABEL208:
__LABEL206:
__LABEL204:
__LABEL202:
__LABEL192:
__LABEL172:
__LABEL170:
	ld a, (ix-4)
	or a
	jp z, __LABEL210
	ld a, (_playerY)
	add a, (ix-4)
	push af
	ld h, 7
	pop af
	and h
	sub 1
	sbc a, a
	ld (ix-5), a
	ld a, (_playerY)
	add a, (ix-4)
	ld h, 8
	call __DIVI8_FAST
	sub 5
	ld (ix-2), a
__LABEL210:
	ld a, (ix-6)
	ld h, (ix-3)
	or a
	jr z, __LABEL344
	ld a, h
__LABEL344:
	or a
	jp z, __LABEL212
	ld a, (ix-5)
	or a
	jp z, __LABEL213
	ld a, (ix-3)
	sub 254
	jp nz, __LABEL215
	ld a, (ix-1)
	dec a
	jp nz, __LABEL217
	ld (ix-10), 1
	jp __LABEL218
__LABEL217:
	ld a, (ix-2)
	push af
	xor a
	pop hl
	cp h
	jp nc, __LABEL219
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
	jp __LABEL220
__LABEL219:
	ld (ix-7), 0
__LABEL220:
	ld a, (ix-2)
	push af
	ld h, 12
	pop af
	cp h
	jp nc, __LABEL221
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
	jp __LABEL222
__LABEL221:
	ld (ix-8), 0
__LABEL222:
	ld a, (ix-7)
	or (ix-8)
	jp z, __LABEL224
	ld (ix-3), 0
	ld a, (ix-7)
	sub 2
	sub 1
	sbc a, a
	push af
	ld a, (ix-8)
	sub 2
	sub 1
	sbc a, a
	pop de
	or d
	jp z, __LABEL226
	ld (ix-11), 1
__LABEL226:
__LABEL224:
__LABEL218:
	jp __LABEL216
__LABEL215:
	ld a, (ix-1)
	sub 32
	jp nz, __LABEL227
	ld (ix-10), 1
	jp __LABEL228
__LABEL227:
	ld a, (ix-2)
	push af
	xor a
	pop hl
	cp h
	jp nc, __LABEL229
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
	jp __LABEL230
__LABEL229:
	ld (ix-7), 0
__LABEL230:
	ld a, (ix-2)
	push af
	ld h, 12
	pop af
	cp h
	jp nc, __LABEL231
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
	jp __LABEL232
__LABEL231:
	ld (ix-8), 0
__LABEL232:
	ld a, (ix-7)
	or (ix-8)
	jp z, __LABEL234
	ld (ix-3), 0
	ld a, (ix-7)
	sub 2
	sub 1
	sbc a, a
	push af
	ld a, (ix-8)
	sub 2
	sub 1
	sbc a, a
	pop de
	or d
	jp z, __LABEL236
	ld (ix-11), 1
__LABEL236:
__LABEL234:
__LABEL228:
__LABEL216:
	jp __LABEL214
__LABEL213:
	ld a, (ix-3)
	sub 254
	jp nz, __LABEL237
	ld a, (ix-1)
	dec a
	jp nz, __LABEL239
	ld (ix-10), 1
	jp __LABEL240
__LABEL239:
	ld a, (ix-2)
	push af
	xor a
	pop hl
	cp h
	jp nc, __LABEL241
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
	jp __LABEL242
__LABEL241:
	ld (ix-7), 0
__LABEL242:
	ld a, (ix-2)
	push af
	ld h, 12
	pop af
	cp h
	jp nc, __LABEL243
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
	jp __LABEL244
__LABEL243:
	ld (ix-8), 0
__LABEL244:
	ld a, (ix-2)
	push af
	ld h, 11
	pop af
	cp h
	jp nc, __LABEL245
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
	jp __LABEL246
__LABEL245:
	ld (ix-9), 0
__LABEL246:
	ld a, (ix-7)
	or (ix-8)
	or (ix-9)
	jp z, __LABEL248
	ld (ix-3), 0
	ld a, (ix-7)
	sub 2
	sub 1
	sbc a, a
	push af
	ld a, (ix-8)
	sub 2
	sub 1
	sbc a, a
	pop de
	or d
	push af
	ld a, (ix-9)
	sub 2
	sub 1
	sbc a, a
	pop de
	or d
	jp z, __LABEL250
	ld (ix-11), 1
__LABEL250:
__LABEL248:
__LABEL240:
	jp __LABEL238
__LABEL237:
	ld a, (ix-1)
	sub 32
	jp nz, __LABEL251
	ld (ix-10), 1
	jp __LABEL252
__LABEL251:
	ld a, (ix-2)
	push af
	xor a
	pop hl
	cp h
	jp nc, __LABEL253
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
	jp __LABEL254
__LABEL253:
	ld (ix-7), 0
__LABEL254:
	ld a, (ix-2)
	push af
	ld h, 12
	pop af
	cp h
	jp nc, __LABEL255
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
	jp __LABEL256
__LABEL255:
	ld (ix-8), 0
__LABEL256:
	ld a, (ix-2)
	push af
	ld h, 11
	pop af
	cp h
	jp nc, __LABEL257
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
	jp __LABEL258
__LABEL257:
	ld (ix-9), 0
__LABEL258:
	ld a, (ix-7)
	or (ix-8)
	or (ix-9)
	jp z, __LABEL260
	ld (ix-3), 0
	ld a, (ix-7)
	sub 2
	sub 1
	sbc a, a
	push af
	ld a, (ix-8)
	sub 2
	sub 1
	sbc a, a
	pop de
	or d
	push af
	ld a, (ix-9)
	sub 2
	sub 1
	sbc a, a
	pop de
	or d
	jp z, __LABEL262
	ld (ix-11), 1
__LABEL262:
__LABEL260:
__LABEL252:
__LABEL238:
__LABEL214:
__LABEL212:
	ld a, (ix-10)
	or a
	jp z, __LABEL263
	ld a, 3
	jp _movePlayer__leave
__LABEL263:
	ld a, (ix-11)
	or a
	jp z, __LABEL265
	ld a, 2
	jp _movePlayer__leave
__LABEL265:
	ld a, (ix-3)
	or (ix-4)
	jp z, __LABEL267
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
	jp nz, __LABEL269
	ld a, 1
	ld (_playerDir), a
	jp __LABEL270
__LABEL269:
	ld a, (ix-3)
	sub 254
	jp nz, __LABEL272
	ld a, 255
	ld (_playerDir), a
__LABEL272:
__LABEL270:
	ld a, 1
	jp _movePlayer__leave
__LABEL267:
	xor a
	jp _movePlayer__leave
__LABEL268:
__LABEL266:
__LABEL264:
_movePlayer__leave:
	ld sp, ix
	pop ix
	ret
_drawPlayer:
	push ix
	ld ix, 0
	add ix, sp
	ld a, (ix+5)
	or a
	jp z, __LABEL273
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
	jp nz, __LABEL275
	ld de, _head1r.__DATA__
	ld hl, (_lastHead)
	or a
	sbc hl, de
	jp nz, __LABEL277
	ld hl, _head2r.__DATA__
	ld (_lastHead), hl
	jp __LABEL278
__LABEL277:
	ld hl, _head1r.__DATA__
	ld (_lastHead), hl
__LABEL278:
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
	ld hl, _body2r.__DATA__
	ld (_lastBody), hl
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
	jp __LABEL276
__LABEL275:
	ld de, _head1l.__DATA__
	ld hl, (_lastHead)
	or a
	sbc hl, de
	jp nz, __LABEL279
	ld hl, _head2l.__DATA__
	ld (_lastHead), hl
	jp __LABEL280
__LABEL279:
	ld hl, _head1l.__DATA__
	ld (_lastHead), hl
__LABEL280:
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
	ld hl, _body2l.__DATA__
	ld (_lastBody), hl
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
__LABEL276:
	jp __LABEL274
__LABEL273:
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
	jp nz, __LABEL281
	ld de, _head1r.__DATA__
	ld hl, (_lastHead)
	or a
	sbc hl, de
	jp nz, __LABEL283
	ld hl, _head2r.__DATA__
	ld (_lastHead), hl
	jp __LABEL284
__LABEL283:
	ld hl, _head1r.__DATA__
	ld (_lastHead), hl
__LABEL284:
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
	ld hl, _body1r.__DATA__
	ld (_lastBody), hl
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
	jp __LABEL282
__LABEL281:
	ld de, _head1l.__DATA__
	ld hl, (_lastHead)
	or a
	sbc hl, de
	jp nz, __LABEL285
	ld hl, _head2l.__DATA__
	ld (_lastHead), hl
	jp __LABEL286
__LABEL285:
	ld hl, _head1l.__DATA__
	ld (_lastHead), hl
__LABEL286:
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
	ld hl, _body1l.__DATA__
	ld (_lastBody), hl
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
__LABEL282:
__LABEL274:
_drawPlayer__leave:
	ld sp, ix
	pop ix
	exx
	pop hl
	ex (sp), hl
	exx
	ret
_keybScan:
	push ix
	ld ix, 0
	add ix, sp
#line 999
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
#line 1036
_keybScan__leave:
	ld sp, ix
	pop ix
	ret
_processDeath:
	push ix
	ld ix, 0
	add ix, sp
#line 1050
		di
		ei
		halt
		di
#line 1054
	xor a
	push af
	ld a, 1
	push af
	ld a, 2
	push af
	xor a
	push af
	call _createAttrib
	call _dumpAttribCenter
#line 1059
		di
		ei
		halt
		halt
		di
#line 1064
	call _dumpAttribsCenter
#line 1069
		di
		ei
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		di
#line 1092
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
#line 1103
		di
		ei
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		di
#line 1126
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
#line 1135
		di
		ei
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		di
#line 1158
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
	ld a, (_lifes)
	sub 3
	jp nz, __LABEL287
	ld hl, 0
	push hl
	ld hl, 6
	push hl
	ld hl, 21
	call _setAttrib
	ld hl, 0
	push hl
	ld hl, 6
	push hl
	ld hl, 22
	call _setAttrib
	jp __LABEL288
__LABEL287:
	ld a, (_lifes)
	sub 2
	jp nz, __LABEL289
	ld hl, 0
	push hl
	ld hl, 4
	push hl
	ld hl, 21
	call _setAttrib
	ld hl, 0
	push hl
	ld hl, 4
	push hl
	ld hl, 22
	call _setAttrib
	jp __LABEL290
__LABEL289:
	ld a, (_lifes)
	dec a
	jp nz, __LABEL291
	ld hl, 0
	push hl
	ld hl, 2
	push hl
	ld hl, 21
	call _setAttrib
	ld hl, 0
	push hl
	ld hl, 2
	push hl
	ld hl, 22
	call _setAttrib
	jp __LABEL292
__LABEL291:
	ld hl, 0
	push hl
	ld hl, 0
	push hl
	ld hl, 21
	call _setAttrib
	ld hl, 0
	push hl
	ld hl, 0
	push hl
	ld hl, 22
	call _setAttrib
__LABEL292:
__LABEL290:
__LABEL288:
	call _dumpScreenCenter
#line 1182
		di
		ei
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		halt
		di
#line 1205
	xor a
	ld hl, (_lifes - 1)
	cp h
	sbc a, a
_processDeath__leave:
	ld sp, ix
	pop ix
	ret
_render:
	push ix
	ld ix, 0
	add ix, sp
#line 1214
		di
		ei
		halt
		di
#line 1218
	ld a, (ix+5)
	push af
	call _drawPlayer
	call _dumpScreenCenter
_render__leave:
	ld sp, ix
	pop ix
	exx
	pop hl
	ex (sp), hl
	exx
	ret
_gameOver:
	push ix
	ld ix, 0
	add ix, sp
	ld hl, 0
	push hl
	inc sp
	ld (ix-1), 10
	jp __LABEL293
__LABEL296:
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 7
	push af
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
#line 1237
		di
		ei
		halt
		di
#line 1241
	call _dumpScreenCenter
__LABEL297:
	inc (ix-1)
__LABEL293:
	ld a, (ix-1)
	push af
	ld a, 21
	pop hl
	cp h
	jp nc, __LABEL296
__LABEL295:
	ld (ix-1), 11
	jp __LABEL298
__LABEL301:
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 7
	push af
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
#line 1251
		di
		ei
		halt
		di
#line 1255
	call _dumpScreenCenter
__LABEL302:
	inc (ix-1)
__LABEL298:
	ld a, (ix-1)
	push af
	ld a, 13
	pop hl
	cp h
	jp nc, __LABEL301
__LABEL300:
	ld (ix-1), 21
	jp __LABEL303
__LABEL306:
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 7
	push af
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
#line 1265
		di
		ei
		halt
		di
#line 1269
	call _dumpScreenCenter
__LABEL307:
	dec (ix-1)
__LABEL303:
	ld a, (ix-1)
	push af
	ld h, 10
	pop af
	cp h
	jp nc, __LABEL306
__LABEL305:
	ld (ix-1), 13
	jp __LABEL308
__LABEL311:
	xor a
	push af
	ld a, 1
	push af
	xor a
	push af
	ld a, 7
	push af
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
#line 1282
		di
		ei
		halt
		di
#line 1286
	call _dumpScreenCenter
__LABEL312:
	dec (ix-1)
__LABEL308:
	ld a, (ix-1)
	push af
	ld h, 11
	pop af
	cp h
	jp nc, __LABEL311
__LABEL310:
	xor a
	push af
	ld a, 11
	push af
	ld a, 11
	push af
	ld hl, __LABEL313
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
	push af
	call _createAttrib
	push af
	ld a, 11
	push af
	ld a, 12
	push af
	ld hl, __LABEL314
	call __LOADSTR
	push hl
	call _printZXString
	xor a
	push af
	ld a, 11
	push af
	ld a, 13
	push af
	ld hl, __LABEL313
	call __LOADSTR
	push hl
	call _printZXString
#line 1296
		di
		ei
		halt
		di
#line 1300
	call _dumpScreenCenter
_gameOver__leave:
	ld sp, ix
	pop ix
	ret
__LABEL0:
	DEFW 0000h
__LABEL53:
	DEFW 0005h
	DEFB 50h
	DEFB 4Fh
	DEFB 57h
	DEFB 45h
	DEFB 52h
__LABEL54:
	DEFW 0004h
	DEFB 4Ch
	DEFB 49h
	DEFB 46h
	DEFB 45h
__LABEL55:
	DEFW 0004h
	DEFB 42h
	DEFB 4Fh
	DEFB 4Dh
	DEFB 42h
__LABEL56:
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
__LABEL57:
	DEFW 0001h
	DEFB 47h
__LABEL58:
	DEFW 0001h
	DEFB 75h
__LABEL59:
	DEFW 0001h
	DEFB 73h
__LABEL60:
	DEFW 0001h
	DEFB 69h
__LABEL61:
	DEFW 0001h
	DEFB 76h
__LABEL62:
	DEFW 0001h
	DEFB 6Fh
__LABEL63:
	DEFW 0001h
	DEFB 6Eh
__LABEL64:
	DEFW 0004h
	DEFB 32h
	DEFB 30h
	DEFB 32h
	DEFB 30h
__LABEL65:
	DEFW 000Eh
	DEFB 50h
	DEFB 52h
	DEFB 45h
	DEFB 53h
	DEFB 53h
	DEFB 20h
	DEFB 54h
	DEFB 4Fh
	DEFB 20h
	DEFB 53h
	DEFB 54h
	DEFB 41h
	DEFB 52h
	DEFB 54h
__LABEL313:
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
__LABEL314:
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

#line 24 "C:/ZXBasic/library-asm/array.asm"

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
#line 62 "C:/ZXBasic/library-asm/array.asm"
		pop bc		; Get next index (Ai) from the stack

#line 72 "C:/ZXBasic/library-asm/array.asm"

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

#line 101 "C:/ZXBasic/library-asm/array.asm"
	    LOCAL ARRAY_SIZE_LOOP

	    ex de, hl
	    ld hl, 0
	    ld b, a
ARRAY_SIZE_LOOP:
	    add hl, de
	    djnz ARRAY_SIZE_LOOP

#line 111 "C:/ZXBasic/library-asm/array.asm"

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

#line 6225 "Program.zxbas"
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

#line 69 "free.asm"

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
#line 6226 "Program.zxbas"
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

#line 6227 "Program.zxbas"
#line 1 "bor16.asm"

; vim:ts=4:et:
	; FASTCALL bitwise or 16 version.
	; result in HL
; __FASTCALL__ version (operands: A, H)
	; Performs 16bit or 16bit and returns the boolean
; Input: HL, DE
; Output: HL <- HL OR DE

__BOR16:
		ld a, h
		or d
	    ld h, a

	    ld a, l
	    or e
	    ld l, a

	    ret

#line 6228 "Program.zxbas"
#line 1 "border.asm"

	; __FASTCALL__ Routine to change de border
	; Parameter (color) specified in A register

	BORDER EQU 229Bh

	; Nothing to do! (Directly from the ZX Spectrum ROM)

#line 6229 "Program.zxbas"
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

#line 6230 "Program.zxbas"
#line 1 "eq16.asm"

__EQ16:	; Test if 16bit values HL == DE
		; Returns result in A: 0 = False, FF = True
			xor a	; Reset carry flag
			sbc hl, de
			ret nz
			inc a
			ret

#line 6231 "Program.zxbas"

#line 1 "inkey.asm"

	; INKEY Function
	; Returns a string allocated in dynamic memory
	; containing the string.
	; An empty string otherwise.

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
#line 111 "C:/ZXBasic/library-asm/alloc.asm"
	        ret z ; NULL
#line 113 "C:/ZXBasic/library-asm/alloc.asm"
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

#line 7 "inkey.asm"

INKEY:
		PROC
		LOCAL __EMPTY_INKEY
		LOCAL KEY_SCAN
		LOCAL KEY_TEST
		LOCAL KEY_CODE

		ld bc, 3	; 1 char length string
		call __MEM_ALLOC

		ld a, h
		or l
		ret z	; Return if NULL (No memory)

		push hl ; Saves memory pointer

		call KEY_SCAN
		jp nz, __EMPTY_INKEY

		call KEY_TEST
		jp nc, __EMPTY_INKEY

		dec d	; D is expected to be FLAGS so set bit 3 $FF
				; 'L' Mode so no keywords.
		ld e, a	; main key to A
				; C is MODE 0 'KLC' from above still.
		call KEY_CODE ; routine K-DECODE
		pop hl

		ld (hl), 1
		inc hl
		ld (hl), 0
		inc hl
		ld (hl), a
		dec hl
		dec hl	; HL Points to string result
		ret

__EMPTY_INKEY:
		pop hl
		xor a
		ld (hl), a
		inc hl
		ld (hl), a
		dec hl
		ret

	KEY_SCAN	EQU 028Eh
	KEY_TEST	EQU 031Eh
	KEY_CODE	EQU 0333h

		ENDP

#line 6233 "Program.zxbas"
#line 1 "load.asm"



#line 1 "print.asm"

; vim:ts=4:sw=4:et:
	; PRINT command routine
	; Does not print attribute. Use PRINT_STR or PRINT_NUM for that

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

#line 6 "print.asm"
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

#line 7 "print.asm"
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
#line 8 "print.asm"
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

#line 1 "const.asm"

	; Global constants

	P_FLAG	EQU 23697
	FLAGS2	EQU 23681
	ATTR_P	EQU 23693	; permanet ATTRIBUTES
	ATTR_T	EQU 23695	; temporary ATTRIBUTES
	CHARS	EQU 23606 ; Pointer to ROM/RAM Charset
	UDG	EQU 23675 ; Pointer to UDG Charset
	MEM0	EQU 5C92h ; Temporary memory buffer used by ROM chars

#line 5 "ink.asm"

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
#line 1 "copy_attr.asm"

#line 4 "C:/ZXBasic/library-asm/copy_attr.asm"



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

#line 63 "C:/ZXBasic/library-asm/copy_attr.asm"
		ret
#line 65 "C:/ZXBasic/library-asm/copy_attr.asm"

__REFRESH_TMP:
		ld a, (hl)
		and 10101010b
		ld c, a
		rra
		or c
		ld (hl), a
		ret

		ENDP

#line 4 "over.asm"


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

#line 1 "attr.asm"

	; Attribute routines
; vim:ts=4:et:sw:







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
#line 19 "print.asm"

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
#line 75 "C:/ZXBasic/library-asm/print.asm"

__PRINT_START:
	        cp ' '
	        jp c, __PRINT_SPECIAL    ; Characters below ' ' are special ones

	        exx               ; Switch to alternative registers
	        ex af, af'        ; Saves a value (char to print) for later


	        call __SCROLL
#line 86 "C:/ZXBasic/library-asm/print.asm"
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
#line 209 "C:/ZXBasic/library-asm/print.asm"
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


#line 4 "load.asm"

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
#line 6234 "Program.zxbas"
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
#line 6235 "Program.zxbas"
#line 1 "lti8.asm"

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
#line 2 "lti8.asm"
#line 6236 "Program.zxbas"
#line 1 "pause.asm"

	; The PAUSE statement (Calling the ROM)

__PAUSE:
		ld b, h
	    ld c, l
	    jp 1F3Dh  ; PAUSE_1
#line 6237 "Program.zxbas"
#line 1 "string.asm"

	; String library



__STR_ISNULL:	; Returns A = FF if HL is 0, 0 otherwise
			ld a, h
			or l
			sub 1		; Only CARRY if HL is NULL
			sbc a, a	; Only FF if HL is NULL (0 otherwise)
			ret


__STRCMP:	; Compares strings at HL, DE: Returns 0 if EQual, -1 if HL < DE, +1 if HL > DE
				; A register is preserved and returned in A'
			PROC ; __FASTCALL__

			LOCAL __STRCMPZERO
			LOCAL __STRCMPEXIT
			LOCAL __STRCMPLOOP
			LOCAL __NOPRESERVEBC
			LOCAL __EQULEN
			LOCAL __EQULEN1
			LOCAL __HLZERO

			ex af, af'	; Saves current A register in A' (it's used by STRXX comparison functions)

			ld a, h
			or l
			jr z, __HLZERO

			ld a, d
			or e
			ld a, 1
			ret z		; Returns +1 if HL is not NULL and DE is NULL

			ld c, (hl)
			inc hl
			ld b, (hl)
			inc hl		; BC = LEN(a$)
			push hl		; HL = &a$, saves it

			ex de, hl
			ld e, (hl)
			inc hl
			ld d, (hl)
			inc hl
			ex de, hl	; HL = LEN(b$), de = &b$

			; At this point Carry is cleared, and A reg. = 1
			sbc hl, bc	; Carry if len(b$) > len(a$)
			jr z, __EQULEN	; Jump if they have the same length so A reg. = 0
			jr c, __EQULEN1 ; Jump if len(b$) > len(a$) so A reg. = 1
__NOPRESERVEBC:
			add hl, bc	; Restore HL (original length)
			ld b, h		; len(b$) <= len(a$)
			ld c, l		; so BC = hl
			dec a		; At this point A register = 0, it must be -1 since len(a$) > len(b$)
__EQULEN:
			dec a		; A = 0 if len(a$) = len(b$), -1 otherwise
__EQULEN1:
			pop hl		; Recovers A$ pointer
			push af		; Saves A for later (Value to return if strings reach the end)
	        ld a, b
	        or c
	        jr z, __STRCMPZERO ; empty string being compared

		; At this point: BC = lesser length, DE and HL points to b$ and a$ chars respectively
__STRCMPLOOP:
			ld a, (de)
			cpi
			jr nz, __STRCMPEXIT ; (HL) != (DE). Examine carry
			jp po, __STRCMPZERO ; END of string (both are equal)
			inc de
			jp __STRCMPLOOP

__STRCMPZERO:
			pop af		; This is -1 if len(a$) < len(b$), +1 if len(b$) > len(a$), 0 otherwise
			ret

__STRCMPEXIT:		; Sets A with the following value
			dec hl		; Get back to the last char
			cp (hl)
			sbc a, a	; A = -1 if carry => (DE) < (HL); 0 otherwise (DE) > (HL)
			cpl			; A = -1 if (HL) < (DE), 0 otherwise
			add a, a    ; A = A * 2 (thus -2 or 0)
			inc a		; A = A + 1 (thus -1 or 1)

			pop bc		; Discard top of the stack
			ret

__HLZERO:
			or d
			or e
			ret z		; Returns 0 (EQ) if HL == DE == NULL
			ld a, -1
			ret			; Returns -1 if HL is NULL and DE is not NULL

			ENDP

			; The following routines perform string comparison operations (<, >, ==, etc...)
			; On return, A will contain 0 for False, other value for True
			; Register A' will determine whether the incoming strings (HL, DE) will be freed
		; from dynamic memory on exit:
			;		Bit 0 => 1 means HL will be freed.
			;		Bit 1 => 1 means DE will be freed.

__STREQ:	; Compares a$ == b$ (HL = ptr a$, DE = ptr b$). Returns FF (True) or 0 (False)
			push hl
			push de
			call __STRCMP
			pop de
			pop hl

			;inc a		; If A == -1, return 0
			;jp z, __FREE_STR

			;dec a		;
			;dec a		; Return -1 if a = 0 (True), returns 0 if A == 1 (False)
	        sub 1
	        sbc a, a
			jp __FREE_STR


__STRNE:	; Compares a$ != b$ (HL = ptr a$, DE = ptr b$). Returns FF (True) or 0 (False)
			push hl
			push de
			call __STRCMP
			pop de
			pop hl

			;jp z, __FREE_STR

			;ld a, 0FFh	; Returns 0xFFh (True)
			jp __FREE_STR


__STRLT:	; Compares a$ < b$ (HL = ptr a$, DE = ptr b$). Returns FF (True) or 0 (False)
			push hl
			push de
			call __STRCMP
			pop de
			pop hl

			jp z, __FREE_STR ; Returns 0 if A == B

			dec a		; Returns 0 if A == 1 => a$ > b$
			;jp z, __FREE_STR

			;inc a		; A = FE now (-2). Set it to FF and return
			jp __FREE_STR


__STRLE:	; Compares a$ <= b$ (HL = ptr a$, DE = ptr b$). Returns FF (True) or 0 (False)
			push hl
			push de
			call __STRCMP
			pop de
			pop hl

			dec a		; Returns 0 if A == 1 => a$ < b$
			;jp z, __FREE_STR

			;ld a, 0FFh	; A = FE now (-2). Set it to FF and return
			jp __FREE_STR


__STRGT:	; Compares a$ > b$ (HL = ptr a$, DE = ptr b$). Returns FF (True) or 0 (False)
			push hl
			push de
			call __STRCMP
			pop de
			pop hl

			jp z, __FREE_STR		; Returns 0 if A == B

			inc a		; Returns 0 if A == -1 => a$ < b$
			;jp z, __FREE_STR		; Returns 0 if A == B

			;ld a, 0FFh	; A = FE now (-2). Set it to FF and return
			jp __FREE_STR


__STRGE:	; Compares a$ >= b$ (HL = ptr a$, DE = ptr b$). Returns FF (True) or 0 (False)
			push hl
			push de
			call __STRCMP
			pop de
			pop hl

			inc a		; Returns 0 if A == -1 => a$ < b$
			;jr z, __FREE_STR

			;ld a, 0FFh	; A = FE now (-2). Set it to FF and return

__FREE_STR: ; This exit point will test A' for bits 0 and 1
				; If bit 0 is 1 => Free memory from HL pointer
				; If bit 1 is 1 => Free memory from DE pointer
				; Finally recovers A, to return the result
			PROC

			LOCAL __FREE_STR2
			LOCAL __FREE_END

			ex af, af'
			bit 0, a
			jr z, __FREE_STR2

			push af
			push de
			call __MEM_FREE
			pop de
			pop af

__FREE_STR2:
			bit 1, a
			jr z, __FREE_END

			ex de, hl
			call __MEM_FREE

__FREE_END:
			ex af, af'
			ret

			ENDP

#line 6238 "Program.zxbas"
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


#line 6239 "Program.zxbas"
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

#line 6240 "Program.zxbas"

ZXBASIC_USER_DATA:
_currentEnemies:
	DEFB 00
_currentMapIndex:
	DEFB 00, 00
_currentMap:
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
_lifes:
	DEFB 04h
_state:
	DEFB 00h
_updateResult:
	DEFB 00h
_bitmapBuffer:
	DEFW __LABEL345
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
__LABEL345:
	DEFW 0000h
	DEFB 01h
_attribBuffer:
	DEFW __LABEL346
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
__LABEL346:
	DEFW 0000h
	DEFB 01h
_tableCP:
	DEFW __LABEL347
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
__LABEL347:
	DEFW 0000h
	DEFB 02h
_tlc:
	DEFW __LABEL348
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
__LABEL348:
	DEFW 0000h
	DEFB 01h
_blc:
	DEFW __LABEL349
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
__LABEL349:
	DEFW 0000h
	DEFB 01h
_mlor:
	DEFW __LABEL350
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
__LABEL350:
	DEFW 0000h
	DEFB 01h
_mlol:
	DEFW __LABEL351
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
__LABEL351:
	DEFW 0000h
	DEFB 01h
_mlo:
	DEFW __LABEL352
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
__LABEL352:
	DEFW 0000h
	DEFB 01h
_dot:
	DEFW __LABEL353
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
__LABEL353:
	DEFW 0000h
	DEFB 01h
_tlcc:
	DEFW __LABEL354
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
__LABEL354:
	DEFW 0000h
	DEFB 01h
_blcc:
	DEFW __LABEL355
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
__LABEL355:
	DEFW 0000h
	DEFB 01h
_rec:
	DEFW __LABEL356
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
__LABEL356:
	DEFW 0000h
	DEFB 01h
_rct:
	DEFW __LABEL357
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
__LABEL357:
	DEFW 0000h
	DEFB 01h
_rcbs:
	DEFW __LABEL358
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
__LABEL358:
	DEFW 0000h
	DEFB 01h
_mlob:
	DEFW __LABEL359
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
__LABEL359:
	DEFW 0000h
	DEFB 01h
_dgl:
	DEFW __LABEL360
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
__LABEL360:
	DEFW 0000h
	DEFB 01h
_dglc:
	DEFW __LABEL361
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
__LABEL361:
	DEFW 0000h
	DEFB 01h
_mlc:
	DEFW __LABEL362
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
__LABEL362:
	DEFW 0000h
	DEFB 01h
_rcb:
	DEFW __LABEL363
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
__LABEL363:
	DEFW 0000h
	DEFB 01h
_energy:
	DEFW __LABEL364
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
__LABEL364:
	DEFW 0000h
	DEFB 01h
_vampUp:
	DEFW __LABEL365
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
__LABEL365:
	DEFW 0000h
	DEFB 01h
_vampDown:
	DEFW __LABEL366
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
__LABEL366:
	DEFW 0000h
	DEFB 01h
_lamp:
	DEFW __LABEL367
_lamp.__DATA__.__PTR__:
	DEFW _lamp.__DATA__
_lamp.__DATA__:
	DEFB 1Fh
	DEFB 18h
	DEFB 7Eh
	DEFB 0FFh
	DEFB 42h
	DEFB 7Eh
	DEFB 24h
	DEFB 18h
__LABEL367:
	DEFW 0000h
	DEFB 01h
_spider:
	DEFW __LABEL368
_spider.__DATA__.__PTR__:
	DEFW _spider.__DATA__
_spider.__DATA__:
	DEFB 00h
	DEFB 0C3h
	DEFB 3Ch
	DEFB 7Eh
	DEFB 0DBh
	DEFB 3Ch
	DEFB 42h
	DEFB 42h
__LABEL368:
	DEFW 0000h
	DEFB 01h
_dinamyte1:
	DEFW __LABEL369
_dinamyte1.__DATA__.__PTR__:
	DEFW _dinamyte1.__DATA__
_dinamyte1.__DATA__:
	DEFB 28h
	DEFB 10h
	DEFB 08h
	DEFB 3Ch
	DEFB 3Ch
	DEFB 3Ch
	DEFB 3Ch
	DEFB 3Ch
__LABEL369:
	DEFW 0000h
	DEFB 01h
_dinamyte2:
	DEFW __LABEL370
_dinamyte2.__DATA__.__PTR__:
	DEFW _dinamyte2.__DATA__
_dinamyte2.__DATA__:
	DEFB 14h
	DEFB 08h
	DEFB 10h
	DEFB 3Ch
	DEFB 3Ch
	DEFB 3Ch
	DEFB 3Ch
	DEFB 3Ch
__LABEL370:
	DEFW 0000h
	DEFB 01h
_skh1:
	DEFW __LABEL371
_skh1.__DATA__.__PTR__:
	DEFW _skh1.__DATA__
_skh1.__DATA__:
	DEFB 3Ch
	DEFB 7Ah
	DEFB 0FFh
	DEFB 0E3h
	DEFB 0C0h
	DEFB 0E1h
	DEFB 7Fh
	DEFB 3Eh
__LABEL371:
	DEFW 0000h
	DEFB 01h
_skh2:
	DEFW __LABEL372
_skh2.__DATA__.__PTR__:
	DEFW _skh2.__DATA__
_skh2.__DATA__:
	DEFB 3Ch
	DEFB 7Ah
	DEFB 0FFh
	DEFB 0FFh
	DEFB 0FDh
	DEFB 7Fh
	DEFB 3Eh
	DEFB 00h
__LABEL372:
	DEFW 0000h
	DEFB 01h
_skb:
	DEFW __LABEL373
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
__LABEL373:
	DEFW 0000h
	DEFB 01h
_bug1:
	DEFW __LABEL374
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
__LABEL374:
	DEFW 0000h
	DEFB 01h
_bug2:
	DEFW __LABEL375
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
__LABEL375:
	DEFW 0000h
	DEFB 01h
_crock1:
	DEFW __LABEL376
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
__LABEL376:
	DEFW 0000h
	DEFB 01h
_crock2:
	DEFW __LABEL377
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
__LABEL377:
	DEFW 0000h
	DEFB 01h
_walll:
	DEFW __LABEL378
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
__LABEL378:
	DEFW 0000h
	DEFB 01h
_wallr:
	DEFW __LABEL379
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
__LABEL379:
	DEFW 0000h
	DEFB 01h
_wallb:
	DEFW __LABEL380
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
__LABEL380:
	DEFW 0000h
	DEFB 01h
_wallt:
	DEFW __LABEL381
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
__LABEL381:
	DEFW 0000h
	DEFB 01h
_walltr:
	DEFW __LABEL382
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
__LABEL382:
	DEFW 0000h
	DEFB 01h
_walltl:
	DEFW __LABEL383
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
__LABEL383:
	DEFW 0000h
	DEFB 01h
_wallbr:
	DEFW __LABEL384
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
__LABEL384:
	DEFW 0000h
	DEFB 01h
_wallbl:
	DEFW __LABEL385
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
__LABEL385:
	DEFW 0000h
	DEFB 01h
_singleWallV:
	DEFW __LABEL386
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
__LABEL386:
	DEFW 0000h
	DEFB 01h
_singleWallH:
	DEFW __LABEL387
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
__LABEL387:
	DEFW 0000h
	DEFB 01h
_rockT:
	DEFW __LABEL388
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
__LABEL388:
	DEFW 0000h
	DEFB 01h
_rockB:
	DEFW __LABEL389
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
__LABEL389:
	DEFW 0000h
	DEFB 01h
_rockL:
	DEFW __LABEL390
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
__LABEL390:
	DEFW 0000h
	DEFB 01h
_rockR:
	DEFW __LABEL391
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
__LABEL391:
	DEFW 0000h
	DEFB 01h
_fly1:
	DEFW __LABEL392
_fly1.__DATA__.__PTR__:
	DEFW _fly1.__DATA__
_fly1.__DATA__:
	DEFB 00h
	DEFB 00h
	DEFB 5Ah
	DEFB 0BDh
	DEFB 0BDh
	DEFB 5Ah
	DEFB 00h
	DEFB 00h
__LABEL392:
	DEFW 0000h
	DEFB 01h
_fly2:
	DEFW __LABEL393
_fly2.__DATA__.__PTR__:
	DEFW _fly2.__DATA__
_fly2.__DATA__:
	DEFB 00h
	DEFB 42h
	DEFB 0BDh
	DEFB 0BDh
	DEFB 5Ah
	DEFB 18h
	DEFB 00h
	DEFB 00h
__LABEL393:
	DEFW 0000h
	DEFB 01h
_scrp1:
	DEFW __LABEL394
_scrp1.__DATA__.__PTR__:
	DEFW _scrp1.__DATA__
_scrp1.__DATA__:
	DEFB 00h
	DEFB 00h
	DEFB 40h
	DEFB 0A3h
	DEFB 83h
	DEFB 7Eh
	DEFB 1Ch
	DEFB 2Ah
__LABEL394:
	DEFW 0000h
	DEFB 01h
_scrp2:
	DEFW __LABEL395
_scrp2.__DATA__.__PTR__:
	DEFW _scrp2.__DATA__
_scrp2.__DATA__:
	DEFB 00h
	DEFB 20h
	DEFB 40h
	DEFB 80h
	DEFB 83h
	DEFB 7Fh
	DEFB 3Ch
	DEFB 54h
__LABEL395:
	DEFW 0000h
	DEFB 01h
_solid:
	DEFW __LABEL396
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
__LABEL396:
	DEFW 0000h
	DEFB 01h
_water:
	DEFW __LABEL397
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
__LABEL397:
	DEFW 0000h
	DEFB 01h
_head1r:
	DEFW __LABEL398
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
__LABEL398:
	DEFW 0000h
	DEFB 01h
_head2r:
	DEFW __LABEL399
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
__LABEL399:
	DEFW 0000h
	DEFB 01h
_body1r:
	DEFW __LABEL400
_body1r.__DATA__.__PTR__:
	DEFW _body1r.__DATA__
_body1r.__DATA__:
	DEFB 0FCh
	DEFB 7Eh
	DEFB 7Fh
	DEFB 3Ch
	DEFB 18h
	DEFB 18h
	DEFB 18h
	DEFB 1Ch
__LABEL400:
	DEFW 0000h
	DEFB 01h
_body2r:
	DEFW __LABEL401
_body2r.__DATA__.__PTR__:
	DEFW _body2r.__DATA__
_body2r.__DATA__:
	DEFB 0FCh
	DEFB 7Eh
	DEFB 7Fh
	DEFB 3Ch
	DEFB 18h
	DEFB 78h
	DEFB 40h
	DEFB 00h
__LABEL401:
	DEFW 0000h
	DEFB 01h
_head1l:
	DEFW __LABEL402
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
__LABEL402:
	DEFW 0000h
	DEFB 01h
_head2l:
	DEFW __LABEL403
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
__LABEL403:
	DEFW 0000h
	DEFB 01h
_body1l:
	DEFW __LABEL404
_body1l.__DATA__.__PTR__:
	DEFW _body1l.__DATA__
_body1l.__DATA__:
	DEFB 3Fh
	DEFB 7Eh
	DEFB 0FEh
	DEFB 3Ch
	DEFB 18h
	DEFB 18h
	DEFB 18h
	DEFB 38h
__LABEL404:
	DEFW 0000h
	DEFB 01h
_body2l:
	DEFW __LABEL405
_body2l.__DATA__.__PTR__:
	DEFW _body2l.__DATA__
_body2l.__DATA__:
	DEFB 3Fh
	DEFB 7Eh
	DEFB 0FEh
	DEFB 3Ch
	DEFB 18h
	DEFB 1Eh
	DEFB 02h
	DEFB 00h
__LABEL405:
	DEFW 0000h
	DEFB 01h
_death1u:
	DEFW __LABEL406
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
__LABEL406:
	DEFW 0000h
	DEFB 01h
_death1d:
	DEFW __LABEL407
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
__LABEL407:
	DEFW 0000h
	DEFB 01h
_death2u:
	DEFW __LABEL408
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
__LABEL408:
	DEFW 0000h
	DEFB 01h
_death2d:
	DEFW __LABEL409
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
__LABEL409:
	DEFW 0000h
	DEFB 01h
_skull:
	DEFW __LABEL410
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
__LABEL410:
	DEFW 0000h
	DEFB 01h
_solidMap:
	DEFW __LABEL411
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
__LABEL411:
	DEFW 0001h
	DEFW 000Ch
	DEFB 01h
_enemyStates:
	DEFW __LABEL412
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
__LABEL412:
	DEFW 0000h
	DEFB 01h
_keyStates:
	DEFW __LABEL413
_keyStates.__DATA__.__PTR__:
	DEFW _keyStates.__DATA__
_keyStates.__DATA__:
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
	DEFB 00h
__LABEL413:
	DEFW 0000h
	DEFB 01h
	_screens.__DATA__ EQU 23755
_screens:
	DEFW __LABEL414
_screens.__DATA__.__PTR__:
	DEFW 23755
__LABEL414:
	DEFW 0001h
	DEFW 0076h
	DEFB 01h
	_maps.__DATA__ EQU 31455
_maps:
	DEFW __LABEL415
_maps.__DATA__.__PTR__:
	DEFW 31455
__LABEL415:
	DEFW 0000h
	DEFB 01h
__LABEL317:
	DEFB 10h
	DEFB 00h
__LABEL318:
	DEFB 01h
__LABEL319:
	DEFB 01h
__LABEL320:
	DEFB 0C0h
__LABEL321:
	DEFB 7Fh
	DEFB 00h
ZXBASIC_MEM_HEAP:
	; Defines DATA END
ZXBASIC_USER_DATA_END EQU ZXBASIC_MEM_HEAP + ZXBASIC_HEAP_SIZE
	; Defines USER DATA Length in bytes
ZXBASIC_USER_DATA_LEN EQU ZXBASIC_USER_DATA_END - ZXBASIC_USER_DATA
	END
