package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class ShapeWithStyleEncode extends EncoderBase
	{
		private var _fillStyleList:FillStyleArrayEncode;
		private var _lineStyleList:LineStyleArrayEncode;
		private var _shapeRecord:ShapeRecordEncode;
		
		public function ShapeWithStyleEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			
			_fillStyleList = new FillStyleArrayEncode();
			_fillStyleList.data = data.fillStyle;
			b.writeBytes(_fillStyleList.binary);
			
			_lineStyleList = new LineStyleArrayEncode();
			b.writeBytes(_lineStyleList.binary);
			
			
			var fillLength:int = data.fillStyle.length;
			var lineLength:int = 0;
			b.writeByte(((fillLength & 0x0F) << 4) + (lineLength & 0x0F));
			
			_shapeRecord = new ShapeRecordEncode();
			_shapeRecord.fillBits = fillLength;
			_shapeRecord.lineBits = lineLength;
			_shapeRecord.data = data.shapeRecords;
			b.writeBytes(_shapeRecord.binary);
			
			return b;
		}
		
	}
	
}