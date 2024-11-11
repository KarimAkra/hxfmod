package;

import openfl.utils.Assets;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import lime.app.Application;
import sys.FileSystem;
import sys.io.File;
import haxe.io.Path;
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
class Main extends Sprite
{
	public var system:System;
	public var sound:Sound;
	public var channel:Channel;

	var audioFile:String = 'assets/Anamanaguchi.mp3';

	public function new()
	{
		super();

		#if linux
		openfl.Lib.current.stage.window.setIcon(lime.graphics.Image.fromFile("icon.png"));
		#end

		#if mobile
		Sys.setCwd(lime.system.System.applicationStorageDirectory);

		if (!FileSystem.exists(Sys.getCwd() + audioFile))
		{
			FileSystem.createDirectory(Sys.getCwd() + Path.directory(audioFile));
			sys.io.File.saveBytes(Sys.getCwd() + audioFile, Assets.getBytes(audioFile));
		}
		#end

		system = new System();
		system.init(32, INIT_NORMAL);
		trace('FMod System Version: ' + system.version);

		channel = new Channel();
		sound = system.createSound(Sys.getCwd() + audioFile, FMOD_CREATESAMPLE, new FMOD_CREATESOUNDEXINFO());
		system.playSound(sound, false, channel);

		var logo = new Bitmap(Assets.getBitmapData('assets/FMOD.png'), true);
		var scale = Math.max(logo.bitmapData.width / stage.window.width, logo.bitmapData.height / stage.window.height);
		logo.scaleX = logo.scaleY = scale;
		logo.x = ((stage.window.width - logo.bitmapData.width) / 2) * 2;
		logo.y = (stage.window.height - logo.bitmapData.height) / 2;
		addChild(logo);

		Application.current.onUpdate.add(onUpdate);
	}

	public function onUpdate(elapsed:Int)
	{
		if (system != null)
			system.update();
	}
}
