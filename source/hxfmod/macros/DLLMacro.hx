package hxfmod.macros;

import haxe.io.Path;
import sys.io.File;
import sys.FileSystem;
import sys.io.Process;
#if macro
import haxe.macro.Context;
#end

using StringTools;

class DLLMacro
{
	#if macro
	public static function addDLLs()
	{
		if (!Context.getDefines().exists('HXFMOD_EXPORT_DIR'))
			Context.error("Couldn't find a value for `HXFMOD_EXPORT_DIR` haxe define, Please make sure you've set it to your export directory.",
				Context.currentPos());

		var exportDir:String = Context.getDefines().get('HXFMOD_EXPORT_DIR');

		#if windows
		#if HXCPP_M64
		var arch:String = getHXFmodDir() + "project/fmod/lib/Windows/x64/";
		#elseif HXCPP_M32
		var arch:String = getHXFmodDir() + "project/fmod/lib/Windows/x86/";
		#elseif HXCPP_ARM64
		var arch:String = getHXFmodDir() + "project/fmod/lib/Windows/arm64/";
		#else
		var arch:String = '';
		#end
		var bin:String = "windows/bin/";
		var dll:String = "dll";
		#elseif winrt
		#if HXCPP_M64
		var arch:String = getHXFmodDir() + "project/fmod/lib/WinRT/x64/";
		#elseif HXCPP_M32
		var arch:String = getHXFmodDir() + "project/fmod/lib/WinRT/x86/";
		#elseif HXCPP_ARM64
		var arch:String = getHXFmodDir() + "project/fmod/lib/WinRT/arm64/";
		#else
		var arch:String = '';
		#end
		var bin:String = "winrt/bin/";
		var dll:String = "dll";
		#elseif linux
		#if HXCPP_M64
		var arch:String = getHXFmodDir() + 'project/fmod/lib/Linux/x86_64/';
		#elseif HXCPP_M32
		var arch:String = getHXFmodDir() + 'project/fmod/lib/Linux/x86/';
		#elseif HXCPP_ARM64
		var arch:String = getHXFmodDir() + 'project/fmod/lib/Linux/arm64/';
		#elseif HXCPP_ARMV7
		var arch:String = getHXFmodDir() + 'project/fmod/lib/Linux/arm/';
		#else
		var arch:String = '';
		#end
		var bin:String = 'linux/bin/';
		var dll:String = "so";
		#else
		var arch:String = '';
		var bin:String = '';
		var dll:String = '';
		#end

		for (dll in FileSystem.readDirectory(arch))
		{
			if (Path.extension(dll) == dll)
			{
				var path = Sys.getCwd() + Path.join([exportDir, bin, dll]);
				File.copy(arch + dll, path);
				trace('copied ${dll} to ${path}');
			}
		}
	}
	#end

	private static function getHXFmodDir():String
	{
		var proc = new sys.io.Process('haxelib libpath hxfmod');
		return proc.stdout.readAll().toString().trim().split("\n")[0];
	}
}
