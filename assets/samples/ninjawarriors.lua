--[[The Ninjawarriors, Again (J) TASsistant
0x7E1211 - Player X
0x7E1291 - Player Y
0x7E0021 - Horizontal pan
]]

--[[if movie.framecount() and not exist tnwxcomp.txt then --dump X coordinates from movie playback
oldxarray = lines of tnwxcomp.txt
playercoords = function
elseif movie.framecount() and exist tnwxcomp.txt then --read X coords dumped from another movie
playercoords = function oldx = something.read(bluh?); gui.text(0,8,"Old: "..oldx)
end]]

local player = {}

local enemy = {}
for i = 0, 3 do
	enemy[i] = {}
end

local enemyaddress = { 0x7E1201, 0x7E1281, 0x7E18A2 } --x, y, hp

function enemycoords()
	for i = 0, 3 do
		enemy[i].x = memory.readword(enemyaddress[1]+(0x04*i))-memory.readword(0x7e0021)
		enemy[i].y = memory.readbyte(enemyaddress[2]+(0x04*i))-(30+i*8)
		enemy[i].hp= memory.readword(enemyaddress[3]+(0x04*i))
		player.x = memory.readword(0x7e1211)
		player.y = memory.readword(0x7e1291)
		if enemy[i].x < 0 then enemy[i].x = 0 end
		if enemy[i].x > 230 then enemy[i].x = 230 end
		if enemy[i].y < 0 then enemy[i].y = 10 end
		if enemy[i].y > 224 then enemy[i].y = 224 end
		if enemy[i].hp > 0 and enemy[i].hp < 10000 then
			gui.text(enemy[i].x, enemy[i].y, enemy[i].hp)
		end
		gui.text(enemy[i].x, 200, enemy[i].x-(player.x-memory.readword(0x7e0021)))
	end
end

while true do
	--playercoords()
	enemycoords()
	snes9x.frameadvance()
end
