package com.skatilsya.util 
{
	import flash.utils.getQualifiedClassName;
	/**
	 * Simple util class for random needs. 
	 * @author kasoi
	 */
	public class AppUtil 
	{
		/**
		 * scans an object and attempts to show first level of childs of this object
		 * @param	...params
		 */
		public static function parametersInfo(... params):void
		{
			Log.info('AppUtil.paramsInfo :', 'params: ', params);
			
			for (var j:int = 0; j < params.length; j++)
			{
				var param:* = params[j];
				Log.debug('AppUtil.paramsInfo :', 'properties of param #' + j, '(' + param + ')');
				for (var key:String in param)
				{
					Log.data('AppUtil.paramsInfo :', key + ':', param[key]);
				}
			}
		}
		
		static public function parseURLToMap(url: String) : Object
		{
			var valuePairs:Array = url.substring(url.indexOf("?") + 1).split("&");
			var map:Object = new Object();
			for (var i: int = 0; i < valuePairs.length; i++) 
			{
				var nextValuePair:Array = valuePairs[i].split("=");
				map[nextValuePair[0]] = nextValuePair[1];
			}
			return map;
		}
	}

}