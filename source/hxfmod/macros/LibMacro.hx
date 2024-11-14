package hxfmod.macros;

import haxe.io.Path;
import sys.io.File;
import sys.FileSystem;
import sys.io.Process;
#if macro
import haxe.macro.Context;
#end

using StringTools;

class LibMacro
{
	#if macro
	public static function addLibs()
	{
		if (!Context.getDefines().exists('HXFMOD_EXPORT_DIR'))
			Context.error("Couldn't find a value for `HXFMOD_EXPORT_DIR` haxe define, Please make sure you've set it to your export directory.",
				Context.currentPos());

		var exportDir:String = Context.getDefines().get('HXFMOD_EXPORT_DIR');

		#if HXCPP_M64
		#if windows
		var arch:String = getHXFmodDir() + "project/fmod/lib/Windows/x64/";
		#elseif winrt
		var arch:String = getHXFmodDir() + "project/fmod/lib/WinRT/x64/";
		#elseif linux
		var arch:String = getHXFmodDir() + 'project/fmod/lib/Linux/x86_64/';
		#else
		var arch:String = '';
		#end
		#end

		#if HXCPP_M32
		#if windows
		var arch:String = getHXFmodDir() + "project/fmod/lib/Windows/x86/";
		#elseif winrt
		var arch:String = getHXFmodDir() + "project/fmod/lib/WinRT/x86/";
		#elseif linux
		var arch:String = getHXFmodDir() + 'project/fmod/lib/Linux/x86/';
		#else
		var arch:String = '';
		#end
		#end

		#if HXCPP_ARM64
		#if windows
		var arch:String = getHXFmodDir() + "project/fmod/lib/Windows/arm64/";
		#elseif winrt
		var arch:String = '';
		Context.error("hxfmod is not supported on arm64 WinRT targets.", Context.currentPos());
		#elseif linux
		var arch:String = getHXFmodDir() + 'project/fmod/lib/Linux/arm64/';
		#else
		var arch:String = '';
		#end
		#end

		#if HXCPP_ARMV7
		#if windows
		var arch:String = '';
		Context.error("hxfmod is not supported on armv7 Windows targets.", Context.currentPos());
		#elseif winrt
		var arch:String = getHXFmodDir() + "project/fmod/lib/WinRT/arm/";
		#elseif linux
		var arch:String = getHXFmodDir() + 'project/fmod/lib/Linux/arm/';
		#else
		var arch:String = '';
		#end
		#end

		#if windows
		var bin:String = "windows/bin/";
		var dll:String = "dll";
		#elseif winrt
		var bin:String = "winrt/bin/";
		var dll:String = "dll";
		#elseif linux
		var bin:String = '/usr/lib/';
		var dll:String = "so";
		var ver:String = '14';
		#else
		var bin:String = '';
		var dll:String = '';
		#end

		#if ((HXCPP_M64 || HXCPP_M32 || HXCPP_ARM64 || HXCPP_ARMV7) && (windows || winrt || linux))
		for (file in FileSystem.readDirectory(arch))
		{
			if (Path.extension(file) == dll)
			{
				#if linux
				Sys.command('sudo', ['cp', arch + file, bin + '$file.$ver']);
				trace('copied ${file} to ' + bin + '$file.$ver');
				#else
				var path = Path.join([exportDir, bin, file]);
				FileSystem.createDirectory(Path.directory(path));
				File.copy(arch + file, path);
				trace('copied ${file} to ${Sys.getCwd() + path}');
				#end
			}
		}
		#end
	}
	#end

	private static function getHXFmodDir():String
	{
		var proc = new sys.io.Process('haxelib libpath hxfmod');
		return proc.stdout.readAll().toString().trim().split("\n")[0];
	}
}
