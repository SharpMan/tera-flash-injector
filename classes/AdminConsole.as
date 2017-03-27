import classes.Joker;
class classes.AdminConsole {

	public static var CLASS_REF = classes.AdminConsole;

	// Constants:
	// Public Properties:
	// Private Properties:
	private var joker:Joker;

	// Initialization:
	public function AdminConsole(joker:Joker) {
		this.joker = joker;
	}

	public function processCommand_before(sPacket:String):Boolean {
		return (false);
	}

	public function processCommand_after(sPacket:String):Void {

	}

	// Public Methods:
	// Protected Methods:
}