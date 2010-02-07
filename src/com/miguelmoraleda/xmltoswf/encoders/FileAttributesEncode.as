package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmBinary;
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class FileAttributesEncode extends TagEncode
	{
		
		public function FileAttributesEncode() 
		{
			super();
			_code = 69;
		}
		
		override protected function encodeBody():ByteArray 
		{
			var b:mmByteArray = new mmByteArray();
			var offsetBits:int = 0;
			
			b.encodeByte(0, 1, 0, offsetBits++);
			
			b.encodeByte(0, 1, (data.HWAceleration == "true") ? 1 : 0, offsetBits++);
			
			b.encodeByte(0, 1, (data.UseGPU == "true") ? 1 : 0, offsetBits++);
			
			b.encodeByte(0, 1, (data.HasMetadata == "true") ? 1 : 0, offsetBits++);
			
			b.encodeByte(0, 1, (data.AS3 == "true") ? 1 : 0, offsetBits++);
			
			b.encodeByte(0, 1, 0, offsetBits++);
			b.encodeByte(0, 1, 0, offsetBits++);
			
			b.encodeByte(0, 1, (data.UseNetwork == "true") ? 1 : 0, offsetBits++);
			
			b.writeByte(0);
			b.writeByte(0);
			b.writeByte(0);
			
			//trace(mmBinary.dump(data));
			
			return b;
		}
		
	}
	
}