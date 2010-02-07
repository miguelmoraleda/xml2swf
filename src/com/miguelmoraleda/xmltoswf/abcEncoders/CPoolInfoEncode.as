package com.miguelmoraleda.xmltoswf.abcEncoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import com.miguelmoraleda.xmltoswf.encoders.StringEncode;
	import com.miguelmoraleda.xmltoswf.swfFactory;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class CPoolInfoEncode extends AbcEncodeBase
	{
		
		public function CPoolInfoEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			
			//trace(dataXML);
			//trace(uniBinary.dump(data));
			
			//write the int Count
			b.writeU30(0);
			//write the uint Count
			b.writeU30(0);
			//write the double Count
			b.writeU30(0);
			
			
			//write the string Count
			b.writeU30(int(data.cpoolInfo.string.length) + 1);
			
			for each(var string:String in data.cpoolInfo.string)
			{
				var insertString:AbcStringEncode = new AbcStringEncode();
				insertString.data = string;
				b.writeBytes(insertString.binary);
			}
			
			b.writeU30(int(data.cpoolInfo.namespace.length) + 1);
			
			for each(var d:Array in data.cpoolInfo.namespace)
			{
				var ns:NamespaceEncode = new NamespaceEncode();
				ns.data = d;
				b.writeBytes(ns.binary);
			}
			
			//write the ns info Count
			b.writeU30(0);
			//write multi name count
			b.writeU30(int(data.cpoolInfo.multiName.length) + 1);
			for each(var e:Array in data.cpoolInfo.multiName)
			{
				var mn:MultiNameEncode = new MultiNameEncode();
				mn.data = e;
				b.writeBytes(mn.binary);
			}
			
			
			return b;
		}
		
	}
	
}