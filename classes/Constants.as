import classes.Joker;
class classes.Constants {

	public static var CLASS_REF = classes.Constants;

	public var DEBUG:Boolean = false;
	public var DOFUS_VERSION:String = "1.29.2";

	private var joker:Joker;

	public function Constants(joker) {
		this.joker = joker;
		this.applyConstants();
	}

	public function applyConstants():Void {
		var dofus = joker.dofusPackage;

		dofus.Constants.VERSION = parseInt(DOFUS_VERSION.split(".")[0]);
		dofus.Constants.SUBVERSION = parseInt(DOFUS_VERSION.split(".")[1]);
		dofus.Constants.SUBSUBVERSION = parseInt(DOFUS_VERSION.split(".")[2]);
	}
}