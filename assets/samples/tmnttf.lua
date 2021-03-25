cpu = manager:machine().devices[":maincpu"]
mem = cpu.spaces["program"]
gui = manager:machine().screens[":screen"]

function main()

mem:write_u8(0x7E1F8C,3)
--mem:write_u8(0x7E0082,0x0C) --Stage Select

  player(0xE80,0x1AA0,  0,0,0x980,0x14C0)
  player(0xF60,0x1AF0,300,0,0xC00,0x15C0)

end

function player(addr,addr2,x,y,addr3,addr4)

chx		= mem:read_i16(addr+0x8)*2
chy		= mem:read_i16(addr+0xC)

flip	= mem:read_u8(addr+0x2C)

hurt	= mem:read_u16(addr + 0x36)--f96
hstimer = mem:read_u16(addr + 0x38)
	
life    = mem:read_u8(addr + 0x64)

meter   = addr2 + 0x20
colorid = addr2 + 0x50

if flip ~= 0 then
	flpx=-1
	else
	flpx=1
end
	
drawaxis(chx,chy,16)
	

--leostanding hurtboxes 0C 14 00 34 14 10 00 10 location 0x12540
membox(180,chx,chy,addr4-0x40,0x88FFFF00,flpx)
membox(180,chx,chy,addr4,0x88FFFF00,flpx)
membox(180,chx,chy,addr4+0x40,0x88FFFF00,flpx)
membox(180,chx,chy,addr3,0x88FF0000,flpx)
membox(180,chx,chy,addr3+0x40,0x88FF00FF,flpx)
--Display
--	gui:draw_box(x,y,x+200,y+32,0xff600000,0xffffffff)
--	gui:draw_text(x+2,y+2,string.format("BoxTest: %d,%d,%d,%d",box1,box2,box3,box4))
--	gui:draw_text(x+2,y+10,string.format("RealTest: %d,%d,%d,%d",0x00+chx,0x34+chy,0x0C,0x14))

end

function membox(screenh,plx,ply,addr,color,flip)
local xoff = mem:read_i16(addr+0x08)*2
local yoff = mem:read_i16(addr+0x10)
local xrad = (mem:read_u16(addr+0x16)*2)*flip
local yrad = mem:read_u16(addr+0x18)

local yoff	 = screenh + yoff
local left	 = xoff - xrad
local right	 = xoff + xrad
local top	   = yoff - yrad
local bottom = yoff + yrad

gui:draw_box(left,top,right,bottom,color,0xffffffff)
end

function colbox(screenh,plx,ply,addr,color,flip)
local xoff = mem:read_i8(addr+2)*2
local yoff = mem:read_i8(addr+3)
local xrad = mem:read_u8(addr)*2
local yrad = mem:read_u8(addr+1)

local xoff	 = plx + xoff * flip
local yoff	 = ply - yoff
local left	 = xoff - xrad
local right	 = xoff + xrad
local top	 = yoff - yrad
local bottom = yoff + yrad

gui:draw_box(left,top,right,bottom,color,0xffffffff)
end

function drawaxis(x,y,axis)

gui:draw_line(x+(axis),y,x-(axis),y,0xFF00FF00)
gui:draw_line(x,y-axis,x,y+axis,0xFF00FFFF)

end

emu.register_frame_done(main,"frame")

--[[
Device
:rspeaker
:maincpu
:st_list
:spc700
:soundcpu
:snsslot
:snsslot:lorom
:cart_list
:ctrl2
:ctrl1:joypad
:bsx_list
:screen
:ppu
:lspeaker
:ctrl1
:ctrl2:joypad
-----------------------
Screen
:screen
]]
	
