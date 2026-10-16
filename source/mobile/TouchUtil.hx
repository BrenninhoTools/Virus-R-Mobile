package mobile;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
#if FLX_TOUCH
import flixel.input.touch.FlxTouch;
#end

class TouchUtil
{
	public static inline var SWIPE_DISTANCE:Float = 70;
	public static inline var TAP_DISTANCE:Float = 30;

	public static var backButton:MobileButton;

	public static var menuInput(get, never):Bool;
	public static var swipeUp(get, never):Bool;
	public static var swipeDown(get, never):Bool;
	public static var swipeLeft(get, never):Bool;
	public static var swipeRight(get, never):Bool;
	public static var tapped(get, never):Bool;
	public static var backPressed(get, never):Bool;
	public static var androidBack(get, never):Bool;

	static function get_menuInput():Bool
	{
		var state = FlxG.state;
		if (state == null)
			return false;
		if (Std.isOfType(state, PlayState))
			return state.subState != null;
		return true;
	}

	static function get_swipeUp():Bool
		return swipe(-135, -45);

	static function get_swipeDown():Bool
		return swipe(45, 135);

	static function get_swipeLeft():Bool
		return swipe(135, -135);

	static function get_swipeRight():Bool
		return swipe(-45, 45);

	static function swipe(minAngle:Float, maxAngle:Float):Bool
	{
		#if FLX_TOUCH
		for (data in FlxG.swipes)
		{
			if (data.ID < 0 || data.distance < SWIPE_DISTANCE)
				continue;

			var angle = data.degrees;
			var inside = minAngle <= maxAngle ? (angle >= minAngle && angle < maxAngle) : (angle >= minAngle || angle < maxAngle);
			if (inside)
				return true;
		}
		#end
		return false;
	}

	static function get_tapped():Bool
	{
		#if FLX_TOUCH
		for (touch in FlxG.touches.justReleased())
			if (isTap(touch))
				return true;
		#end
		return false;
	}

	static function get_androidBack():Bool
	{
		#if android
		return FlxG.android.justReleased.BACK;
		#else
		return false;
		#end
	}

	static function get_backPressed():Bool
	{
		if (androidBack)
			return true;
		return backButton != null && backButton.exists && backButton.visible && backButton.justPressed;
	}

	public static function tappedOn(object:FlxSprite, padding:Float = 0, ?camera:FlxCamera):Bool
	{
		#if FLX_TOUCH
		for (touch in FlxG.touches.justReleased())
			if (isTap(touch) && touchContains(object, touch, padding, camera))
				return true;
		#end
		return false;
	}

	public static function justPressedOn(object:FlxSprite, padding:Float = 0, ?camera:FlxCamera):Bool
	{
		#if FLX_TOUCH
		for (touch in FlxG.touches.justStarted())
			if (touchContains(object, touch, padding, camera))
				return true;
		#end
		return false;
	}

	public static function pressedOn(object:FlxSprite, padding:Float = 0, ?camera:FlxCamera):Bool
	{
		#if FLX_TOUCH
		for (touch in FlxG.touches.list)
			if (touch.pressed && touchContains(object, touch, padding, camera))
				return true;
		#end
		return false;
	}

	public static function tappedMember<T:FlxSprite>(group:FlxTypedGroup<T>, padding:Float = 10):Int
	{
		if (group == null)
			return -1;

		var camera = group.getCameras()[0];

		for (i in 0...group.members.length)
		{
			var member = group.members[i];
			if (member != null && member.alive && tappedOn(member, padding, camera))
				return i;
		}
		return -1;
	}

	#if FLX_TOUCH
	public static function isTap(touch:FlxTouch):Bool
	{
		var dx = touch.viewX - touch.justPressedPosition.x;
		var dy = touch.viewY - touch.justPressedPosition.y;
		return Math.sqrt(dx * dx + dy * dy) <= TAP_DISTANCE;
	}

	public static function touchContains(object:FlxSprite, touch:FlxTouch, padding:Float = 0, ?camera:FlxCamera):Bool
	{
		if (object == null || !object.exists || !object.visible)
			return false;

		if (camera == null)
			camera = object.getCameras()[0];
		var rect = getBounds(object, camera);
		if (rect == null)
			return false;

		var point = touch.getViewPosition(camera, FlxPoint.get());
		var result = point.x >= rect.x - padding
			&& point.x <= rect.right + padding
			&& point.y >= rect.y - padding
			&& point.y <= rect.bottom + padding;

		point.put();
		rect.put();
		return result;
	}
	#end

	static function getBounds(object:FlxSprite, camera:FlxCamera):FlxRect
	{
		if (Std.isOfType(object, FlxTypedSpriteGroup))
		{
			var group:FlxTypedSpriteGroup<FlxSprite> = cast object;
			var result:FlxRect = null;
			for (member in group.members)
			{
				if (member == null || !member.exists || !member.visible)
					continue;

				var bounds = getBounds(member, camera);
				if (bounds == null)
					continue;

				if (result == null)
					result = bounds;
				else
				{
					result.union(bounds);
					bounds.put();
				}
			}
			return result;
		}

		return object.getScreenBounds(null, camera);
	}
}
