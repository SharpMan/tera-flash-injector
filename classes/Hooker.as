import classes.Joker;
import classes.Dataprocessor;
import utils.Cipher;
class classes.Hooker {

	public static var CLASS_REF = classes.Hooker;

	private var joker:Joker;

	public function Hooker(joker:Joker) {
		this.joker = joker;
	}

	public function hook_DofusCore() {
		var _this = joker.dofusPackage.DofusCore.getInstance();
		_this.checkNodesAndContinue = function() {
			if (_this.checkNodes()) {
				_this.startGame();
				var $:Joker = _global.joker;
				$.hooker.hook_Network();
			} else {
				_this.addToQueue({object:_this, method:_this.checkNodesAndContinue});
			}// end else if
		};
	}

	public function hook_Network() {
		var _this = joker.dofusPackage.utils.Api.getInstance()._oNetwork;
		_this._xSocket.onClose = function() {
			var $ = _global.joker.dofusPackage.utils.Api.getInstance()._oNetwork;
			_global.joker.onClose();
			$.onClose();
			$.resetKeys();
		};
		_this.processCommand = function(sData) {
			/*var $:Joker = _global.joker;
			var stopExec:Boolean = $.dataprocessor.processPacket_before(sData);
			
			if (!stopExec) {
			this._oDataProcessor.process(sData);
			$.dataprocessor.processPacket_before(sData);
			}*/
			//Note : desactivated to reduce kikoos number
		};
		_this.onDeco = function() {
			if (this._bConnected) {
				this.resetKeys();
				this._xSocket.close();
				this._bConnected = false;
			}
			// end if          
			this.onClose(true,false,false);
		};

		_this.onData = function(sData) {
			var $:Joker = _global.joker;

			sData = $.dataprocessor.readPacket(sData);
			$._main.console.text += "\n"+ sData;
			if (sData == null) {
				return;
			}

			_global.ank.utils.Timer.removeTimer(this.Lag,"lag");

			if (this._bLag) {
				joker.dofusPackage.utils.Api.getInstance().ui.unloadUIComponent("WaitingMessage");
				_global.ank.utils.Timer.removeTimer(this.Deco,"deco");
				this._bLag = false;
			}
			// end if                   
			sData = this.unprepareData(sData);

			if (this._isWaitingForData) {
				this._isWaitingForData = false;
				this.api.ui.unloadUIComponent("Waiting");
				var _loc3 = getTimer()-this._nLastWaitingSend;
				if (_loc3>100) {
				}
				// end if                    
				this._aLastPings.push(_loc3);
				if (this._aLastPings.length>joker.dofusPackage.aks.Aks.EVALUATE_AVERAGE_PING_ON_COMMANDS) {
					this._aLastPings.shift();
				}
				// end if                    
			}
			// end if      

			var stopExec:Boolean = $.dataprocessor.processPacket_before(sData,this._xSocket);
			if (!stopExec) {
				this._oDataProcessor.process(sData);
				$.dataprocessor.processPacket_after(sData);
			}
		};

		_this.send = function(sData, bWaiting, sWaitingMessage, bNoLimit, bNoCyphering) {
			var $:Joker = _global.joker;

			this.api.kernel.GameManager.signalActivity();
			if (bWaiting || bWaiting == undefined) {
				if (sWaitingMessage != undefined) {
					this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:sWaitingMessage},{bAlwaysOnTop:true, bForceLoad:true});
				}
				// end if               
				this._sDebug = sData;
				this.api.ui.loadUIComponent("Waiting","Waiting");
				this._isWaitingForData = true;
				if (this.api.datacenter.Basics.inGame && this._bAutoReco) {
					_global.ank.utils.Timer.setTimer(this.Lag,"lag",this,this.onLag,Number(this.api.lang.getConfigText("DELAY_RECO_MESSAGE")));
				}
				// end if               
			}
			// end if               
			if (!bNoCyphering) {
				sData = this.prepareData(sData);
			}
			// end if               
			sData = $.dataprocessor.writePacket(sData);
			if (sData == null) {
				return;
			}

			if (sData.charAt(sData.length-1) != "\n") {
				sData = sData+"\n";
			}
			// end if               
			this._xSocket.send(sData);
			if (bWaiting || bWaiting == undefined) {
				this._nLastWaitingSend = getTimer();
			}
			// end if               
		};
	}

	public function hook_Others(dApi) {

		dApi.kernel.AdminManager.sendCommand = function (sCommand)
		{
			
		};
	}

}