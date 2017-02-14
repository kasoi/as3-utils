package com.skatilsya.ui 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * 
	 * @author me
	 */
	public class ScrollableContent extends Sprite 
	{
		
		////////////////////////////////////////////////////////////////////
		// Public properties
		////////////////////////////////////////////////////////////////////
		
		public function get viewWidth():Number 
		{
			return _viewWidth;
		}
		
		public function set viewWidth(value:Number):void 
		{
			_viewWidth = value;
			this.update();
		}
		
		public function get viewHeight():Number 
		{
			return _viewHeight;
		}
		
		public function set viewHeight(value:Number):void 
		{
			_viewHeight = value;
			this.update();
		}
		
		public function get scrollVProgress():Number 
		{
			return _scrollVProgress;
		}
		
		public function set scrollVProgress(value:Number):void 
		{
			_scrollVProgress = value;
			this.update();
		}
		
		public function get scrollHProgress():Number 
		{
			return _scrollHProgress;
		}
		
		public function set scrollHProgress(value:Number):void 
		{
			_scrollHProgress = value;
			
			this.update();
		}
		
		////////////////////////////////////////////////////////////////////
		// Private properties
		////////////////////////////////////////////////////////////////////
		
		private var content: DisplayObject;
		
		private var _viewWidth: Number;
		
		private var _viewHeight: Number;
		
		private var _scrollVProgress: Number = 0;
		
		private var _scrollHProgress: Number = 0;
		
		private var scrollValueV: Number = 0;
		
		private var scrollValueH: Number = 0;
		
		////////////////////////////////////////////////////////////////////
		// Public methods
		////////////////////////////////////////////////////////////////////
		
		public function ScrollableContent(content: DisplayObject, width: Number, height: Number) 
		{
			this._viewWidth = width;
			this._viewHeight = height;
			this.content = content;
			this.init();
		}
		
		public function destroy():void 
		{
			this.content.scrollRect = null;
			while (this.numChildren > 0) 
			{
				this.removeChildAt(0);
			}
		}
		
		public function update() : void 
		{
			
			this.doScroll();
		}
		
		////////////////////////////////////////////////////////////////////
		// Private methods
		////////////////////////////////////////////////////////////////////
		
		private function init() : void
		{
			
		}
		
		private function calculateYValueByProgress(progress: Number):void 
		{
			this.scrollValueV = (this.content.height - this._viewHeight) * progress;
		}
		
		private function doScroll():void 
		{
			this.content.scrollRect = new Rectangle(this.scrollValueH, this.scrollValueV, this._viewWidth, this._viewHeight);
		}
		
		////////////////////////////////////////////////////////////////////
		// Listeners
		////////////////////////////////////////////////////////////////////
		
	}
	
}