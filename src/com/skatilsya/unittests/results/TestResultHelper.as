package com.skatilsya.unittests.results 
{
	/**
	 * ...
	 * @author me
	 */
	public class TestResultHelper 
	{
		private var results: Vector.<TestResult>;
		
		public function TestResultHelper(results: Vector.<TestResult>):void 
		{
			this.results = results;
		}
		
		public function getFailedTests() : Vector.<TestResult>
		{
			var vec: Vector.<TestResult> = new Vector.<TestResult>();
			
			for (var i:int = 0; i < results.length; i++) 
			{
				if (results[i].fullyPassed == false) vec.push(results[i]);
			}
			
			return vec;
		}
		
		public function getPassedTests(): Vector.<TestResult>
		{
			var vec: Vector.<TestResult> = new Vector.<TestResult>();
			
			for (var i:int = 0; i < results.length; i++) 
			{
				if (results[i].fullyPassed == true) vec.push(results[i]);
			}
			
			return vec;
		}
		
		public function getAllFailedTestItems(): Vector.<TestResultItem> 
		{
			var vec: Vector.<TestResultItem> = new Vector.<TestResultItem>();
			
			for (var i:int = 0; i < results.length; i++) 
			{
				var result: TestResult = results[i];
				if (result.fullyPassed)
				{
					vec = vec.concat(result.getFailedItems());
				}
			}
			
			return vec;
		}
		
	}

}