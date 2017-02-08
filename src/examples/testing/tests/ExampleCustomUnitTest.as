package examples.testing.tests 
{
	import com.skatilsya.unittests.IUnitTestBase;
	import com.skatilsya.unittests.results.TestResult;
	import com.skatilsya.unittests.results.TestResultItem;
	import flash.utils.getTimer;
	/**
	 * This unittest is handmade and has its own run calculations
	 * @author me
	 */
	public class ExampleCustomUnitTest implements IUnitTestBase
	{
		private var _name: String;
		
		public function ExampleCustomUnitTest() 
		{
			this._name = "Example unit test written only by implementing interface";
		}
		
		public function run(): TestResult
		{
			var start: int = getTimer();
			
			var result: TestResult = new TestResult(this._name);
			result.addResult(test());
			return result;
		}
		
		public function get name():String 
		{
			return _name;
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