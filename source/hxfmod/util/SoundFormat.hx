package hxfmod.util;

import hxfmod.externs.Types.FMOD_SOUND_TYPE;
import hxfmod.externs.Types.FMOD_SOUND_FORMAT;

typedef SoundFormat =
{
	public var type:FMOD_SOUND_TYPE;
	public var format:FMOD_SOUND_FORMAT;
	public var channels:Int;
	public var bits:Int;
}