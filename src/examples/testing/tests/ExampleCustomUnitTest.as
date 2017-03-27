package examples.testing.tests 
{
	import com.skatilsya.unittests.IUnitTestBase;
	import com.skatilsya.unittests.events.UnitTestingEvent;
	import com.skatilsya.unittests.results.TestResult;
	import com.skatilsya.unittests.results.TestResultItem;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	/**
	 * This unittest is handmade and has its own run calculations
	 * @author me
	 */
	public class ExampleCustomUnitTest extends EventDispatcher implements IUnitTestBase
	{
		public function get name():String 
		{
			return _name;
		}
		
		public function get result():TestResult 
		{
			return _result;
		}
		
		private var _name: String;
		
		private var _count: int = 0;
		
		private var testFunctions: Vector.<Function>;
		
		private var _result: TestResult;
		
		
		public function ExampleCustomUnitTest() 
		{
			this.testFunctions = new Vector.<Function>();
			this._name = "Example unit test written only by implementing interface";
			this._result = new TestResult(this._name);
			
			testFunctions.push(test);
			testFunctions.push(test2);
		}
		
		public function run(): TestResult
		{
			var start: int = getTimer();
			
			var result: TestResult = new TestResult(this._name);
			result.addResult(test());
			return result;
		}
		
		public function runNext() : Boolean 
		{
			if (testFunctions.length == 0)
			{
				throw new Error("You didn't added any test by calling addTest(func: Function). "
					+ "Please check if everything is right with your code. [" + getQualifiedClassName(this) + "]");
			}
			
			var func: Function = testFunctions[this._count];
			var startTime: int = getTimer();
			var item: TestResultItem = func() as TestResultItem;
			if (!item is TestResultItem)
			{
				throw new Error("Can't get result of your function as TestResultItem, please check if everything is correct");
			}
			var endTime: int = getTimer();
			item.setTime(endTime - startTime);
			
			_result.addResult(item);
			
			this._count ++;
			
			this.dispatchEvent(new UnitTestingEvent(UnitTestingEvent.MINITEST_COMPLETE, this._result));
			return this._count == this.testFunctions.length;
		}
		
		private function test2() : TestResultItem
		{
			var startTime: int = getTimer();
			recursion(0);
			
			var item: TestResultItem = new TestResultItem(true, "custom time tracking test #2");
			item.setTime(getTimer() - startTime);
			
			return item;
		}
		
		private function recursion(i: int) : int
		{
			var max: int = 25;
			if (i < max) return (recursion(i + 1) + recursion(i + 2));
			return max + 1;
		}
		
		private function test(): TestResultItem
		{
			for (var j:int = 0; j < 1000; j++) 
			{
				var temp: String = "we're not calculating time right here";
			}
			
			var startTime: int = getTimer();
			for (var i:int = 0; i < 666666; i++) 
			{
				var abc: String = String("hello, world").toUpperCase().toLowerCase();
			}
			
			var item: TestResultItem = new TestResultItem(true, "custom time tracking test");
			item.setTime(getTimer() - startTime);
			
			return item;
		}
	}

}