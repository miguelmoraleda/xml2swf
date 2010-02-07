package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class FillStyleArrayEncode extends EncoderBase
	{
		
		public function FillStyleArrayEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			
			if (!data[0]) data = new Array(data);
			
			b.writeUI8(data.length)
			
			for each(var a:Array in data)
			{
				var fillStyle:FillStyleEncode = new FillStyleEncode();
				fillStyle.data = a;
				b.writeBytes(fillStyle.binary);
			}
			
			return b;
		}
		
	}
	
}