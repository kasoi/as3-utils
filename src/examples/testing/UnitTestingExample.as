package examples.testing 
{
	import com.skatilsya.unittests.UnitTesting;
	import com.skatilsya.unittests.events.UnitTestingEvent;
	import com.skatilsya.unittests.results.TestResult;
	import com.skatilsya.unittests.results.TestResultHelper;
	import examples.testing.tests.ExampleCustomUnitTest;
	import examples.testing.tests.ExampleUnitTest;
	import examples.testing.tests.ReallyLongUnitTest;
	import flash.display.Sprite;
	
	/**
	 * Simple example of simple unit test system
	 * @author me
	 */
	public class UnitTestingExample extends Sprite 
	{
		
		////////////////////////////////////////////////////////////////////
		// Public properties
		////////////////////////////////////////////////////////////////////
		
		////////////////////////////////////////////////////////////////////
		// Private properties
		////////////////////////////////////////////////////////////////////
		
		////////////////////////////////////////////////////////////////////
		// Public methods
		////////////////////////////////////////////////////////////////////
		
		public function UnitTestingExample() 
		{
			this.defaultUsage();
			//this.timeoutTesting(); // uncomment it if you want to wait until you get timeout exception
			/**
			 * And this one will work even if you have a huge amount of tests or large ones
			 * Be careful that if your test is large by itself (like just one can work for a minute), you
			 * need to create your test class by implementing interface and make async calls of tests inside
			 */
			//this.asyncTesting(); 
		}
		
		////////////////////////////////////////////////////////////////////
		// Private methods
		////////////////////////////////////////////////////////////////////
		
		private function defaultUsage() : void
		{
			// all what you need is to create example of UnitTesting class
			var testing: UnitTesting = new UnitTesting();
			// then pass to it your unit test classes
			testing.addUnitTestClass(ExampleUnitTest);
			testing.addUnitTestClass(ExampleCustomUnitTest);
			// then get results just by calling run() method
			var results: Vector.<TestResult> = testing.run();
			// you're awesome!
			var helper: TestResultHelper = new TestResultHelper(results);
			var passedNum: int = helper.getPassedTests().length;
			var totalNum: int = results.length;
			trace('UnitTestingExample.defaultUsage :', 'tests passed: ' + passedNum + " / " + totalNum);
			trace('UnitTestingExample.defaultUsage :', 'failed tests: ' + helper.getFailedTests());
			trace('UnitTestingExample.defaultUsage :', 'first result total time: ' + results[0].totalTime);
			trace('UnitTestingExample.defaultUsage :', 'first result first item time: ' + results[0].items[0].time);
			trace('Main.init :', results);
		}
		
		private function timeoutTesting():void 
		{
			var testing: UnitTesting = new UnitTesting();
			
			for (var i:int = 0; i < 1000; i++) 
			{
				testing.addUnitTestClass(ReallyLongUnitTest);
			}
			
			var results: Vector.<TestResult> = testing.run();
			
			trace('UnitTestingExample.timeoutTesting :', results);
		}
		
		private function asyncTesting():void 
		{
			var testing: UnitTesting = new UnitTesting();
			
			for (var i:int = 0; i < 100; i++) 
			{
				testing.addUnitTestClass(ReallyLongUnitTest);
			}
			
			testing.addEventListener(UnitTestingEvent.SINGLE_TEST_COMPLETE, this.testing_onSingleTestCompleted);
			testing.addEventListener(UnitTestingEvent.UNITTESTING_COMPLETE, this.testing_onUnitTestingComplete);
			
			testing.runAsync();
		}
		
		////////////////////////////////////////////////////////////////////
		// Listeners
		////////////////////////////////////////////////////////////////////
		
		private function testing_onUnitTestingComplete(e:UnitTestingEvent):void 
		{
			var results: Vector.<TestResult> = (e.currentTarget as UnitTesting).getResults();
			
			trace('UnitTestingExample.testing_onUnitTestingComplete :', 'tests passed: ' + new TestResultHelper(results).getPassedTests().length + " of " + results.length);
		}
		
		private function testing_onSingleTestCompleted(e: UnitTestingEvent):void 
		{
			trace('UnitTestingExample.testing_onSingleTestCompleted :', e.result);
		}
	}
	
}