version(Windows)
{
	import std.stdio;

	@system int main(string[] args){  
	
		int nonSwitchArgument;
		int skipArgument = 0;
		if (args.length > 1){
			foreach (i, programCommandLineArgument; args){
				if (skipArgument > 0){ --skipArgument; continue; }
				if (i != 0){
					switch (programCommandLineArgument) {
						case "--help":
						case "--help=1":
							writeln("First page.");
							
							// help="1" Page numbering
							//          Exceeds    the array as no arguments supplied for -help
							bool nextArgumentDoesNotReachEndOfArray = i + 1 < args.length; 
							if (nextArgumentDoesNotReachEndOfArray){ // Do not go over array when accessing the array: rdmd CreateFile.d  asd asd -help
								if (args[i + 1] != ""){ 
									writeln("programCommandLineArgument's programCommandLineArgument", args[i + 1]); 
									skipArgument++; // rdmd CreateFile.d -help -helas
								}
								
								if (args[i + 2] != ""){ 
									writeln("programCommandLineArgument's programCommandLineArgument", args[i + 2]); 
									skipArgument++; // rdmd CreateFile.d -help -helas
								}
							} else {
								writeln("Reached the end of the array. No arguments for programCommandLineArgument.");
							}
							break;

					
					
						default:
							nonSwitchArgument++;
							writeln("The non switch programCommandLineArgument supplied ", nonSwitchArgument);
					}
				
				
					// if (programCommandLineArgument == "-help"){
					// 	writeln("Corr");
					// }
					writeln(i, ". ", programCommandLineArgument);
				}
				
			}
		} else {
			writeln("Welcome to the User Interface.");
			writeln("Without arguments");
		
		}
		import core.sys.windows.winbase;
		import core.sys.windows.winnt;

		const wchar * lpFileName = ".\\someFolder\\Example_filename.txt";
		uint dwDesiredAccess = GENERIC_READ | GENERIC_WRITE;
		uint dwShareMode = 0;
		
		LPSECURITY_ATTRIBUTES lpSecurityAttributes = null;
		uint dwCreationDisposition = CREATE_NEW;
		uint dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL;
		void * hTemplateFile = null;

		core.sys.windows.winbase.CreateFileW(
			lpFileName, 
			dwDesiredAccess, 
			dwShareMode, 
			lpSecurityAttributes, 
			dwCreationDisposition, 
			dwFlagsAndAttributes, 
			hTemplateFile
		);

		import std.conv: text, wtext, dtext;
		switch (GetLastError()){

			case 0:
				writeln("CreateFile: File \"", wtext(lpFileName), "\" created sucessfully using Win32 API. ");
				break;
				
			case ERROR_FILE_EXISTS:
				writeln("CreateFile: \"", wtext(lpFileName), "\" ERROR_FILE_EXISTS");
				return GetLastError();
				break;				
				
			case ERROR_PATH_NOT_FOUND:
				writeln("CreateFile: \"", wtext(lpFileName) ,"\" ERROR_PATH_NOT_FOUND");
				return GetLastError();
				break;
				
			default:
				writeln(__LINE__," Line, ", __FILE__, ": Unhandled Error: ", GetLastError());
				writeln("https://docs.microsoft.com/en-us/windows/win32/debug/system-error-codes--0-499-");
				return GetLastError();
				break;
		}
		
		return 0;
	}
}