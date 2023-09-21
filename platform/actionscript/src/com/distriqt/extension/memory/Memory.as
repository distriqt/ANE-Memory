/**
 *        __       __               __
 *   ____/ /_ ____/ /______ _ ___  / /_
 *  / __  / / ___/ __/ ___/ / __ `/ __/
 * / /_/ / (__  ) / / /  / / /_/ / /
 * \__,_/_/____/_/ /_/  /_/\__, /_/
 *                           / /
 *                           \/
 * https://distriqt.com
 *
 * @author 		Michael Archbold (https://github.com/marchbold)
 * @created		19/05/2016
 * @copyright	http://distriqt.com/copyright/license.txt
 *
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
	 * This class represents the memory extension.
	 */
	public final class Memory extends EventDispatcher
	{
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//

		//
		//	ID and Version numbers
		public static const EXT_CONTEXT_ID:String = Const.EXTENSIONID;

		public static const VERSION:String = Const.VERSION;
		private static const VERSION_DEFAULT:String = "0";
		private static const IMPLEMENTATION_DEFAULT:String = "unknown";

		//
		//	Error Messages
		private static const ERROR_CREATION:String = "The native extension context could not be created";
		private static const ERROR_SINGLETON:String = "The singleton has already been created. Use Memory.service to access the functionality";


		////////////////////////////////////////////////////////
		//	VARIABLES
		//

		//
		// Singleton variables
		private static var _instance:Memory;
		private static var _shouldCreateInstance:Boolean = false;
		private static var _extContext:ExtensionContext = null;



		////////////////////////////////////////////////////////
		//	SINGLETON INSTANCE
		//

		/**
		 * The singleton instance of the Memory class.
		 * @throws Error If there was a problem creating or accessing the extension
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
		 * Disposes the extension and releases any allocated resources. Once this function
		 * has been called, a call to <code>init</code> is neccesary again before any of the
		 * extensions functionality will work.
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
		 * The version of this extension.
		 * This should be of the format, <code>MAJOR.MINOR.BUILD</code>
		 */
		public function get version():String
		{
			return VERSION;
		}


		/**
		 * The native version string of the native extension.
		 */
		public function get nativeVersion():String
		{
			try
			{
				return _extContext.call( "version" ) as String;
			}
			catch (e:Error)
			{
			}
			return VERSION_DEFAULT;
		}


		/**
		 * The implementation currently in use.
		 * This should be one of the following depending on the platform in use and the
		 * functionality supported by this extension:
		 * <ul>
		 * <li><code>Android</code></li>
		 * <li><code>iOS</code></li>
		 * <li><code>default</code></li>
		 * <li><code>unknown</code></li>
		 * </ul>
		 */
		public function get implementation():String
		{
			try
			{
				return _extContext.call( "implementation" ) as String;
			}
			catch (e:Error)
			{
			}
			return IMPLEMENTATION_DEFAULT;
		}


		//
		//
		//	EXTENSION FUNCTIONALITY
		//
		//

		/**
		 * Access the native memory information
		 *
		 * @return A <code>MemoryInfo</code> instance containing the current memory statistics
		 */
		public function getMemoryInfo():MemoryInfo
		{
			try
			{
				return MemoryInfo.fromObject( _extContext.call( "getMemoryInfo" ) as Object );
			}
			catch (e:Error)
			{
			}
			return null;
		}


		override public function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void
		{
			super.addEventListener( type, listener, useCapture, priority, useWeakReference );
			if (type == MemoryEvent.LOW_MEMORY_WARNING)
			{
				try
				{
					_extContext.call( "startMonitoringMemory" );
				}
				catch (e:Error)
				{
				}
			}
		}


		////////////////////////////////////////////////////////
		//	INTERNALS
		//


		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//

		private function extension_statusHandler( event:StatusEvent ):void
		{
			var data:Object;
			try
			{
				switch (event.code)
				{
					case "extension:error":
					{
						dispatchEvent( new ErrorEvent( ErrorEvent.ERROR, false, false, event.level ) );
						break;
					}

					case MemoryEvent.LOW_MEMORY_WARNING:
					{
						data = JSON.parse( event.level );
						var level:String = data.hasOwnProperty( "level" ) ? data.level : MemoryWarningLevel.UNKNOWN;
						dispatchEvent(
								new MemoryEvent(
										MemoryEvent.LOW_MEMORY_WARNING,
										level
								)
						);
						break;
					}

				}

			}
			catch (e:Error)
			{
			}
		}

	}
}
