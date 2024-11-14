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
import hxfmod.externs.Constants;
import hxfmod.externs.Types;
import lime.app.Application;
import openfl.utils.Assets;
import haxe.Timer;

/**
 * The entry point of the application.
 */
class Main extends Sprite
{
	public var system:System;
	public var sound:Sound;
	public var channel:Channel;

	var audioFile:String = 'assets/Anamanaguchi.ogg';

	public function new()
	{
		super();

		#if linux
		stage.window.setIcon(lime.graphics.Image.fromFile("icon.png"));
		#end

		#if mobile
		Sys.setCwd(lime.system.System.applicationStorageDirectory);

		#if !android
		if (!FileSystem.exists(audioFile))
		{
			FileSystem.createDirectory(Path.directory(audioFile));
			File.saveBytes(audioFile, Assets.getBytes(audioFile));
		}
		#end
		#end

		var logo = new Bitmap(Assets.getBitmapData('assets/FMOD.png'), true);
		var scale = Math.max(logo.width / stage.window.width, logo.height / stage.window.height);
		logo.scaleX = logo.scaleY = scale;
		logo.x = ((stage.window.width - logo.width) / 2);
		logo.y = (stage.window.height - logo.height) / 2;
		addChild(logo);

		var startTime:Float = Timer.stamp();
		system = new System();
		system.init(32, Constants.INIT_NORMAL);
		trace('FMod System Version: ' + system.version);

		channel = new Channel();
		sound = system.createSound(audioFile, Constants.FMOD_LOOP_NORMAL, FMOD_CREATESOUNDEXINFO.alloc());
		system.playSound(sound, false, channel);

		trace('Took ${Timer.stamp() - startTime} second(s) to load!');

		Application.current.onUpdate.add(onUpdate);
	}

	public function onUpdate(elapsed:Int)
	{
		if (system != null)
			system.update();
	}
}
