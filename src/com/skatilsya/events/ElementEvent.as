package com.skatilsya.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Kasoi
	 */
	public class ElementEvent extends Event 
	{
		static public const MOUSE_OVER: String = '_mouseOver';
		
		static public const MOUSE_OUT: String = '_mouseOut';
		
		static public const CLICK: String = '_click';
		
		static public const PRESS: String = '_press';
		
		static public const RELEASE: String = '_release';
		
		static public const SELECT: String = '_select';
		
		static public const DISSELECT: String = '_disselect';
		
		static public const SHOW_COMPLETE: String = '_showComplete';
		
		static public const HIDE_COMPLETE: String = '_hideComplete';
		
		static public const HIDE_START: String = '_hideStart';
		
		static public const SHOW_START: String = '_showStart';
		
		public function ElementEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ElementEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ElementEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}