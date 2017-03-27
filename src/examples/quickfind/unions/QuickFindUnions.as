package examples.quickfind.unions 
{
	/**
	 * ...
	 * @author me
	 */
	public class QuickFindUnions 
	{
		
		private var id: Vector.<int>;
		
		public function QuickFindUnions(size: int) 
		{
			id = new Vector.<int>();
			
			for (var i:int = 0; i < size; i++) 
			{
				id[i] = i;
			}
		}
		
		public function isConnected(indexA: int, indexB: int): Boolean
		{
			return id[indexA] == id[indexB];
		}
		
		public function union(p: int, q: int):void 
		{
			var pid: int = id[p];
			var qid: int = id[q];
			for (var i:int = 0; i < id.length; i++) 
			{
				if (id[i] == pid) id[i] = qid;
			}
		}
		
	}

}