package com.skatilsya.unittests.results 
{
	/**
	 * ...
	 * @author me
	 */
	public class TestResult 
	{
		
		private var _isPassed: Boolean;
		
		private var _items: Vector.<TestResultItem> = new Vector.<TestResultItem>();
		
		private var _name: String;
		
		public function TestResult(name: String) 
		{
			this._name = name;
		}
		
		/**
		 * in case if one unitTest class has more than 1 function, i created an addResult
		 * method that can contain as much result items as you want
		 * @param	item
		 */
		public function addResult(item: TestResultItem):void 
		{
			this._items.push(item);
		}
		
		public function get fullyPassed():Boolean 
		{
			for (var i:int = 0; i < this._items.length; i++) 
			{
				var item: TestResultItem = this._items[i];
				if (item.isPassed == false) return false;
			}
			
			return true;
		}
		
		/**
		 * check passed tests and returns it in percentage
		 * @return value from 0 to 100
		 */
		public function getPassedPercentage(): Number
		{
			var passedNum: int = 0;
			for (var i:int = 0; i < this._items.length; i++) 
			{
				var item: TestResultItem = this.items[i];
				if (item.isPassed) passedNum ++;
			}
			
			return (passedNum / this.items.length) * 100;
		}
		
		public function getFailedItems(): Vector.<TestResultItem>
		{
			var vec: Vector.<TestResultItem> = new Vector.<TestResultItem>();
			for (var i:int = 0; i < items.length; i++) 
			{
				if (items[i].isPassed == false) vec.push(items[i]);
			}
			return vec;
		}
		
		public function get totalTime(): Number
		{
			var time: Number = 0;
			for (var i:int = 0; i < items.length; i++) 
			{
				var itemTime: int = items[i].time;
				if (itemTime >= 0) time += itemTime;
			}
			
			return time;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get items():Vector.<TestResultItem> 
		{
			return _items;
		}
		
		public function toString():String 
		{
			var itemsInfo: String = "";
			for (var i:int = 0; i < items.length; i++) 
			{
				itemsInfo += "\r\n\t\t" + items[i].toString();
			}
			return "[TestResult fullyPassed=" + fullyPassed + " name=" + name + " items=\r\n\t{" + itemsInfo + "\r\n\t} ]";
		}
	}

}