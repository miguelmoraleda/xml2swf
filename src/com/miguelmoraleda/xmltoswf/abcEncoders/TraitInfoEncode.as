package com.miguelmoraleda.xmltoswf.abcEncoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class TraitInfoEncode extends AbcEncodeBase
	{
		
		public function TraitInfoEncode() 
		{
			super();
		}
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			
			
			
			//write name
			b.writeU30(int(data.name));
			//write kind
			b.writeByte(int(data.type));
			
			//@TODO ONLY IMPLEMENTED FOR TYPE 4 TRAIT CLASS
			//trace(uniBinary.dump(data));
			//trace(int(data.traitsClass.slotId), int(data.traitsClass.classi))
			b.writeU30(int(data.traitsClass.slotId));
			b.writeU30(int(data.traitsClass.classi));
			
			
			//write metadata count
			//b.writeU30(0);
			
			
			return b;
		}
	}
	
}