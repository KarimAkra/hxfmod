package hxfmod.externs;

@:buildXml('<include name="${haxelib:hxfmod}/project/Build.xml" />')
@:include('fmod_common.h')
@:unreflective
extern enum abstract Constants(cpp.UInt32)
{
	@:native('FMOD_VERSION')
	var FMOD_VERSION:cpp.UInt32;
}