package com.miguelmoraleda.xmltoswf.abcEncoders 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import com.miguelmoraleda.xmltoswf.data.mmXML;
	import com.miguelmoraleda.xmltoswf.encoders.EncoderBase;
	import com.miguelmoraleda.xmltoswf.swfFactory;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class AbcFileEncode extends AbcEncodeBase
	{
		
		public function AbcFileEncode() 
		{
			super();
		}
		
		public function get binary():ByteArray
		{
			var b:mmByteArray = new mmByteArray();
			
			//trace(dataXML);
			//trace(uniBinary.dump(data));
			
			
			
			for each(var item:XML in dataXML.children()) {
				var newData:mmXML = new mmXML(item);
				for (var tag:String in newData.toArray()) {
					if (tag != "version" && tag != "cpoolInfo") continue;
					var r = swfFactory.getEncoder(tag);
					
					r.dataXML = item;
					var dataArray:mmXML = new mmXML(item);
					r.data = dataArray.toArray();
					
					b.writeBytes(r.binary);
				}
			}
			
			//method count
			b.writeU30(int(data.methodInfo.length));
			
			for each(var methodArray:Object in data.methodInfo)
			{
				var mi:MethodInfoEncode = new MethodInfoEncode();
				b.writeBytes(mi.binary);
			}
			
			//write medataInfo
			b.writeU30(0);
			
			//write class count
			if (!(data.classInfo[0])) data.classInfo = new Array(data.classInfo);
			if (!(data.instanceInfo[0])) data.instanceInfo = new Array(data.instanceInfo);
			b.writeU30(int(data.classInfo.length));
			for each(var instanceArray:Object in data.instanceInfo)
			{
				var ii:InstanceInfoEncode = new InstanceInfoEncode();
				ii.data = instanceArray;
				b.writeBytes(ii.binary);
			}
			
			
			for each(var classArray:Object in data.classInfo)
			{
				var ci:ClassInfoEncode = new ClassInfoEncode();
				ci.data = classArray;
				b.writeBytes(ci.binary);
			}
			
			//write script count
			//trace(data.scriptInfo.length, "scriptInfo");
			
			if (!(data.scriptInfo[0])) data.scriptInfo = new Array(data.scriptInfo);
			b.writeU30(int(data.scriptInfo.length));
			for each(var scriptArray:Object in data.scriptInfo)
			{
				var si:ScriptInfoEncode = new ScriptInfoEncode();
				si.data = scriptArray;
				b.writeBytes(si.binary);
			}
			
			//write bodyInfo count
			trace(data.bodyInfo.length, "bodyInfo");
			b.writeU30(int(data.bodyInfo.length));
			
			for each(var itemBody:XML in dataXML.children()) {
				var newDataBody:mmXML = new mmXML(itemBody);
				for (var tagBody:String in newDataBody.toArray()) {
					if (tagBody != "bodyInfo") continue;
					var rr = swfFactory.getEncoder(tagBody);
					
					rr.dataXML = itemBody;
					var dataArrayBody:mmXML = new mmXML(itemBody);
					rr.data = dataArrayBody.toArray().bodyInfo;
					
					b.writeBytes(rr.binary);
				}
			}
			
			return b;
		}
		
	}
	
}