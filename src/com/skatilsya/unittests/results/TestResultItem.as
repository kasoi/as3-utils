package com.skatilsya.unittests.results 
{
	/**
	 * It's just a container of information about test. Most useful information is is it passed or not
	 * but also can contain small description about what were calculated here
	 * UnitTestBase sets a running time there after all
	 * @author me
	 */
	public class TestResultItem 
	{
		private var _isPassed: Boolean;
		
		private var _time: int = -1;
		
		private var _description: String;
		
		public function TestResultItem(isPassed: Boolean, description: String = null) 
		{
			_isPassed = isPassed;
			_time = time;
			_description = description;
		}
		
		public function setTime(time: int):void 
		{
			_time = time;
		}
		
		public function get isPassed():Boolean 
		{
			return _isPassed;
		}
		
		public function get time():int 
		{
			return _time;
		}
		
		public function get description():String 
		{
			return _description;
		}
		
		public function toString():String 
		{
			return "[TestResultItem isPassed=" + isPassed + " \ttime=" + time + "ms \t\tdescription=" + description + "]";
		}
	}

}