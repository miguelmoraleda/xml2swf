package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmBinary;
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import com.miguelmoraleda.xmltoswf.swfFactory;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class DefineShapeEncode extends TagEncode
	{
		protected var _dimensionRect:RectangleEncode;
		protected var _matrix:MatrixEncode;
		protected var _shapeWithList:ShapeWithStyleEncode;
		
		
		public function DefineShapeEncode() 
		{
			super();
			_code = 2;
		}
		
		override protected function encodeBody():ByteArray 
		{
			var b:mmByteArray = new mmByteArray();
			
			//trace(mmBinary.dump(data));
			
			b.writeUI16(int(data.id));
			
			_dimensionRect = new RectangleEncode();
			_dimensionRect.data = data.rectangle;
			b.writeBytes(_dimensionRect.binary);
			
			_shapeWithList = new ShapeWithStyleEncode();
			_shapeWithList.data = data.shapeInfo;
			b.writeBytes(_shapeWithList.binary);
			//trace(b.length, " DEFINESAPE");
			return b;
			
		}
		
	}
	
}