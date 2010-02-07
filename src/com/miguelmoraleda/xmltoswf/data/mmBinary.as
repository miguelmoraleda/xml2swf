package com.miguelmoraleda.xmltoswf.data
{
	import flash.utils.getQualifiedClassName;
	import flash.utils.ByteArray;
	import flash.display.Bitmap;
	
	/**
	* Converter class between Array and Binary data.
	*
	* @author Miguel Moraleda
	*/
	public class mmBinary
	{
		
		static public function dump(d:Object, tab:String=""):String
		{
			var out:String=""
				, cnt:int=0
				, out2:String=""
			;
			if(typeof d == "string") return '"'+d+'"';
			if(typeof d == "number") return new String(d);
			if (typeof d == "boolean") return new String(d?"true":"false");
			if (d == null) return "null";
			if(d is Bitmap) 
			{
				return 'Bitmap '+d.width+'x'+d.height;
			}
			
			var type:String = typeof d;
			if(d is Array) type = "Array";
			
			out2+=type+" (\n";
			for(var n:String in d)
			{
				cnt++;
				var r:String="";
				r = mmBinary.dump(d[n], tab+"  ");
				out2+=tab+"  ["+n+"] => "+r+"\n";
			}
			out2+=tab+")";
			
			if(!cnt && d.toString) out += d.toString();
			else out += out2;
			
			return out;
		}
		
	}
}
