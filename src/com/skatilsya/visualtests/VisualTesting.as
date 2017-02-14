package com.skatilsya.visualtests 
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Cubic;
	import com.skatilsya.events.ElementEvent;
	import com.skatilsya.util.TextUtils;
	import com.skatilsya.visualtests.ui.SimpleTextButton;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Sometimes you need just to watch result of working of component or something else
	 * like buttons behaviors or animations and so on. So this tests is straight for you
	 * 
	 * (it also can be as a handy and powerful tool like console. Just use your imagination)
	 * requires com.greensock, com.skatilsya.events.ElementEvent, com.skatilsya.util.TextUtils
	 */
	public class VisualTesting extends Sprite 
	{
		
		////////////////////////////////////////////////////////////////////
		// Public properties
		////////////////////////////////////////////////////////////////////
		
		////////////////////////////////////////////////////////////////////
		// Private properties
		////////////////////////////////////////////////////////////////////
		
		private var backgroundAlpha: Number = 0.8;
		
		private var tests: Vector.<Class>;
		
		private var testDictionary: Dictionary;
		
		private var container: Sprite;
		
		private var background: Sprite;
		
		private var title: TextField;
		
		private var currentTest: VisualTestBase;
		
		private var description: TextField;
		
		private var body: Sprite;
		
		private var buttonsList: Vector.<SimpleTextButton>;
		
		private var listContainer: Sprite;
		
		private var backButton: SimpleTextButton;
		
		private var nextPageButton: SimpleTextButton;
		
		private var prevPageButton: SimpleTextButton;
		
		private var contentHeight: Number = 350;
		
		private var currentPage: int = 0;
		
		private var itemsPadding: int = 5;
		
		private var maxPages: int;
		
		////////////////////////////////////////////////////////////////////
		// Public methods
		////////////////////////////////////////////////////////////////////
		
		public function VisualTesting(contentHeight: Number = 450) 
		{
			this.contentHeight = contentHeight;
			this.init();
		}
		
		public function addTestClass(test: Class) : void 
		{
			this.addTestItem(test);
		}
		
		public function destroy() : void 
		{
			while (this.listContainer.numChildren > 0) 
			{
				var link: SimpleTextButton = this.listContainer.getChildAt(0) as SimpleTextButton;
				link.removeEventListener(ElementEvent.CLICK, this.listItem_onClick);
				link.destroy();
				this.listContainer.removeChildAt(0);
				link = null;
			}
			
			this.backButton.removeEventListener(ElementEvent.CLICK, this.backButton_onClick);
			this.body.removeChild(this.backButton);
			this.backButton.destroy();
			this.backButton = null;
			
			if (this.currentTest)
			{
				this.currentTest.destroy();
				this.container.removeChild(this.currentTest);
				this.currentTest = null;
			}
		}
		
		////////////////////////////////////////////////////////////////////
		// Private methods
		////////////////////////////////////////////////////////////////////
		
		private function init() : void
		{
			this.tests = new Vector.<Class>();
			this.testDictionary = new Dictionary();
			this.buttonsList = new Vector.<SimpleTextButton>();
			this.listContainer = new Sprite();
			this.nextPageButton = new SimpleTextButton("next >");
			this.prevPageButton = new SimpleTextButton("&lt; prev");
			
			this.y = 25;
			
			this.body = new Sprite();
			this.background = new Sprite();
			this.container = new Sprite();
			this.title = TextUtils.makeOneLine("Testing page", new TextFormat("Verdana", 44, 0x555555), false);
			this.description = TextUtils.makeOneLine("Here is list of testing classes, try to select any to see test", 
				new TextFormat("Verdana", 14, 0x666666), false);
			this.backButton = new SimpleTextButton("back");
			this.backButton.hide();
			
			this.background.graphics.beginFill(0xffffff, this.backgroundAlpha);
			this.background.graphics.drawRect(0, 0, 800, 150);
			this.background.graphics.endFill();
			
			this.title.x = this.description.x = 20;
			this.title.y = 25;
			this.description.y = this.background.height - this.description.height - 50;
			
			this.backButton.y = this.description.y;
			this.backButton.x = 20;
			this.container.y = this.backButton.height;
			
			this.prevPageButton.x = 20;
			this.prevPageButton.y = this.backButton.y + 30;
			this.nextPageButton.x = this.prevPageButton.x + this.prevPageButton.width + 10;
			this.nextPageButton.y = this.prevPageButton.y;
			
			this.prevPageButton.show();
			this.nextPageButton.show();
			
			this.body.addChild(this.background);
			this.body.addChild(this.title);
			this.body.addChild(this.description);
			this.body.addChild(this.container);
			this.body.addChild(this.backButton);
			this.body.addChild(this.prevPageButton);
			this.body.addChild(this.nextPageButton);
			this.addChild(this.body);
			
			this.description.mouseEnabled = false;
			this.title.mouseEnabled = false;
			this.body.addChild(this.listContainer);
			
			this.backButton.addEventListener(ElementEvent.CLICK, this.backButton_onClick);
			this.nextPageButton.addEventListener(ElementEvent.CLICK, this.nextPageButton_onClick);
			this.prevPageButton.addEventListener(ElementEvent.CLICK, this.prevPageButton_onClick);
		}
		
		private function clearContainer():void 
		{
			while (this.listContainer.numChildren > 0) 
			{
				var item: SimpleTextButton = this.listContainer.getChildAt(0) as SimpleTextButton;
				item.removeEventListener(ElementEvent.CLICK, this.listItem_onClick);
				item.destroy();
				this.testDictionary[item] = null;
				this.listContainer.removeChild(item);
				item = null;
			}
		}
		
		private function getPossibleListHeight(): Number
		{
			var possibleListHeight: Number = this.contentHeight - this.listContainer.y;
			return possibleListHeight;
		}
		
		private function getItemsPerPage(): int
		{
			return this.getPossibleListHeight() / (SimpleTextButton.ITEM_HEIGHT + this.itemsPadding);
		}
		
		private function showPage(page: int = 0):void 
		{
			this.clearContainer();
			
			var itemsPerPage: int = this.getItemsPerPage();
			var start: int = itemsPerPage * page;
			var end: int = start + itemsPerPage;
			if (end > this.tests.length) end = this.tests.length;
			
			for (var i:int = start; i < end; i++) 
			{
				var button: SimpleTextButton = this.getListButton(i);
				button.x = 20;
				button.y = 20 + (i - start) * (SimpleTextButton.ITEM_HEIGHT + this.itemsPadding);
				
				this.listContainer.addChild(button);
				button.show();
				this.testDictionary[button] = this.tests[i];
				
				button.addEventListener(ElementEvent.CLICK, this.listItem_onClick);
			}
			
			this.listContainer.graphics.clear();
			this.listContainer.graphics.beginFill(0xffffff, this.backgroundAlpha);
			this.listContainer.graphics.drawRect(0, 0, this.listContainer.width + 80, this.getPossibleListHeight() + 40);
			this.listContainer.graphics.endFill();
			
			this.listContainer.y = this.background.height;
			this.checkPageButtonsVisibility();
		}
		
		private function checkPageButtonsVisibility():void 
		{
			this.currentPage > 0 ? this.prevPageButton.show() : this.prevPageButton.hide();
			this.currentPage < this.maxPages ? this.nextPageButton.show() : this.nextPageButton.hide();
		}
		
		private function addTestItem(testClass: Class):void 
		{
			this.tests.push(testClass);
			
			this.maxPages = (this.tests.length - 1) / this.getItemsPerPage();
			if (this.maxPages < 0) this.maxPages = 0;
			
			// buttons list will be redrawn until new page will be available
			if (this.currentPage == this.maxPages) this.showPage(this.currentPage);
			this.checkPageButtonsVisibility();
		}
		
		private function getListButton(index: int): SimpleTextButton 
		{
			var i: int = index;
			var className: String = getQualifiedClassName(this.tests[i]);
			if (className.split("::").length > 1) className = className.split("::")[1];
			var link: SimpleTextButton = new SimpleTextButton(className);
			link.text = className;
			
			return link;
		}
		
		private function hideMenu() : void 
		{
			this.listContainer.mouseChildren = this.listContainer.mouseEnabled = false;
			TweenLite.to(this.listContainer, 0.35, { x: -this.listContainer.width * 0.5, y: this.background.height + this.listContainer.height * 0.1, 
				alpha: 0, scaleX: 1, scaleY: 0.8, ease: Cubic.easeOut } );
			
			this.backButton.show(0.15);
			this.title.text = "Testing";
			TweenLite.to(this.description, 0.5, { alpha: 0, ease: Cubic.easeOut } );
			this.nextPageButton.hide();
			this.prevPageButton.hide();
			
			this.container.alpha = 0;
			this.container.x = 200;
			this.container.mouseChildren = this.container.mouseEnabled = true;
			TweenLite.to(this.container, 0.5, { alpha: 1, x: 0, ease: Cubic.easeOut} );
		}
		
		private function showMenu() : void 
		{
			this.backButton.hide();
			this.listContainer.mouseChildren = this.listContainer.mouseEnabled = true;
			TweenLite.to(this.listContainer, 0.5, { x: 0, y: this.background.height, alpha: 1, scaleX: 1, scaleY: 1, ease: Cubic.easeOut } );
			TweenLite.to(this.description, 0.5, { alpha: 1, ease: Cubic.easeOut } );
			
			this.container.mouseChildren = this.container.mouseEnabled = true;
			TweenLite.to(this.container, 0.5, { alpha: 0, x: 200, ease: Cubic.easeOut, onComplete: this.killTests } );
		}
		
		private function killTests() : void 
		{
			if (this.currentTest != null)
			{
				if(this.container.contains(this.currentTest)) this.container.removeChild(this.currentTest);
				this.currentTest.destroy();
				this.currentTest = null;
			}
		}
		
		////////////////////////////////////////////////////////////////////
		// Listeners
		////////////////////////////////////////////////////////////////////
		
		private function prevPageButton_onClick(e:ElementEvent):void 
		{
			this.currentPage --;
			if (this.currentPage < 0) this.currentPage = 0;
			this.showPage(this.currentPage);
		}
		
		private function nextPageButton_onClick(e:ElementEvent):void 
		{
			this.currentPage ++;
			if (this.currentPage >= this.maxPages) this.currentPage = this.maxPages;
			this.showPage(this.currentPage);
		}
		
		private function listItem_onClick(e: ElementEvent) : void 
		{
			this.hideMenu();
			this.killTests();
			
			var link: SimpleTextButton = e.currentTarget as SimpleTextButton;
			var testClass: Class = this.testDictionary[link];
			
			this.currentTest = new testClass() as VisualTestBase;
			this.container.addChild(this.currentTest);
			
			this.container.y = this.background.height;
		}
		
		private function backButton_onClick(e: ElementEvent) : void 
		{
			this.showMenu();
		}
	}
	
}