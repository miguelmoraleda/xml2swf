package com.miguelmoraleda.xmltoswf.encoders
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	public class RectangleEncode extends EncoderBase
	{
		public function get binary():ByteArray
		{
			var b:mmByteArray;
			var xMin:int;
			var xMax:int;
			var yMin:int;
			var yMax:int;
			//var maxBitsValue:int;
			var nBits:int;
			
			xMin = (int(data.x) * 20);
			xMax = (int(data.x) + int(data.width)) * 20;
			yMin = int(data.y) * 20;
			yMax = (data.y + int(data.height)) * 20;
			
			
			nBits = findNBits(xMin, xMax, yMin, yMax) + 1;
			//trace("xMin: " + xMin + " xMax: " + xMax + " yMin: " + yMin + " yMax: " + yMax + " nBits: " + nBits);
			
			b = new mmByteArray();
			b.writeByte(nBits << 3);
			b.encodeByte(0, nBits, xMin, 5);
			
			b.encodeByte(1, nBits, xMax, 5);
			
			b.encodeByte(2, nBits, yMin, 5);
			
			b.encodeByte(3, nBits, yMax, 5);
			return b;
		}
		
	}
}