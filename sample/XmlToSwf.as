package  
{
	import com.miguelmoraleda.xmltoswf.data.mmBinary;
	import com.miguelmoraleda.xmltoswf.data.mmByteArray;
	import com.miguelmoraleda.xmltoswf.data.mmXML;
	import com.miguelmoraleda.xmltoswf.encoders.BackgroundColorEncode;
	import com.miguelmoraleda.xmltoswf.encoders.DefineShapeEncode;
	import com.miguelmoraleda.xmltoswf.encoders.DoAbcEncode;
	import com.miguelmoraleda.xmltoswf.encoders.FileAttributesEncode;
	import com.miguelmoraleda.xmltoswf.encoders.HeaderEncode;
	import com.miguelmoraleda.xmltoswf.encoders.ImageEncode;
	import com.miguelmoraleda.xmltoswf.encoders.ShowFrameEncode;
	import com.miguelmoraleda.xmltoswf.encoders.SpriteEncode;
	import com.miguelmoraleda.xmltoswf.encoders.SymbolClassEncode;
	import com.miguelmoraleda.xmltoswf.utils.ImageLoader;
	import flash.events.Event;
	import flash.filesystem.File;
	
	/**
	 * ...
	 * @author Miguel
	 */
	public class XmlToSwf 
	{
		protected var _createdFile:File;
		protected var _binaryData:mmByteArray;
		protected var _xml:XML;
		protected var _uniXml:mmXML;
		protected var dataArray:Array;
		
		protected var _imageLoader:ImageLoader;
		
		protected var _characterIdCounter:int = 0;
		
		public function XmlToSwf() 
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
			_imageLoader.imagesData = dataArray.movie.library.imagesData;
		}
		
		private function imagesCompleteHandler(e:Event):void 
		{
			convertXml();
		}
		
		public function convertXml():void
		{
			createHeader();
			createFileAttributes();
			createBackgroundColor();
			createImages();
			createDefineShape();
			createClip();
			createABC();
			createSymbolClass();
			
			var showFrameEncode:ShowFrameEncode = new ShowFrameEncode();
			_binaryData.writeBytes(showFrameEncode.binary);
			
			_binaryData.writeUI16(0);
			
			
			
			_binaryData.position = 4;
			_binaryData.writeUI32(_binaryData.length);
			_createdFile.save(_binaryData, "dasdas.swf");
			
			//DEBUG
			var aa:mmByteArray = new mmByteArray();
			aa.writeBytes(_binaryData);
			//trace(aa.toString());
		}
		
		private function createBackgroundColor():void
		{
			var backgroundColorEncode:BackgroundColorEncode = new BackgroundColorEncode();
			backgroundColorEncode.data = "0xFFCCCC";
			_binaryData.writeBytes(backgroundColorEncode.binary);
		}
		
		private function createSymbolClass():void
		{
			var xml:XML = <symbolClass>
								<symbol>
									<id>5</id>
									<string>main.notemixer.test.testImage</string>
								</symbol>
							</symbolClass>;
			
			//xml.symbol.id = dataArray.movie.library.clip.id;
			xml.symbol.id = _characterIdCounter;
			xml.symbol.string = dataArray.movie.library.clip["class"];
			//trace();
			var dd:mmXML = new mmXML(xml);
			
			var symbolClassEncode:SymbolClassEncode = new SymbolClassEncode();
			symbolClassEncode.data = dd.toArray();
			symbolClassEncode.data = symbolClassEncode.data.symbolClass;
			trace(mmBinary.dump(symbolClassEncode.data));
			_binaryData.writeBytes(symbolClassEncode.binary);
			
			
		}
		
		protected function createClip():void
		{
			var spriteXML:XML = <sprite>
									<id>5</id>
								</sprite>;
								
			var placeObjectXML:XML = <placeObject2>
										<hasActions>false</hasActions>
										<hasClipDepth>false</hasClipDepth>
										<hasName>false</hasName>
										<hasRatio>false</hasRatio>
										<hasColorTransform>false</hasColorTransform>
										<hasMatrix>true</hasMatrix>
										<hasChars>true</hasChars>
										<moveFlag>false</moveFlag>
										<depth>1</depth>
										<characterId>3</characterId>
										<matrix>
											<transX>0</transX>
											<transY>0</transY>
										</matrix>
										<showFrame>true</showFrame>
									</placeObject2>;
								
			var spriteData:mmXML = new mmXML(spriteXML);
			var spriteArray:Array = spriteData.toArray();
			spriteArray.sprite.id = _characterIdCounter;
			spriteArray.sprite.placeObject2 = new Array();
			
			if (!(dataArray.movie.library.clip.frames.place[0])) dataArray.movie.library.clip.frames.place = new Array(dataArray.movie.library.clip.frames.place);
			for each(var image:Object in dataArray.movie.library.clip.frames.place)
			{
				var placeObjectData:mmXML = new mmXML(placeObjectXML);
				var placeObjectArray:Array = placeObjectData.toArray();
				placeObjectArray.placeObject2.characterId = int(image.id) + int(_imageLoader.images.length);
				placeObjectArray.placeObject2.matrix.transX = image.x;
				placeObjectArray.placeObject2.matrix.transY = image.y;
				
				spriteArray.sprite.placeObject2.push(placeObjectArray.placeObject2);
				
				placeObjectXML.moveFlag = true;
			}
			
			var spriteEncode:SpriteEncode = new SpriteEncode();
			spriteEncode.data = spriteArray.sprite;
			_binaryData.writeBytes(spriteEncode.binary);
		}
		
		protected function createImages():void
		{
			var imageEncode:ImageEncode = new ImageEncode();
			imageEncode.data = _imageLoader.images;
			_binaryData.writeBytes(imageEncode.binary);
		}
		
		protected function createDefineShape():void
		{
			_characterIdCounter = _imageLoader.images.length + 1;
			
			var hXML:XML =  <defineShape>
								<id>4</id>
								<rectangle>
									<x>0</x>
									<y>0</y>
									<width>75</width>
									<height>60</height>
								</rectangle>
								<shapeInfo>
									<fillStyle>
										<bitmapStyle>65</bitmapStyle>
										<bitmapId>65535</bitmapId>
										<matrix>
											<scaleX>1</scaleX>
											<scaleY>1</scaleY>
										</matrix>
									</fillStyle>
									<fillStyle>
										<bitmapStyle>65</bitmapStyle>
										<bitmapId>2</bitmapId>
										<matrix>
											<scaleX>1</scaleX>
											<scaleY>1</scaleY>
											<transX>0</transX>
											<transY>0</transY>
										</matrix>
									</fillStyle>
									<shapeRecords>
										<styleChangeRecord>
											<newStyles>false</newStyles>
											<lineStyle>false</lineStyle>
											<fillStyle1>true</fillStyle1>
											<fillStyle0>false</fillStyle0>
											<move>
												<x>0</x>
												<y>0</y>
											</move>
											<fillStyle1Id>2</fillStyle1Id>
										</styleChangeRecord>
									</shapeRecords>
									<shapeRecords>
										<straightEdgeRecord>
											<generalLine>false</generalLine>
											<vertLine>false</vertLine>
											<deltaX>0</deltaX>
										</straightEdgeRecord>
									</shapeRecords>
									<shapeRecords>
										<straightEdgeRecord>
											<generalLine>false</generalLine>
											<vertLine>true</vertLine>
											<deltaY>0</deltaY>
										</straightEdgeRecord>
									</shapeRecords>
									<shapeRecords>
										<straightEdgeRecord>
											<generalLine>false</generalLine>
											<vertLine>false</vertLine>
											<deltaX>-0</deltaX>
										</straightEdgeRecord>
									</shapeRecords>
									<shapeRecords>
										<straightEdgeRecord>
											<generalLine>false</generalLine>
											<vertLine>true</vertLine>
											<deltaY>-0</deltaY>
										</straightEdgeRecord>
									</shapeRecords>
								</shapeInfo>
							</defineShape>;
			var defineData:mmXML = new mmXML(hXML);
			
			
			for each(var image:Object in _imageLoader.images)
			{
				var defineArray:Array = defineData.toArray();
				defineArray.defineShape.shapeInfo.fillStyle[1].bitmapId = _characterIdCounter - _imageLoader.images.length;
				//trace("BITMAPID: " + defineArray.defineShape.shapeInfo.fillStyle[1].bitmapId);
				defineArray.defineShape.id = _characterIdCounter;
				defineArray.defineShape.rectangle.width = image.width;
				defineArray.defineShape.rectangle.height = image.height;
				defineArray.defineShape.shapeInfo.shapeRecords[1].straightEdgeRecord.deltaX = image.width;
				defineArray.defineShape.shapeInfo.shapeRecords[2].straightEdgeRecord.deltaY = image.height;
				defineArray.defineShape.shapeInfo.shapeRecords[3].straightEdgeRecord.deltaX = -image.width;
				defineArray.defineShape.shapeInfo.shapeRecords[4].straightEdgeRecord.deltaY = -image.height;
				
				var defineShapeEncode:DefineShapeEncode = new DefineShapeEncode();
				defineShapeEncode.data = defineArray;
				defineShapeEncode.data = defineArray.defineShape;
				_binaryData.writeBytes(defineShapeEncode.binary);
				_characterIdCounter++;
			}
		}
		
		protected function createHeader():void
		{
			var hXML:XML = <header>
								<version>10</version>
								<rectangle>
									<x>0</x>
									<y>0</y>
									<width>550</width>
									<height>400</height>
								</rectangle>
								<framerate>30.00</framerate>
								<totalFrame>1</totalFrame>
							</header>;
			var headerData:mmXML = new mmXML(hXML);
			var header:HeaderEncode = new HeaderEncode();
			header.data = headerData.toArray();
			header.data = header.data.header;
			_binaryData.writeBytes(header.binary);
		}
		
		protected function createFileAttributes():void
		{
			var fXML:XML =  <fileAttributes>
								<HWAceleration>false</HWAceleration>
								<UseGPU>false</UseGPU>
								<HasMetadata>false</HasMetadata>
								<AS3>true</AS3>
								<UseNetwork>false</UseNetwork>
							</fileAttributes>;
							
			var fileData:mmXML = new mmXML(fXML);
			var fileAttribute:FileAttributesEncode = new FileAttributesEncode();
			fileAttribute.data = fileData.toArray();
			fileAttribute.data = fileAttribute.data.fileAttributes;
			_binaryData.writeBytes(fileAttribute.binary);
		}
		
		protected function createABC():void
		{
			var classData:String = dataArray.movie.library.clip["class"];
			var nameArray:Array = classData.split(".");
			var className:String = nameArray.pop();
			
			trace(className);
			var classPackage:String = nameArray.join(".");
			trace(classPackage);
			
			var completeName:String = classPackage + ":" + className;
			
			var xXML:XML = <doABC>
								<flags>16777216</flags>
								<name></name>
								<abcFile>
									<version>
										<minor>16</minor>
										<major>46</major>
									</version>
									<cpoolInfo>
										<string></string>
										<string>main.notemixer.test</string>
										<string>testImage</string>
										<string>flash.display</string>
										<string>MovieClip</string>
										<string>main.notemixer.test:testImage</string>
										<string>Object</string>
										<string>flash.events</string>
										<string>EventDispatcher</string>
										<string>DisplayObject</string>
										<string>InteractiveObject</string>
										<string>DisplayObjectContainer</string>
										<string>Sprite</string>
										<namespace>
											<kind>22</kind>
											<nameId>1</nameId>
										</namespace>
										<namespace>
											<kind>22</kind>
											<nameId>4</nameId>
										</namespace>
										<namespace>
											<kind>22</kind>
											<nameId>2</nameId>
										</namespace>
										<namespace>
											<kind>24</kind>
											<nameId>6</nameId>
										</namespace>
										<namespace>
											<kind>22</kind>
											<nameId>8</nameId>
										</namespace>
										<multiName>
											<queueName>
												<ns>2</ns>
												<name>5</name>
											</queueName>
										</multiName>
										<multiName>
											<queueName>
												<ns>3</ns>
												<name>3</name>
											</queueName>
										</multiName>
										<multiName>
											<queueName>
												<ns>1</ns>
												<name>7</name>
											</queueName>
										</multiName>
										<multiName>
											<queueName>
												<ns>5</ns>
												<name>9</name>
											</queueName>
										</multiName>
										<multiName>
											<queueName>
												<ns>2</ns>
												<name>10</name>
											</queueName>
										</multiName>
										<multiName>
											<queueName>
												<ns>2</ns>
												<name>11</name>
											</queueName>
										</multiName>
										<multiName>
											<queueName>
												<ns>2</ns>
												<name>12</name>
											</queueName>
										</multiName>
										<multiName>
											<queueName>
												<ns>2</ns>
												<name>13</name>
											</queueName>
										</multiName>
									</cpoolInfo>
									<methodInfo></methodInfo>
									<methodInfo></methodInfo>
									<methodInfo></methodInfo>
									<instanceInfo>
										<name>2</name>
										<superName>1</superName>
										<protectedNs>4</protectedNs>
										<iinit>1</iinit>
									</instanceInfo>
									<classInfo>
										<cinit>0</cinit>
									</classInfo>
									<scriptInfo>
										<init>2</init>
										<traitsInfo>
											<name>2</name>
											<type>4</type>
											<traitsClass>
												<slotId>1</slotId>
												<classi>0</classi>
											</traitsClass>
										</traitsInfo>
									</scriptInfo>
									<bodyInfo>
										<method>0</method>
										<maxStack>1</maxStack>
										<localCount>1</localCount>
										<initScopeDepth>9</initScopeDepth>
										<maxScopeDepth>10</maxScopeDepth>
										<code>
											<getlocal_0></getlocal_0>
											<pushscope></pushscope>
											<returnvoid></returnvoid>
										</code>
									</bodyInfo>
									<bodyInfo>
										<method>1</method>
										<maxStack>1</maxStack>
										<localCount>1</localCount>
										<initScopeDepth>10</initScopeDepth>
										<maxScopeDepth>11</maxScopeDepth>
										<code>
											<getlocal_0></getlocal_0>
											<pushscope></pushscope>
											<getlocal_0></getlocal_0>
											<constructsuper>0</constructsuper>
											<returnvoid></returnvoid>
										</code>
									</bodyInfo>
									<bodyInfo>
										<method>2</method>
										<maxStack>2</maxStack>
										<localCount>1</localCount>
										<initScopeDepth>1</initScopeDepth>
										<maxScopeDepth>9</maxScopeDepth>
										<code>
											<getlocal_0></getlocal_0>
											<pushscope></pushscope>
											<getscopeobject>0</getscopeobject>
											<getlex>3</getlex>
											<pushscope></pushscope>
											<getlex>4</getlex>
											<pushscope></pushscope>
											<getlex>5</getlex>
											<pushscope></pushscope>
											<getlex>6</getlex>
											<pushscope></pushscope>
											<getlex>7</getlex>
											<pushscope></pushscope>
											<getlex>8</getlex>
											<pushscope></pushscope>
											<getlex>1</getlex>
											<pushscope></pushscope>
											<getlex>1</getlex>
											<newclass>0</newclass>
											<popscope></popscope>
											<popscope></popscope>
											<popscope></popscope>
											<popscope></popscope>
											<popscope></popscope>
											<popscope></popscope>
											<popscope></popscope>
											<initproperty>2</initproperty>
											<returnvoid></returnvoid>
										</code>
									</bodyInfo>
								</abcFile>
							</doABC>;
			//trace(xXML.abcFile);
			xXML.abcFile.cpoolInfo.string[1] = classPackage;
			xXML.abcFile.cpoolInfo.string[2] = className;
			xXML.abcFile.cpoolInfo.string[5] = completeName;
			//trace(xXML);
			var xData:mmXML = new mmXML(xXML);
							
			var doABCEncode:DoAbcEncode = new DoAbcEncode();
			doABCEncode.dataXML = xXML;
			
			doABCEncode.data = xData.toArray();
			doABCEncode.data = doABCEncode.data.doABC;
			
			_binaryData.writeBytes(doABCEncode.binary);
		}
	}
	
}