package hxfmod;

import cpp.UInt32;
import cpp.Pointer;
import hxfmod.externs.Types;
import hxfmod.externs.FMOD_RESULT;
import hxfmod.externs.Constants;
import hxfmod.externs.Types;
import hxfmod.Channel;
import hxfmod.Sound;
import cpp.RawPointer;

class System
{
	public var version(get, null):Int;

	private var _system:RawPointer<FMod_System> = untyped NULL;

	public function new()
	{
		var result = FMod.System_Create(RawPointer.addressOf(_system), Constants.FMOD_VERSION);

		if (result == FMOD_OK)
		{
			trace('[FMod System] Succesfully created a FMod System instance!');
		}
		else
		{
			trace('[FMod System] Failed to create FMod System instance with error code ${result.toInt()}');
		}
	}

	public function init(maxchannels:Int, initFlags:FMOD_INITFLAGS, extradriverdata:Int = 0):FMOD_RESULT
	{
		var extraDriverPointer = RawPointer.addressOf(extradriverdata);
		var result = _system[0].init(32, INIT_NORMAL, extraDriverPointer);

		if (result == FMOD_OK)
		{
			trace('[FMod System] Succesfully initialized the FMod System!');
		}
		else
		{
			trace('[FMod System] Failed to initialize the FMod System with error code ${result.toInt()}');
		}

		return result;
	}

	public function createSound(name_or_data:String, mode:FMOD_MODE, exinfo:FMOD_CREATESOUNDEXINFO):Sound
	{
		var sound = new Sound();

		var exInfoPtr:RawPointer<FMOD_CREATESOUNDEXINFO> = RawPointer.addressOf(exinfo);
		var constCharStar:cpp.ConstCharStar = name_or_data;
		var soundPtr:RawPointer<RawPointer<FMod_Sound>> = RawPointer.addressOf(sound._sound);

		var result = _system[0].createSound(constCharStar, mode, untyped NULL, soundPtr);

		if (result == FMOD_OK)
		{
			trace('[FMod System] Created a new FMod Sound Object!');
		}
		else
		{
			trace('[FMod System] Failed to create sound instance with error ${result}');
		}

		return sound;
	}

	public function playSound(sound:Sound, paused:Bool = false, channel:Channel):FMOD_RESULT
	{
		var ptr = RawPointer.addressOf(channel._channel);
		var result = _system[0].playSound(sound._sound, untyped nullptr, paused, ptr);

		if (result == FMOD_OK)
		{
			trace('[FMod System] Played a FMod Sound Object!');
		}
		else
		{
			trace('[FMod System] Failed to play sound instance with error ${result}');
		}

		return result;
	}

	public function close():FMOD_RESULT
	{
		return _system[0].close();
	}

	public function release():FMOD_RESULT
	{
		return _system[0].release();
	}

	public function update():FMOD_RESULT
	{
		return _system[0].update();
	}

	@:noCompletion
	private function get_version():cpp.UInt32
	{
		var versionCode:cpp.UInt32 = 0;
		var rawPtr:RawPointer<cpp.UInt32> = Pointer.addressOf(versionCode).raw;
		_system[0].getVersion(rawPtr);
		return versionCode;
	}
}
