package com.miguelmoraleda.xmltoswf.abcEncoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class AbcStringEncode extends AbcEncodeBase
	{
		
		public function AbcStringEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			var b2:mmByteArray = new mmByteArray();
			
			b2.writeUTF(String(data));
			b2.position = 2;
			
			b.writeU30(b2.bytesAvailable);
			
			b.writeBytes(b2, 2, b2.bytesAvailable);
			
			return b;
		}
	}
	
}