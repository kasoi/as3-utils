package examples.visualtesting.tests 
{
	import com.skatilsya.visualtests.VisualTestBase;
	import com.skatilsya.visualtests.ui.SimpleTextButton;
	import flash.display.Sprite;
	
	/**
	 * 
	 * @author me
	 */
	public class SimpleTextButtonTest extends VisualTestBase 
	{
		
		////////////////////////////////////////////////////////////////////
		// Public properties
		////////////////////////////////////////////////////////////////////
		
		////////////////////////////////////////////////////////////////////
		// Private properties
		////////////////////////////////////////////////////////////////////
		
		private var button: SimpleTextButton;
		
		////////////////////////////////////////////////////////////////////
		// Public methods
		////////////////////////////////////////////////////////////////////
		
		public function SimpleTextButtonTest() 
		{
			this.init("SimpleTextButton testing");
			this.addOption("add button", this.addButton);
			this.addOption("kill button", this.killButton);
			this.addOption("show", this.showButton);
			this.addOption("hide", this.hideButton);
			
			/**
			 * sample test. It can help you to detect some bugs and after code changing you 
			 * will be able to test it again. At least this test (feb 2017) helps you to detect
			 * that it's written not good for not prepared users (you can create many buttons
			 * but able to kill only last one and any calling of button without creating of it 
			 * causes an error. And anyway there is one more bug: button is shown by default but when
			 * you call "show()" method, it will blink. And then work as planned. So testing works: we found some bugs!)
			 */
		}
		
		////////////////////////////////////////////////////////////////////
		// Private methods
		////////////////////////////////////////////////////////////////////
		
		private function addButton():void 
		{
			this.button = new SimpleTextButton("Testing button");
			this.addChild(this.button);
		}
		
		private function killButton():void 
		{
			this.button.destroy();
			this.removeChild(this.button);
			this.button = null;
		}
		
		private function showButton():void 
		{
			this.button.show();
		}
		
		private function hideButton():void 
		{
			this.button.hide();
		}
		
		////////////////////////////////////////////////////////////////////
		// Listeners
		////////////////////////////////////////////////////////////////////
		
	}
	
}