package examples.visualtesting.tests 
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Cubic;
	import com.skatilsya.visualtests.VisualTestBase;
	import flash.display.Sprite;
	
	/**
	 * 
	 * @author me
	 */
	public class SquaresTest extends VisualTestBase
	{
		
		////////////////////////////////////////////////////////////////////
		// Public properties
		////////////////////////////////////////////////////////////////////
		
		////////////////////////////////////////////////////////////////////
		// Private properties
		////////////////////////////////////////////////////////////////////
		
		private var container: Sprite;
		
		////////////////////////////////////////////////////////////////////
		// Public methods
		////////////////////////////////////////////////////////////////////
		
		public function SquaresTest() 
		{	
			this.init("Squares test thing");
			
			this.container = new Sprite();
			this.addChild(this.container);
			
			this.addOption("add square", this.addSquare);
			this.addOption("move rnd square", this.moveRandomSquare);
			this.addOption("remove rnd square", this.removeRandomSquare);
		}
		
		override public function destroy():void 
		{
			super.destroy();
			
			while (this.container.numChildren > 0) 
			{
				this.container.removeChildAt(0);
			}
		}
		
		////////////////////////////////////////////////////////////////////
		// Private methods
		////////////////////////////////////////////////////////////////////
		
		private function addSquare():void 
		{
			var sq: Sprite = new Sprite();
			sq.graphics.beginFill(Math.random() * 0xffffff, 0.4);
			sq.graphics.drawRect(0, 0, 55, 55);
			sq.graphics.endFill();
			
			sq.x = Math.random() * 300;
			sq.y = Math.random() * 200;
			
			container.addChild(sq);
		}
		
		private function moveRandomSquare():void 
		{
			var sq: Sprite = container.getChildAt(Math.random() * container.numChildren) as Sprite;
			
			TweenLite.to(sq, 0.5, {x: Math.random() * 300, y: Math.random() * 200, ease: Cubic.easeOut});
		}
		
		private function removeRandomSquare():void 
		{
			var sq: Sprite = container.getChildAt(Math.random() * container.numChildren) as Sprite;
			if (sq != null)
			{
				TweenLite.killTweensOf(sq);
				container.removeChild(sq);
				sq = null;
			}
		}
		
		////////////////////////////////////////////////////////////////////
		// Listeners
		////////////////////////////////////////////////////////////////////
		
	}
	
}