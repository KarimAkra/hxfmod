package hxfmod;

import cpp.UInt32;
import cpp.Pointer;
import cpp.RawPointer;
import hxfmod.Sound;
import hxfmod.Channel;
import hxfmod.externs.Types;
import hxfmod.externs.Constants;
import hxfmod.externs.FModErrors;
import hxfmod.externs.FMOD_RESULT;
import hxfmod.util.FModAudioSource;

class System
{
	public var version(get, never):Int;

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
		var result = _system[0].init(32, Constants.INIT_NORMAL, extraDriverPointer);

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

	public function createSound(name_or_data:FModAudioSource, mode:FMOD_MODE, exinfo:FMOD_CREATESOUNDEXINFO):Sound
	{
		var sound = new Sound();

		var exInfoPtr:RawPointer<FMOD_CREATESOUNDEXINFO> = RawPointer.addressOf(exinfo);
		var soundPtr:RawPointer<RawPointer<FMod_Sound>> = RawPointer.addressOf(sound._sound);

		var result = FMOD_RESULT.FMOD_ERR_INVALID_PARAM;

		if (name_or_data is String)
		{
			if (mode & Constants.FMOD_DEFAULT == 0) mode |= Constants.FMOD_DEFAULT;

			final name:String = cast name_or_data;
			var constCharStar:cpp.ConstCharStar = name;
			result = _system[0].createSound(constCharStar, mode, exInfoPtr, soundPtr);
		}
		else if (name_or_data is haxe.io.Bytes)
		{
			if (mode & Constants.FMOD_OPENMEMORY == 0) mode |= Constants.FMOD_OPENMEMORY;

			final soundData:haxe.io.BytesData = cast(name_or_data, haxe.io.Bytes).getData();
			final rawData:cpp.RawPointer<cpp.UInt8> = untyped __cpp__('new unsigned char[{0}]', soundData.length);

			if (exinfo.length != soundData.length) exinfo.length = soundData.length;
			cpp.Stdlib.nativeMemcpy(cast rawData, cast cpp.Pointer.ofArray(soundData).constRaw, soundData.length);

			var constCharStar:cpp.ConstCharStar = untyped __cpp__('(const char *) {0}', rawData);
			result = _system[0].createSound(constCharStar, mode, exInfoPtr, soundPtr);
		}

		if (result == FMOD_OK)
		{
			trace('[FMod System] Created a new FMod Sound Object!');
		}
		else
		{
			trace('[FMod System] Failed to create sound instance with error ${result.toInt()}');
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
			trace('[FMod System] Failed to play sound instance with error ${result.toInt()}');
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
