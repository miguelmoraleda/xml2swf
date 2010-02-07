package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class ShowFrameEncode extends EncoderBase
	{
		
		public function ShowFrameEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			
			b.writeUI16(0x0040);
			
			return b;
			
		}
		
	}
	
}