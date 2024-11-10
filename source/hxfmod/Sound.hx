package hxfmod;

import cpp.RawPointer;
import hxfmod.externs.Types.FMod_Sound;

@:allow(hxfmod.System)
@:allow(hxfmod.Channel)
class Sound
{
	private var _sound:cpp.RawPointer<FMod_Sound> = untyped NULL;

	private function new() {};

	private static function fromSoundPointer(_sound:cpp.RawPointer<FMod_Sound>):Sound
	{
		var sound:Sound = new Sound();
		sound._sound = _sound;
		return sound;
	}
}
