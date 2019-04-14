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
 * @file   		MemoryEvent.as
 * @brief  		
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		19/05/2016
 */
package com.distriqt.extension.memory.events
{
	import flash.events.Event;
	
	
	/**	
	 * <p>
	 * Represents events from the Memory extension.
	 * </p>
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
		public static const LOW_MEMORY_WARNING	: String = "memory:lowmemorywarning";
		
		
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		/**
		 *  Constructor
		 */
		public function MemoryEvent( type:String, bubbles:Boolean =false, cancelable:Boolean =false)
		{
			super(type, bubbles, cancelable);
		}
		
		
		override public function clone():Event
		{
			return new MemoryEvent(type, bubbles, cancelable );
		}
		
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		
	}
}