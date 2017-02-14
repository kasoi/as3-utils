package com.skatilsya.data.parsers 
{
	
	/**
	 * ...
	 * @author me
	 */
	public interface ITextParser 
	{
		function get code() : String;
		
		function parse(data: Object):void;
	}
	
}