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
package com.distriqt.extension.memory.functions;

import android.app.ActivityManager;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.distriqt.extension.memory.MemoryContext;

public class GetMemoryInfoFunction implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args )
	{
		FREObject result = null;
		try
		{
			MemoryContext ctx = (MemoryContext)context;

			ActivityManager.MemoryInfo info = ctx.controller().getMemoryInfo();
			if (info != null)
			{
				result = FREObject.newObject( "Object", null );

				result.setProperty( "availableMemory", FREObject.newObject( info.availMem ) );
				result.setProperty( "totalMemory", FREObject.newObject( info.totalMem ) );
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return result;
	}

}
