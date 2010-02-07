package com.miguelmoraleda.xmltoswf.data 
{
	import flash.utils.ByteArray;
	
	/**
	 * This class extends from ByteArray and add writing functions to create swf files.
	 * @author Miguel Moraleda
	 * @see flash.utils.ByteArray
	 */
	public class mmByteArray extends ByteArray
	{
		/**
		 * Write a value in a number of bytes.
		 * @param	value Number to write
		 * @param	bytes how many bytes will be use
		 */
		public function writeBits(value:Number, bytes:int):void
		{
			var i:int;
			var shift:int = 0;
			var offset:int = position;
			for (i = 0; i < bytes; i++)
			{
				position = i + offset;
				shift = (bytes - 1 - i) * 8;
				writeByte((value & (0xff << shift)) >> shift);
			}
		}
		
		/**
		 * 
		 * @param	offset
		 * @param	nBits
		 * @param	value
		 * @return
		 */
		protected function encodeUB(offset:int, nBits:int, value:Number):mmByteArray
		{
			var b:mmByteArray;
			var l:int = 0;
			var hi:int;
			var lo:int;
			var shift:int;
			
			l = Math.ceil(Number(offset + nBits)/8);
			b = new mmByteArray();
			shift = (8 - ((offset + nBits) % 8));
			if (shift == 8) shift = 0;
			value = value << shift;
			b.writeBits(value, l);
			
			return b;
			
		}
		
		/**
		 * 
		 * @param	position
		 * @param	nBits
		 * @param	value
		 * @param	offset
		 */
		public function encodeByte(position:int, nBits:int, value:Number, offset:int = 0):void
		{
			var i:int;
			var aaaa:int = 0;
			
			offset %= 8;
			
			var f:mmByteArray = encodeUB((position>0) ? ((offset + nBits * position) % 8) : offset, nBits, value);
			
			if (offset == 0 && position == 0) 
			{
				this.writeByte(0);
			}
			
			this.position = length - 1;
			aaaa = readUnsignedByte();
			this.position = length - 1;
			
			f.position = 0;
			aaaa += f.readUnsignedByte();
			writeByte(aaaa);
			
			var l = f.bytesAvailable;
			for (i = 0; i < l; i++)
			{
				writeByte(f.readUnsignedByte());
			}
		}
		
		/**
		 * Write a fixed 8 bits.
		 * @param	value number
		 */
		public function writeFixed8(value:Number):void
		{
			var hi:int;
			var lo:int;
			
			hi = value;
			lo = value * 100 - hi * 100;
			
			writeByte(lo);
			writeByte(hi);
		}
		
		/**
		 * Write UI8
		 * @param	value
		 */
		public function writeUI8(value:int):void
		{
			writeByte(value);
		}
		
		/**
		 * WriteUI16
		 * @param	value
		 */
		public function writeUI16(value:int):void
		{
			var hi:int;
			var lo:int;
			
			hi = value >> 8;
			lo = value - (hi << 8);
			//trace("lo: " + lo + " hi: " + hi + " value: " + value);
			
			writeByte(lo);
			writeByte(hi);
		}
		
		/**
		 * WriteUI32
		 * @param	value
		 */
		public function writeUI32(value:int):void
		{
			var hi:int;
			var lo:int;
			
			hi = value >> 16;
			lo = value - (hi << 16);
			writeUI16(lo);
			writeUI16(hi);
		}
		
		/**
		 * WriteU30
		 * @param	value
		 */
		public function writeU30(value:int):void
		{
			writeByte(value);
		}
		
		
		/**
		 * Trace the hex representation of this class.
		 * @return string info
		 */
		override public function toString():String 
		{
			var aa:mmByteArray = new mmByteArray();
			var oldPos:int = position;
			position = 0;
			aa.writeBytes(this);
			position = oldPos;
			return aa.toString();
		}
	}
	
}
