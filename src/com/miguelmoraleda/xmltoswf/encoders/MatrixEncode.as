package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class MatrixEncode extends EncoderBase
	{
		
		public function MatrixEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			var bytePosition:int = 0;
			var offsetBits:int = 0;
			var nBits:int;
			
			offsetBits = saveData(b, offsetBits, Number(data.scaleX), Number(data.scaleY));
			offsetBits = saveData(b, offsetBits, Number(data.rotateSkew0), Number(data.rotateSkew1));
			offsetBits = saveData(b, offsetBits, Number(data.transX), Number(data.transY), false, true);
			
			return b;
		}
		
		public function saveData(b:mmByteArray, offsetBits:int, x:Number, y:Number, isFixed:Boolean = true, noFlag:Boolean = false):int
		{
			var nBits:int;
			
			if (!noFlag) {
				b.encodeByte(0, 1, (((x || y) ? 1 : 0)), offsetBits);
				offsetBits++;
			}
			if (offsetBits == 8) offsetBits = 0 ;
			if (x || y) {
				if(isFixed) {
					/**
					 * Maybe is not *20 becouse in the description file say that is now twips value.
					 */
					var hvX:int = int(x * 20);
					var lvX:int = (Number(x * 20) - hvX) * 65536;
					
					var hvY:int = int(y * 20);
					var lvY:int = (Number(y * 20) - hvY) * 65536;
					
					nBits = (findNBits(hvX, hvY) + 17);
					
					b.encodeByte(0, 5, nBits, offsetBits);
					b.encodeByte(0, nBits, int((hvX << 16) + lvX), 5 + offsetBits);
					b.encodeByte(1, nBits, int((hvY << 16) + lvY), 5 + offsetBits);
				} else {
					nBits = (findNBits(Math.abs(x) * 20, Math.abs(y) * 20) + 1);
					
					//trace("NBITS OF THE MATRIX: " + nBits + " offset: " + offsetBits);
					x *= 20;
					y *= 20;
					if (x < 0) {
						x = (Math.abs(x) - 1)^(Math.pow(2, nBits)-1) ;
					}
					if (y < 0) {
						y = (Math.abs(y) - 1)^(Math.pow(2, nBits)-1) ;
					}
					
					b.encodeByte(0, 5, nBits, offsetBits);
					b.encodeByte(0, nBits, x, (5+offsetBits));
					b.encodeByte(1, nBits, y, (5+offsetBits));
				}
				
				offsetBits  = (offsetBits + 5 + nBits * 2) - ((b.length -1) * 8);
			}
			return offsetBits;
		}
		
		
		
	}
	
}