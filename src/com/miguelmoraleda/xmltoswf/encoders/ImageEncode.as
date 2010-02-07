package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmBinary;
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class ImageEncode extends EncoderBase
	{
		
		public function ImageEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			//trace(mmBinary.dump(data));
			
			for each(var image:Object in data)
			{
				//trace(mmBinary.dump(image));
				var imageEncode:JPEG3Encode = new JPEG3Encode();
				imageEncode.data = image;
				b.writeBytes(imageEncode.binary);
			}
			
			return b;
		}
		
	}
	
}