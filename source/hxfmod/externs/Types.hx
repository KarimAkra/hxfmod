package hxfmod.externs;

import cpp.UInt32;
import cpp.RawPointer;
import cpp.ConstCharStar;
import hxfmod.externs.Constants;
import hxfmod.externs.FMOD_RESULT;

class Types
{
}

@:buildXml('<include name="${haxelib:hxfmod}/project/Build.xml" />')
@:include('fmod.hpp')
@:unreflective
@:structAccess
@:native('FMOD::System')
extern class FMod_System
{
	@:native('System')
	private function new();

	function init(maxchannels:Int, initFlags:FMOD_INITFLAGS, extradriverdata:RawPointer<Int> = null):FMOD_RESULT;
	function close():FMOD_RESULT;
	function release():FMOD_RESULT;
	function update():FMOD_RESULT;

	function setOutput(output:FMOD_OUTPUTTYPE):FMOD_RESULT;
	function getOutput(output:RawPointer<FMOD_OUTPUTTYPE>):FMOD_RESULT;

	function getVersion(version:RawPointer<cpp.UInt32>):FMOD_RESULT;

	function createSound(name_or_data:cpp.ConstCharStar, mode:FMOD_MODE, exinfo:RawPointer<FMOD_CREATESOUNDEXINFO>,
		sound:RawPointer<RawPointer<FMod_Sound>>):FMOD_RESULT;

	function playSound(sound:RawPointer<FMod_Sound>, ChannelGroup:RawPointer<FMod_ChannelGroup>, paused:Bool,
		channel:RawPointer<RawPointer<FMod_Channel>>):FMOD_RESULT;
}

@:buildXml('<include name="${haxelib:hxfmod}/project/Build.xml" />')
@:include('fmod.hpp')
@:unreflective
@:structAccess
@:native('FMOD::Sound')
extern class FMod_Sound
{
	@:native('Sound')
	private function new();

	function release():FMOD_RESULT;

	function getLength(length:RawPointer<UInt32>, lengthtype:FMOD_TIMEUNIT):FMOD_RESULT;

	function getFormat(type:RawPointer<FMOD_SOUND_TYPE>, format:RawPointer<FMOD_SOUND_FORMAT>, channels:RawPointer<Int>, bits:RawPointer<Int>):FMOD_RESULT;

	function getName(name:RawPointer<cpp.Char>, namelen:Int):FMOD_RESULT;

	function getDefaults(frequency:RawPointer<cpp.Float32>, volume:RawPointer<cpp.Float32>):FMOD_RESULT;
	function setDefaults(frequency:cpp.Float32, volume:cpp.Float32):FMOD_RESULT;

	function getNumSubSounds(numsubsounds:RawPointer<Int>):FMOD_RESULT;

	function getSubSound(index:Int, subsound:RawPointer<FMod_Sound>):FMOD_RESULT;

	function setMode(mode:FMOD_MODE):FMOD_RESULT;
	function getMode(mode:RawPointer<FMOD_MODE>):FMOD_RESULT;

	function getLoopPoints(loopstart:RawPointer<cpp.UInt32>, loopstarttype:FMOD_TIMEUNIT, loopend:RawPointer<cpp.UInt32>,
		loopendtype:FMOD_TIMEUNIT):FMOD_RESULT;
	function setLoopPoints(loopstart:cpp.UInt32, loopstarttype:FMOD_TIMEUNIT, loopend:cpp.UInt32, loopendtype:FMOD_TIMEUNIT):FMOD_RESULT;
}

@:buildXml('<include name="${haxelib:hxfmod}/project/Build.xml" />')
@:include('fmod.hpp')
@:unreflective
@:structAccess
@:native('FMOD::Channel')
extern class FMod_Channel extends FMod_ChannelControl
{
	@:native('Channel')
	private function new();

	function setFrequency(frequency:cpp.Float32):FMOD_RESULT;
	function getFrequency(frequency:RawPointer<cpp.Float32>):FMOD_RESULT;

	function setPriority(priority:Int):FMOD_RESULT;
	function getPriority(fpriority:RawPointer<Int>):FMOD_RESULT;

	function setPosition(position:UInt32, postype:FMOD_TIMEUNIT):FMOD_RESULT;
	function getPosition(position:RawPointer<UInt32>, postype:FMOD_TIMEUNIT):FMOD_RESULT;

	// function setChannelGroup(channelgroup:RawPointer<FMod_ChannelGroup>):FMOD_RESULT;
	// function getChannelGroup(channelgroup:RawPointer<RawPointer<FMod_ChannelGroup>>):FMOD_RESULT;
	function setLoopCount(loopcount:Int):FMOD_RESULT;
	function getLoopCount(loopcount:RawPointer<Int>):FMOD_RESULT;

	function setLoopPoints(loopstart:UInt32, loopstarttype:FMOD_TIMEUNIT, loopend:UInt32, loopendtype:FMOD_TIMEUNIT):FMOD_RESULT;
	function getLoopPoints(loopstart:RawPointer<UInt32>, loopstarttype:FMOD_TIMEUNIT, loopend:RawPointer<UInt32>, loopendtype:FMOD_TIMEUNIT):FMOD_RESULT;

	function isVirtual(isvirtual:RawPointer<Bool>):FMOD_RESULT;

	function getCurrentSound(sound:RawPointer<RawPointer<FMod_Sound>>):FMOD_RESULT;

	function getIndex(index:RawPointer<Int>):FMOD_RESULT;
}

@:buildXml('<include name="${haxelib:hxfmod}/project/Build.xml" />')
@:include('fmod.hpp')
@:unreflective
@:structAccess
@:native('FMOD::ChannelGroup')
extern class FMod_ChannelGroup extends FMod_ChannelControl
{
}

@:buildXml('<include name="${haxelib:hxfmod}/project/Build.xml" />')
@:include('fmod.hpp')
@:unreflective
@:structAccess
@:native('FMOD::ChannelControl')
extern class FMod_ChannelControl
{
	function setPaused(paused:Bool):FMOD_RESULT;
	function getPaused(paused:RawPointer<Bool>):FMOD_RESULT;

	function setVolume(volume:cpp.Float32):FMOD_RESULT;
	function getVolume(volume:RawPointer<cpp.Float32>):FMOD_RESULT;
}

extern enum abstract FMOD_SOUND_TYPE(FMOD_SOUND_TYPE_Impl)
{
	@:native('FMOD_SOUND_TYPE_UNKNOWN')
	var FMOD_SOUND_TYPE_UNKNOWN;

	@:native('FMOD_SOUND_TYPE_AIFF')
	var FMOD_SOUND_TYPE_AIFF;

	@:native('FMOD_SOUND_TYPE_ASF')
	var FMOD_SOUND_TYPE_ASF;

	@:native('FMOD_SOUND_TYPE_DLS')
	var FMOD_SOUND_TYPE_DLS;

	@:native('FMOD_SOUND_TYPE_FLAC')
	var FMOD_SOUND_TYPE_FLAC;

	@:native('FMOD_SOUND_TYPE_FSB')
	var FMOD_SOUND_TYPE_FSB;

	@:native('FMOD_SOUND_TYPE_IT')
	var FMOD_SOUND_TYPE_IT;

	@:native('FMOD_SOUND_TYPE_MIDI')
	var FMOD_SOUND_TYPE_MIDI;

	@:native('FMOD_SOUND_TYPE_MOD')
	var FMOD_SOUND_TYPE_MOD;

	@:native('FMOD_SOUND_TYPE_MPEG')
	var FMOD_SOUND_TYPE_MPEG;

	@:native('FMOD_SOUND_TYPE_OGGVORBIS')
	var FMOD_SOUND_TYPE_OGGVORBIS;

	@:native('FMOD_SOUND_TYPE_PLAYLIST')
	var FMOD_SOUND_TYPE_PLAYLIST;

	@:native('FMOD_SOUND_TYPE_RAW')
	var FMOD_SOUND_TYPE_RAW;

	@:native('FMOD_SOUND_TYPE_S3M')
	var FMOD_SOUND_TYPE_S3M;

	@:native('FMOD_SOUND_TYPE_USER')
	var FMOD_SOUND_TYPE_USER;

	@:native('FMOD_SOUND_TYPE_WAV')
	var FMOD_SOUND_TYPE_WAV;

	@:native('FMOD_SOUND_TYPE_XM')
	var FMOD_SOUND_TYPE_XM;

	@:native('FMOD_SOUND_TYPE_XMA')
	var FMOD_SOUND_TYPE_XMA;

	@:native('FMOD_SOUND_TYPE_AUDIOQUEUE')
	var FMOD_SOUND_TYPE_AUDIOQUEUE;

	@:native('FMOD_SOUND_TYPE_AT9')
	var FMOD_SOUND_TYPE_AT9;

	@:native('FMOD_SOUND_TYPE_VORBIS')
	var FMOD_SOUND_TYPE_VORBIS;

	@:native('FMOD_SOUND_TYPE_MEDIA_FOUNDATION')
	var FMOD_SOUND_TYPE_MEDIA_FOUNDATION;

	@:native('FMOD_SOUND_TYPE_MEDIACODEC')
	var FMOD_SOUND_TYPE_MEDIACODEC;

	@:native('FMOD_SOUND_TYPE_FADPCM')
	var FMOD_SOUND_TYPE_FADPCM;

	@:native('FMOD_SOUND_TYPE_OPUS')
	var FMOD_SOUND_TYPE_OPUS;

	@:native('FMOD_SOUND_TYPE_MAX')
	var FMOD_SOUND_TYPE_MAX;

	@:from
	static public inline function fromInt(i:Int):FMOD_SOUND_TYPE
		return cast i;

	@:to
	extern public inline function toInt():Int
		return untyped this;
}

extern enum abstract FMOD_SOUND_FORMAT(FMOD_SOUND_FORMAT_Impl)
{
	@:native('FMOD_SOUND_FORMAT_NONE')
	var FMOD_SOUND_FORMAT_NONE;

	@:native('FMOD_SOUND_FORMAT_PCM8')
	var FMOD_SOUND_FORMAT_PCM8;

	@:native('FMOD_SOUND_FORMAT_PCM16')
	var FMOD_SOUND_FORMAT_PCM16;

	@:native('FMOD_SOUND_FORMAT_PCM24')
	var FMOD_SOUND_FORMAT_PCM24;

	@:native('FMOD_SOUND_FORMAT_PCM32')
	var FMOD_SOUND_FORMAT_PCM32;

	@:native('FMOD_SOUND_FORMAT_PCMFLOAT')
	var FMOD_SOUND_FORMAT_PCMFLOAT;

	@:native('FMOD_SOUND_FORMAT_BITSTREAM')
	var FMOD_SOUND_FORMAT_BITSTREAM;

	@:native('FMOD_SOUND_FORMAT_MAX')
	var FMOD_SOUND_FORMAT_MAX;

	@:from
	static public inline function fromInt(i:Int):FMOD_SOUND_FORMAT
		return cast i;

	@:to
	extern public inline function toInt():Int
		return untyped this;
}

extern enum abstract FMOD_CHANNELORDER(FMOD_CHANNELORDER_Impl)
{
	@:native('FMOD_CHANNELORDER_DEFAULT')
	var FMOD_CHANNELORDER_DEFAULT;

	@:native('FMOD_CHANNELORDER_WAVEFORMAT')
	var FMOD_CHANNELORDER_WAVEFORMAT;

	@:native('FMOD_CHANNELORDER_PROTOOLS')
	var FMOD_CHANNELORDER_PROTOOLS;

	@:native('FMOD_CHANNELORDER_ALLMONO')
	var FMOD_CHANNELORDER_ALLMONO;

	@:native('FMOD_CHANNELORDER_ALLSTEREO')
	var FMOD_CHANNELORDER_ALLSTEREO;

	@:native('FMOD_CHANNELORDER_ALSA')
	var FMOD_CHANNELORDER_ALSA;

	@:native('FMOD_CHANNELORDER_MAX')
	var FMOD_CHANNELORDER_MAX;

	@:from
	static public inline function fromInt(i:Int):FMOD_CHANNELORDER
		return cast i;

	@:to
	extern public inline function toInt():Int
		return untyped this;
}

extern enum abstract FMOD_OUTPUTTYPE(FMOD_OUTPUTTYPE_Impl)
{
	@:native('FMOD_OUTPUTTYPE_AUTODETECT')
	var FMOD_OUTPUTTYPE_AUTODETECT;

	@:native('FMOD_OUTPUTTYPE_UNKNOWN')
	var FMOD_OUTPUTTYPE_UNKNOWN;

	@:native('FMOD_OUTPUTTYPE_NOSOUND')
	var FMOD_OUTPUTTYPE_NOSOUND;

	@:native('FMOD_OUTPUTTYPE_WAVWRITER')
	var FMOD_OUTPUTTYPE_WAVWRITER;

	@:native('FMOD_OUTPUTTYPE_NOSOUND_NRT')
	var FMOD_OUTPUTTYPE_NOSOUND_NRT;

	@:native('FMOD_OUTPUTTYPE_WAVWRITER_NRT')
	var FMOD_OUTPUTTYPE_WAVWRITER_NRT;

	@:native('FMOD_OUTPUTTYPE_WASAPI')
	var FMOD_OUTPUTTYPE_WASAPI;

	@:native('FMOD_OUTPUTTYPE_ASIO')
	var FMOD_OUTPUTTYPE_ASIO;

	@:native('FMOD_OUTPUTTYPE_PULSEAUDIO')
	var FMOD_OUTPUTTYPE_PULSEAUDIO;

	@:native('FMOD_OUTPUTTYPE_ALSA')
	var FMOD_OUTPUTTYPE_ALSA;

	@:native('FMOD_OUTPUTTYPE_COREAUDIO')
	var FMOD_OUTPUTTYPE_COREAUDIO;

	@:native('FMOD_OUTPUTTYPE_AUDIOTRACK')
	var FMOD_OUTPUTTYPE_AUDIOTRACK;

	@:native('FMOD_OUTPUTTYPE_OPENSL')
	var FMOD_OUTPUTTYPE_OPENSL;

	@:native('FMOD_OUTPUTTYPE_AUDIOOUT')
	var FMOD_OUTPUTTYPE_AUDIOOUT;

	@:native('FMOD_OUTPUTTYPE_AUDIO3D')
	var FMOD_OUTPUTTYPE_AUDIO3D;

	@:native('FMOD_OUTPUTTYPE_WEBAUDIO')
	var FMOD_OUTPUTTYPE_WEBAUDIO;

	@:native('FMOD_OUTPUTTYPE_NNAUDIO')
	var FMOD_OUTPUTTYPE_NNAUDIO;

	@:native('FMOD_OUTPUTTYPE_WINSONIC')
	var FMOD_OUTPUTTYPE_WINSONIC;

	@:native('FMOD_OUTPUTTYPE_AAUDIO')
	var FMOD_OUTPUTTYPE_AAUDIO;

	@:native('FMOD_OUTPUTTYPE_AUDIOWORKLET')
	var FMOD_OUTPUTTYPE_AUDIOWORKLET;

	@:native('FMOD_OUTPUTTYPE_PHASE')
	var FMOD_OUTPUTTYPE_PHASE;

	@:native('FMOD_OUTPUTTYPE_OHAUDIO')
	var FMOD_OUTPUTTYPE_OHAUDIO;

	@:native('FMOD_OUTPUTTYPE_MAX')
	var FMOD_OUTPUTTYPE_MAX;

	@:from
	static public inline function fromInt(i:Int):FMOD_OUTPUTTYPE
		return cast i;

	@:to
	extern public inline function toInt():Int
		return untyped this;
}

@:buildXml('<include name="${haxelib:hxfmod}/project/Build.xml" />')
@:include('fmod_common.h')
@:native('FMOD_SOUND_TYPE')
private extern class FMOD_SOUND_TYPE_Impl
{
}

@:buildXml('<include name="${haxelib:hxfmod}/project/Build.xml" />')
@:include('fmod_common.h')
@:native('FMOD_SOUND_FORMAT')
private extern class FMOD_SOUND_FORMAT_Impl
{
}

@:buildXml('<include name="${haxelib:hxfmod}/project/Build.xml" />')
@:include('fmod_common.h')
@:native('FMOD_CHANNELORDER')
private extern class FMOD_CHANNELORDER_Impl
{
}

@:buildXml('<include name="${haxelib:hxfmod}/project/Build.xml" />')
@:include('fmod_common.h')
@:native('FMOD_OUTPUTTYPE')
private extern class FMOD_OUTPUTTYPE_Impl
{
}

@:buildXml('<include name="${haxelib:hxfmod}/project/Build.xml" />')
@:include('fmod_common.h')
@:unreflective
@:structAccess
@:native('FMOD_CREATESOUNDEXINFO')
extern class FMOD_CREATESOUNDEXINFO
{
	@:native('FMOD_CREATESOUNDEXINFO')
	private function new();

	public static inline function alloc():FMOD_CREATESOUNDEXINFO
	{
		var exInfo:cpp.Star<FMOD_CREATESOUNDEXINFO> = new FMOD_CREATESOUNDEXINFO();
		exInfo.cbsize = cpp.Native.sizeof(FMOD_CREATESOUNDEXINFO);
		return exInfo;
	}

	var cbsize:Int;
	var length:cpp.UInt32;
	var fileoffset:cpp.UInt32;
	var numchannels:Int;
	var defaultfrequency:Int;
	var format:FMOD_SOUND_FORMAT;
	var decodebuffersize:cpp.UInt32;
	var initialsubsound:Int;
	var numsubsounds:Int;
	var inclusionlist:RawPointer<Int>;
	var inclusionlistnum:Int;
	// var pcmreadcallback:FMOD_SOUND_PCMREAD_CALLBACK;
	// var pcmsetposcallback:FMOD_SOUND_PCMSETPOS_CALLBACK;
	// var nonblockcallback:FMOD_SOUND_NONBLOCK_CALLBACK;
	var dlsname:ConstCharStar;
	var encryptionkey:ConstCharStar;
	var maxpolyphony:Int;
	var userdata:RawPointer<cpp.Void>;
	var suggestedsoundtype:FMOD_SOUND_TYPE;
	// var fileuseropen:FMOD_FILE_OPEN_CALLBACK;
	// var fileuserclose:FMOD_FILE_CLOSE_CALLBACK;
	// var fileuserread:FMOD_FILE_READ_CALLBACK;
	// var fileuserseek:FMOD_FILE_SEEK_CALLBACK;
	// var fileuserasyncread:FMOD_FILE_ASYNCREAD_CALLBACK;
	// var fileuserasynccancel:FMOD_FILE_ASYNCCANCEL_CALLBACK;
	var fileuserdata:RawPointer<cpp.Void>;
	var filebuffersize:Int;
	var channelorder:FMOD_CHANNELORDER;
	// var initialsoundgroup:RawPointer<FMOD_SOUNDGROUP>;
	var initialseekposition:cpp.UInt32;
	var initialseekpostype:FMOD_TIMEUNIT;
	var ignoresetfilesystem:Int;
	var audioqueuepolicy:cpp.UInt32;
	var minmidigranularity:cpp.UInt32;
	var nonblockthreadid:Int;
	// var fsbguid:FMOD_GUID;
}
