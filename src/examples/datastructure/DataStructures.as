package examples.datastructure 
{
	import examples.datastructure.stack.LinkedStack;
	import flash.display.Sprite;
	
	/**
	 * 
	 * @author me
	 */
	public class DataStructures extends Sprite 
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
		
		public function DataStructures() 
		{
			this.init();
		}
		
		////////////////////////////////////////////////////////////////////
		// Private methods
		////////////////////////////////////////////////////////////////////
		
		private function init() : void
		{
			var stack: LinkedStack = new LinkedStack();
			stack.push("a");
			stack.push("b");
			stack.push("c");
			
			var vec: Vector.<Array>
			
			while (stack.isEmpty() == false)
			{
				trace('DataStructures.init :', stack.pop());
			}
		}
		
		////////////////////////////////////////////////////////////////////
		// Listeners
		////////////////////////////////////////////////////////////////////
		
	}
	
}