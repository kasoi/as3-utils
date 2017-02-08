package  
{
	import org.flashdevelop.utils.FlashConnect;
	import org.flashdevelop.utils.TraceLevel;
	/**
	 * ...
	 * @author Kasoi
	 */
	public class Log
	{
		static private var _isEnabled: Boolean = true;
		
		static private var _isFlashConnectMode: Boolean = true;
		
		static private var _useTime: Boolean = false;
		
		static public function info(...rest) : void 
		{
			Log._trace(Log.getFullString(rest as Array), 0);
		}
		
		static public function debug(...rest) : void 
		{
			Log._trace(Log.getFullString(rest as Array), 1);
		}
		
		static public function data(...rest) : void 
		{
			Log._trace(Log.getFullString(rest as Array), 2);
		}
		
		static public function error(...rest) : void 
		{
			Log._trace(Log.getFullString(rest as Array), 3);
		}
		
		static public function fatal(...rest) : void 
		{
			Log._trace(Log.getFullString(rest as Array), 4);
		}
		
		static public function init(useFlashConnect: Boolean = true) : void 
		{
			if (!useFlashConnect) Log._isFlashConnectMode = false;
			else
			{
				FlashConnect.initialize();
			}
		}
		
		static private function getFullString(rest: Array) : String
		{
			var str: String = '';
			for (var i: int = 0; i < rest.length; i++) 
			{
				str += rest[i] + ' ';
			}
			return str;
		}
		
		static private function _trace(value: String, level: int) : void 
		{
			if (!Log._isEnabled) return;
			if (Log._useTime) 
			{
				var d: Date = new Date();
				var ms: String = d.milliseconds.toString().substr(0, 3);
				var time: String = '[' + ((d.hours > 9) ? d.hours : '0' + d.hours) + 
					':' + ((d.minutes > 9) ? d.minutes : '0' + d.minutes) +
					':' + ((d.seconds > 9) ? d.seconds : '0' + d.seconds) + '.' + ms + '] ';
				value = time + value;
			}
			if (Log._isFlashConnectMode) FlashConnect.trace(value, level);
			else trace(level + ':' + value);
		}
		
		static public function get isEnabled() : Boolean 
		{
			return Log._isEnabled;
		}
		
		static public function set isEnabled(value: Boolean) : void 
		{
			trace(0 +':' + 'Logging is ' + (value ? 'enabled' : 'disabled'));
			Log._isEnabled = value;
		}
		
		static public function get useTime() : Boolean 
		{ 
			return Log._useTime; 
		}
		
		static public function set useTime(value: Boolean) : void 
		{
			Log._useTime = value;
		}
		
	}

}