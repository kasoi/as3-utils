package com.skatilsya.net 
{
	import events.DataSenderEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.Dictionary;
	/**
	 * looks deprecated (since 2010), needs rework
	 * @author Kasoi
	 */
	public class DataSender extends EventDispatcher
	{
		
		/////////////////////////////////////////////////////////////////////////////
		// Public properties
		/////////////////////////////////////////////////////////////////////////////
		
		public function get attempts() : int 
		{
			return this._attempts;
		}
		
		public function set attempts(value: int) : void 
		{
			this._attempts = value;
		}
		
		public function get isXML() : Boolean 
		{
			return this._isXML;
		}
		
		public function set isXML(value: Boolean) : void 
		{
			this._isXML = value;
		}
		
		public function get responce() : * 
		{
			return this._responce;
		}
		
		public function get lastCommand() : String
		{
			return this._lastCommand;
		}
		
		public function get traceResponce() : Boolean 
		{
			return this._traceResponce;
		}
		
		public function set traceResponce(value: Boolean) : void 
		{
			this._traceResponce = value;
		}
		
		/////////////////////////////////////////////////////////////////////////////
		// Private properties
		/////////////////////////////////////////////////////////////////////////////
		
		private var _url: String;
		
		private var loaders: Vector.<URLLoader>;
		
		private var _loaders: Dictionary;
		
		private var _lastId: int = 0;
		
		private var _attempts: int = 3;
		
		private var _isXML: Boolean = true;
		
		private var _responce: * ;
		
		private var _lastCommand: String;
		
		private var _traceResponce: Boolean = false;
		
		/////////////////////////////////////////////////////////////////////////////
		// Public methods
		/////////////////////////////////////////////////////////////////////////////
		
		public function DataSender(url: String) 
		{
			this._url = url;
			this.loaders = [];
			this._loaders = new Dictionary();
		}
		
		public function sendVars(...vars) : int 
		{
			this._lastId++;
			
			var _vars: Array = vars as Array;
			if (vars is Array) _vars = vars[0];
			var data: String = this.sortData(_vars);
			
			this.sendData(data, this._lastId, null);
			return this._lastId;
		}
		
		public function sendVarsToCallback(method: Function, value: *) : int
		{
			this._lastId++;
			
			var data: Array = [];
			if (value is Object && !(value is Array))
			{
				for (var key: String in value)
				{
					data.push(key + '=' + value[key]);
				}
				//this.send(data);
				//return;
			}
			else
			{
				if (value is Array) data = value;
				else data = value;
				if (value is String && value.length == 1)
				{
					data = value.split('&');
				}
			}
			var strData: String = this.sortData(data);
			this.sendData(strData, this._lastId, method);
			
			return this._lastId;
		}
		
		/////////////////////////////////////////////////////////////////////////////
		// Private methods
		/////////////////////////////////////////////////////////////////////////////
		
		private function sortData(commands: Array) : String
		{
			commands = commands.sort();
			
			var str: String = '';
			var len: int = commands.length;
			for (var i: int = 0; i < len; i++) 
			{
				var command: String = commands[i];
				str += ((i == len - 1) ? command : (command + '&'));
			}
			
			return str;
		}
		
		private function sendData(data: String, id: int, method: Function = null) : void 
		{
			this._lastCommand = data;
			var req: URLRequest = new URLRequest(this._url);
			req.method = URLRequestMethod.POST;
			req.data = data;
			
			var loader: URLLoader = new URLLoader(req);
			
			this.loaders[loader] = { data: data, id: id, method: method, attempts: this._attempts, loader: loader};
			this.loaders[id] = this.loaders[loader];
			if(this._traceResponce) trace('DataSender.sendData :', 'sending data: ', data, 'id: ',id);
			loader.addEventListener(Event.COMPLETE, this.loader_onLoad);
		}
		
		private function killLoader(loader: URLLoader):void 
		{
			loader.removeEventListener(Event.COMPLETE, this.loader_onLoad);
			loader = null;
			obj = null;
			this.loaders[id] = null;
			this.loaders[loader] = null;
		}
		
		/////////////////////////////////////////////////////////////////////////////
		// Private methods
		/////////////////////////////////////////////////////////////////////////////
		
		private function loader_onLoad(e: Event) : void 
		{
			var obj: Object = this.loaders[e.target];
			var sendData: String = obj.data;
			var id: int = obj.id;
			var method: Function = obj.method;
			var data: Object = (e.target as URLLoader).data;
			
			if(this._traceResponce) trace('DataSender.loader_onLoad :', data);
			
			var xml: XML;
			
			try
			{
				xml = XML(data);
			}
			catch (e: Error)
			{
				Log.error('DataSender.loader_onLoad :', e.message, e.getStackTrace());
			}
			
			if (this._isXML) xml = XML(data);
			
			if (method != null)
			{
				if (this._isXML) method(xml);
				else method(data);
			}
			else
			{
				this.dispatchEvent(new DataSenderEvent(DataSenderEvent.LOAD_COMPLETE, id))
			}
			
			var loader: URLLoader = obj.loader;
			try
			{
				loader.close();
			}
			catch(e: Error)
			{
				trace('DataSender.loader_onLoad :', e.message);
			}
			this.killLoader(loader);
			
			if (this._isXML) this._responce = xml;
			else this._responce = data;
		}
		
	}

}