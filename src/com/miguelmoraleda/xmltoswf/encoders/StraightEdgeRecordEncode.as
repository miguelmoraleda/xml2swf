package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class StraightEdgeRecordEncode extends EncoderBase
	{
		public var fillBits:int;
		public var lineBits:int;
		
		public var finalOffset:int;
		public var byteArray:mmByteArray;
		
		public function StraightEdgeRecordEncode() 
		{
			super();
		}
		
		public function get binary():mmByteArray
		{
			var offsetBits:int = finalOffset;
			var b:mmByteArray = byteArray;
			
			//trace("Start straight offset: " + offsetBits);
			
			
			//Type Flag... always 1
			b.encodeByte(0, 1, 1, offsetBits++);
			offsetBits %= 8;
			//StraightFlag...always 1
			b.encodeByte(0, 1, 1, offsetBits++);
			offsetBits %= 8;
			var moveBits:int;
			var vertLine:int;
			var saveValue:int;
			if (data.vertLine == "true") {
				vertLine = 1;
				saveValue = int(int(data.deltaY) * 20);
			} else {
				vertLine = 0;
				saveValue = int(int(data.deltaX) * 20);
				
			}
			moveBits = findNBits(Math.abs(saveValue)) + 1;
			
			if (saveValue < 0) {
				saveValue = (Math.abs(saveValue) - 1)^(Math.pow(2, moveBits)-1) ;
			}
			//trace("IS : " + moveBits);
			
			b.encodeByte(0, 4, moveBits-2, offsetBits);
			offsetBits += 4;
			offsetBits %= 8;
			//General line always false
			b.encodeByte(0, 1, 0, offsetBits++);
			offsetBits %= 8;
			b.encodeByte(0, 1, vertLine, offsetBits++);
			offsetBits %= 8;
			b.encodeByte(0, moveBits, saveValue, offsetBits);
			
			offsetBits += moveBits;
			offsetBits %= 8;
			finalOffset = offsetBits;
			
			
			return b;
		}
		
	}
	
}