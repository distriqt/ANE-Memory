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
 * @created		22/9/2023
 * @copyright	distriqt 2023 (https://distriqt.com/copyright/license.txt)
 */
package com.distriqt.extension.memory
{
	public class MemoryWarningLevel
	{
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//

		/**
		 * the process had been showing a user interface, and is no longer doing so.
		 * Large allocations with the UI should be released at this point to allow
		 * memory to be better managed
		 */
		public static const UI_HIDDEN:String = "ui_hidden";

		/**
		 * the process is not an expendable background process, but the device
		 * is running moderately low on memory. Your running process may want
		 * to release some unneeded resources for use elsewhere
		 */
		public static const RUNNING_MODERATE:String = "running_moderate";

		/**
		 * the process is not an expendable background process, but the
		 * device is running low on memory. Your running process should
		 * free up unneeded resources to allow that memory to be used elsewhere
		 */
		public static const RUNNING_LOW:String = "running_low";

		/**
		 * the process is not an expendable background process, but the device
		 * is running extremely low on memory and is about to not be able to keep
		 * any background processes running. Your running process should free up
		 * as many non-critical resources as it can to allow that memory to be used
		 * elsewhere. The next thing that will happen after this is onLowMemory()
		 * called to report that nothing at all can be kept in the background, a
		 * situation that can start to notably impact the user.
		 */
		public static const RUNNING_CRITICAL:String = "running_critical";

		/**
		 * the process has gone on to the LRU list. This is a good opportunity
		 * to clean up resources that can efficiently and quickly be re-built
		 * if the user returns to the app
		 */
		public static const BACKGROUND:String = "background";

		/**
		 * the process is around the middle of the background LRU list;
		 * freeing memory can help the system keep other processes running
		 * later in the list for better overall performance.
		 */
		public static const MODERATE:String = "moderate";

		/**
		 * the process is nearing the end of the background LRU list, and if
		 * more memory isn't found soon it will be killed.
		 */
		public static const COMPLETE:String = "complete";


		/**
		 * An unknown memory warning occurred, or no additional details
		 * are available on this platform
		 */
		public static const UNKNOWN:String = "unknown";

	}
}
