memory.usememorydomain("WRAM")

function position()
	camx = mainmemory.read_s16_le(0x0620)
	camy = mainmemory.read_s16_le(0x0622)
	p1posx = mainmemory.read_s16_le(0x1101)
	p1posy = mainmemory.read_s16_le(0x1181)
	p2posx = mainmemory.read_s16_le(0x1105)
	p2posy = mainmemory.read_s16_le(0x1185)
end

local function hpdisplay()
	local HP1 = (mainmemory.read_s32_le(0x1B70) / 4096)
	local HP2 = (mainmemory.read_s32_le(0x1B74) / 4096)
	
	gui.pixelText(  15, 32, math.floor(HP1 * 10000) * .0001 .. "/1799", 0xFF808080, 0x00000000) 
	gui.pixelText( 143, 32, math.floor(HP2 * 10000) * .0001 .. "/1799", 0xFF808080, 0x00000000) 

end

local function player()

	for i = 0,1, 1 do
		local pstart 	= 0x1100 + (0x04 * i)
		local pposx    	= mainmemory.read_s16_le(pstart + 0x01)
		local pposy    	= mainmemory.read_s16_le(pstart + 0x80 + 0x01)
		local plengthx 	= mainmemory.read_s16_le(pstart + 0x700 + 0x02)
		local plengthy 	= mainmemory.read_s16_le(pstart + 0x700 + 0x80 + 0x02)			
		local poffsetx	= mainmemory.read_s16_le(pstart + 0x700)
		local poffsety	= mainmemory.read_s16_le(pstart + 0x700 + 0x80)
		local pface     = mainmemory.read_u8	(pstart + 0x200 + 0x80 + 0x03)
		local pmovetype = mainmemory.read_u8	(pstart + 0x100)
		local pstate 	= mainmemory.read_u8	(pstart + 0x101)
		local pattack	= mainmemory.read_u8	(pstart + 0x500) 
		
		if  bit.band( pface, 64) == 64 then
			pfacing = -1
		else
			pfacing = 1
		end

		local boxborder
		local boxfill

		if  bit.band( pstate, 16) == 16 then
			boxborder 	= 0xFFFF8888
			boxfill 	= 0x40CC6666
		elseif  bit.band( pstate, 2) == 2 then
			boxborder	= 0xFF00FFFF
			boxfill 	= 0x4000FFFF
		elseif  bit.band( pmovetype , 8) == 8 then
			boxborder	= 0xFF000000
			boxfill 	= 0x60000000
		else
			boxborder	= 0xFF0000FF
			boxfill  	= 0x400000FF
		end

		gui.drawBox(pposx - camx + (poffsetx * pfacing ),
					pposy - camy + (poffsety),
					pposx - camx + ( (poffsetx + plengthx) * pfacing ),
					pposy - camy + (poffsety + plengthy),
					boxborder, boxfill)
	end
end
local function magicbox()

	for i = 0,1, 1 do
		local pstart 	= 0x1100 + (0x04 * i)
		local pposx    	= mainmemory.read_s16_le(pstart + 0x01)
		local pposy    	= mainmemory.read_s16_le(pstart + 0x80 + 0x01)
		local poffsetx	= mainmemory.read_s16_le(pstart + 0xAC0)
		local poffsety	= mainmemory.read_s16_le(pstart + 0xAC0 + 0x02)
		local plengthx 	= mainmemory.read_s16_le(pstart + 0x600 + 0x80 + 0x02)
		local plengthy 	= mainmemory.read_s16_le(pstart + 0xAC0 + 0x08)			
		local pface     = mainmemory.read_u8	(pstart + 0x200 + 0x80 + 0x03)
		local pmovetype = mainmemory.read_u8	(pstart + 0x100)
		local pstate 	= mainmemory.read_u8	(pstart + 0x101)
		local pattack	= mainmemory.read_u8	(pstart + 0x500) 
		
		if  bit.band( pface, 64) == 64 then
			pfacing = -1
		else
			pfacing = 1
		end

		local boxborder
		local boxfill

		if  bit.band( pstate, 16) == 16 then
			boxborder 	= 0xFFFF8888
			boxfill 	= 0x40CC6666
		elseif  bit.band( pstate, 2) == 2 then
			boxborder	= 0xFF00FFFF
			boxfill 	= 0x4000FFFF
		elseif  bit.band( pmovetype , 8) == 8 then
			boxborder	= 0xFF000000
			boxfill 	= 0x60000000
		else
			boxborder	= 0xFF0000FF
			boxfill  	= 0x400000FF
		end

	if plengthx > -1 then
		gui.drawBox(pposx - camx + (poffsetx * pfacing ),
					pposy - camy + (poffsety),
					pposx - camx + ( (poffsetx + plengthx) * pfacing ),
					pposy - camy + (poffsety + plengthy),
					boxborder, boxfill)
	end
	end
end

local function redboxes()

	for i = 0,1, 1 do
		local pstart 	= 0x1100 + (0x04 * i)
		local pposx    	= mainmemory.read_s16_le(pstart + 0x01)
		local pposy    	= mainmemory.read_s16_le(pstart + 0x80 + 0x01)
		local plengthx 	= mainmemory.read_s16_le(pstart + 0x800 + 0x02)
		local plengthy 	= mainmemory.read_s16_le(pstart + 0x800 + 0x80 + 0x02)			
		local poffsetx	= mainmemory.read_s16_le(pstart + 0x800)
		local poffsety	= mainmemory.read_s16_le(pstart + 0x800 + 0x80)
		local pmovetype = mainmemory.read_u8	(pstart + 0x100)
		local pstate 	= mainmemory.read_u8	(pstart + 0x101)
		local pattack	= mainmemory.read_u8	(pstart + 0x500) 
		local pface     = mainmemory.read_u8	(pstart + 0x200 + 0x80 + 0x03)

		if  bit.band(pface, 64) == 64 then
			pfacing = -1
		else
			pfacing = 1
		end

		local boxborder	= 0xFFFF0000
		local boxfill	= 0x40FF0000

		if pattack > 0 then
		gui.drawBox(pposx - camx + (poffsetx * pfacing),
					pposy - camy + (poffsety),
					pposx - camx + ( (poffsetx + plengthx) * pfacing ),
					pposy - camy + (poffsety + plengthy),
					boxborder, boxfill)
		end
	end
end

local function scaler()
    xs = client.screenwidth() / 256
    ys = client.screenwidth() / 224
end

local function projectiles()

	local pjstart

	for i = 0,7, 1 do

		pjstart = 0x1140 + (0x04 * i)
		local pjposx    = mainmemory.read_s16_le(pjstart + 0x01)
		local pjposy    = mainmemory.read_s16_le(pjstart + 0x80 + 0x01)
		local pjlengthx = mainmemory.read_s16_le(pjstart + 0x800 + 0x02)
		local pjlengthy = mainmemory.read_s16_le(pjstart + 0x800 + 0x80 + 0x02)			
		local pjoffsetx = mainmemory.read_s16_le(pjstart + 0x800)
		local pjoffsety = mainmemory.read_s16_le(pjstart + 0x800 + 0x80)

		local pjface    = mainmemory.read_u8	(pjstart + 0x200 + 0x80 + 0x03)
		local pjenable  = mainmemory.read_s16_le(pjstart - 0x100)
		local facing = 1

		if  bit.band( pjface, 64) == 64 then
			facing = -1
		else
			facing = 1
		end

		if pjenable > 0 then
		gui.drawBox(pjposx - camx + (pjoffsetx * facing),
					pjposy - camy + (pjoffsety),
					pjposx - camx + ( (pjoffsetx + pjlengthx) * facing ),
					pjposy - camy + (pjoffsety + pjlengthy),
					0xFFFF0000,
					0x40000000)
		end
	end
end

local function vulcans()

	local pjstart

	for i = 0,7, 1 do

		pjstart = 0x1120 + (0x04 * i)
		local pjposx    = mainmemory.read_s16_le(pjstart + 0x01)
		local pjposy    = mainmemory.read_s16_le(pjstart + 0x80 + 0x01)
		local pjlengthx = mainmemory.read_s16_le(pjstart + 0x800 + 0x02)
		local pjlengthy = mainmemory.read_s16_le(pjstart + 0x800 + 0x80 + 0x02)			
		local pjoffsetx = mainmemory.read_s16_le(pjstart + 0x800)
		local pjoffsety = mainmemory.read_s16_le(pjstart + 0x800 + 0x80)

		local pjface    = mainmemory.read_u8	(pjstart + 0x200 + 0x80 + 0x03)
		local pjenable  = mainmemory.read_s16_le(pjstart - 0x100)
		local facing = 1

		if  bit.band( pjface, 64) == 64 then
			facing = -1
		else
			facing = 1
		end

		if pjenable > 0 then
		gui.drawBox(pjposx - camx + (pjoffsetx * facing),
					pjposy - camy + (pjoffsety),
					pjposx - camx + ( (pjoffsetx + pjlengthx) * facing  ),
					pjposy - camy + (pjoffsety + pjlengthy),
					0xFFFF0000,
					0x40000000)
		end
	end
end

while true do
	local gamestate = mainmemory.read_u8(0x000000)
	local matchstate = mainmemory.read_u8(0x000002)
		if gamestate == 8 and matchstate == 32 then
			position()
			magicbox()
			hpdisplay()
			player()
			redboxes()
			projectiles()
			vulcans()
		else
			gui.clearGraphics()
			gui.cleartext()
		end
	scaler()
	emu.frameadvance()
end