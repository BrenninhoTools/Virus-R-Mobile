package;

class NGio
{
	public static var isLoggedIn:Bool = false;
	public static var scoreboardsLoaded:Bool = false;
	public static var GAME_VER:String = "";
	public static var GAME_VER_NUMS:String = '';
	public static var gotOnlineVer:Bool = false;

	public static function noLogin(api:String) {}

	public function new(api:String, encKey:String, ?sessionId:String) {}

	public static function postScore(score:Int = 0, song:String) {}

	public static function logEvent(event:String) {}

	public static function unlockMedal(id:Int) {}
}
