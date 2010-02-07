package com.miguelmoraleda.xmltoswf
{
	import com.miguelmoraleda.xmltoswf.abcEncoders.BodyInfoEncode;
	import com.miguelmoraleda.xmltoswf.abcEncoders.CPoolInfoEncode;
	import com.miguelmoraleda.xmltoswf.abcEncoders.VersionEncode;
	import com.miguelmoraleda.xmltoswf.encoders.DoAbcEncode;
	import com.miguelmoraleda.xmltoswf.encoders.FileAttributesEncode;
	import com.miguelmoraleda.xmltoswf.encoders.ImageEncode;
	import com.miguelmoraleda.xmltoswf.encoders.PlaceObject2Encode;
	import com.miguelmoraleda.xmltoswf.encoders.RectangleEncode;
	import com.miguelmoraleda.xmltoswf.encoders.HeaderEncode;
	import com.miguelmoraleda.xmltoswf.encoders.EncoderBase;
	import com.miguelmoraleda.xmltoswf.encoders.BackgroundColorEncode;
	import com.miguelmoraleda.xmltoswf.encoders.DefineShapeEncode;
	import com.miguelmoraleda.xmltoswf.encoders.ShowFrameEncode;
	import com.miguelmoraleda.xmltoswf.encoders.SpriteEncode;
	import com.miguelmoraleda.xmltoswf.encoders.StraightEdgeRecordEncode;
	import com.miguelmoraleda.xmltoswf.encoders.StringEncode;
	import com.miguelmoraleda.xmltoswf.encoders.StyleChangeRecordEncode;
	import com.miguelmoraleda.xmltoswf.encoders.SymbolClassEncode;
	
	/**
	 * 
	 */
    public class swfFactory
    {
		protected static var _classList:Object = { 
			"rectangleEncode": RectangleEncode
			, "headerEncode": HeaderEncode
			, "backgroundColorEncode": BackgroundColorEncode
			, "defineShapeEncode": DefineShapeEncode
			, "styleChangeRecordEncode": StyleChangeRecordEncode
			, "straightEdgeRecordEncode": StraightEdgeRecordEncode
			, "spriteEncode": SpriteEncode
			, "placeObject2Encode": PlaceObject2Encode
			, "symbolClassEncode": SymbolClassEncode
			, "showFrameEncode": ShowFrameEncode
			, "imagesDataEncode": ImageEncode
			, "doABCEncode": DoAbcEncode
			, "versionEncode": VersionEncode
			, "cpoolInfoEncode": CPoolInfoEncode
			, "stringEncode": StringEncode
			, "bodyInfoEncode": BodyInfoEncode
			, "fileAttributesEncode": FileAttributesEncode
		};
		
        public function swfFactory()
        {
			
        }
       
        static public function getEncoder(type:String):EncoderBase
        {
			return new _classList[type+"Encode"]();
        }
    }
}