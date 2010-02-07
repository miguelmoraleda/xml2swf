package com.miguelmoraleda.xmltoswf.abcEncoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class MethodInfoEncode extends AbcEncodeBase
	{
		
		public function MethodInfoEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			
			//write param count
			b.writeU30(0);
			//write return type
			b.writeU30(0);
			//write name
			b.writeU30(0);
			//write flags
			b.writeU30(0);
			
			return b;
		}
		
	}
	
}