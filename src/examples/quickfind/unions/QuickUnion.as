package examples.quickfind.unions 
{
	/**
	 * ...
	 * @author me
	 */
	public class QuickUnion implements IUnion
	{
		
		private var ids: Vector.<int>;
		
		public function QuickUnion(size: int) 
		{
			this.ids = new Vector.<int>();
			
			for (var i:int = 0; i < size; i++) 
			{
				ids[i] = i;
			}
		}
		
		private function root(i: int):int
		{
			while (i != ids[i]) i = ids[i];
			return i;
		}
		
		public function isConnected(p: int, q: int): Boolean
		{
			return root(p) == root(q);
		}
		
		public function union(p: int, q: int):void 
		{
			var i: int = root(p);
			var j: int = root(q);
			ids[i] = j;
		}
		
		public function getIds(): Vector.<int>
		{
			return ids;
		}
		
	}

}