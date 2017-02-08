package com.skatilsya.unittests 
{
	import com.skatilsya.unittests.events.UnitTestingEvent;
	import com.skatilsya.unittests.results.TestResult;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.describeType;
	import flash.utils.getAliasName;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author me
	 */
	public class UnitTesting extends EventDispatcher
	{
		/// @eventType	com.skatilsya.unittests.events.UnitTestingEvent.UNITTESTING_COMPLETE
		[Event(name="unitTestingComplete", type="com.skatilsya.unittests.events")] 
		
		/// @eventType	com.skatilsya.unittests.events.UnitTestingEvent.SINGLE_TEST_COMPLETE
		[Event(name="singleTestComplete", type="com.skatilsya.unittests.events")] 
		
		public function getResults(): Vector.<TestResult>
		{
			return results;
		}
		
		private var results: Vector.<TestResult>;
		
		private var testClasses: Vector.<Class>;
		
		private var asyncTestCount: int = -1;
		
		public function UnitTesting() 
		{
			testClasses = new Vector.<Class>();
		}
		
		/**
		 * Call it and get all the results of tests
		 * @return
		 */
		public function run(): Vector.<TestResult> 
		{
			results = new Vector.<TestResult>();
			
			for (var i:int = 0; i < testClasses.length; i++) 
			{
				var unitCLass: Class = testClasses[i];
				var testUnit: IUnitTestBase = new unitCLass() as IUnitTestBase;
				
				results.push(testUnit.run());
			}
			
			return results;
		}
		
		/**
		 * In case if your tests are really big and causing timeout error, you can try async test running.
		 * You need to catch UnitTestingEvent and catch every result by yourself
		 * @return
		 */
		public function runAsync(): void
		{
			this.asyncTestCount = 0;
			this.results = new Vector.<TestResult>();
			this.runNextTest();
		}
		
		public function runNextTest():void 
		{
			var unit: Class = testClasses[asyncTestCount];
			var testUnit: IUnitTestBase = new unit() as IUnitTestBase;
			
			var result: TestResult = testUnit.run();
			results.push(result);
			this.dispatchEvent(new UnitTestingEvent(UnitTestingEvent.SINGLE_TEST_COMPLETE, result));
			
			asyncTestCount++;
			if (asyncTestCount >= testClasses.length) 
			{
				this.dispatchEvent(new UnitTestingEvent(UnitTestingEvent.UNITTESTING_COMPLETE));
				
				return;
			}
			
			setTimeout(runNextTest, 10); // just to let the program window be closeable
		}
		
		/**
		 * this method receives an extended of UnitTestBase class which will be created and ran in "run" method.
		 * If you don't want to extend UnitTestBase for some reason, you can implement IUnitTestBase interface
		 * @param	unit
		 */
		public function addUnitTestClass(unit: Class):void 
		{
			testClasses.push(unit);
		}
		
	}

}