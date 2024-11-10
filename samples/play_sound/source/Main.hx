package;

import hxfmod.Sound;
import hxfmod.Channel;
import hxfmod.System;
import hxfmod.externs.Types;
import lime.app.Application;
import openfl.utils.Assets;
import sys.FileSystem;

/**
 * The entry point of the application.
 */
class Main extends openfl.display.Sprite
{
	public var system:System;
	public var sound:Sound;
	public var channel:Channel;

	var audioFile:String = 'assets/sound.ogg';

	public function new()
	{
		#if mobile
		Sys.setCwd(lime.system.System.applicationStorageDirectory);
		#end

		#if linux
		openfl.Lib.current.stage.window.setIcon(lime.graphics.Image.fromFile("icon.png"));
		#end

		super();

		Application.current.preloader.onComplete.add(create);
		Application.current.onUpdate.add(onUpdate);
	}

	public function create():Void
	{
		#if mobile
		if (!FileSystem.exists(Sys.getCwd() + audioFile))
		{
			FileSystem.createDirectory(Sys.getCwd() + 'assets');
			sys.io.File.saveBytes(Sys.getCwd() + audioFile, Assets.getBytes(audioFile));
		}
		#end

		system = new System();
		system.init(32, INIT_NORMAL);
		trace('FMod System Version: ' + system.version);

		channel = new Channel();
		sound = system.createSound(Sys.getCwd() + audioFile, FMOD_CREATESAMPLE, new FMOD_CREATESOUNDEXINFO());
		system.playSound(sound, false, channel);

		var logo = new openfl.display.Bitmap(Assets.getBitmapData('assets/FMOD.png'), true);
		logo.x = (stage.window.width - logo.bitmapData.width) / 2;
		logo.y = (stage.window.height - logo.bitmapData.height) / 2;
		addChild(logo);
	}

	public function onUpdate(elapsed:Int)
	{
		if (system != null)
			system.update();
	}
}
