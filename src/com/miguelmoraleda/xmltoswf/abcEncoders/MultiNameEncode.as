package com.miguelmoraleda.xmltoswf.abcEncoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmBinary;
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class MultiNameEncode extends AbcEncodeBase
	{
		
		public function MultiNameEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			
			//trace(mmBinary.dump(data));
			//trace(mmBinary.dump(data.queueName));
			//trace(data.queueName.ns);
			//trace(data.queueName.name);
			
			/**
			 * @TODO FOR THE MOMENT IS ONLY USING A KIND OF KIND THE QUEUENAME.
			 */
			
			//write kind constant for queueName
			b.writeByte(7);
			
			b.writeU30(int(data.queueName.ns));
			b.writeU30(int(data.queueName.name));
			
			return b;
		}
		
	}
	
}