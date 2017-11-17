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
 * @author marchbold
 * @created 01/03/2017
 */
package com.distriqt.extension.memory.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.distriqt.extension.memory.MemoryContext;

public class StopMonitoringMemoryFunction implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args )
	{
		FREObject result = null;
		try
		{
			MemoryContext ctx = (MemoryContext)context;
			ctx.controller().stopMonitoringMemory();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return result;
	}

}
