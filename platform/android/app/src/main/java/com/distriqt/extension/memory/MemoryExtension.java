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
 * @file MemoryExtension.java
 * @brief Main Extension implementation for this ANE
 * @author Michael Archbold (https://github.com/marchbold)
 * @created 19/05/2016
 */
package com.distriqt.extension.memory;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class MemoryExtension implements FREExtension
{
	public static MemoryContext context;


	@Override
	public FREContext createContext( String arg0 )
	{
		context = new MemoryContext();
		return context;
	}


	@Override
	public void dispose()
	{
		if (context != null)
		{
			context.dispose();
			context = null;
		}
	}


	@Override
	public void initialize()
	{
	}

}
