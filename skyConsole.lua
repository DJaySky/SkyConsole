--SkyConsole Version 0.1
--Created by DJaySky

--[[
features (that are different from normal terminal):
	-supports running of lua files
	-has a built in text editor? (make a seperate exe)
	-support for easier colors than normal cmd
	
list of commands:
	-run - runs the specified exe, bat, or lua file
	-pack [luaFile] [outName] - packs a lua file into a windows executable

	-info - displays information about the console

potential commands:
	-time - displays time


non-command functionality
	-typing the name of a lua file runs said file
	-typing the name+extension of a bat/exe file runs said file
]]

--- Displays information about the console
function showInfo()
	io.write([[
#######################################################
# SkyConsole 0.1 (alpha) | Copyright (C) 2024 DJaySky #
# GitHub repo: [link to gh repo]                      #
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
pack [luaFile] [outName] - Packs a lua file into a Windows executable, which is named outName

For more advanced descriptions of commands and their parameters, see [gh docs link].
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
			--[[os.execute("cd "..afterCd)
			os.execute("cd")]]
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
			--use the "start src/lua" command to run the lua file
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