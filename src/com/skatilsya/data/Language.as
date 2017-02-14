package com.skatilsya.data 
{
	
	/**
	 * 
	 * @author kasoi
	 */
	public class Language 
	{
		static public const RU: String = 'ru';
		
		static public const EN: String = 'en';
		
		static private const DEFAULT_LANGUAGES: Array = [Language.RU, Language.EN, null];
		
		//////////////////////////////////////////////////////////
		// Singleton initialization
		//////////////////////////////////////////////////////////
		
		private static var instance: Language;
		
		private static var allowInstantation: Boolean = true;
		
		public static function getInstance() : Language
		{
			if (!instance)
			{
				instance = new Language();
				allowInstantation = false;
			}
			return instance;
		}
	   
		private function Language() 
		{
			if (!Language.allowInstantation)
			{
				throw new Error("Error: Instantiation failed.");
			}
		}
		
		
		
		
		//////////////////////////////////////////////////////////
		// Public properties
		//////////////////////////////////////////////////////////
		
		public function get currentLangauge() : String 
		{
			return this._currentLangauge;
		}
		
		public function get languages() : Array 
		{
			return this._languages;
		}
		
		//////////////////////////////////////////////////////////
		// private properties
		//////////////////////////////////////////////////////////
		
		private var _languages: Array;
		
		private var isInitialized: Boolean = false;
		
		private var _currentLangauge: String;
		
		//////////////////////////////////////////////////////////
		// Public methods
		//////////////////////////////////////////////////////////
		
		public function init(useDefaultLanguages: Boolean = true) : void 
		{
			if (this.isInitialized) throw new Error("Error: Language is already initialized");
			
			this.isInitialized = true;
			
			this._languages = [];
			if (useDefaultLanguages)
			{
				this._languages = Language.DEFAULT_LANGUAGES;
			}
		}
		
		public function addLanguage(lang: String) : void 
		{
			this.languages.push(lang);
		}
		
		public function changeLanguage(lang: String) : void 
		{
			var langs: Array = this.languages;
			var len: int = langs.length;
			var found: int = 0;
			for (var i: int = 0; i < len; i++) 
			{
				if (langs[i] == lang) found++;
			}
			if (found > 0)
			{
				this._currentLangauge = lang;
			}
			else
			{
				throw new Error("Language.changeLanguage: unknown language");
			}
		}
	}
}