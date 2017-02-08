package com.skatilsya.math
{
	
	public class MathColor
	{
		/**
		 * Comparing two colors and returning true if they are similar in selected threshold area
		 * 
		 * on example: 0xff0000 and 0xf90000 are similar with treshold 10
		 * 
		 * @param	color1
		 * @param	color2
		 * @param	treshold
		 * @return
		 */
		public static function colorsAreSimilar(color1: uint, color2: uint, treshold: int):Boolean
		{
			var r: uint = color1 >> 16 & 0xFF;
			var g: uint = color1 >> 8 & 0xFF;
			var b: uint = color1 & 0xFF;
			
			var r2: uint = color2 >> 16 & 0xFF;
			var g2: uint = color2 >> 8 & 0xFF;
			var b2: uint = color2 & 0xFF;
			
			var diff: int = Math.abs(r - r2);
			var maxDifference: int = diff;
			diff = Math.abs(g - g2);
			if (maxDifference < diff) maxDifference = diff;
			diff = Math.abs(b - b2);
			if (maxDifference < diff) maxDifference = diff;
			
			return maxDifference < treshold;
		}
		
	}

}
