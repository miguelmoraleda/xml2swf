package com.miguelmoraleda.xmltoswf 
{
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import com.miguelmoraleda.xmltoswf.data.mmXML;
	import com.miguelmoraleda.xmltoswf.utils.ImageLoader;
	import flash.events.Event;
	import flash.filesystem.File;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class ConvertXML 
	{

		protected var _createdFile:File;
		protected var _binaryData:mmByteArray;
		protected var _xml:XML;
		protected var _uniXml:mmXML;
		protected var dataArray:Array;
		
		protected var _imageLoader:ImageLoader;
		
		public function ConvertXML() 
		{
			_createdFile = new File();
			_binaryData = new mmByteArray();
		}
		
		public function createSWF(xml:XML):void
		{
			_xml = XML(xml);
			_uniXml = new mmXML(_xml);
			dataArray = _uniXml.toArray();
			
			_imageLoader = new ImageLoader();
			_imageLoader.addEventListener(Event.COMPLETE, imagesCompleteHandler);
			_imageLoader.imagesData = dataArray.swf.imagesData;
		}
		
		private function imagesCompleteHandler(e:Event):void 
		{
			convertXml();
		}
		
		public function convertXml():void
		{
			for each(var picture:XML in _xml.children()) {
				var newData:mmXML = new mmXML(picture);
				for (var tag:String in newData.toArray()) {
					//if (tag == "imagesData") continue;
					if ((dataArray.swf[tag] is Array) && dataArray.swf[tag][0]) {
						for each(var ww:Array in dataArray.swf[tag])
						{
							
							var p = swfFactory.getEncoder(tag);
							trace("CREANDO UN : " + p);
							p.data = ww;
							_binaryData.writeBytes(p.binary);
						}
						//trace("ES ARRAY: " + uniBinary.dump(dataArray.swf[tag]));
					} else {
						var r = swfFactory.getEncoder(tag);
						r.data = dataArray.swf[tag];
						
						if (tag == "imagesData") {
							r.data = _imageLoader.images;
						}
						
						if (tag == "doABC") {
							r.dataXML = picture;
						}
						
						_binaryData.writeBytes(r.binary);
					}
				}
			
			}
			_binaryData.writeUI16(0);
			
			_binaryData.position = 4;
			_binaryData.writeUI32(_binaryData.length);
			_createdFile.save(_binaryData, "dasdas.swf");
			
			//DEBUG
			var aa:mmByteArray = new mmByteArray();
			aa.writeBytes(_binaryData);
			//trace(aa.toString());
		}
	}
	
}