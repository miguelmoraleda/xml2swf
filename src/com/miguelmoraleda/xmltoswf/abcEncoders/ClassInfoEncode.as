package com.miguelmoraleda.xmltoswf.abcEncoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class ClassInfoEncode extends AbcEncodeBase
	{
		
		public function ClassInfoEncode() 
		{
			super();
		}
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			
			//write name
			b.writeU30(int(data.cinit));
			
			//write trait count
			b.writeU30(0);
			
			
			return b;
		}
	}
	
}