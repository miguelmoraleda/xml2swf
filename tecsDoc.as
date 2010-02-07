xml2swf es una libreria open source la cual permite la creacion de archivos SWF.


Como funciona?
La libreria se basa en la especificacion de SWF y va escribiendo en un byteArray cada byte necesario para crear los archivos SWF.

Features
- permite crear archivos swf con movieclips dentro. Los movieclips tienen un linkage name, lo cual permite su facil uso dentro de nuestras aplicaciones.

Goals
- multiples movieclip dentro de los SWF (por ahora solo permite crear MC por SWF)
- soporte para Fuentes, sonidos y videos.




SAMPLE

XML structure

<movie>
	<library>
		<imagesData>
			<images>
				<characterId>1</characterId>
				<source>assets/image1.png</source>
				<format><JPEG3>90</JPEG3></format>
			</images>
			<images>
				<characterId>2</characterId>
				<source>assets/image2.png</source>
				<format><JPEG3>90</JPEG3></format>
			</images>
		</imagesData>
		<clip>
			<class>main.notemixer.test.testImage</class>
			<frames>
				<place>
					<id>1</id>
					<x>0</x>
					<y>0</y>
				</place>
				<place>
					<id>2</id>
					<x>0</x>
					<y>0</y>
				</place>
			</frames>
		</clip>
	</library>
</movie>