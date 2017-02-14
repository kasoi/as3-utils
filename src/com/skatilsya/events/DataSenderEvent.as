package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Kasoi
	 */
	public class DataSenderEvent extends Event 
	{
		static public const LOAD_COMPLETE: String = 'loadComplete';
		
		public var loaderID: int;
		
		public function DataSenderEvent(type: String, loaderID: int, bubbles: Boolean = false, cancelable: Boolean = false) 
		{ 
			super(type, bubbles, cancelable);
			this.loaderID;
		} 
		
		public override function clone() : Event 
		{ 
			return new DataSenderEvent(type, this.loaderID, bubbles, cancelable);
		} 
		
		public override function toString() : String 
		{ 
			return formatToString("DataSenderEvent", "type", "bubbles", "cancelable", "eventPhase", "loaderID"); 
		}
		
	}
	
}