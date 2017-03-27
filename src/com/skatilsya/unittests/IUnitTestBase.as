package com.skatilsya.unittests 
{
	import com.skatilsya.unittests.results.TestResult;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	 * all what UnitTesting needs from your object is to know results and name of your object
	 * follow these short comments if you want to create custom IUnitTestBase
	 * @author me
	 */
	public interface IUnitTestBase extends IEventDispatcher
	{
		/**
		 * it's obvious enough tho
		 */
		function get name() : String;
		
		function get result() : TestResult;
		
		/**
		 * this method will be called when you executing UnitTesting().run()
		 * it just called all the method in one cycle and returning TestResult which should
		 * contain TestResultItem for each minitest
		 * @return
		 */
		function run() : TestResult;
		
		/**
		 * in case when you have billions minitests which can cause an exceeding of 15 seconds limit
		 * it's better to call runAsync in UnitTesting, which will call runNext in your unitTestBase
		 * and it should return true if you have new one minitest and false if you ran all of the 
		 * minitests in this test
		 * 
		 * every minitest completion should dispatch UnitTestingEvent.MINITEST_COMPLETED
		 */
		function runNext() : Boolean;
	}
	
}