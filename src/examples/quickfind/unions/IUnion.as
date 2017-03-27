package examples.quickfind.unions 
{
	
	/**
	 * ...
	 * @author me
	 */
	public interface IUnion 
	{
		function isConnected(p: int, q: int) : Boolean;
		
		function union(p: int, q: int) : void;
		
		//function getIds() : Vector.<int>;
	}
	
}