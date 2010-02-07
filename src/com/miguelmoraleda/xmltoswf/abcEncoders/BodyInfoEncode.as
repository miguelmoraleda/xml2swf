package com.miguelmoraleda.xmltoswf.abcEncoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import com.miguelmoraleda.xmltoswf.data.mmXML;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class BodyInfoEncode extends AbcEncodeBase
	{
		
		public function BodyInfoEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			//trace("BODY INFO" + uniBinary.dump(data) + dataXML);
			
			//write method
			b.writeU30(int(data.method));
			//write maxStack
			b.writeU30(int(data.maxStack));
			//write localCount
			b.writeU30(int(data.localCount));
			//write initScopeDepth
			b.writeU30(int(data.initScopeDepth));
			//write maxScopeDepth
			b.writeU30(int(data.maxScopeDepth));
			
			
			var codeData:ByteArray;
			for each(var item:XML in dataXML) {
				var newDataBody:mmXML = new mmXML(item);
				for (var tagBody:String in newDataBody.toArray()) {
					if (tagBody != "code") {
						var dataArray:mmXML = new mmXML(item);
						var codeEncode:CodeEncode = new CodeEncode();
						
						codeEncode.data = dataArray.toArray();
						codeEncode.dataXML = dataXML;
						codeData = codeEncode.binary;
					}
				}
			}
			//write code length
			b.writeU30(codeData.length);
			
			b.writeBytes(codeData);
			
			//write exception count
			b.writeU30(0);
			
			//write trait count
			b.writeU30(0);
			
			return b;
		}
	}
	
}