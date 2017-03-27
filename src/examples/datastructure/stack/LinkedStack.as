package examples.datastructure.stack 
{
	/**
	 * ...
	 * @author me
	 */
	public class LinkedStack
	{
		private var first: Node = null;
		
		public function LinkedStack() 
		{
			
		}
		
		public function isEmpty() : Boolean
		{
			return first == null;
		}
		
		public function push(item: String) : void
		{
			var oldfirst: Node = first;
			first = new Node();
			first.item = item;
			first.next = oldfirst;
		}
		
		public function pop() : String
		{
			var item: String = first.item;
			first = first.next;
			return item;
		}
		
	}

}
	
	class Node
	{
		public var item: String;
		
		public var next: Node;
	}