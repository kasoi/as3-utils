package com.skatilsya.unittests.events 
{
	import com.skatilsya.unittests.results.TestResult;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author me
	 */
	public class UnitTestingEvent extends Event 
	{
		
		static public const SINGLE_TEST_COMPLETE: String = "singleTestComplete";
		
		static public const UNITTESTING_COMPLETE: String = "unitTestingComplete";
		
		public var result: TestResult;
		
		public function UnitTestingEvent(type:String, result: TestResult = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.result = result;
		} 
		
		public override function clone():Event 
		{ 
			return new UnitTestingEvent(type, this.result, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("UnitTestingEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}