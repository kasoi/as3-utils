package com.skatilsya.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author kasoi
	 */
	public class LoaderEvent extends Event 
	{
		static public const LOAD_COMPLETE: String = 'loadComplete';
		
		static public const PROGRESS: String = 'progress';
		
		public var progress: Number = 0;
		
		public function LoaderEvent(type: String, progress: Number = 0, bubbles: Boolean = false, cancelable: Boolean = false) 
		{ 
			super(type, bubbles, cancelable);
			this.progress = progress;
		} 
		
		public override function clone() : Event 
		{ 
			return new LoaderEvent(type, this.progress, bubbles, cancelable);
		} 
		
		public override function toString() : String 
		{ 
			return formatToString("LoaderEvent", "type", "progress", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}