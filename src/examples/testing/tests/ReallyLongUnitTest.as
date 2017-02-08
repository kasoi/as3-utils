package examples.testing.tests 
{
	import com.skatilsya.unittests.UnitTestBase;
	import com.skatilsya.unittests.results.TestResultItem;
	/**
	 * ...
	 * @author me
	 */
	public class ReallyLongUnitTest extends UnitTestBase
	{
		
		public function ReallyLongUnitTest() 
		{
			super("Time wasting unit test");
			addTest(test);
		}
		
		private function test(): TestResultItem
		{
			for (var i:int = 0; i < 1000*1000; i++) 
			{
				var abc: String = String("Lorem ipsum dolor sit amet").toUpperCase().toLowerCase();
			}
			
			var item: TestResultItem = new TestResultItem(true);
			return item;
		}
		
	}

}