package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import com.adobe.images.JPGEncoder;
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class JPEG3Encode extends TagEncode
	{
		
		public function JPEG3Encode() 
		{
			super();
			_code = 35;
		}
		
		override protected function encodeBody():ByteArray 
		{
			var b:mmByteArray = new mmByteArray();
			
			//Write de id of the image
			b.writeUI16(int(data.id));
			
			var image:Bitmap = Bitmap(data.image);
			//trace(image);
			
			var encoder:JPGEncoder = new JPGEncoder(Number(data.jpgQuality));
			
			var imageJpg:ByteArray = encoder.encode(image.bitmapData);
			
			b.writeUI32(imageJpg.length);
			
			b.writeBytes(imageJpg);
			
			var compresedData:mmByteArray = new mmByteArray();
			
			for (var k:int = 0; k < image.height; k++ )
			{
				for (var j:int = 0; j < image.width; j++ )
				{
					var color:uint = image.bitmapData.getPixel32(j, k);
					
					compresedData.writeByte((color & 0xFF000000) >> 24);
				}
			}
			
			compresedData.compress(CompressionAlgorithm.ZLIB);
			b.writeBytes(compresedData);
			
			return b;
		}
		
	}
	
}