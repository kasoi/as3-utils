package com.skatilsya.math 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author me
	 */
	public class PureMath 
	{
		
		static public function lg(value: Number) : Number
		{
			return logOfBase(10, value);
		}
		
		static public function logOfBase(base: Number, value: Number) : Number 
		{
			return Math.log(value) / Math.log(base);
		}
		
		static public function ln(value: Number): Number 
		{
			return Math.log(value);
		}
		
	}

}