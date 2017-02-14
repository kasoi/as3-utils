package com.skatilsya.util
{
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	* ...
	*/
	public class TextUtils 
	{
		/**
		 * 
		 * @param	str - warning, it will be htmlText
		 * @param	format
		 * @param	embedFont
		 * @return
		 */
		static public function makeOneLine(str: String, format: TextFormat, embedFont: Boolean = true) : TextField
		{
			var tf: TextField = new TextField();
			tf.defaultTextFormat = format;
			tf.htmlText = str;
			tf.selectable = false;
			tf.embedFonts = embedFont;
			tf.autoSize = TextFieldAutoSize.LEFT;
			
			return tf;
		}
		
		static public function makeMultiLine(str: String, format: TextFormat, width: Number = 200, height: Number = 100, embedFont: Boolean = true) : TextField
		{
			var tf: TextField = new TextField();
			tf.defaultTextFormat = format;
			tf.width = width;
			tf.height = height;
			tf.htmlText = str;
			tf.selectable = false;
			tf.multiline = true;
			tf.wordWrap = true;
			tf.embedFonts = embedFont;
			
			return tf;
		}
		
		/*
		 * Applies advanced thickness and sharpness. Does the same as makeOneLine
		 */
		static public function makeTitle(str: String, format: TextFormat) : TextField
		{
			var tf: TextField = new TextField();
			tf.defaultTextFormat = format;
			tf.htmlText = str;
			tf.selectable = false;
			tf.embedFonts = true;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			tf.thickness += 40;
			tf.sharpness += 10;
			
			return tf;
		}
		
		static public function solveDoubleLineBug(field: TextField) : void 
		{
			var lineStr: String = String.fromCharCode(13);
			field.text = field.text.split(lineStr).join('\n');
		}
		
		/**
		 * 
		 * @param	width
		 * @param	field
		 * @return	font size
		 */
		static public function fitSizeToWidth(width: int, field: TextField) : Number
		{
			if (field.width > width)
			{
				var size: Number = Number(field.defaultTextFormat.size);
				var scale: Number = width / (field.width + 6);
				size = size * scale;
				var format: TextFormat = field.defaultTextFormat;
				format.size = size;
				field.setTextFormat(format, 0, field.length);
				field.width = width;
				return size;
			}
			return Number(field.defaultTextFormat.size);
		}
		
		static public function addCurrency(field: TextField, symbol: String, format: TextFormat) : void 
		{
			field.appendText(symbol);
			field.setTextFormat(format, field.length - 1, field.length);
		}
		
		static public function divideNumBySpaces(num: Number) : String
		{
			var str: String = '' + num;
			var before: String = str.split('.')[0];
			var len: int = before.length;
			var result: String = before;
			if (len > 3) 
			{
				result = '';
				var c: int = 0;
				for (var i: int = len - 1; i >= 0; i--) 
				{
					if (c % 3 == 0 && c != 0) result = ' ' + result;
					result = before.charAt(i) + result;
					c++;
				}
			}
			
			return result;
		}
	}
	
}