class utils.Base64
{
	public static var CLASS_REF = utils.Base64;
	/**
	* Variables
	* @exclude
	*/
	private static var base64chars:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

	/**
	* Encodes a base64 string.
	*/
	public static function encode(src:String):String {
		var i:Number = 0;
		var output:String = new String("");
		var chr1:Number, chr2:Number, chr3:Number;
		var enc1:Number, enc2:Number, enc3:Number, enc4:Number;
		while (i < src.length) {
			chr1 = src.charCodeAt(i++);
			chr2 = src.charCodeAt(i++);
			chr3 = src.charCodeAt(i++);
			enc1 = chr1 >> 2;
			enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
			enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
			enc4 = chr3 & 63;
			if(isNaN(chr2)) enc3 = enc4 = 64;
			else if(isNaN(chr3)) enc4 = 64;
			output += base64chars.charAt(enc1)+base64chars.charAt(enc2);
			output += base64chars.charAt(enc3)+base64chars.charAt(enc4)
		}
		return output;
	}

	/**
	* Decodes a base64 string.
	*/
	public static function decode(src:String):String {
		var i:Number = 0;
		var output:String = new String("");
		var chr1:Number, chr2:Number, chr3:Number;
		var enc1:Number, enc2:Number, enc3:Number, enc4:Number;
		while (i < src.length) {
			enc1 = base64chars.indexOf(src.charAt(i++));
			enc2 = base64chars.indexOf(src.charAt(i++));
			enc3 = base64chars.indexOf(src.charAt(i++));
			enc4 = base64chars.indexOf(src.charAt(i++));
			chr1 = (enc1 << 2) | (enc2 >> 4);
			chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
			chr3 = ((enc3 & 3) << 6) | enc4;
			output += String.fromCharCode(chr1);
			if (enc3 != 64) output = output+String.fromCharCode(chr2);
			if (enc4 != 64) output = output+String.fromCharCode(chr3);
		}
		return output;
	}

	public static function decodeBinary(src:String):Array {
		var i:Number = 0;
		var output:Array = new Array();
		var chr1:Number, chr2:Number, chr3:Number;
		var enc1:Number, enc2:Number, enc3:Number, enc4:Number;
		var k:Number = 0;
		while (i < src.length) {
			enc1 = base64chars.indexOf(src.charAt(i++));
			enc2 = base64chars.indexOf(src.charAt(i++));
			enc3 = base64chars.indexOf(src.charAt(i++));
			enc4 = base64chars.indexOf(src.charAt(i++));
			chr1 = (enc1 << 2) | (enc2 >> 4);
			chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
			chr3 = ((enc3 & 3) << 6) | enc4;
			output[k++] = chr1;
			if (enc3 != 64) output[k++] = chr2;
			if (enc4 != 64) output[k++] = chr3;
		}
		return output;
	}
}