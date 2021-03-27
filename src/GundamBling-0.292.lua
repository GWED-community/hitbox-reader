memory.usememorydomain("WRAM")

local function hpdisplay()
	local HP1 = mainmemory.read_s16_le(0x1B70)
	local HP2 = mainmemory.read_s16_le(0x1B74)
	
	gui.pixelText(  15, 32, HP1 .. "/28927", 0xFF808080, 0x00000000) 
	gui.pixelText( 143, 32, HP2 .. "/28927", 0xFF808080, 0x00000000) 

end
local function player()
	local camx = mainmemory.read_s16_le(0x0620)
	local camy = mainmemory.read_s16_le(0x0622)
	local p1posx = mainmemory.read_s16_le(0x1101)
	local p1posy = mainmemory.read_s16_le(0x1181)

	local p2posx = mainmemory.read_s16_le(0x1105)
	local p2posy = mainmemory.read_s16_le(0x1185)
	
	local p1face = mainmemory.read_u8(0x1383)
	local p2face = mainmemory.read_u8(0x1387)
	local p1facing = 1
	local p2facing = -1
	
	if ( p1face == 46 ) then
		p1facing = 1
	end
	if ( p1face == 112 ) then
		p1facing = -1
	end

	if ( p2face == 52 ) then
		p2facing = 1
	end
	if ( p2face == 116 ) then
		p2facing = -1
	end
	
	local p1bx1 = mainmemory.read_s16_le(0x1800) 
	local p1bx2 = mainmemory.read_s16_le(0x1802)
	local p1by1 = mainmemory.read_s16_le(0x1880)
	local p1by2 = mainmemory.read_s16_le(0x1882)
	local p1bposx = mainmemory.read_s16_le(0x1101)
	local p1bposy = mainmemory.read_s16_le(0x1181)
	local p1state = mainmemory.read_u8(0x1201)
	
	if p1state == 2 then
	gui.drawBox(p1posx - camx + (p1bx1 * p1facing),p1posy - camy + p1by1,(p1posx - camx + (p1bx1+p1bx2)*p1facing),p1posy - camy + (p1by1+p1by2),0xFF00FFFF,0x4000FFFF)
	elseif p1state == 3 then
	gui.drawBox(p1posx - camx + (p1bx1 * p1facing),p1posy - camy + p1by1,(p1posx - camx + (p1bx1+p1bx2)*p1facing),p1posy - camy + (p1by1+p1by2),0xFFFF8888,0x40CC6666)
	else
	gui.drawBox(p1posx - camx + (p1bx1 * p1facing),p1posy - camy + p1by1,(p1posx - camx + (p1bx1+p1bx2)*p1facing),p1posy - camy + (p1by1+p1by2),0xFF0000FF,0x400000FF)
	end
	local offp2 = 200
	local p2bx1 = mainmemory.read_s16_le(0x1804) 
	local p2bx2 = mainmemory.read_s16_le(0x1806)
	local p2by1 = mainmemory.read_s16_le(0x1884)
	local p2by2 = mainmemory.read_s16_le(0x1886)
	local p2bposx = mainmemory.read_s16_le(0x1101)
	local p2bposy = mainmemory.read_s16_le(0x1181)
	local p2state = mainmemory.read_u8(0x1205)

	if p2state == 2 then
	gui.drawBox(p2posx-camx+(p2bx1 * p2facing),p2posy - camy + p2by1,p2posx-camx+((p2bx1+p2bx2)*p2facing),p2posy - camy + (p2by1+p2by2),0xFF00FFFF,0x4000FFFF)
	elseif p2state == 3 then
	gui.drawBox(p2posx-camx+(p2bx1 * p2facing),p2posy - camy + p2by1,p2posx-camx+((p2bx1+p2bx2)*p2facing),p2posy - camy + (p2by1+p2by2),0xFFFF8888,0x40CC6666)
	else
	gui.drawBox(p2posx-camx+(p2bx1 * p2facing),p2posy - camy + p2by1,p2posx-camx+((p2bx1+p2bx2)*p2facing),p2posy - camy + (p2by1+p2by2),0xFF0000FF,0x400000FF)
	end
	
	if mainmemory.read_u8(0x1600) > 0 then

		local offp2 = 200
		local p1rx1 = mainmemory.read_s16_le(0x1900) 
		local p1rx2 = mainmemory.read_s16_le(0x1902)
		local p1ry1 = mainmemory.read_s16_le(0x1980)
		local p1ry2 = mainmemory.read_s16_le(0x1982)
		local p1rposx = mainmemory.read_s16_le(0x1101)
		local p1rposy = mainmemory.read_s16_le(0x1181)

		if mainmemory.read_u8(0x1600) == 6 then
			gui.drawBox(p1posx - camx + (p1rx1 * p1facing),p1posy - camy + p1ry1,p1posx - camx + ((p1rx1+p1rx2)*p1facing),p1posy - camy + (p1ry1+p1ry2),0xFFFF00AA,0x40FF00AA)
		else
			gui.drawBox(p1posx - camx + (p1rx1 * p1facing),p1posy - camy + p1ry1,p1posx - camx + ((p1rx1+p1rx2)*p1facing),p1posy - camy + (p1ry1+p1ry2),0xFFFF0000,0x40FF0000)
		end
	end
	
	if mainmemory.read_u8(0x1604) > 0 then

	local p2rx1 = mainmemory.read_s16_le(0x1904) 
	local p2rx2 = mainmemory.read_s16_le(0x1906)
	local p2ry1 = mainmemory.read_s16_le(0x1984)
	local p2ry2 = mainmemory.read_s16_le(0x1986)
	local p2rposx = mainmemory.read_s16_le(0x1101)
	local p2rposy = mainmemory.read_s16_le(0x1181)
	gui.drawBox(p2posx-camx+(p2rx1 * p2facing),p2posy - camy + p2ry1,p2posx-camx+((p2rx1+p2rx2)*p2facing),p2posy - camy + (p2ry1+p2ry2),0xFFFF0000,0x40FF0000)

	end

end

local function magicbox()
	local camx = mainmemory.read_s16_le(0x0620)
	local camy = mainmemory.read_s16_le(0x0622)
	local p1posx = mainmemory.read_s16_le(0x1101)
	local p1posy = mainmemory.read_s16_le(0x1181)

	local p2posx = mainmemory.read_s16_le(0x1105)
	local p2posy = mainmemory.read_s16_le(0x1185)
	
	local p1face = mainmemory.read_u8(0x1383)
	local p2face = mainmemory.read_u8(0x1387)
	local p1facing = 1
	local p2facing = -1
	
	if ( p1face == 46 ) then
		p1facing = 1
	end
	if ( p1face == 112 ) then
		p1facing = -1
	end

	if ( p2face == 52 ) then
		p2facing = 1
	end
	if ( p2face == 116 ) then
		p2facing = -1
	end
	
	local p1bx1 = mainmemory.read_s16_le(0x1BC0) 
	local p1bx2 = mainmemory.read_s16_le(0x1782)
	local p1by1 = mainmemory.read_s16_le(0x1BC2)
	local p1by2 = mainmemory.read_s16_le(0x1BC8)
	local p1bposx = mainmemory.read_s16_le(0x1101)
	local p1bposy = mainmemory.read_s16_le(0x1181)
	local p1state = mainmemory.read_u8(0x1201)

	if p1bx2 > -1 then
		if p1state == 2 then
			gui.drawBox(p1posx - camx + (p1bx1 * p1facing),p1posy - camy + p1by1,(p1posx - camx + (p1bx1+p1bx2)*p1facing),p1posy - camy + (p1by1+p1by2),0xFF00FFFF,0x4000FFFF)
		elseif p1state == 3 then
			gui.drawBox(p1posx - camx + (p1bx1 * p1facing),p1posy - camy + p1by1,(p1posx - camx + (p1bx1+p1bx2)*p1facing),p1posy - camy + (p1by1+p1by2),0xFFFF8888,0x40CC6666)
		else
			gui.drawBox(p1posx - camx + (p1bx1 * p1facing),p1posy - camy + p1by1,(p1posx - camx + (p1bx1+p1bx2)*p1facing),p1posy - camy + (p1by1+p1by2),0xFF0000FF,0x400000FF)
		end
	end
	
	local offp2 = 200
	local p2bx1 = mainmemory.read_s16_le(0x1BC4) 
	local p2bx2 = mainmemory.read_s16_le(0x1786)
	local p2by1 = mainmemory.read_s16_le(0x1BC6)
	local p2by2 = mainmemory.read_s16_le(0x1BCC)
	local p2bposx = mainmemory.read_s16_le(0x1101)
	local p2bposy = mainmemory.read_s16_le(0x1181)
	local p2state = mainmemory.read_u8(0x1205)

	if p2bx2 > -1 then
		if p2state == 2 then
			gui.drawBox(p2posx-camx+(p2bx1 * p2facing),
						p2posy - camy + p2by1,
						p2posx-camx+((p2bx1+p2bx2)*p2facing),
						p2posy - camy + (p2by1+p2by2),
						0xFF00FFFF,
						0x4000FFFF)
		elseif p2state == 3 then
			gui.drawBox(p2posx-camx+(p2bx1 * p2facing),
						p2posy - camy + p2by1,
						p2posx-camx+((p2bx1+p2bx2)*p2facing),
						p2posy - camy + (p2by1+p2by2),
						0xFFFF8888,
						0x40CC6666)
		else
			gui.drawBox(p2posx-camx+(p2bx1 * p2facing),p2posy - camy + p2by1,p2posx-camx+((p2bx1+p2bx2)*p2facing),p2posy - camy + (p2by1+p2by2),0xFF0000FF,0x400000FF)
		end
	end
	
end

local function scaler()
    xs = client.screenwidth() / 256
    ys = client.screenwidth() / 224
end

local function projectiles()

	local pjstart
	local camx = mainmemory.read_s16_le(0x0620)
	local camy = mainmemory.read_s16_le(0x0622)

	for i = 0,3, 1 do

		pjstart = 0x1140 + (0x08 * i)
		local pjposx    = mainmemory.read_s16_le(pjstart + 0x01)
		local pjposy    = mainmemory.read_s16_le(pjstart + 0x80 + 0x01)
		local pjlengthx = mainmemory.read_s16_le(pjstart + 0x800 + 0x02)
		local pjlengthy = mainmemory.read_s16_le(pjstart + 0x800 + 0x80 + 0x02)			
		local pjoffsetx = mainmemory.read_s16_le(pjstart + 0x800)
		local pjoffsety = mainmemory.read_s16_le(pjstart + 0x800 + 0x80)

		gui.drawBox(pjposx - camx + (pjoffsetx),
					pjposy - camy + (pjoffsety),
					pjposx - camx + ( (pjoffsetx + pjlengthx)  ),
					pjposy - camy + (pjoffsety + pjlengthy),
					0xFFFF0000,
					0x40000000)

	end
end

while true do
	magicbox()
	scaler()
	hpdisplay()
    player()
	projectiles()
    emu.frameadvance()
end