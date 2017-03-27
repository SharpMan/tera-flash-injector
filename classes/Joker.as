import classes.Hooker;
import classes.Utils;
import classes.Constants;
import classes.Dataprocessor;
import classes.AdminConsole;
import mx.controls.Label;

class classes.Joker
{


	// Constants:
	public static var CLASS_REF = classes.Joker;

	public var _main;

	//Dofus access stocked vars
	public var dofusLoader;
	public var dofusPackage;

	// Initialization:
	public function Joker(Main,oLoader,pDofus)
	{
		_global.joker = this;
		this._main = Main;
		this.dofusLoader = oLoader;
		this.dofusPackage = pDofus;
		this.registerClasses();
		hooker.hook_DofusCore();
		this._main.console += "\n" + "Joker created!";
	}

	public var hooker:Hooker;
	public var utils:Utils;
	public var constants:Constants;
	public var dataprocessor:Dataprocessor;
	public var adminConsole:AdminConsole;
	public var packetLabel;

	private function registerClasses():Void
	{
		this.hooker = new Hooker(this);
		this.utils = new Utils(this);
		this.dataprocessor = new Dataprocessor(this);
		this.constants = new Constants(this);
		this.adminConsole = new AdminConsole(this);
	}

	public function initAndLoginFinished(dApi):Void
	{
		this._main.console.text += "\n" + "InitAndLoginFinished()!";
		//hooker.hook_Others(dApi);
	}

	public function onClose():Void
	{
	}

	public function getAPI()
	{
		return this.dofusPackage.utils.Api.getInstance();
	}


}