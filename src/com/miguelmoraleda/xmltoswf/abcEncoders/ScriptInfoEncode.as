package com.miguelmoraleda.xmltoswf.abcEncoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class ScriptInfoEncode extends AbcEncodeBase
	{
		
		public function ScriptInfoEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			//trace(uniBinary.dump(data));
			if (!(data is Array)) data = new Array(data);
			
			//write name
			b.writeU30(int(data.init));
			
			//write trait count
			b.writeU30(1);
			
			var traitInfo:TraitInfoEncode = new TraitInfoEncode();
			traitInfo.data = data.traitsInfo;
			b.writeBytes(traitInfo.binary);
			
			
			return b;
		}
		
	}
	
}