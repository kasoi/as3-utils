package examples.quickfind 
{
	import com.skatilsya.unittests.UnitTesting;
	import com.skatilsya.unittests.events.UnitTestingEvent;
	import com.skatilsya.unittests.results.TestResult;
	import examples.quickfind.unions.QuickUnion;
	import examples.quickfind.unittesting.QuickUnionTest;
	import flash.display.Sprite;
	
	/**
	 * 
	 * @author me
	 */
	public class UnionsExample extends Sprite 
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
		
		public function UnionsExample() 
		{
			this.init();
		}
		
		////////////////////////////////////////////////////////////////////
		// Private methods
		////////////////////////////////////////////////////////////////////
		
		private function init() : void
		{
			//this.simpleQuickUnionTest();
			
			this.unitTestRun();
		}
		
		private function unitTestRun():void 
		{
			var test: UnitTesting = new UnitTesting();
			test.addUnitTestClass(QuickUnionTest);
			
			test.addEventListener(UnitTestingEvent.UNITTESTING_COMPLETE, test_onComplete);
			test.runAsync();
		}
		
		private function test_onComplete(e:UnitTestingEvent):void 
		{
			trace('UnionsExample.test_onComplete :', (e.currentTarget as UnitTesting).getResults());
			/**
			 * So as we can see, working with small arrays can be harmful with WeightedUF
			 * but as array growths (starting from 10k items), the time to work with it grows much more with simple UF algorithms
			 */
		}
		
		private function simpleQuickUnionTest():void 
		{
			var union: QuickUnion = new QuickUnion(10);
			
			trace('UnionsExample.quickUnion :', union.getIds());
			
			union.union(1, 2);
			
			trace('UnionsExample.quickUnion :', union.getIds());
			
			union.union(4, 3);
			
			trace('UnionsExample.quickUnion :', union.getIds());
			
			union.union(3, 6);
			
			trace('UnionsExample.quickUnion :', union.getIds());
			
			union.union(1, 6);
			
			trace('UnionsExample.quickUnion :', union.getIds());
		}
		
		
		
		////////////////////////////////////////////////////////////////////
		// Listeners
		////////////////////////////////////////////////////////////////////
		
	}
	
}