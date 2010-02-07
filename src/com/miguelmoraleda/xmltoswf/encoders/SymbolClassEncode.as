package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class SymbolClassEncode extends TagEncode
	{
		
		public function SymbolClassEncode() 
		{
			super();
			_code = 76;
		}
		
		override protected function encodeBody():ByteArray 
		{
			var b:mmByteArray = new mmByteArray();
			
			if (!data.symbol[0]) data.symbol = new Array(data.symbol);
			
			b.writeUI16(data.symbol.length);
			
			for each(var tag:Array in data.symbol)
			{
				b.writeUI16(int(tag.id));
				
				var stringName:StringEncode = new StringEncode();
				stringName.data = tag.string;
				b.writeBytes(stringName.binary);
			}
			
			return b;
		}
		
	}
	
}