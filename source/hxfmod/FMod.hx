package hxfmod;

import hxfmod.externs.Types.FMod_System;
import hxfmod.externs.FMOD_RESULT;
import hxfmod.externs.Constants;
import cpp.RawPointer;

@:buildXml('<include name="${haxelib:hxfmod}/project/Build.xml" />')
@:include('fmod.hpp')
@:unreflective
extern class FMod
{
	@:native('System_Create')
	static function System_Create(system:RawPointer<RawPointer<FMod_System>>, headerversion:cpp.UInt32):FMOD_RESULT;
}
