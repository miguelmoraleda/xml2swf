package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class LineStyleArrayEncode extends EncoderBase
	{
		
		public function LineStyleArrayEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			
			b.writeByte(0);
			
			return b;
		}
		
	}
	
}