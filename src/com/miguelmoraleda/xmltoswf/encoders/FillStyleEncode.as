package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class FillStyleEncode extends EncoderBase
	{
		protected var _matrix:MatrixEncode;
		
		public function FillStyleEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			
			/**
			 * Write the type of this FileStyle, in the xml the value is 65 that is 0x41 in hex that is the type for bitmaps.
			 */
			b.writeUI8(int(data.bitmapStyle));
			
			b.writeUI16(int(data.bitmapId));
			
			_matrix = new MatrixEncode();
			_matrix.data = data.matrix;
			b.writeBytes(_matrix.binary);
			
			return b;
		}
		
	}
	
}