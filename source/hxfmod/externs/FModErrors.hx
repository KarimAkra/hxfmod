package hxfmod.externs;

@:buildXml('<include name="${haxelib:hxfmod}/project/Build.xml" />')
@:include('fmod_errors.h')
@:unreflective
extern class FModErrors
{
	// having to make a whole class just for this is ridiculous...
	@:native('FMOD_ErrorString')
	static function errorString(errcode:FMOD_RESULT):cpp.ConstCharStar;
}