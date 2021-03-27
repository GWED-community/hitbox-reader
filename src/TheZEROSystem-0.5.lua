memory.usememorydomain("WRAM")
gui.defaultPixelFont(1)
resetgame = 0
healthlock = -1
menuselect = 1
option = {}
option[1] = -1
option[2] = -1
option[3] = -1
option[4] = -1

function globals()
	camx = mainmemory.read_s16_le(0x0620)
	camy = mainmemory.read_s16_le(0x0622)
	p1posx = mainmemory.read_s16_le(0x1101)
	p1posy = mainmemory.read_s16_le(0x1181)
	p2posx = mainmemory.read_s16_le(0x1105)
	p2posy = mainmemory.read_s16_le(0x1185)
	p1statetype = mainmemory.read_u8(0x1200)
	p2statetype = mainmemory.read_u8(0x1204)
end

function inputpress()
	buttons = joypad.get()
	if buttons["P1 Up"] == true then
		buttonp1up = buttonp1up + 1
	else
		buttonp1up	= 0
	end
	if buttons["P1 Down"] == true then
		buttonp1down = buttonp1down + 1
	else
		buttonp1down 		= 0
	end
	if buttons["P1 Left"] == true then
		buttonp1left = buttonp1left + 1
	else
		buttonp1left		= 0
	end
	if buttons["P1 Right"] == true then
		buttonp1right = buttonp1right + 1
	else
		buttonp1right 		= 0
	end
	if buttons["P1 A"] == true then
		buttonp1a = buttonp1a + 1
	else
		buttonp1a 		= 0
	end
	if buttons["P1 Y"] == true then
		buttonp1y = buttonp1y + 1
	else
		buttonp1y 		= 0
	end
	if buttons["P1 B"] == true then
		buttonp1b = buttonp1b + 1
	else
		buttonp1b 		= 0
	end
	if buttons["P1 L"] == true then
		buttonp1l = buttonp1l + 1
	else
		buttonp1l 		= 0
	end
	if buttons["P1 R"] == true then
		buttonp1r = buttonp1r + 1
	else
		buttonp1r 		= 0
	end
	if buttons["P1 Select"] == true then
		buttonp1select = buttonp1select + 1
	else
		buttonp1select 		= 0
	end
	if buttons["P1 Start"] == true then
		buttonp1start = buttonp1start + 1
	else
		buttonp1start 		= 0
	end
	if buttons["P2 Up"] == true then
		buttonp2up = buttonp2up + 1
	else
		buttonp2up	= 0
	end
	if buttons["P2 Down"] == true then
		buttonp2down = buttonp2down + 1
	else
		buttonp2down 		= 0
	end
	if buttons["P2 Left"] == true then
		buttonp2left = buttonp2left + 1
	else
		buttonp2left		= 0
	end
	if buttons["P2 Right"] == true then
		buttonp2right = buttonp2right + 1
	else
		buttonp2right 		= 0
	end
	if buttons["P2 A"] == true then
		buttonp2a = buttonp2a + 1
	else
		buttonp2a 		= 0
	end
	if buttons["P2 Y"] == true then
		buttonp2y = buttonp2y + 1
	else
		buttonp2y 		= 0
	end
	if buttons["P2 B"] == true then
		buttonp2b = buttonp2b + 1
	else
		buttonp2b 		= 0
	end
	if buttons["P2 L"] == true then
		buttonp2l = buttonp2l + 1
	else
		buttonp2l 		= 0
	end
	if buttons["P2 R"] == true then
		buttonp2r = buttonp2r + 1
	else
		buttonp2r 		= 0
	end
	if buttons["P2 Select"] == true then
		buttonp2select = buttonp2select + 1
	else
		buttonp2select 		= 0
	end
	if buttons["P2 Start"] == true then
		buttonp2start = buttonp2start + 1
	else
		buttonp2start 		= 0
	end

end

local function reset()
	if buttons["P1 L"] == true and buttons["P1 R"] == true and buttons["P1 Start"] == true and buttons["P1 Select"] == true then
		resetgame = resetgame + 1
	else
		resetgame = 0
	end

	if resetgame > 119 then
		mainmemory.write_u8(0x00, 0) 
		resetgame = 0
	end

end

local function hpdisplay()
	local HP1 = (mainmemory.read_s16_le(0x1B70) / 16)
	local HP2 = (mainmemory.read_s16_le(0x1B74) / 16)

	gui.pixelText(  15, 32, math.floor(HP1) .. "/1807", 0xFF00AAFF, 0x00000000) 
	gui.pixelText( 143, 32, math.floor(HP2) .. "/1807", 0xFF00AAFF, 0x00000000) 

--if bit.band(p1statetype, 128) == 128 then
--	gui.pixelText(  15, 4, "Cancel Ready!", 0xFFFFFF00, 0x00000000) 
--end

--if bit.band(p2statetype, 128) == 128 then
--	gui.pixelText( 143, 4, "Cancel Ready!", 0xFFFFFF00, 0x00000000) 
--end

end

function hplock()
	healthlock = healthlock * -1
	return healthlock
end

local function hpbutton()

--	forms.button(healthlock, 'TESTING', hplock, 20, 38, 100 , 7)

--	if healthlock == 1 then
		mainmemory.write_s16_le(0x1B70, 1807*16)
		mainmemory.write_s16_le(0x1B74, 1807*16)
--	end

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
		local pnograb 	= mainmemory.read_u8	(0x1BE2 + (i * 0x04))
		
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
		elseif  bit.band( pmovetype, 8) == 8 then
			boxborder	= 0xFF000000
			boxfill 	= 0x60000000
		elseif  pnograb > 0 then
			boxborder	= 0xFF0080FF
			boxfill 	= 0x400080FF
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

local function recovery()

	local p1recovery = mainmemory.read_u8(0x1b1A)
		if p1recovery > 0 then
			gui.pixelText(	p1posx - camx - 8,
							p1posy - camy - 8,
							mainmemory.read_u8(0x1B1A),
							0xFFFFFFFF, 0xB0000000) 
		end

	local p2recovery = mainmemory.read_u8(0x1b1E)
		if p2recovery > 0 then
			gui.pixelText(	p2posx - camx - 8,
							p2posy - camy - 8,
							mainmemory.read_u8(0x1B1E),
							0xFFFFFFFF, 0xB0000000) 
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

function pausemenu()
	
	local menulength = 4
--	local textcolor 

	
	if buttonp1down == 1 then
		menuselect = menuselect + 1
		if menuselect > menulength then
			menuselect = 1
		end
	elseif buttonp1up == 1 then
		menuselect = menuselect - 1
		if menuselect < 1 then
			menuselect = menulength
		end
	end
	

	local pausemenulabels = {}
	pausemenulabels[1] = "Max HP"
	pausemenulabels[2] = "Max Super Meter"
	pausemenulabels[3] = "Disable Timer"
	pausemenulabels[4] = "Hide Hitboxes"

	if buttonp1a == 1 then
		option[menuselect] = option[menuselect]	* -1
	end
	
	for i = 1,menulength, 1 do
		if menuselect == i then
			textcolor 	= 0xFF00AAFF
			textback	= 0x00000000
		else
			textcolor 	= 0xFFFFFFFF
			textback	= 0x00000000			
		end
		gui.pixelText( 112, 80 + (i*8), pausemenulabels[i], textcolor, textback)
		if option[i] == 1 then
			gui.pixelText( 104, 80 + (i*8), "O", 0xFFFF0000)
		end
	end



end

function settings()
	if option[1] == 1 then
		mainmemory.write_s16_le(0x1B70, 1807*16)
		mainmemory.write_s16_le(0x1B74, 1807*16)
	end
	if option[2] == 1 then
		mainmemory.write_s16_le(0x1B80, 300)
		mainmemory.write_s16_le(0x1B84, 300)		
	end	
--	if option[3] == 1 then
--		memory.usememorydomain("APURAM")
--		mainmemory.write_u8(0x000C, 0)
--		memory.usememorydomain("WRAM")
--	elseif option[3] == -1 then
--		memory.usememorydomain("APURAM")
--		if pause < 0 then
--			mainmemory.write_u8(0x000C, 128)
--		else
--			mainmemory.write_u8(0x000C, 255)
--		end
--		memory.usememorydomain("WRAM")	
--	end
	if option[3] == 1 then 
		mainmemory.write_u8(0xFF02, 2)
	elseif option[3] == -1 then
		mainmemory.write_u8(0xFF02, 0)	
	end
--	if option[4] == 1 then
--		
--	end
end

while true do
	globals()
	inputpress()
	gamestate = mainmemory.read_u8(0x000000)
	matchstate = mainmemory.read_u8(0x000002)
	pause = mainmemory.read_s16_le(0x000608) -- -1 for pause. 0 for unpause. -2 to pause without darkened screen

	if gamestate > 0 then
		reset()
	end

		if gamestate == 8 and matchstate == 32 then
			hpdisplay()
			if option[4] == -1 then
			magicbox()
			player()
			redboxes()
			projectiles()
			vulcans()
			recovery()
			end
			
		if pause < 0 then
			pausemenu()
		end
			settings()
		else
			gui.clearGraphics()
			gui.cleartext()
		end
	scaler()
	emu.frameadvance()
end