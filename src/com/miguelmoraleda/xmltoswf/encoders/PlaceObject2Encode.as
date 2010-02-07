package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class PlaceObject2Encode extends TagEncode
	{
		
		public function PlaceObject2Encode() 
		{
			super();
			_code = 26;
		}
		
		override protected function encodeBody():ByteArray 
		{
			var b:mmByteArray = new mmByteArray();
			
			var offsetBits:int = 0;
			
			b.encodeByte(0, 1, (data.hasActions == "true") ? 1 : 0, offsetBits++);
			
			b.encodeByte(0, 1, (data.hasClipDepth == "true") ? 1 : 0, offsetBits++);
			
			b.encodeByte(0, 1, (data.hasName == "true") ? 1 : 0, offsetBits++);
			
			b.encodeByte(0, 1, (data.hasRatio == "true") ? 1 : 0, offsetBits++);
			
			b.encodeByte(0, 1, (data.hasColorTransform == "true") ? 1 : 0, offsetBits++);
			
			b.encodeByte(0, 1, (data.hasMatrix == "true") ? 1 : 0, offsetBits++);
			
			b.encodeByte(0, 1, (data.hasChars == "true") ? 1 : 0, offsetBits++);
			
			b.encodeByte(0, 1, (data.moveFlag == "true") ? 1 : 0, offsetBits++);

			b.writeUI16(int(data.depth));
			
			if (data.hasChars == "true") {
				b.writeUI16(int(data.characterId));
			}
			
			if (data.hasMatrix == "true") {
				var matrix:MatrixEncode = new MatrixEncode();
				matrix.data = data.matrix;
				b.writeBytes(matrix.binary);
			}
			
			if (data.hasColorTransform == "true") {
				//Todo colortransformencode. CXFORMWITHALPHA
			}
			
			if (data.hasRatio == "true") {
				b.writeUI16(int(data.ratio));
			}
			
			if (data.hasName == "true") {
				//Todo StringEncode
			}
			
			if (data.hasClipDepth == "true") {
				b.writeUI16(int(data.clipDepth));
			}
			
			if (data.hasActions == "true") {
				//Todo ClipsActionsEncode
			}
			
			return b;
		}
		
	}
	
}