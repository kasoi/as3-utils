package examples.quickfind.unittesting 
{
	import com.skatilsya.unittests.IUnitTestBase;
	import com.skatilsya.unittests.UnitTestBase;
	import com.skatilsya.unittests.events.UnitTestingEvent;
	import com.skatilsya.unittests.results.TestResult;
	import com.skatilsya.unittests.results.TestResultItem;
	import examples.quickfind.unions.QuickUnion;
	import examples.quickfind.unions.QuickUnionAdvanced;
	import examples.quickfind.unions.WeightedQuickUnionUF;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author me
	 */
	public class QuickUnionTest extends EventDispatcher implements IUnitTestBase 
	{
		public function get name():String 
		{
			return _name;
		}
		
		public function get result():TestResult 
		{
			return _result;
		}
		
		private var _count: int = 0;
		
		private var _result: TestResult;
		
		private var _name: String = "Union Find tests";
		
		private var testFunctions: Vector.<Function>;
		
		public function QuickUnionTest() 
		{
			this.testFunctions = new Vector.<Function>();
			this._result = new TestResult(this._name);
			
			this.addTest(testSimple);
			this.addTest(testAdvanced);
			this.addTest(testWeighted);
			this.addTest(divider);
			this.addTest(testBigSimple);
			this.addTest(testBigAdvanced);
			this.addTest(testBigWeighted);
		}
		
		public function run() : TestResult
		{
			throw new Error("It requires async call");
			return null;
		}
		
		public function runNext() : Boolean
		{
			trace('QuickUnionTest.runNext :', 'minitest ' + (_count + 1) + " completed");
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
		
		private function addTest(func: Function):void 
		{
			this.testFunctions.push(func);
		}
		
		private function divider(): TestResultItem
		{
			var res: TestResultItem = new TestResultItem(true, '--------------------');
			return res;
		}
		
		private function testWeighted() : TestResultItem 
		{
			var time: int = getTimer();
			var result: TestResultItem = new TestResultItem(true, "short array, many times: weighted UF");
			
			UnionRunner.runShortManyTimes(WeightedQuickUnionUF);
			
			result.setTime(getTimer() - time);
			return result;
		}
		
		private function testSimple() : TestResultItem
		{
			var time: int = getTimer();
			var result: TestResultItem = new TestResultItem(true, "short array, many times: quick UF");
			
			UnionRunner.runShortManyTimes(QuickUnion);
			
			result.setTime(getTimer() - time);
			return result;
		}
		
		private function testAdvanced():TestResultItem 
		{
			var time: int = getTimer();
			var result: TestResultItem = new TestResultItem(true, "short array, many times: quick UF Advanced");
			
			UnionRunner.runShortManyTimes(QuickUnionAdvanced);
			
			result.setTime(getTimer() - time);
			return result;
		}
		
		private function testBigWeighted() : TestResultItem 
		{
			var time: int = getTimer();
			var result: TestResultItem = new TestResultItem(true, "long array, less times: weighted UF");
			
			UnionRunner.runLongLessTimes(WeightedQuickUnionUF);
			
			result.setTime(getTimer() - time);
			return result;
		}
		
		private function testBigSimple() : TestResultItem 
		{
			var time: int = getTimer();
			var result: TestResultItem = new TestResultItem(true, "long array, less times: simple UF");
			
			UnionRunner.runLongLessTimes(QuickUnion);
			
			result.setTime(getTimer() - time);
			return result;
		}
		
		private function testBigAdvanced() : TestResultItem 
		{
			var time: int = getTimer();
			var result: TestResultItem = new TestResultItem(true, "long array, less times: advanced UF");
			
			UnionRunner.runLongLessTimes(QuickUnionAdvanced);
			
			result.setTime(getTimer() - time);
			return result;
		}
		
	}

}