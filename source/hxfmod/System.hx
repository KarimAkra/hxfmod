package hxfmod;

import cpp.UInt32;
import cpp.RawPointer;
import haxe.io.Path;
import hxfmod.Sound;
import hxfmod.Channel;
import hxfmod.externs.Types;
import hxfmod.externs.Constants;
import hxfmod.externs.ResultCode;
import hxfmod.util.FModAudioSource;

using StringTools;

class System
{
	public var version(get, never):Int;
	public var output(get, set):FMOD_OUTPUTTYPE;

	public var lastResultCode:Int = -1;

	private var _system:RawPointer<FMod_System> = untyped NULL;

	public function new()
	{
		lastResultCode = FMod.System_Create(RawPointer.addressOf(_system), Constants.VERSION);

		if (lastResultCode == FMOD_OK)
		{
			trace('[FMod System] Succesfully created a FMod System instance!');
		}
		else
		{
			trace('[FMod System] Failed to create FMod System instance with error code ${ResultCode.fromInt(lastResultCode).toString()}');
		}
	}

	public function init(maxchannels:Int, initFlags:InitFlags, extradriverdata:Int = 0):Bool
	{
		var extraDriverPointer = RawPointer.addressOf(extradriverdata);
		lastResultCode = _system[0].init(maxchannels, Constants.INIT_NORMAL, extraDriverPointer);

		if (lastResultCode == FMOD_OK)
		{
			#if android
			// output = FMOD_OUTPUTTYPE_OPENSL;
			_system[0].setOutput(FMOD_OUTPUTTYPE_OPENSL);
			#end
			trace('[FMod System] Succesfully initialized the FMod System!');

			return true;
		}
		else
		{
			trace('[FMod System] Failed to initialize the FMod System with error code ${ResultCode.fromInt(lastResultCode).toString()}');
		}

		return false;
	}

	public function createSound(name_or_data:FModAudioSource, mode:Mode, exinfo:FMOD_CREATESOUNDEXINFO):Sound
	{
		var sound = new Sound();

		var exInfoPtr:RawPointer<FMOD_CREATESOUNDEXINFO> = RawPointer.addressOf(exinfo);
		var soundPtr:RawPointer<RawPointer<FMod_Sound>> = RawPointer.addressOf(sound._sound);

		if (name_or_data is String)
		{
			if (mode & Constants.DEFAULT == 0)
				mode |= Constants.DEFAULT;

			var name:String = cast name_or_data;

			if (name.contains(":") #if android && !lime.utils.Assets.exists(name) #end)
				name = name.split(":")[1];

			#if android
			if (lime.utils.Assets.exists(name))
			{
				// name = Path.join(['file:///android_asset/', Path.normalize(name)]);
				name = 'file:///android_asset/' + Path.normalize(name.contains(":") ? name = name.split(":")[1] : name);
			}
			else
			{
				name = Path.normalize(name);
			}
			#elseif windows
			name = Path.normalize(name).split('/').join('\\');
			#else
			name = Path.normalize(name);
			#end

			trace('playing audio from $name!');
			var constCharStar:cpp.ConstCharStar = name;
			lastResultCode = _system[0].createSound(constCharStar, mode, exInfoPtr, soundPtr);
		}
		else if (name_or_data is haxe.io.Bytes)
		{
			if (mode & Constants.OPENMEMORY == 0)
				mode |= Constants.OPENMEMORY;

			final soundData:haxe.io.BytesData = cast(name_or_data, haxe.io.Bytes).getData();
			final rawData:cpp.RawPointer<cpp.UInt8> = untyped __cpp__('new unsigned char[{0}]', soundData.length);

			if (exinfo.length != soundData.length)
				exinfo.length = soundData.length;
			cpp.Stdlib.nativeMemcpy(cast rawData, cast cpp.Pointer.ofArray(soundData).constRaw, soundData.length);

			var constCharStar:cpp.ConstCharStar = untyped __cpp__('(const char *) {0}', rawData);
			lastResultCode = _system[0].createSound(constCharStar, mode, exInfoPtr, soundPtr);
		}

		if (lastResultCode == FMOD_OK)
		{
			trace('[FMod System] Created a new FMod Sound Object!');
		}
		else
		{
			trace('[FMod System] Failed to create sound instance with error ${ResultCode.fromInt(lastResultCode).toString()}');
		}

		return sound;
	}

	public function playSound(sound:Sound, paused:Bool = false, channel:Channel):Void
	{
		var ptr = RawPointer.addressOf(channel._channel);
		lastResultCode = _system[0].playSound(sound._sound, untyped nullptr, paused, ptr);

		if (lastResultCode == FMOD_OK)
		{
			trace('[FMod System] Played a FMod Sound Object!');
		}
		else
		{
			trace('[FMod System] Failed to play sound instance with error ${ResultCode.fromInt(lastResultCode).toString()}');
		}
	}

	public function close():Void
	{
		lastResultCode = _system[0].close();
	}

	public function release():Void
	{
		lastResultCode = _system[0].release();
	}

	public function update():Void
	{
		lastResultCode = _system[0].update();
	}

	@:noCompletion
	private function get_version():cpp.UInt32
	{
		var versionCode:cpp.UInt32 = 0;
		var rawPtr:RawPointer<cpp.UInt32> = RawPointer.addressOf(versionCode);
		_system[0].getVersion(rawPtr);
		return versionCode;
	}

	@:noCompletion
	private function get_output():FMOD_OUTPUTTYPE
	{
		var output:FMOD_OUTPUTTYPE = FMOD_OUTPUTTYPE_AUTODETECT;
		var rawPtr:RawPointer<FMOD_OUTPUTTYPE> = RawPointer.addressOf(output);
		_system[0].getOutput(rawPtr);
		return output;
	}

	@:noCompletion
	private function set_output(output:FMOD_OUTPUTTYPE):FMOD_OUTPUTTYPE
	{
		_system[0].setOutput(output);
		return output;
	}
}
