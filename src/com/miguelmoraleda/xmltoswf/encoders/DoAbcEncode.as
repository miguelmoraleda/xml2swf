package com.miguelmoraleda.xmltoswf.encoders 
{
	import com.miguelmoraleda.xmltoswf.abcEncoders.AbcFileEncode;
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import com.miguelmoraleda.xmltoswf.data.mmXML;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class DoAbcEncode extends TagEncode
	{
		
		public var dataXML:XML;
		
		public function DoAbcEncode() 
		{
			super();
			_code = 82;
		}
		
		override protected function encodeBody():ByteArray 
		{
			var b:mmByteArray = new mmByteArray();
			
			//trace(dataXML);
			b.writeUI32(int(data.flags));
			
			var stringName:StringEncode = new StringEncode();
			stringName.data = data.name;
			b.writeBytes(stringName.binary);
			
			
			var abcFileXML:XML;
			
			for each(var item:XML in dataXML.children()) {
				var newData:mmXML = new mmXML(item);
				for (var tag:String in newData.toArray()) {
					if (tag == "abcFile") abcFileXML = item;
				}
			}
			
			var abcFile:AbcFileEncode = new AbcFileEncode();
			abcFile.data = data.abcFile;
			abcFile.dataXML = abcFileXML;
			b.writeBytes(abcFile.binary);
			
			return b;
		}
		
	}
	
}