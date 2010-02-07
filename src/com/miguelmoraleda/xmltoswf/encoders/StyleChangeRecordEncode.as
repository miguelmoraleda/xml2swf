package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class StyleChangeRecordEncode extends EncoderBase
	{
		public var fillBits:int;
		public var lineBits:int;
		
		public var finalOffset:int;
		public var byteArray:mmByteArray;
		
		public function StyleChangeRecordEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var offsetBits:int = finalOffset;
			var b:mmByteArray = byteArray;
			
			b.encodeByte(0, 1, 0, offsetBits++);
			
			b.encodeByte(0, 1, (data.newStyles == "true") ? 1 : 0, offsetBits++);
			
			b.encodeByte(0, 1, (data.lineStyle == "true") ? 1 : 0, offsetBits++);
			
			b.encodeByte(0, 1, (data.fillStyle1 == "true") ? 1 : 0, offsetBits++);
			
			b.encodeByte(0, 1, (data.fillStyle0 == "true") ? 1 : 0, offsetBits++);
			
			if (data.move) {
				b.encodeByte(0, 1, 1, offsetBits++);
				var moveBits:int = findNBits(Number(data.move.x * 20), Number(data.move.y * 20)) + 1;
				b.encodeByte(0, 5, moveBits, offsetBits);
				offsetBits = (offsetBits + 5) % 8;
				b.encodeByte(0, moveBits, int(data.move.x * 20), offsetBits);
				b.encodeByte(1, moveBits, int(data.move.y * 20), offsetBits);
				offsetBits  = (offsetBits + moveBits * 2) % 8;
			} else {
				b.encodeByte(0, 0, 1, offsetBits++);
			}
			
			if ((data.fillStyle0 == "true")) {
				b.encodeByte(0, fillBits, int(data.fillStyle0Id), offsetBits);
				offsetBits += fillBits;
			}
			if ((data.fillStyle1 == "true")) {
				b.encodeByte(0, fillBits, int(data.fillStyle1Id), offsetBits);
				offsetBits += fillBits;
			}
			
			
			offsetBits %= 8;
			finalOffset = offsetBits;
			return b;
		}
		
	}
	
}