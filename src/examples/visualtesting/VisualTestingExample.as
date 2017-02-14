package examples.visualtesting 
{
	import com.skatilsya.visualtests.VisualTesting;
	import examples.visualtesting.tests.SimpleTextButtonTest;
	import examples.visualtesting.tests.SquaresTest;
	import flash.display.Sprite;
	
	/**
	 * 
	 * @author me
	 */
	public class VisualTestingExample extends Sprite 
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
		
		public function VisualTestingExample() 
		{
			this.init();
		}
		
		////////////////////////////////////////////////////////////////////
		// Private methods
		////////////////////////////////////////////////////////////////////
		
		private function init() : void
		{
			this.graphics.beginFill(0x000, 0.3);
			this.graphics.drawRect(0, 0, 800, 600);
			this.graphics.endFill();
			
			var testing: VisualTesting = new VisualTesting();
			
			var arr: Array = [SquaresTest, SimpleTextButtonTest];
			var len: int = 9+ Math.random() * 40;
			trace('VisualTestingExample.init :', len);
			for (var i:int = 0; i < len; i++) 
			{
				var cl: Class = arr[int(Math.random() * arr.length)];
				testing.addTestClass(cl);
			}
			addChild(testing);
			
			//trace('VisualTestingExample.init :', );
		}
		
		////////////////////////////////////////////////////////////////////
		// Listeners
		////////////////////////////////////////////////////////////////////
		
	}
	
}