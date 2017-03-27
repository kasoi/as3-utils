package examples.quickfind.unittesting 
{
	import examples.quickfind.unions.IUnion;
	/**
	 * ...
	 * @author me
	 */
	public class UnionRunner 
	{
		static public function runShortManyTimes(unionClass: Class) : void 
		{
			var ufLength: int = 1000;
			for (var i:int = 0; i < 1000; i++) 
			{
				calcTest(unionClass, ufLength);
			}
		}
		
		static public function runLongLessTimes(unionClass: Class):void 
		{
			var ufLength: int = 30000;
			for (var i:int = 0; i < 20; i++) 
			{
				calcTest(unionClass, ufLength);
			}
		}
		
		static private function calcTest(unionClass: Class, max: int):void 
		{
			var union: IUnion = new unionClass(max);
			if (union == null) 
			{
				throw new Error("The class " + unionClass + " is not implementing IUnion interface");
				return;
			}
			
			for (var i:int = 0; i < max; i ++) 
			{
				union.union(Math.random() * max, Math.random() * max);
				union.isConnected(Math.random() * max, Math.random() * max);
			}
		}
		
	}

}