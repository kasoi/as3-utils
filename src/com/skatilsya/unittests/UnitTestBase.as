package com.skatilsya.unittests 
{
	import com.skatilsya.unittests.events.UnitTestingEvent;
	import com.skatilsya.unittests.results.TestResult;
	import com.skatilsya.unittests.results.TestResultItem;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	/**
	 * Extend this class to make your own unit test and then set it to UnitTesting
	 * if you want to run an array of tests
	 * @author me
	 */
	public class UnitTestBase extends EventDispatcher implements IUnitTestBase
	{
		
		private var _result: TestResult;
		
		private var testFunctions: Vector.<Function> = new Vector.<Function>();
		
		private var _name: String;
		
		private var _count: int = 0;
		
		public function UnitTestBase(name: String) 
		{
			this._name = name;
			_result = new TestResult(this.name);
		}
		
		final public function run() : TestResult
		{
			if (testFunctions.length == 0)
			{
				throw new Error("You didn't added any test by calling addTest(func: Function). "
					+ "Please check if everything is right with your code. [" + getQualifiedClassName(this) + "]");
			}
			
			for (var i:int = 0; i < testFunctions.length; i++) 
			{
				var func: Function = testFunctions[i];
				
				var startTime: int = getTimer();
				var item: TestResultItem = func() as TestResultItem;
				if (!item is TestResultItem)
				{
					throw new Error("Can't get result of your function as TestResultItem, please check if everything is correct");
				}
				var endTime: int = getTimer();
				item.setTime(endTime - startTime);
				
				_result.addResult(item);
			}
			
			return _result;
		}
		
		/**
		 * this is for async testing. Call it until it returns "true"
		 * @return
		 */
		final public function runNext() : Boolean
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
		
		/**
		 * add your test method here. It should return TestResultItem
		 * (like [  function base64ToPNG() : TestResultItem { return new TestResultItem();}  ] )
		 * i guess it's not really accurate, but i do not want to require
		 * new command class just to call execute() from there. So be careful.
		 * (and when i learned a bit of C# i realized that i miss delegates)
		 * @param	testFunction
		 */
		protected function addTest(testFunction: Function):void 
		{
			this.testFunctions.push(testFunction);
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get result():TestResult 
		{
			return _result;
		}
		
	}

}