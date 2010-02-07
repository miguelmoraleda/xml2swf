package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import com.miguelmoraleda.xmltoswf.swfFactory;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class ShapeRecordEncode extends EncoderBase
	{
		public var fillBits:int;
		public var lineBits:int;
		
		public function ShapeRecordEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			var offset:int = 0;
			
			//trace(uniBinary.dump(data));
			
			for each(var style:Array in data)
			{
				for (var tagName:String in style) {
					//if (tagName == "straightEdgeRecord") continue;
					var scr = swfFactory.getEncoder(tagName);
					scr.byteArray = b;
					scr.fillBits = fillBits;
					scr.lineBits = lineBits;
					scr.data = style[tagName];
					//trace("offset en el liop principal: " + offset);
					scr.finalOffset = offset;
					scr.binary;
					offset = scr.finalOffset;
					
				}
				
			}
			
			//Write the EndShapeRecord
			b.encodeByte(0, 6, 0, offset);
			
			return b;
		}
		
	}
	
}