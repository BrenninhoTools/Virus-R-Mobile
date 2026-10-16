package mobile;

import flixel.FlxG;
import flixel.FlxSprite;

class MobileButton extends FlxSprite
{
	public var justPressed(get, never):Bool;
	public var pressed(get, never):Bool;

	public function new(x:Float, y:Float, image:String, prefix:String, size:Float = 1)
	{
		super(x, y);

		frames = Paths.getSparrowAtlas('mobile/' + image, 'shared');
		animation.addByIndices('idle', prefix, [0], '', 24, false);
		animation.addByPrefix('press', prefix, 24, false);
		animation.play('idle');

		scale.set(size, size);
		updateHitbox();
		scrollFactor.set();
		antialiasing = FlxG.save.data.antialiasing;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (visible && justPressed)
			animation.play('press', true);
	}

	override function destroy()
	{
		if (TouchUtil.backButton == this)
			TouchUtil.backButton = null;
		super.destroy();
	}

	function get_justPressed():Bool
		return visible && TouchUtil.justPressedOn(this);

	function get_pressed():Bool
		return visible && TouchUtil.pressedOn(this);
}
