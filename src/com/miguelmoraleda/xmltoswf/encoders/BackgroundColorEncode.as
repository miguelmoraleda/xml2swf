package com.miguelmoraleda.xmltoswf.encoders
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	public class BackgroundColorEncode extends TagEncode
	{
		
		public function BackgroundColorEncode()
		{
			super();
			_code = 9;
		}
		
		override protected function encodeBody():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			b.writeBits(int(data), 3);
			return b;
		}
	}
}