package mobile;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import openfl.display.BitmapData;
import openfl.display.GradientType;
import openfl.display.Shape;
import openfl.geom.Matrix;

class Hitbox extends FlxSpriteGroup
{
	static final COLORS:Array<FlxColor> = [0xFFC24B99, 0xFF00FFFF, 0xFF12FA05, 0xFFF9393F];
	static inline var IDLE_ALPHA:Float = 0.1;
	static inline var PRESSED_ALPHA:Float = 0.6;

	public var hints:Array<FlxSprite> = [];
	public var pressed:Array<Bool> = [false, false, false, false];
	public var onPress:Int->Void;
	public var onRelease:Int->Void;
	public var ignore:FlxSprite;

	public function new()
	{
		super();

		var hintWidth = Std.int(FlxG.width / 4);
		for (i in 0...4)
		{
			var hint = new FlxSprite(hintWidth * i, 0);
			hint.loadGraphic(createGraphic(hintWidth, FlxG.height, COLORS[i]));
			hint.alpha = IDLE_ALPHA;
			hint.antialiasing = false;
			hints.push(hint);
			add(hint);
		}

		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		for (i in 0...hints.length)
		{
			var held = visible && isHeld(hints[i]);

			if (held && !pressed[i])
			{
				pressed[i] = true;
				if (onPress != null)
					onPress(i);
			}
			else if (!held && pressed[i])
			{
				pressed[i] = false;
				if (onRelease != null)
					onRelease(i);
			}

			hints[i].alpha = pressed[i] ? PRESSED_ALPHA : IDLE_ALPHA;
		}
	}

	public function releaseAll()
	{
		for (i in 0...pressed.length)
		{
			if (pressed[i])
			{
				pressed[i] = false;
				if (onRelease != null)
					onRelease(i);
			}
			hints[i].alpha = IDLE_ALPHA;
		}
	}

	function isHeld(hint:FlxSprite):Bool
	{
		#if FLX_TOUCH
		for (touch in FlxG.touches.list)
		{
			if (!touch.pressed)
				continue;
			if (ignore != null && ignore.visible && TouchUtil.touchContains(ignore, touch))
				continue;
			if (TouchUtil.touchContains(hint, touch))
				return true;
		}
		#end
		return false;
	}

	function createGraphic(width:Int, height:Int, color:FlxColor):BitmapData
	{
		var rgb:Int = color.rgb;
		var matrix = new Matrix();
		matrix.createGradientBox(width, height, 0, 0, 0);

		var shape = new Shape();
		shape.graphics.beginGradientFill(GradientType.LINEAR, [rgb, rgb, rgb], [1, 0, 1], [0, 128, 255], matrix);
		shape.graphics.drawRect(0, 0, width, height);
		shape.graphics.endFill();
		shape.graphics.lineStyle(4, rgb, 1);
		shape.graphics.drawRect(2, 2, width - 4, height - 4);

		var bitmap = new BitmapData(width, height, true, 0);
		bitmap.draw(shape);
		return bitmap;
	}
}
