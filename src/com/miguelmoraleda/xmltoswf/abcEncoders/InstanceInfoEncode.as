package com.miguelmoraleda.xmltoswf.abcEncoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class InstanceInfoEncode extends AbcEncodeBase
	{
		
		public function InstanceInfoEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			
			if (!(data is Array)) data = new Array(data);
			//write name
			b.writeU30(int(data.name));
			//write super name
			b.writeU30(int(data.superName));
			//write flag
			//@TODO ONLY IMPLEMENTES CLASS PROTECTED NS
			b.writeByte(8);
			//write protected ns
			b.writeU30(int(data.protectedNs));
			//write intrf count
			b.writeU30(0);
			//write iinit
			b.writeU30(int(data.iinit));
			
			//write trait count
			b.writeU30(0);
			
			
			return b;
		}
		
	}
	
}