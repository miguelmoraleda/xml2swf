package com.miguelmoraleda.xmltoswf.abcEncoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class CodeEncode extends AbcEncodeBase
	{
		protected var _typeList:Object = {
			"getlocal_0": 0xd0
			, "pushscope": 0x30
			, "returnvoid": 0x47
			, "constructsuper": 0x49
			, "popscope": 0x1d
			, "getlex": 0x60
			, "getscopeobject": 0x65
			, "newclass": 0x58
			, "initproperty": 0x68
		};
		public function CodeEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			
			//trace(dataXML);
			//trace(uniBinary.dump(data));
			
			
			for each(var item:XML in dataXML) {
				for each(var code:XML in item.code)
				{
					//trace(code);
					for each(var ins:Object in code.children())
					{
						var n:String = ins.name()
						if (_typeList[n]) {
							b.writeByte(_typeList[n]);
							if (ins.toString() != "") {
								b.writeByte(parseInt(ins.toString()));
							}
						}
					}
				}
			}
			return b;
		}
		
	}
	
}