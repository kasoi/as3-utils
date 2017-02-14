package com.skatilsya.visualtests 
{
	import com.skatilsya.events.ElementEvent;
	import com.skatilsya.util.TextUtils;
	import com.skatilsya.visualtests.ui.SimpleTextButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	/**
	 * 
	 * @author kasoi
	 */
	public class VisualTestBase extends Sprite 
	{
		
		////////////////////////////////////////////////////////////////////
		// Public properties
		////////////////////////////////////////////////////////////////////
		
		////////////////////////////////////////////////////////////////////
		// Private properties
		////////////////////////////////////////////////////////////////////
		
		private var title: TextField;
		
		private var background: Sprite;
		
		private var options: Vector.<SimpleTextButton>;
		
		private var optionsDictionary: Dictionary;
		
		private var optionsContainer: Sprite;
		
		private var maxWidth: Number;
		
		private var linkX: Number = 0;
		
		private var isInitialized: Boolean = false;
		
		////////////////////////////////////////////////////////////////////
		// Public methods
		////////////////////////////////////////////////////////////////////
		
		public function VisualTestBase() 
		{
			this.initOptions();
		}
		
		public function destroy() : void 
		{
			if (!this.isInitialized) throw new Error('you should use call init() at test first');
			for (var i: int = 0; i < this.options.length; i++) 
			{
				var link: SimpleTextButton = this.options[i];
				this.optionsDictionary[link] = null;
				link.removeEventListener(ElementEvent.CLICK, this.link_onClick);
				link.destroy();
				this.optionsContainer.removeChild(link);
				link = null;
			}
			this.optionsDictionary = null;
			while (this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
			
			this.background.graphics.clear();
			this.background = null;
		}
		
		////////////////////////////////////////////////////////////////////
		// Private methods
		////////////////////////////////////////////////////////////////////
		
		private function initOptions() : void 
		{
			this.optionsContainer = new Sprite();
			this.options = new Vector.<SimpleTextButton>();
			this.optionsDictionary = new Dictionary();
			
			this.addChild(this.optionsContainer);
			
			this.addEventListener(Event.ADDED_TO_STAGE, this._onAddedToStage);
		}
		
		protected function init(name: String, width: Number = 800, height: Number = 400, alpha: Number = 0.8) : void
		{
			this.isInitialized = true;
			this.maxWidth = width;
			this.background = new Sprite();
			this.title = TextUtils.makeOneLine(name, new TextFormat("Verdana", 40, 0x888888), false);
			
			this.title.mouseEnabled = false;
			
			this.addChild(this.title);
			this.addChild(this.background);
			
			this.background.graphics.beginFill(0xffffff, alpha);
			this.background.graphics.drawRect(0, 0, width, height);
			this.background.graphics.endFill();
			
			this.title.x = 100;
			this.title.y = -this.title.height - 20;
			
			this.addChild(this.optionsContainer);
		}
		
		protected function addOption(name: String, method: Function) : void
		{	
			var link: SimpleTextButton = new SimpleTextButton(name);
			link.text = name;
			
			this.options.push(link);
			this.optionsDictionary[link] = method;
			
			link.addEventListener(ElementEvent.CLICK, this.link_onClick);
			
			link.x = this.linkX;
			
			this.linkX += link.width + 10;
			link.show();
			
			this.optionsContainer.addChild(link);
			this.optionsContainer.y = -link.height - 4;
		}
		
		////////////////////////////////////////////////////////////////////
		// Listeners
		////////////////////////////////////////////////////////////////////
		
		private function link_onClick(e: ElementEvent) : void 
		{
			var link: SimpleTextButton = e.currentTarget as SimpleTextButton;
			
			var method: Function = this.optionsDictionary[link];
			method();
		}
		
		private function _onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			
			if (!this.isInitialized) throw new Error('It seems that you forgot to call init() method in your test. Please do it in ' + this);
		}
		
	}
	
}