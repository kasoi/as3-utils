package com.skatilsya.math 
{
	/**
	 * ...
	 * @author me
	 */
	public class MathUtil 
	{
		
		/**
		 * be careful: this method is really slow on big values
		 * 
		 * @param	num
		 * @return fibonacci of selected number. E.g. fibonacci(5) = 1 + 1 + 2 + 3 + 5 = 12
		 */
		static public function fibonacci(num: int) : int
		{
			if (num < 1) return 0;
			if (num == 1 || num == 2) return 1;
			else return fibonacci(num - 1) + fibonacci(num - 2);
		}
		
		public function MathUtil() 
		{
			
		}
		
	}

}