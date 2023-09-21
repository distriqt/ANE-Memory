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
 * @copyright	distriqt 2023 (https://distriqt.com/copyright/license.txt)
 */
package com.distriqt.extension.memory
{

	/**
	 * This class contains memory information retrieved from the
	 * native operating system.
	 */
	public class MemoryInfo
	{
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//		


		////////////////////////////////////////////////////////
		//	VARIABLES
		//

		/**
		 * The available memory on the system. (bytes)
		 */
		public var availableMemory:Number = 0;


		/**
		 * The total memory accessible by the kernel. (bytes)
		 */
		public var totalMemory:Number = 0;


		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//

		/**
		 *  Constructor
		 */
		public function MemoryInfo()
		{
		}


		/**
		 * @private
		 */
		internal static function fromObject( data:Object ):MemoryInfo
		{
			if (data != null)
			{
				var info:MemoryInfo = new MemoryInfo();

				if (data.hasOwnProperty( "availableMemory" )) info.availableMemory = data.availableMemory;
				if (data.hasOwnProperty( "totalMemory" )) info.totalMemory = data.totalMemory;

				return info;
			}
			return null;
		}


		////////////////////////////////////////////////////////
		//	INTERNALS
		//


		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//


	}
}