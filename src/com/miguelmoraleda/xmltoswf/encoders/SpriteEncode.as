package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class SpriteEncode extends TagEncode
	{
		
		public function SpriteEncode() 
		{
			super();
			_code = 39;
		}
		
		override protected function encodeBody():ByteArray 
		{
			var b:mmByteArray = new mmByteArray();
			b.writeUI16(int(data.id));
			
			//write the framecount
			b.writeUI16(int(data.placeObject2.length));
			
			for each(var placeObject:Array in data.placeObject2)
			{
				var place:PlaceObject2Encode = new PlaceObject2Encode();
				place.data = placeObject;
				b.writeBytes(place.binary);
			}
			
			b.writeUI16(0);
			
			return b;
		}
		
	}
	
}