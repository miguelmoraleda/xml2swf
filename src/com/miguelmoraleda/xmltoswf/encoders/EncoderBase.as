package com.miguelmoraleda.xmltoswf.encoders
{
	import flash.utils.ByteArray;
	
	public class EncoderBase
	{
		protected var _data:Object;
		
		
		public function get data():Object { return _data; }
		
		public function set data(value:Object):void 
		{
			_data = value;
		}
		
		protected  function findNBits(...args):int
		{
			var maxBitsValue:int = 0;
			var nBits:int;
			for each(var value:int in args) {
				maxBitsValue = Math.max(maxBitsValue, value);
			}
			
			nBits = Math.ceil(Math.log(maxBitsValue) / Math.log(2));
			return nBits;
		}
		
		protected function upShiftValue(steps:int, value:Number):Number
		{
			return value << steps;
		}
		
		protected function downShiftValue(steps:int, value:Number):Number
		{
			return value >> steps;
		}
	}
}