# SkyConsole
SkyConsole is a lightweight console application written entirely in Lua that simplifies the default Windows terminal. 
## Features:
- Lightweight - the packaged app is only a single file!
- Easy to use - SkyConsole's comamnds are much easier to understand than most other terminals
- Supports running batch scripts, exe files, and Lua files from the command line
- Basic control over files
- Pack Lua files into Windows executables

## Installation:
### **Pre-built installation:**  
This is the recommended way to install SkyConsole. Just head over to the [link]releases[/link] page, where both installers and zip files are provided.

### **Building from source**  
To build SkyConsole, open a terminal, navigate to the folder where you extracted the source code, and run `start src/rtc -s skyConsole.lua`. This will output a `skyConsole.exe` file in the same directory as the lua script. You can also use the wrtc.exe file that comes with rtc to customize the installation. If you move the SkyConsole.exe file, however, you need to make sure that you move the /src folder with it.

## Documentation:
Commands will **only** execute when typed exactly as shown in the table.
| **Command** | **Description**                                                                    |
| ----------- | ---------------------------------------------------------------------------------- |
| help        | Displays a help menu displaying <br> all other commands                            |
| clear       | Clears the screen                                                                  |
| info        | Displays information about the <br> console, including the console's <br> version  |
| quit        | Quits the app                                                                      |
| ls          | Displays a list of the apps in <br> the working directory                          |
| cd          | Display the current path                                                           |
| mk          | Creates a new file. See below <br> for advanced usage                              |
| rm [file]   | Deletes file at [file]                                                             |
| run [file]  | Runs the specified exe, bat, or <br> lua file at [file]                            |
| pack        | Packs a lua file into an exe file, <br> using [rtc](https://github.com/samyeyo/rtc)|

### Advanced Commands
**mk -f [name].[type]:**
>**Description**  
Creates a new file. The `mk` command will not work without parameters.  
><br>**Parameters**  
`name`: The name of the file to be created  
`type`: The type of the file to be created  
><br>**Options**  
`-f`: Adding `-f` to the `mk` command will create a folder instead of a file. The `type` argument will be appended to the end of the folder's name.  
><br>**Examples**  
`"mk main.lua"` - creates a Lua file named `main.lua` in the working directory  
`"mk -f bin"` - creates a folder named `bin` in the working directory  

**run [file].[type]:**  
>**Description**  
Runs the specified exe, bat, or lua file. If no file extension is specified, the command searches for exe files, bat files, and lua files with the name `file`, in that order. This means that exe files have priority over all other runnable file types.  
><br>**Parameters**  
`file`: The name of the file to be ran  
`type`: The type of the file to be ran. See the command's description for additional information on file types 

**pack:**  
>**Description**  
Packs a lua file into an exe file, using rtc.  
><br>**Notes**  
This command does **not** require rtc to be installed and exposed to the path, as it comes with the app's installation.

## Links
- [Lua](https://lua.org/about.html)
- [rtc](https://github.com/samyeyo/rtc)

## License
TBD