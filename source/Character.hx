package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = FlxG.save.data.antialiasing;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('GF_assets','shared',true);
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');

			case 'gf-tv-r':
				tex = Paths.getSparrowAtlas('GF_assets_TV','shared',true);
				frames = tex;
				animation.addByIndices('sad', 'gf sad_r', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat_r', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat_r', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');

			case 'gf-tv-ace':
				tex = Paths.getSparrowAtlas('GF_assets_TV','shared',true);
				frames = tex;
				animation.addByIndices('sad', 'gf sad_ace', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat_ace', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat_ace', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');

			case 'r':
				tex = Paths.getSparrowAtlas('R_Sprites','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'R idle dance', 24, false);
				animation.addByPrefix('singUP', 'R note up', 24, false);
				animation.addByPrefix('singRIGHT', 'R note right', 24, false);
				animation.addByPrefix('singDOWN', 'R note down', 24, false);
				animation.addByPrefix('singLEFT', 'R note left', 24, false);
				animation.addByPrefix('angry', 'R angry', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');

			case 'r3':
				tex = Paths.getSparrowAtlas('r3o','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'r3 idle', 24, false);
				animation.addByPrefix('singUP', 'r3 up', 24, false);
				animation.addByPrefix('singRIGHT', 'r3 right', 24, false);
				animation.addByPrefix('singDOWN', 'r3 down', 24, false);
				animation.addByPrefix('singLEFT', 'r3 left', 24, false);
				animation.addByPrefix('singUPSus', 'r3 up0003', 24, false);
				animation.addByPrefix('singRIGHTSus', 'r3 right0003', 24, false);
				animation.addByPrefix('singDOWNSus', 'r3 down0003', 24, false);
				animation.addByPrefix('singLEFTSus', 'r3 left0003', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');

			case 'acesora':
				tex = Paths.getSparrowAtlas('ask','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'AceIdle', 24, false);
				animation.addByPrefix('singUP', 'Aceup0', 24, false);
				animation.addByPrefix('singRIGHT', 'Aceright0', 24, false);
				animation.addByPrefix('singDOWN', 'Acedown0', 24, false);
				animation.addByPrefix('singLEFT', 'Aceleft0', 24, false);

				animation.addByPrefix('singUP-alt', 'Aceup2', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Aceright2', 24, false);
				animation.addByPrefix('singDOWN-alt', 'Acedown2', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Aceleft2', 24, false);

				animation.addByPrefix('smile', 'Acesmile', 24, false);

				setGraphicSize(Std.int(width * 0.8));
				updateHitbox();

				loadOffsetFile(curCharacter);

				playAnim('idle');

			case 'r-window':
				tex = Paths.getSparrowAtlas('Rweek2','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'Ridle', 24, false);
				animation.addByPrefix('singUP', 'Rup', 24, false);
				animation.addByPrefix('singRIGHT', 'Rright', 24, false);
				animation.addByPrefix('singDOWN', 'Rdown', 24, false);
				animation.addByPrefix('singLEFT', 'Rleft', 24, false);

				animation.addByPrefix('singUPSus', 'Rup0005', 24, false);
				animation.addByPrefix('singRIGHTSus', 'Rright0005', 24, false);
				animation.addByPrefix('singDOWNSus', 'Rdown0005', 24, false);
				animation.addByPrefix('singLEFTSus', 'Rleft0005', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');

			case 'bf':
				tex = Paths.getSparrowAtlas('BOYFRIEND','shared',true);
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, false);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				loadOffsetFile(curCharacter);

				playAnim('idle');

				flipX = true;
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	public function loadOffsetFile(character:String, library:String = 'shared')
	{
		var offset:Array<String> = CoolUtil.coolTextFile(Paths.txt('images/characters/' + character + "Offsets", library));

		for (i in 0...offset.length)
		{
			var data:Array<String> = offset[i].split(' ');
			addOffset(data[0], Std.parseInt(data[1]), Std.parseInt(data[2]));
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				trace('dance');
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance(forced:Bool = false, altAnim:Bool = false)
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf' | 'gf-tv-r' | 'gf-tv-ace':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'r':
					if (animation.curAnim.name != 'angry')
						playAnim('idle', forced);
				case 'acesora':
					if (animation.curAnim.name != 'smile')
						playAnim('idle', forced);
				default:
					if (altAnim && animation.getByName('idle-alt') != null)
						playAnim('idle-alt', forced);
					else
						playAnim('idle', forced);
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{

		if (AnimName.endsWith('alt') && animation.getByName(AnimName) == null)
		{
			#if debug
			FlxG.log.warn(['Such alt animation doesnt exist: ' + AnimName]);
			#end
			AnimName = AnimName.split('-')[0];
		}

		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
