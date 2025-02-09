package hxfmod.externs;

@:build(hxfmod.macros.LinkerMacro.build('fmod_common.h'))
extern class Constants
{
	// Base FMod information static variables
	@:native('FMOD_VERSION')
	static var VERSION:cpp.UInt32;

	@:native('FMOD_BUILDNUMBER')
	static var BUILDNUMBER:cpp.UInt32;

	// FMOD_INITFLAGS
	@:native('FMOD_INIT_NORMAL')
	static var INIT_NORMAL:InitFlags;

	// FMOD_TIMEUNIT
	@:native('FMOD_TIMEUNIT_MS')
	static var TIMEUNIT_MS:TimeUnit;

	@:native('FMOD_TIMEUNIT_PCM')
	static var TIMEUNIT_PCM:TimeUnit;

	@:native('FMOD_TIMEUNIT_PCMBYTES')
	static var TIMEUNIT_PCMBYTES:TimeUnit;

	@:native('FMOD_TIMEUNIT_RAWBYTES')
	static var TIMEUNIT_RAWBYTES:TimeUnit;

	@:native('FMOD_TIMEUNIT_PCMFRACTION')
	static var TIMEUNIT_PCMFRACTION:TimeUnit;

	@:native('FMOD_TIMEUNIT_MODORDER')
	static var TIMEUNIT_MODORDER:TimeUnit;

	@:native('FMOD_TIMEUNIT_MODROW')
	static var TIMEUNIT_MODROW:TimeUnit;

	@:native('FMOD_TIMEUNIT_MODPATTERN')
	static var TIMEUNIT_MODPATTERN:TimeUnit;

	// FMOD_MODE
	@:native('FMOD_DEFAULT')
	static var DEFAULT:Mode;

	@:native('FMOD_LOOP_OFF')
	static var LOOP_OFF:Mode;

	@:native('FMOD_LOOP_NORMAL')
	static var LOOP_NORMAL:Mode;

	@:native('FMOD_LOOP_BIDI')
	static var LOOP_BIDI:Mode;

	@:native('FMOD_2D')
	static var MODE_2D:Mode;

	@:native('FMOD_3D')
	static var MODE_3D:Mode;

	@:native('FMOD_CREATESTREAM')
	static var CREATESTREAM:Mode;

	@:native('FMOD_CREATESAMPLE')
	static var CREATESAMPLE:Mode;

	@:native('FMOD_CREATECOMPRESSEDSAMPLE')
	static var CREATECOMPRESSEDSAMPLE:Mode;

	@:native('FMOD_OPENUSER')
	static var OPENUSER:Mode;

	@:native('FMOD_OPENMEMORY')
	static var OPENMEMORY:Mode;

	@:native('FMOD_OPENMEMORY_POINT')
	static var OPENMEMORY_POINT:Mode;

	@:native('FMOD_OPENRAW')
	static var OPENRAW:Mode;

	@:native('FMOD_OPENONLY')
	static var OPENONLY:Mode;

	@:native('FMOD_ACCURATETIME')
	static var ACCURATETIME:Mode;

	@:native('FMOD_MPEGSEARCH')
	static var MPEGSEARCH:Mode;

	@:native('FMOD_NONBLOCKING')
	static var NONBLOCKING:Mode;

	@:native('FMOD_UNIQUE')
	static var UNIQUE:Mode;

	@:native('FMOD_3D_HEADRELATIVE')
	static var MODE_3D_HEADRELATIVE:Mode;

	@:native('FMOD_3D_WORLDRELATIVE')
	static var MODE_3D_WORLDRELATIVE:Mode;

	@:native('FMOD_3D_INVERSEROLLOFF')
	static var MODE_3D_INVERSEROLLOFF:Mode;

	@:native('FMOD_3D_LINEARROLLOFF')
	static var MODE_3D_LINEARROLLOFF:Mode;

	@:native('FMOD_3D_LINEARSQUAREROLLOFF')
	static var MODE_3D_LINEARSQUAREROLLOFF:Mode;

	@:native('FMOD_3D_INVERSETAPEREDROLLOFF')
	static var MODE_3D_INVERSETAPEREDROLLOFF:Mode;

	@:native('FMOD_3D_CUSTOMROLLOFF')
	static var MODE_3D_CUSTOMROLLOFF:Mode;

	@:native('FMOD_3D_IGNOREGEOMETRY')
	static var MODE_3D_IGNOREGEOMETRY:Mode;

	@:native('FMOD_IGNORETAGS')
	static var IGNORETAGS:Mode;

	@:native('FMOD_LOWMEM')
	static var LOWMEM:Mode;

	@:native('FMOD_VIRTUAL_PLAYFROMSTART')
	static var VIRTUAL_PLAYFROMSTART:Mode;
}

// Just wanna keep this similar to how it is in FMod
typedef InitFlags = cpp.UInt32;
typedef TimeUnit = cpp.UInt32;
typedef Mode = cpp.UInt32;
