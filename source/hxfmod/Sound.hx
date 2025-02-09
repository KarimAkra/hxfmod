package hxfmod;

import cpp.RawConstPointer;
import cpp.Pointer;
import cpp.RawPointer;
import hxfmod.externs.Types;
import hxfmod.util.LoopPoints;
import hxfmod.util.SoundFormat;
import hxfmod.externs.Constants;
import hxfmod.externs.ResultCode;

@:allow(hxfmod.System)
@:allow(hxfmod.Channel)
class Sound
{
	public var length(get, null):Float;
	public var format(get, null):SoundFormat;
	public var name(get, null):String;

	public var lastResultCode:Int = 0;

	private var _sound:cpp.RawPointer<FMod_Sound> = untyped NULL;

	private function new()
	{
	}

	public function release():Void
	{
		lastResultCode = _sound[0].release();
	}

	public function getLengthAdvanced(lengthtype:TimeUnit):Float
	{
		var length:cpp.UInt32 = 0;
		var rawPtr:RawPointer<cpp.UInt32> = Pointer.addressOf(length).raw;
		lastResultCode = _sound[0].getLength(rawPtr, lengthtype);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Sound] Failed to get sound length with error code ${ResultCode.fromInt(lastResultCode).toString()}');
		}

		return length;
	}

	// returns 1 letter from the sound name grrr i hate u haxe
	// it was returning 1 letter... now it's returning the whole name but some of the letters are broken..? i hate this so much :sob:
	public function getNameAdvanced(namelen:Int):String
	{
		var name:cpp.Char = untyped NULL;
		var raw:RawPointer<cpp.Char> = RawPointer.addressOf(name);

		lastResultCode = _sound[0].getName(raw, namelen);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Sound] Failed to get sound name with error code ${ResultCode.fromInt(lastResultCode).toString()}');
			name = untyped NULL;
		}

		var constPtr:cpp.ConstPointer<cpp.Char> = cpp.ConstPointer.fromRaw(RawConstPointer.addressOf(name));
		return cpp.NativeString.fromPointer(constPtr);
	}

	public function setMode(mode:Mode):Void
	{
		lastResultCode = _sound[0].setMode(mode);
	}

	public function setLoopPoints(loopstart:Int, loopstarttype:TimeUnit, loopend:Int, loopendtype:TimeUnit):Void
	{
		lastResultCode = _sound[0].setLoopPoints(loopstart, loopstarttype, loopend, loopendtype);
	}

	public function getLoopPoints(loopstarttype:TimeUnit, loopendtype:TimeUnit):LoopPoints
	{
		var loopstart:cpp.UInt32 = 0;
		var loopend:cpp.UInt32 = 0;

		var rawPtr1:RawPointer<cpp.UInt32> = Pointer.addressOf(loopstart).raw;
		var rawPtr2:RawPointer<cpp.UInt32> = Pointer.addressOf(loopend).raw;

		lastResultCode = _sound[0].getLoopPoints(rawPtr1, loopstarttype, rawPtr2, loopendtype);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Sound] Failed to get loop points with error code ${ResultCode.fromInt(lastResultCode).toString()}');

			loopstart = 0;
			loopend = 0;
		}

		return {loopstart: loopstart, loopend: loopend};
	}

	private static function fromSoundPointer(_sound:cpp.RawPointer<FMod_Sound>):Sound
	{
		var sound:Sound = new Sound();
		sound._sound = _sound;
		return sound;
	}

	@:noCompletion
	private function get_length():Float
	{
		return getLengthAdvanced(Constants.TIMEUNIT_MS);
	}

	@:noCompletion
	private function get_format():SoundFormat
	{
		var type:FMOD_SOUND_TYPE = FMOD_SOUND_TYPE_UNKNOWN;
		var format:FMOD_SOUND_FORMAT = FMOD_SOUND_FORMAT.FMOD_SOUND_FORMAT_NONE;
		var channels:Int = -1;
		var bits:Int = -1;

		var rawPtr1:RawPointer<FMOD_SOUND_TYPE> = Pointer.addressOf(type).raw;
		var rawPtr2:RawPointer<FMOD_SOUND_FORMAT> = Pointer.addressOf(format).raw;
		var rawPtr3:RawPointer<Int> = Pointer.addressOf(channels).raw;
		var rawPtr4:RawPointer<Int> = Pointer.addressOf(bits).raw;

		lastResultCode = _sound[0].getFormat(rawPtr1, rawPtr2, rawPtr3, rawPtr4);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Sound] Failed to get sound format with error code ${ResultCode.fromInt(lastResultCode).toString()}');

			type = FMOD_SOUND_TYPE_UNKNOWN;
			format = FMOD_SOUND_FORMAT_NONE;
			channels = -1;
			bits = -1;
		}

		return {
			type: type,
			format: format,
			channels: channels,
			bits: bits
		};
	}

	@:noCompletion
	private function get_name():String
	{
		return getNameAdvanced(256);
	}
}
