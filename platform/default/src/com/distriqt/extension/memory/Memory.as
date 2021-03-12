/**
 *        __       __               __
 *   ____/ /_ ____/ /______ _ ___  / /_
 *  / __  / / ___/ __/ ___/ / __ `/ __/
 * / /_/ / (__  ) / / /  / / /_/ / /
 * \__,_/_/____/_/ /_/  /_/\__, /_/
 *                           / /
 *                           \/
 * http://distriqt.com
 *
 * @file   		Memory.as
 * @brief  		Memory Native Extension
 * @author 		Michael Archbold (https://github.com/marchbold)
 * @created		19/05/2016
 */
package com.distriqt.extension.memory
{
	import flash.events.EventDispatcher;
	import flash.system.System;
	
	
	/**
	 * @eventType com.distriqt.extension.memory.events.MemoryEvent.LOW_MEMORY_WARNING
	 */
	[Event(name="memory:lowmemorywarning", type="com.distriqt.extension.memory.events.MemoryEvent")]
	
	/**
	 * <p>This class represents the memory extension.</p>
	 */
	public final class Memory extends EventDispatcher
	{
		
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//
		
		//
		//	ID and Version numbers
		public static const EXT_CONTEXT_ID:String = "com.distriqt.Memory";
		
		public static const VERSION:String = Const.VERSION;
		public static const VERSION_DEFAULT:String = "0";
		public static const IMPLEMENTATION_DEFAULT:String = "unknown";
		
		//
		//	Error Messages
		private static const ERROR_CREATION:String = "The native extension context could not be created";
		private static const ERROR_SINGLETON:String = "The extension has already been created. Use ExtensionClass.service to access the functionality of the class";
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		//
		// Singleton variables
		private static var _instance:Memory;
		private static var _shouldCreateInstance:Boolean = false;
		
		
		private var _extensionId:String;
		
		
		////////////////////////////////////////////////////////
		//	SINGLETON INSTANCE
		//
		
		public static function get service():Memory
		{
			createInstance();
			return _instance;
		}
		
		
		private static function createInstance():void
		{
			if (_instance == null)
			{
				_shouldCreateInstance = true;
				_instance = new Memory();
				_shouldCreateInstance = false;
			}
		}
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		public function Memory()
		{
			if (_shouldCreateInstance)
			{
				_extensionId = EXT_CONTEXT_ID;
			}
			else
			{
				throw new Error( ERROR_SINGLETON );
			}
		}
		
		
		public function dispose():void
		{
			_instance = null;
		}
		
		
		public static function get isSupported():Boolean
		{
			return false;
		}
		
		
		public function get version():String
		{
			return VERSION;
		}
		
		
		public function get nativeVersion():String
		{
			return VERSION_DEFAULT;
		}
		
		
		public function get implementation():String
		{
			return "default";
		}
		
		
		//
		//
		//	EXTENSION FUNCTIONALITY
		//
		//
		
		public function getMemoryInfo():MemoryInfo
		{
			return MemoryInfo.fromObject(
					{
						availableMemory: System.freeMemory,
						totalMemory:     System.totalMemory
					} );
		}
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
	}
}
