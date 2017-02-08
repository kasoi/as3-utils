package examples.testing.tests 
{
	import com.skatilsya.unittests.results.TestResultItem;
	import com.skatilsya.unittests.UnitTestBase;
	import flash.geom.Point;
	/**
	 * ...
	 * @author me
	 */
	public class ExampleUnitTest extends UnitTestBase
	{
		
		public function ExampleUnitTest() 
		{
			super("Example test");
			
			addTest(testMillionSquares);
			addTest(failedTest);
		}
		
		private function testMillionSquares(): TestResultItem
		{
			var length: int = Math.pow(10, 6);
			for (var i:int = 0; i < length; i++) 
			{
				var a: Number = Math.random();
				a = a * a;
			}
			
			return new TestResultItem(true, "billion squares");
		}
		
		private function failedTest(): TestResultItem
		{
			for (var i:int = 0; i < 100000; i++) 
			{
				String("It's a failed test").toLowerCase().toUpperCase();
			}
			return new TestResultItem(false, "failed test");
		}
		
	}

}