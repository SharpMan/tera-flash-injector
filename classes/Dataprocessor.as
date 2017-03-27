import classes.Joker;
import utils.Base64;
import utils.Cipher;
class classes.Dataprocessor {

	public static var CLASS_REF = classes.Dataprocessor;

	private var joker:Joker;

	private var PRIVATE_KEY:String = "²mIl/Jx;4FGKSF^I6!p/K²5/I?²:oA?sC6Cd#g6dsh-Iyr-QR£-Péa+PnR#0W+JGAtp,V!Dl0jèT§M3pfmII²uh?yg+iHchO6l,P;µNRg--T.v9éJz-c:£Y@%SSB,Xµ9";

	private var DECRYPT_KEY:String = null;

	public function Dataprocessor(joker:Joker) {
		this.joker = joker;
	}

	public function writePacket(sData:String):String {
		if (this.DECRYPT_KEY != null) {
			return Cipher.write(sData, this.DECRYPT_KEY);
		} else {
			return null;
		}
	}

	public function readPacket(sData:String):String {
		//joker.packetLabel.Text = joker.packetLabel + \n  + sData;
		if ((sData.substr(0, 2) == "JK") && (sData.substr(2).length == 32)) {
			this.useSerial(sData.substr(2));
			return null;
		} else if (this.DECRYPT_KEY != null) {
			return Cipher.read(sData, this.DECRYPT_KEY);
		}	
	}

	public function processPacket_before(sPacket:String,xSocket:Object):Boolean {
		if (sPacket.charAt(0) == "@") {
			var packet = sPacket.substr(1);
			var packet_type = packet.charAt(0);
			var packet_subType = packet.charAt(1);
			var packet_isError = packet.charAt(2) == "E";

			switch (packet_type) {
				case "S" ://System
					{
						switch (packet_subType) {
							case "R" ://Reboot
								{
									joker._main.api().kernel.reboot();
									break;
								};
							case "C" ://ClearCache
								{
									joker._main.api().kernel.clearCache();
									break;
								};
							case "Q" ://Quit
								{
									joker._main.api().kernel.quit(false);
									break;
							}
						};
						break;
				}

			};
			return (true);
		}
		if(sPacket.substr(0,2) == "GE"){
			var packet = "FRGE";
			        
			packet = writePacket(packet);
			
			if (packet == null) {
				return;
			}

			/*if (packet.charAt(packet.length-1) != "\n") {
				packet = packet+"\n";
			}*/
			xSocket.send(packet, false, "", false, false);
			
			
		}
		return (false);
	}
	

	public function processPacket_after(sPacket:String):Void {

	}

	private function useSerial(PUBLIC_KEY:String):Void {
		this.DECRYPT_KEY = Base64.encode(Cipher.write(PUBLIC_KEY, this.PRIVATE_KEY));
	}


}