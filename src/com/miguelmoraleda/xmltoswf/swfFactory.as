package classes
{
	import classes.abcEncoders.BodyInfoEncode;
	import classes.abcEncoders.CPoolInfoEncode;
	import classes.abcEncoders.VersionEncode;
	import classes.encoders.DoAbcEncode;
	import classes.encoders.FileAttributesEncode;
	import classes.encoders.ImageEncode;
	import classes.encoders.PlaceObject2Encode;
	import classes.encoders.RectangleEncode;
	import classes.encoders.HeaderEncode;
	import classes.encoders.EncoderBase;
	import classes.encoders.BackgroundColorEncode;
	import classes.encoders.DefineShapeEncode;
	import classes.encoders.ShowFrameEncode;
	import classes.encoders.SpriteEncode;
	import classes.encoders.StraightEdgeRecordEncode;
	import classes.encoders.StringEncode;
	import classes.encoders.StyleChangeRecordEncode;
	import classes.encoders.SymbolClassEncode;
	
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