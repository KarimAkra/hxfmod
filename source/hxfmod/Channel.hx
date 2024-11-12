package hxfmod;

import cpp.Pointer;
import cpp.RawPointer;
import hxfmod.externs.Types;
import hxfmod.externs.Constants;
import hxfmod.externs.FMOD_RESULT;
import hxfmod.util.LoopPoints;

@:allow(hxfmod.System)
class Channel
{
	private var _channel:cpp.RawPointer<FMod_Channel> = untyped NULL;

	public function new() {}

	public function setFrequency(frequency:Float):FMOD_RESULT
	{
		return _channel[0].setFrequency(frequency);
	}

	public function getFrequency():Float
	{
		var frequency:cpp.Float32 = -1;
		var rawPtr:RawPointer<cpp.Float32> = Pointer.addressOf(frequency).raw;
		var result = _channel[0].getFrequency(rawPtr);

		if (result != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get frequency with error code ${result}');
			frequency = -1;
		}

		return frequency;
	}

	public function setPriority(priority:Int):FMOD_RESULT
	{
		return _channel[0].setPriority(priority);
	}

	public function getPriority():Int
	{
		var priority:Int = -1;
		var rawPtr:RawPointer<Int> = Pointer.addressOf(priority).raw;
		var result = _channel[0].getPriority(rawPtr);

		if (result != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get priority with error code ${result}');
			priority = -1;
		}

		return priority;
	}

	public function setPosition(position:Int, postype:FMOD_TIMEUNIT):FMOD_RESULT
	{
		return _channel[0].setPosition(position, postype);
	}

	public function getPosition(postype:FMOD_TIMEUNIT):Int
	{
		var position:cpp.UInt32 = 0;
		var rawPtr:RawPointer<cpp.UInt32> = Pointer.addressOf(position).raw;
		var result = _channel[0].getPosition(rawPtr, postype);

		if (result != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get position with error code ${result}');
			position = 0;
		}

		return position;
	}

	public function setLoopCount(loopcount:Int):FMOD_RESULT
	{
		return _channel[0].setLoopCount(loopcount);
	}

	public function getLoopCount(loopcount:Int):Int
	{
		var loopcount:Int = 1;
		var rawPtr:RawPointer<Int> = Pointer.addressOf(loopcount).raw;
		var result = _channel[0].getLoopCount(rawPtr);

		if (result != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get loop count with error code ${result}');
			loopcount = 1;
		}

		return loopcount;
	}

	public function setLoopPoints(loopstart:Int, loopstarttype:FMOD_TIMEUNIT, loopend:Int, loopendtype:FMOD_TIMEUNIT):FMOD_RESULT
	{
		return _channel[0].setLoopPoints(loopstart, loopstarttype, loopend, loopendtype);
	}

	public function getLoopPoints(loopstarttype:FMOD_TIMEUNIT, loopendtype:FMOD_TIMEUNIT):LoopPoints
	{
		var loopstart:cpp.UInt32 = 0;
		var loopend:cpp.UInt32 = 0;

		var rawPtr1:RawPointer<cpp.UInt32> = Pointer.addressOf(loopstart).raw;
		var rawPtr2:RawPointer<cpp.UInt32> = Pointer.addressOf(loopend).raw;

		var result = _channel[0].getLoopPoints(rawPtr1, loopstarttype, rawPtr2, loopendtype);

		if (result != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get loop points with error code ${result}');

			loopstart = 0;
			loopend = 0;
		}

		return {loopstart: loopstart, loopend: loopend};
	}

	public function isVirtual():Bool
	{
		var virtual:Bool = false;

		var rawPtr:RawPointer<Bool> = Pointer.addressOf(virtual).raw;
		var result = _channel[0].isVirtual(rawPtr);

		if (result != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get isVirtual with error code ${result}');
			virtual = false;
		}

		return virtual;
	}

	public function getCurrentSound():Sound
	{
		var _sound:RawPointer<FMod_Sound> = untyped NULL;

		var rawPtr:RawPointer<RawPointer<FMod_Sound>> = Pointer.addressOf(_sound).raw;
		var result = _channel[0].getCurrentSound(rawPtr);

		if (result != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get current sound with error code ${result}');
			_sound = untyped NULL;
			return null;
		}

		return Sound.fromSoundPointer(_sound);
	}

	public function getIndex():Int
	{
		var index:Int = 1;
		var rawPtr:RawPointer<Int> = Pointer.addressOf(index).raw;
		var result = _channel[0].getIndex(rawPtr);

		if (result != FMOD_OK)
		{
			trace('[FMod Channel] Failed to get index with error code ${result}');
			index = 1;
		}

		return index;
	}
}