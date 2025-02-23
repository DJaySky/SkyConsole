--SkyConsole Version 1.0
--Created by DJaySky

--- Displays information about the console
function showInfo()
	io.write([[
#######################################################
# SkyConsole 1.0 | Copyright (C) 2024 DJaySky         #
# GitHub repo: https://github.com/DJaySky/SkyConsole  #
#######################################################
	]])
end

--- Checks if a file exists
function checkFile(name)
	local file = io.open(name, "r")
	if(file ~= nil) then
		io.close(file)
		return true
	else
		return false
	end
end

--- Parses and runs input
function  handleInput(input)
	local endString = string.sub(input, -3)

	if(string.sub(input, 1, 4) == "help") then
		io.write([[

help - Displays this menu
clear - Clears the screen
info - Displays information about the current console
quit - Quits the app

ls - Display files in the current directory
cd - Display the current path. Add a filepath after the command to switch directories

mk -f name[.type] - Creates a new file of type [.type]. Adding -f  creates a folder
rm [file] - Deletes a file

run - Runs the specified exe, bat, or lua file
pack [luaFile] [appName] - Packs a lua file into a Windows executable, which is named appName

time - Displays the current time

For more advanced descriptions of commands and their parameters, see https://github.com/DJaySky/SkyConsole?tab=readme-ov-file#documentation.
		]])
	elseif(input == "clear") then
		os.execute("cls")
	elseif(input == "info") then
		showInfo()
	elseif(input == "quit") then
		os.exit()

	elseif(input == "ls") then
		--find a way to add a / in front of folder names?
		os.execute("dir /B")
	elseif(string.sub(input, 1, 2) == "cd") then
		local afterCd = string.sub(input, 3)
		if(afterCd == "" or afterCd == nil) then
			os.execute("cd")
		else
			io.write("Changing paths is not supported by this version.\n")
		end
	
	elseif(string.sub(input, 1,2) == "mk") then
		local afterMk = string.sub(input, 3)
		if(afterMk == "" or afterMk == nil) then 
			io.write("Provide a file to be created.\n")
		elseif(string.sub(input, 4, 5) == "-f") then
			os.execute("mkdir"..string.sub(input, 6))
		else
			os.execute("echo. >"..string.sub(input, 4))
		end
	elseif(string.sub(input, 1, 2) == "rm") then
		local afterRm = string.sub(input, 3)
		if(afterRm == "" or afterRm == nil) then
			io.write("Provide a file to be deleted.\n")
		else
			os.execute("del"..string.sub(input, 3))
		end

	elseif(string.sub(input, 1, 3) == "run") then
		local type = string.sub(input, -3)
		local name = nil

		if(string.find(input, "%.") == nil) then
			name = string.sub(input, 5)
		else
			name = string.sub(input, 5, string.find(input, "%.") -1)
		end

		if(type == "exe" or type == "bat") then
			os.execute("start "..name.."."..type)
		elseif(type == "lua") then
			os.execute("start src/lua "..name..".lua")
		else
			if(checkFile(name..".".."exe") or checkFile(name..".".."bat")) then
				os.execute("start "..name)
			elseif(checkFile(name..".".."lua")) then
				os.execute("start src/lua "..name..".lua")
			else
				io.write("File not found.\n")
			end
		end
	elseif(string.sub(input, 1, 4) == "pack") then
		if(string.find(input, ".lua") ~= nil) then
			local luaFile = string.sub(input, 6, string.find(input, ".lua") + 3)
			local appName = string.sub(input, string.find(input, ".lua") + 4)

			os.execute("start src/rtc -o "..appName..".exe "..luaFile)
		else
			io.write("A .lua extension is required for Lua source files.\n")
		end
	elseif(input == "time") then
		os.execute("time /t")
	--if the end of the command is bat, exe or lua, run the file
	elseif(endString=="exe" or endString=="bat" or endString=="lua") then
		local type = string.sub(input, -3)
		local name = nil

		if(string.find(input, "%.") == nil) then
			name = input
		else
			name = string.sub(input, 1, string.find(input, "%.") -1)
		end

		if(type == "exe" or type == "bat") then
			os.execute("start "..name.."."..type)
		elseif(type == "lua") then
			os.execute("start src/lua "..name..".lua")
		else
			if(checkFile(name..".".."exe") or checkFile(name..".".."bat")) then
				os.execute("start "..name)
			elseif(checkFile(name..".".."lua")) then
				os.execute("start src/lua "..name..".lua")
			else
				io.write("File not found.\n")
			end
		end
	elseif(input ~= "") then
		io.write("\""..input.."\" is not a valid command.")
	end
	
	if(input ~= "" and input ~= "clear") then
		io.write("\n")
	end
end

os.execute("cls")
showInfo()
io.write("\n\n")

--- Whether or not to keep running the main loop
continue = true

while(continue) do
	local input = nil

	io.write("> ")
	input = io.read()

	handleInput(input)
end