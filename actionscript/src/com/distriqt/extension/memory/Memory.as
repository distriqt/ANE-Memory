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
 * @author 		Michael Archbold
 * @created		19/05/2016
 */
package com.distriqt.extension.memory
{
	import com.distriqt.extension.memory.events.MemoryEvent;
	
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	
	
	
	/**
	 * @eventType com.distriqt.extension.memory.events.MemoryEvent.LOW_MEMORY_WARNING
	 */
	[Event(name="memory:lowmemorywarning", type="com.distriqt.extension.memory.events.MemoryEvent")]
	
	
	/**	
	 * <p>
	 * This class represents the memory extension.
	 * </p>
	 */
	public final class Memory extends EventDispatcher
	{
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//

		//
		//	ID and Version numbers
		public static const EXT_CONTEXT_ID			: String = "com.distriqt.Memory";
		
		public static const VERSION					: String = "1";
		public static const VERSION_DEFAULT			: String = "0";
		public static const IMPLEMENTATION_DEFAULT	: String = "unknown";
		
		//
		//	Error Messages
		private static const ERROR_CREATION			: String = "The native extension context could not be created";
		private static const ERROR_SINGLETON		: String = "The singleton has already been created. Use Memory.service to access the functionality";
		
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		//
		// Singleton variables
		private static var _instance				: Memory;
		private static var _shouldCreateInstance	: Boolean = false;
		private static var _extContext				: ExtensionContext = null;

		
		private var _extensionId			: String = "";

		
		////////////////////////////////////////////////////////
		//	SINGLETON INSTANCE
		//
		
		/**
		 * The singleton instance of the Memory class.
		 * @throws Error If there was a problem creating or accessing the extension, or if the key is invalid
		 */
		public static function get service():Memory
		{
			createInstance();
			return _instance;
		}
		
		
		/**
		 * @private
		 * Creates the actual singleton instance 
		 */
		private static function createInstance():void
		{
			if(_instance == null)
			{
				_shouldCreateInstance = true; 
				_instance = new Memory();
				_shouldCreateInstance = false;
			}
		}
		
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		/**
		 * Constructor
		 * 
		 * You should not call this directly, but instead use the singleton access
		 */
		public function Memory()
		{
			if (_shouldCreateInstance)
			{
				try
				{
					_extensionId = EXT_CONTEXT_ID;
					_extContext = ExtensionContext.createExtensionContext( EXT_CONTEXT_ID, null );
					_extContext.addEventListener( StatusEvent.STATUS, extension_statusHandler, false, 0, true );
				}
				catch (e:Error)
				{
					throw new Error( ERROR_CREATION );
				}
			}
			else
			{
				throw new Error( ERROR_SINGLETON );
			}
		}
		
		
		/**
		 * <p>
		 * Disposes the extension and releases any allocated resources. Once this function 
		 * has been called, a call to <code>init</code> is neccesary again before any of the 
		 * extensions functionality will work.
		 * </p>
		 */		
		public function dispose():void
		{
			if (_extContext)
			{
				_extContext.removeEventListener( StatusEvent.STATUS, extension_statusHandler );
				_extContext.dispose();
				_extContext = null;
			}
			_instance = null;
		}
		
		
		/**
		 * Whether the current device supports the extensions functionality
		 */
		public static function get isSupported():Boolean
		{
			createInstance();
			return _extContext.call( "isSupported" );
		}
		
		
		/**
		 * <p>
		 * The version string of the native extension. This will be of the format:
		 * </p>
		 * <pre>
		 * [main version].[base version].[implementation].[native version]
		 * </pre>
		 */
		public function get version():String
		{
			var nativeVersion:String  = VERSION_DEFAULT;
			var implementation:String = IMPLEMENTATION_DEFAULT;
			try
			{
				nativeVersion  = _extContext.call( "version" ) as String;
				implementation = _extContext.call( "implementation" ) as String;
			}
			catch (e:Error)
			{
			}
			return VERSION+"."+implementation+"."+nativeVersion;
		}
		
		
		//
		//
		//	EXTENSION FUNCTIONALITY
		//
		//
		
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		private function extension_statusHandler( event:StatusEvent ):void
		{
			switch (event.code)
			{
				case "extension:error":
				{
					dispatchEvent( new ErrorEvent( ErrorEvent.ERROR, false, false, event.level ));
					break;
				}
				
				case MemoryEvent.LOW_MEMORY_WARNING:
				{
					dispatchEvent( new MemoryEvent( MemoryEvent.LOW_MEMORY_WARNING ));
					break;
				}
					
			}
		}
		
	}
}
