package com.miguelmoraleda.xmltoswf.encoders
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	public class HeaderEncode extends EncoderBase
	{
		protected var _dimensionRect:RectangleEncode;
		
		protected var _lenghtPosition:int;
		
		public function HeaderEncode()
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			
			/**
			 * Write FWS. The first thing that we need to create a swf.
			 */
			b.writeBits(0x465753, 3);
			//Write version
			b.writeByte(data.version);
			
			/**
			 * Save 4 bits for the lenght of the complete file
			 */
			 b.writeBits(0, 4);
			
			/**
			 * Write a new rectangle for the dimension of the file
			 */
			_dimensionRect = new RectangleEncode();
			_dimensionRect.data = data.rectangle;
			b.writeBytes(_dimensionRect.binary);
			
			/**
			 * Write the framerate
			 */
			b.writeFixed8(Number(data.framerate));
			//Write total frames
			b.writeUI16(data.totalFrame);
			
			return b;
		}
	}
}