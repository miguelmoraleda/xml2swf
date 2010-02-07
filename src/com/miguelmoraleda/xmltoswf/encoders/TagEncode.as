package com.miguelmoraleda.xmltoswf.encoders
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	public class TagEncode extends EncoderBase
	{
		protected var _code:int = 0;
		
		
		public function TagEncode()
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b2:ByteArray = encodeBody();
			var header:int;
			var l:int;
			
			header = _code << 6;
			var b:mmByteArray = new mmByteArray();
			l = b2.length;
			
			//trace("TagEncode: code: " + _code + " lenght: " + l + " header: " + header);
			if (l > 62) {
				header += 63;
				b.writeUI16(header);
				
				b.writeUI32(l);
			} else {
				header += l;
				b.writeUI16(header);
				//trace("HEADER: " + header);
			}
			
			b.writeBytes(b2);
			
			if (!(data is String) && data.showFrame != null && data.showFrame == "true") b.writeUI16(0x0040);
			
			return b;
		}
		
		protected function encodeBody():ByteArray
		{
			//trace("en tagencode");
			return new ByteArray();
		}
	}
}