memory.usememorydomain("WRAM")

local function player()
	local rx1 = 56+mainmemory.read_s16_le(0x1900) 
	local rx2 = 56+mainmemory.read_s16_le(0x1902)
	local ry1 = 192+mainmemory.read_s16_le(0x1980)
	local ry2 = mainmemory.read_s16_le(0x1982)
	local rposx = mainmemory.read_s16_le(0x1101)
	local rposy = mainmemory.read_s16_le(0x1181)
	gui.drawBox(rx1,ry1,(rx1+rx2),(ry1+ry2),0xFFFF0000,0x40FF0000)

	local bx1 = 56+mainmemory.read_s16_le(0x1800) 
	local bx2 = 56+mainmemory.read_s16_le(0x1802)
	local by1 = 192+mainmemory.read_s16_le(0x1880)
	local by2 = mainmemory.read_s16_le(0x1882)
	local bposx = mainmemory.read_s16_le(0x1101)
	local bposy = mainmemory.read_s16_le(0x1181)
	gui.drawBox(bx1,by1,(bx1+bx2),(by1+by2),0xFF0000FF,0x400000FF)

end

while true do
    player()
    emu.frameadvance()
end