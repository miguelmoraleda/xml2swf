package com.miguelmoraleda.xmltoswf.utils 
{
	import com.miguelmoraleda.xmltoswf.data.mmBinary;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class ImageLoader extends EventDispatcher
	{
		protected var _images:Array;
		protected var _countImage:int = 0;
		protected var _imagesData:Array;
		
		public function ImageLoader() 
		{
			super();
			_images = new Array();
		}
		
		
		protected function loadImages():void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoadedHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.load(new URLRequest(_imagesData.images[_countImage].source));
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void 
		{
			trace(e);
		}
		
		private function imageLoadedHandler(e:Event):void 
		{
			e.target.removeEventListener(Event.COMPLETE, imageLoadedHandler);
			e.target.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			var image:Bitmap = Bitmap(e.target.content);
			_images.push( { id: _imagesData.images[_countImage].characterId, image:  image, width: image.width, height:image.height, jpgQuality: _imagesData.images[_countImage].format.JPEG3 } );
			
			if (_countImage < _imagesData.images.length -1) {
				
				_countImage++;
				loadImages();
			} else {
				dispatchEvent(new Event(Event.COMPLETE));
			}
			
		}
		
		public function get imagesData():Array { return _imagesData; }
		
		public function set imagesData(value:Array):void 
		{
			_imagesData = value;
			if (!_imagesData.images[0]) _imagesData.images = new Array(_imagesData.images);
			
			//trace(mmBinary.dump(_imagesData));
			loadImages();
		}
		
		public function get images():Array { return _images; }
		
	}
	
}