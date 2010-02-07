package
{
	import com.miguelmoraleda.xmltoswf.utils.ImageLoader;
	import com.miguelmoraleda.xmltoswf.ConvertXML;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	import com.miguelmoraleda.xmltoswf.swfFactory;
	
	public class Main extends Sprite
	{
		
		protected var _xml:XML;
		protected var _convertXml:ConvertXML;
		protected var _xmlToSwfConverter:XmlToSwf;
		
		
		public function Main()
		{
			super();
			_convertXml = new ConvertXML();
			_xmlToSwfConverter = new XmlToSwf();
			
			loadXML();
		
		}
		
		
		protected function loadXML():void
		{
			var loader= new URLLoader(new URLRequest("library.xml"));
			loader.addEventListener(Event.COMPLETE, xmlLoadedCompleteHandler);
		}
		
		protected function xmlLoadedCompleteHandler(e:Event):void 
		{
			e.target.removeEventListener(Event.COMPLETE, xmlLoadedCompleteHandler);
			
			_xml = XML(e.target.data);
			//trace(_xml);
			
			_xmlToSwfConverter.createSWF(_xml);
			//_convertXml.createSWF(_xml);
		}
		
	}
}