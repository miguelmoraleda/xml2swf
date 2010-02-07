package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.abcEncoders.AbcEncodeBase;
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class StringEncode extends AbcEncodeBase
	{
		
		public function StringEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			var b2:mmByteArray = new mmByteArray();
			
			b2.writeUTF(String(data));
			b2.position = 2;
			
			b.writeBytes(b2, 2, b2.bytesAvailable);
			b.writeByte(0);
			
			return b;
		}
		
	}
	
}