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
 * @brief
 * @author Michael Archbold (https://github.com/marchbold)
 * @created 01/03/2017
 */
package com.distriqt.extension.memory.events;

import org.json.JSONObject;

public class MemoryEvent
{

	public static final String LOWMEMORYWARNING	 = "memory:lowmemorywarning";


	public static String formatForEvent( String level )
	{
		try
		{
			JSONObject e = new JSONObject();
			e.putOpt( "level", level );
			return e.toString();
		}
		catch (Exception e)
		{
		}
		return "{}";
	}


}
