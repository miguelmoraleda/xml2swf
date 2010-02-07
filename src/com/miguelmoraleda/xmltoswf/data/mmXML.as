package com.miguelmoraleda.xmltoswf.data
{

	/**
	 * Helper class to convert XML.
	 * 
	 * @author Miguel Moraleda
	 */
	public class mmXML
	{
		/**
		 * the XML object
		 */
		protected var _xml:XML;

		/**
		 * constructor
		 * @see XML
		 * @param initXML
		 */
		public function mmXML(initXML:XML)
		{
			_xml=initXML;
		}

		/**
		 * parse the XML to Array
		 * @param data    list of xml nodes
		 */
		protected function parseXML(data:XMLList):Array
		{
			var value:Array = new Array();
	
			if(data.length())
			{
				var cnt:Object = new Object();
				for each(var item:Object in data)
				{
					var ret:Object;
					var iName:String = item.name();
					if(! cnt[iName]) cnt[iName] = 0;
	
					if(item.hasSimpleContent())
					{
						ret = item.toString();
					}
					else
					{
						ret = parseXML(item.children()/*, tab+"|-- "*/);
					}
			
					if(cnt[iName] == 0)
					{
						value[iName] = ret;
					}
					if(cnt[iName] == 1)
					{
						value[iName] = new Array(value[iName]);
					}
					if(cnt[iName] > 0)
					{
						value[iName].push(ret);
					}
			
					cnt[iName]++;
				}
			}
			return value;
		}

		/**
		 * convert the XML to hirachical array
		 * @return the array structure
		 */
		public function toArray():Array
		{
			var ar:Array = new Array();
			ar[_xml.name()] = parseXML(_xml.children());
			return ar;
		}

		/**
		 * convert to string
		 * @see XML:toString()
		 */
		public function toString():String
		{
			return _xml.toString();
		}

		/**
		 * return the XML object
		 */
		public function toXML():XML
		{
			return _xml;
		}


	}

}