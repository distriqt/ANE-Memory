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
 * @copyright	https://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.memory.events
{
	import com.distriqt.extension.memory.MemoryWarningLevel;

	import flash.events.Event;

	/**
	 * Represents events from the Memory extension.
	 */
	public class MemoryEvent extends Event
	{
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//


		/**
		 * <p>
		 * Dispatched when the system dispatches a low-memory warning to your app.
		 * </p>
		 * <strong>You should respond immediately</strong>
		 * <p>
		 * Low-memory warnings are your opportunity to remove references to objects that you do not need.
		 * Responding to these warnings is crucial because apps that fail to do so are more likely to be terminated.
		 * </p>
		 * <p>
		 * Upon receiving this event, your handler method should respond by immediately freeing up any unneeded memory.
		 * Use this event to clear out caches and release images.
		 * If you have large data structures that are not being used, write those structures to disk and release the in-memory copies of the data.
		 * </p>
		 *
		 * @eventType	memory:lowmemorywarning
		 */
		public static const LOW_MEMORY_WARNING:String = "memory:lowmemorywarning";


		////////////////////////////////////////////////////////
		//	VARIABLES
		//


		/**
		 * The context of the memory warning, giving a hint of the amount of trimming the application may like to perform.
		 * <br/>
		 *
		 * On platforms that don't support additional level information this will be "unknown"
		 *
		 * @see com.distriqt.extension.memory.MemoryWarningLevel
		 */
		public var level:String = MemoryWarningLevel.UNKNOWN;


		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//

		/**
		 *  Constructor
		 */
		public function MemoryEvent( type:String, level:String = MemoryWarningLevel.UNKNOWN, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
			this.level = level;
		}


		override public function clone():Event
		{
			return new MemoryEvent( type, level, bubbles, cancelable );
		}


		////////////////////////////////////////////////////////
		//	INTERNALS
		//


		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//


	}
}