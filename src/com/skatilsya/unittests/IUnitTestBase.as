package com.skatilsya.unittests 
{
	import com.skatilsya.unittests.results.TestResult;
	
	/**
	 * all what UnitTesting needs from your object is to know results and name of your object
	 * @author me
	 */
	public interface IUnitTestBase 
	{
		function get name() : String;
		
		function run() : TestResult;
	}
	
}