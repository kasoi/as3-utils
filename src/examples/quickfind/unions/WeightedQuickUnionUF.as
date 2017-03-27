package examples.quickfind.unions 
{
	/**
	 * ...
	 * @author me
	 */
	public class WeightedQuickUnionUF implements IUnion
	{
		
		public function get count() : int
		{
			return _count;
		}
		
		private var parent: Vector.<int>;
		private var size: Vector.<int>;
		private var _count: int;
		
		public function WeightedQuickUnionUF(size: int) 
		{
			_count = size;
			parent = new Vector.<int>(size);
			size = new Vector.<int>(size);
			for (var i:int = 0; i < size; i++) 
			{
				parent[i] = i;
				size[i] = i;
			}
		}
		
		public function find(p: int) : int
		{
			validate(p);
			while (p != parent[p])
				p = parent[p];
			return p;
		}
		
		public function isConnected(p: int, q: int) : Boolean
		{
			return find(p) == find(q);
		}
		
		public function union(p: int, q: int) : void 
		{
			var rootP: int = find(p);
			var rootQ: int = find(q);
			if (rootP == rootQ) return;
			
			if (size[rootP] < size[rootQ]) 
			{
				parent[rootP] = rootQ;
				size[rootQ] += size[rootP];
			}
			else
			{
				parent[rootQ] = rootP;
				size[rootP] += size[rootQ];
			}
			_count --;
		}
		
		private function validate(p: int) : void
		{
			var n: int = parent.length;
			if (p < 0 || p >= n) throw new RangeError("index " + p + " is not between 0 and " + (n + 1));
		}
		
	}

}