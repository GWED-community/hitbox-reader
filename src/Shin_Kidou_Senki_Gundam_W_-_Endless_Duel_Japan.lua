memory.usememorydomain("WRAM")

local function player()
	local p1rx1 = 56+mainmemory.read_s16_le(0x1900) 
	local p1rx2 = mainmemory.read_s16_le(0x1902)
	local p1ry1 = 192+mainmemory.read_s16_le(0x1980)
	local p1ry2 = mainmemory.read_s16_le(0x1982)
	local p1rposx = mainmemory.read_s16_le(0x1101)
	local p1rposy = mainmemory.read_s16_le(0x1181)
	gui.drawBox(p1rx1,p1ry1,(p1rx1+p1rx2),(p1ry1+p1ry2),0xFFFF0000,0x40FF0000)

	local p1bx1 = 56+mainmemory.read_s16_le(0x1800) 
	local p1bx2 = mainmemory.read_s16_le(0x1802)
	local p1by1 = 192+mainmemory.read_s16_le(0x1880)
	local p1by2 = mainmemory.read_s16_le(0x1882)
	local p1bposx = mainmemory.read_s16_le(0x1101)
	local p1bposy = mainmemory.read_s16_le(0x1181)
	gui.drawBox(p1bx1,p1by1,(p1bx1+p1bx2),(p1by1+p1by2),0xFF0000FF,0x400000FF)

	local offp2 = 200
	local p2rx1 = mainmemory.read_s16_le(0x1904) 
	local p2rx2 = mainmemory.read_s16_le(0x1906)
	local p2ry1 = 192+mainmemory.read_s16_le(0x1984)
	local p2ry2 = mainmemory.read_s16_le(0x1986)
	local p2rposx = mainmemory.read_s16_le(0x1101)
	local p2rposy = mainmemory.read_s16_le(0x1181)
	gui.drawBox(offp2-p2rx1,p2ry1,offp2+(-p2rx1-p2rx2),(p2ry1+p2ry2),0xFFFF0000,0x40FF0000)

	local p2bx1 = mainmemory.read_s16_le(0x1804) 
	local p2bx2 = mainmemory.read_s16_le(0x1806)
	local p2by1 = 192+mainmemory.read_s16_le(0x1884)
	local p2by2 = mainmemory.read_s16_le(0x1886)
	local p2bposx = mainmemory.read_s16_le(0x1101)
	local p2bposy = mainmemory.read_s16_le(0x1181)
	gui.drawBox(offp2+(-p2bx1),p2by1,offp2+((-p2bx1-p2bx2)),(p2by1+p2by2),0xFF0000FF,0x400000FF)

end

while true do
    player()
    emu.frameadvance()
end