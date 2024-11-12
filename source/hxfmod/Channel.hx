package hxfmod;

import cpp.Pointer;
import cpp.RawPointer;
import hxfmod.externs.Types;
import hxfmod.util.LoopPoints;
import hxfmod.externs.Constants;
import hxfmod.externs.FMOD_RESULT;

@:allow(hxfmod.System)
class Channel
{
	public var frequency(get, set):Float;
	public var priority(get, set):Int;
	public var position(get, set):Int;
	public var loopCount(get, set):Int;
	public var isVirtual(get, never):Bool;
	public var currentSound(get, never):Sound;
	public var index(get, never):Int;

	public var paused(get, set):Bool;
	public var volume(get, set):Float;

	/*
	 * Error: Channel.cpp
	C:/haxelib/hxcpp/git/include\cpp/Variant.h(154): error C2440: '<function-style-cast>': cannot convert from 'const cpp::Variant' to 'RETURN_'
    with
    [
        RETURN_=FMOD_RESULT
    ]
	*/
	// TF DOES THIS MEAN!??!?! I'M NOT CASTING THIS OR RETURNING IT ANYWHERE?????
	// IT JUST RANDOMLY STARTED HAPPENING AND THE ONLY SOLUTION I FOUND IS MAKING THE RESULT A INT SORRY

	public var lastResultCode:Int = 0;
	private var _channel:cpp.RawPointer<FMod_Channel> = untyped NULL;

	public function new() {}

	public function setPositionAdvanced(position:Int, postype:FMOD_TIMEUNIT):Int
	{
		lastResultCode = _channel[0].setPosition(position, postype);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Channel] Failed to set position with error code ${lastResultCode}');
		}

		return lastResultCode == FMOD_OK ? position : getPositionAdvanced(postype);
	}

	public function getPositionAdvanced(postype:FMOD_TIMEUNIT):Int
	{
		var position:cpp.UInt32 = 0;
		var rawPtr:RawPointer<cpp.UInt32> = RawPointer.addressOf(position);
		lastResultCode = _channel[0].getPosition(rawPtr, postype);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get position with error code ${lastResultCode}');
			position = 0;
		}

		return position;
	}

	public function setLoopPoints(loopstart:Int, loopstarttype:FMOD_TIMEUNIT, loopend:Int, loopendtype:FMOD_TIMEUNIT):FMOD_RESULT
	{
		return _channel[0].setLoopPoints(loopstart, loopstarttype, loopend, loopendtype);
	}

	public function getLoopPoints(loopstarttype:FMOD_TIMEUNIT, loopendtype:FMOD_TIMEUNIT):LoopPoints
	{
		var loopstart:cpp.UInt32 = 0;
		var loopend:cpp.UInt32 = 0;

		var rawPtr1:RawPointer<cpp.UInt32> = RawPointer.addressOf(loopstart);
		var rawPtr2:RawPointer<cpp.UInt32> = RawPointer.addressOf(loopend);

		lastResultCode = _channel[0].getLoopPoints(rawPtr1, loopstarttype, rawPtr2, loopendtype);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get loop points with error code ${lastResultCode}');

			loopstart = 0;
			loopend = 0;
		}

		return {loopstart: loopstart, loopend: loopend};
	}

	@:noCompletion
	private function set_frequency(frequency:Float):Float
	{
		lastResultCode = _channel[0].setFrequency(frequency);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Channel] Failed to set frequency with error code ${lastResultCode}');
		}

		return lastResultCode == FMOD_OK ? frequency : this.frequency;
	}

	@:noCompletion
	private function get_frequency():Float
	{
		var frequency:cpp.Float32 = -1;
		var rawPtr:RawPointer<cpp.Float32> = RawPointer.addressOf(frequency);
		lastResultCode = _channel[0].getFrequency(rawPtr);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get frequency with error code ${lastResultCode}');
			frequency = -1;
		}

		return frequency;
	}

	@:noCompletion
	private function set_priority(priority:Int):Int
	{
		lastResultCode = _channel[0].setPriority(priority);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Channel] Failed to set priority with error code ${lastResultCode}');
		}

		return lastResultCode == FMOD_OK ? priority : this.priority;
	}

	@:noCompletion
	private function get_priority():Int
	{
		var priority:Int = -1;
		var rawPtr:RawPointer<Int> = RawPointer.addressOf(priority);
		lastResultCode = _channel[0].getPriority(rawPtr);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get priority with error code ${lastResultCode}');
			priority = -1;
		}

		return priority;
	}

	@:noCompletion
	private function set_position(position:Int):Int
	{
		return setPositionAdvanced(position, Constants.FMOD_TIMEUNIT_MS);
	}

	@:noCompletion
	private function get_position():Int
	{
		return getPositionAdvanced(Constants.FMOD_TIMEUNIT_MS);
	}

	@:noCompletion
	private function set_loopCount(loopcount:Int):Int
	{
		lastResultCode = _channel[0].setLoopCount(loopcount);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Channel] Failed to set loop count with error code ${lastResultCode}');
		}

		return lastResultCode == FMOD_OK ? loopcount : loopCount;
	}

	@:noCompletion
	private function get_loopCount():Int
	{
		var loopcount:Int = 1;
		var rawPtr:RawPointer<Int> = RawPointer.addressOf(loopcount);
		lastResultCode = _channel[0].getLoopCount(rawPtr);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get loop count with error code ${lastResultCode}');
			loopcount = 1;
		}

		return loopcount;
	}

	@:noCompletion
	private function get_isVirtual():Bool
	{
		var virtual:Bool = false;

		var rawPtr:RawPointer<Bool> = Pointer.addressOf(virtual).raw;
		lastResultCode = _channel[0].isVirtual(rawPtr);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get isVirtual with error code ${lastResultCode}');
			virtual = false;
		}

		return virtual;
	}

	@:noCompletion
	private function get_currentSound():Sound
	{
		var _sound:RawPointer<FMod_Sound> = untyped NULL;

		var rawPtr:RawPointer<RawPointer<FMod_Sound>> = RawPointer.addressOf(_sound);
		lastResultCode = _channel[0].getCurrentSound(rawPtr);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get current sound with error code ${lastResultCode}');
			_sound = untyped NULL;
			return null;
		}

		return Sound.fromSoundPointer(_sound);
	}

	@:noCompletion
	private function get_index():Int
	{
		var index:Int = 1;
		var rawPtr:RawPointer<Int> = RawPointer.addressOf(index);
		lastResultCode = _channel[0].getIndex(rawPtr);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get index with error code ${lastResultCode}');
			index = 1;
		}

		return index;
	}

	@:noCompletion
	private function set_paused(pause:Bool):Bool
	{
		lastResultCode = _channel[0].setPaused(pause);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Channel] Failed to set loop count with error code ${lastResultCode}');
		}

		return lastResultCode == FMOD_OK ? pause : paused;
	}

	@:noCompletion
	private function get_paused():Bool
	{
		var paused:Bool = false;

		var rawPtr:RawPointer<Bool> = RawPointer.addressOf(paused);
		lastResultCode = _channel[0].getPaused(rawPtr);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get paused with error code ${lastResultCode}');
			paused = false;
		}

		return paused;
	}

	@:noCompletion
	private function set_volume(volume:Float):Float
	{
		lastResultCode = _channel[0].setVolume(volume);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Channel] Failed to set volume with error code ${lastResultCode}');
		}

		return lastResultCode == FMOD_OK ? volume : this.volume;
	}

	@:noCompletion
	private function get_volume():Float
	{
		var volume:cpp.Float32 = -1;
		var rawPtr:RawPointer<cpp.Float32> = RawPointer.addressOf(volume);
		lastResultCode = _channel[0].getVolume(rawPtr);

		if (lastResultCode != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get volume with error code ${lastResultCode}');
			volume = -1;
		}

		return volume;
	}
}
