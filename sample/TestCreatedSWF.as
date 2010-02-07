package
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getDefinitionByName;
	
	public class TestCreatedSWF extends Sprite
	{
		public static const FILE_TO_LOAD:String = "dasdas.swf";
		public static const LINKAGE_NAME:String = "main.notemixer.test.testImage";
		
		
		private var _loader:Loader;
		
		private var _appDomain:ApplicationDomain;
		
		
		public function TestCreatedSWF()
		{
			super();
			
			loadFile();
		}
		
		private function loadFile():void
		{
			
			_appDomain = new ApplicationDomain();
			var context:LoaderContext = new LoaderContext(false, _appDomain);
			
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, fileLoaded);
			_loader.load(new URLRequest(FILE_TO_LOAD), context);
		}
		
		override public function toString():String 
		{
			return super.toString();
		}
		
		private function fileLoaded(e:Event):void 
		{
			var swfLoaded:MovieClip = _loader.content as MovieClip;
			
			try
			{
				var classInstance:Class = _appDomain.getDefinition(LINKAGE_NAME) as Class;
				var imageInstance:MovieClip = new classInstance();
				addChild(imageInstance);
			} catch (error:ReferenceError)
			{
				trace(error);
			}
			
		}
	}
}