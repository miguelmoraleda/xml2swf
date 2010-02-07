package com.miguelmoraleda.xmltoswf.abcEncoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import com.miguelmoraleda.xmltoswf.encoders.EncoderBase;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class VersionEncode extends AbcEncodeBase
	{
		
		public function VersionEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			
			b.writeUI16(data.version.minor);
			
			b.writeUI16(data.version.major);
			
			return b;
		}
		
	}
	
}