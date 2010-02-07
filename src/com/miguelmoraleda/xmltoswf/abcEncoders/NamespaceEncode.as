package com.miguelmoraleda.xmltoswf.abcEncoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class NamespaceEncode extends AbcEncodeBase
	{
		
		public function NamespaceEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			
			//trace(uniBinary.dump(data));
			
			b.writeByte(int(data.kind));
			
			b.writeU30(int(data.nameId));
			
			return b;
		}
		
	}
	
}