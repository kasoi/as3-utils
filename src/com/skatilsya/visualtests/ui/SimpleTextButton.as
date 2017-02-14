package com.skatilsya.visualtests.ui 
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Cubic;
	import com.skatilsya.events.ElementEvent;
	import com.skatilsya.util.TextUtils;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * 
	 * @author me
	 */
	public class SimpleTextButton extends Sprite 
	{
		static public const ITEM_HEIGHT: Number = 25;
		
		////////////////////////////////////////////////////////////////////
		// Public properties
		////////////////////////////////////////////////////////////////////
		
		public function get showPhase():Number 
		{
			return _showPhase;
		}
		
		public function set showPhase(value:Number):void 
		{
			_showPhase = value;
			
			this.field.filters = [new BlurFilter((1 - value) * 6, (1 - value) * 6, 2)];
			if (value == 1) this.field.filters = [];
			this.field.alpha = value;
		}
		
		public function get text():String 
		{
			return _text;
		}
		
		public function set text(value:String):void 
		{
			_text = value;
			this.field.text = value;
			
			this.drawTrigger();
		}
		
		////////////////////////////////////////////////////////////////////
		// Private properties
		////////////////////////////////////////////////////////////////////
		
		private var field: TextField;
		
		private var _text: String;
		
		private var trigger: Sprite;
		
		private var _showPhase: Number = 0;
		
		////////////////////////////////////////////////////////////////////
		// Public methods
		////////////////////////////////////////////////////////////////////
		
		public function SimpleTextButton(text: String) 
		{
			this._text = text;
			this.init();
		}
		
		public function destroy():void 
		{
			this.trigger.removeEventListener(MouseEvent.CLICK, this.trigger_onClick);
			TweenLite.killTweensOf(this);
			while (this.numChildren > 0) 
			{
				this.removeChildAt(0);
			}
			
			this.trigger = null;
			this.field = null;
		}
		
		public function show(delay: Number = 0):void 
		{
			this.trigger.visible = true;
			TweenLite.to(this, 0.5, { showPhase: 1, ease: Cubic.easeOut});
		}
		
		public function hide(delay: Number = 0):void 
		{
			this.trigger.visible = false;
			TweenLite.to(this, 0.5, { showPhase: 0, ease: Cubic.easeOut});
		}
		
		////////////////////////////////////////////////////////////////////
		// Private methods
		////////////////////////////////////////////////////////////////////
		
		private function init() : void
		{
			this.field = TextUtils.makeOneLine(text, new TextFormat("Verdana", 15, 0x999999), false);
			this.trigger = new Sprite();
			
			this.drawTrigger();
			
			this.addChild(this.field);
			this.addChild(this.trigger);
			
			this.trigger.buttonMode = true;
			
			this.trigger.addEventListener(MouseEvent.CLICK, this.trigger_onClick);
		}
		
		private function drawTrigger() : void
		{
			this.trigger.graphics.clear();
			this.trigger.graphics.beginFill(0xff00ff, 0);
			this.trigger.graphics.drawRect(0, 0, this.field.width, this.field.height);
			this.trigger.graphics.endFill();
		}
		
		////////////////////////////////////////////////////////////////////
		// Listeners
		////////////////////////////////////////////////////////////////////
		
		private function trigger_onClick(e:MouseEvent):void 
		{
			this.dispatchEvent(new ElementEvent(ElementEvent.CLICK));
		}
		
	}
	
}