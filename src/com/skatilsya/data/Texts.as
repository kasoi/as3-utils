package com.skatilsya.data
{
	import com.skatilsya.events.LoaderEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	/**
	 * @author kasoi [kasoizz@gmail.com]
	 */
	public class Texts extends EventDispatcher
	{
		[Event(name = "loadComplete", type = "events.LoaderEvent")]
		[Event(name = "ioError", type = "events.IOErrorEvent")]
		
		private const TEXTS: String = 'texts';
		
		private const LANGUAGES: String = 'languages';
		
		////////////////////////////////////////////////////////////////////
		// Lazy Singleton
		////////////////////////////////////////////////////////////////////
		
		static public var instance: Texts;
		
		static public function getInstance() : Texts
		{
			if (instance == null) 
			{
				instance = new Texts();
				dictionary = new Dictionary();
			}
			
		}
		
		private function Texts() 
		{
			Texts.dictionary = new Dictionary();
			
			Language.getInstance().init();
		}
		
		/*
		 * Возвращает текст по вашему коду (возвращается код по отношению 
		 * к текущему языку в util.Language
		 * 
		 * @param code сам код-ключ, по которму нужно будет искать текст
		 * @param inLanguage получить ли текст по какому-то определенному языку
		 */
		static public function getText(code: String, inLanguage: String = null) : String
		{
			var language: String = Language.getInstance().currentLangauge;
			if (inLanguage != null) language = inLanguage;
			var lang: String = ':' + language;
			if (language == null) lang = '';
			var text: String = Texts.dictionary[code + lang];
			if (text == null) text = '!' + code + lang;
			return text;
		}
		
		/*
		 * Возвращает текст без использования разных языков по вашему коду
		 * 
		 * @param code сам код-ключ, по которму нужно будет искать текст
		 */
		static public function getNonLanguagedText(code: String) : String
		{
			var text: String = Texts.dictionary[code];
			if (text == null) text = '!' + code;
			return text;
		}
		
		static private var dictionary: Dictionary;
		
		////////////////////////////////////////////////////////////////////
		// Private properties
		////////////////////////////////////////////////////////////////////
		
		private var textsIsLoading: Boolean = false;
		
		private var loader: URLLoader;
		
		////////////////////////////////////////////////////////////////////
		// Public methods
		////////////////////////////////////////////////////////////////////
		
		public function loadTexts(path: String) : void 
		{
			if (this.textsIsLoading) 
			{
				trace('Texts.loadTexts : Texts already loading');
				return;
			}
			this.textsIsLoading = true;
			
			this.loader = new URLLoader();
			this.loader.addEventListener(Event.COMPLETE, this.loader_onLoad);
			this.loader.addEventListener(IOErrorEvent.IO_ERROR, this.loader_onIoError);
			
			this.loader.load(new URLRequest(path));
		}
		
		/*
		 * You can add your own texts by code and language
		 * 
		 * @param code the code of your text
		 * @param value your text value
		 * @param language language of your text
		 */
		public function addTexts(code: String, value: String,
			language: String = null) : void 
		{
			var lang: String = ':' + language;
			if (language == null) lang = '';
			Texts.dictionary[code + lang] = value;
		}
		
		/*
		 * Checks if your code is exists
		 */
		public function textIsExists(code: String) : Boolean 
		{
			var langValue: String = Language.getInstance().currentLangauge;
			var lang: String = (langValue == '' || langValue == null) ? '' : ':' + langValue;
			return (Texts.getText(code) != ('!' + code + lang));
		}
		
		////////////////////////////////////////////////////////////////////
		// Private methods
		////////////////////////////////////////////////////////////////////
		
		/*
		 * This method parses default texts base. It can parse this one
		 * <text code="hello_world">Hello, world</text>
		 * 
		 * or this multilanguaged one
		 * 
		 * <text code="hello_world">
		 * 		<ru>Привет, мир!</ru>
		 * 		<en>Hello, world!</en>
		 * </text>
		 */
		private function parseTextsBase(base: XML) : void 
		{
			var textLength: Number = base.text.length();
			
			for (var i: int = 0; i < textLength; i++) 
			{
				var text: XML = base.text[i];
				for (var j: int = 0; j < text.children().length(); j++)
				{
					var _lang: String = text.children()[j].name();
					var _text: String = text.children()[j];
					this.addTexts(text.@code, _text, _lang);
				}
			}
		}
		
		/*
		 * В данной функции можно добавлять новые языки, если планируется
		 * неизвестное количество языков, которое невозможно будет забить
		 * изначально в код. Прочесть все языки можно будет в 
		 * Language.getInstance().languages
		 */
		private function parseLanguagesBase(base: XML) : void 
		{
			var textLength: Number = base.language.length();
			
			var codes: Array = [];
			
			for (var i: int = 0; i < textLength; i++) 
			{
				var text: XML = base.language[i];
				Language.getInstance().addLanguage(text.@code);
			}
		}
		
		////////////////////////////////////////////////////////////////////
		// Listeners
		////////////////////////////////////////////////////////////////////
		
		/*
		 * Тут стоит добавлять обработку новых "баз"
		 */
		private function sender_onLoadTexts(data: XML) : void 
		{
			var baseLength: Number = data.base.length();
			for (var i: int = 0; i < baseLength; i++) 
			{
				var base: XML = data.base[i];
				if (base.@name == this.TEXTS) this.parseTextsBase(base);
				if (base.@name == this.LANGUAGES) this.parseLanguagesBase(base);
			}
			
			this.dispatchEvent(new LoaderEvent(LoaderEvent.LOAD_COMPLETE));
		}
		
		private function loader_onLoad(e: Event) : void 
		{
			var data: XML = new XML(this.loader.data);
			this.sender_onLoadTexts(data);
		}
		
		private function loader_onIoError(e: IOErrorEvent) : void 
		{
			this.dispatchEvent(e);
		}
		
	}

}