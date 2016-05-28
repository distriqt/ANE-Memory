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
 * @file   		MemoryImplementationFunction.java
 * @brief  		Implementation function implementation for the Compass ANE
 * @author 		Michael Archbold (ma@distriqt.com)
 * @created		19/05/2016
 */
package com.distriqt.extension.memory.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.distriqt.extension.memory.MemoryContext;

public class ImplementationFunction implements FREFunction 
{

	@Override
	public FREObject call( FREContext context, FREObject[] args ) 
	{
		FREObject result = null;
		try
		{
			result = FREObject.newObject( MemoryContext.IMPLEMENTATION );
		}
		catch (FREWrongThreadException e) 
		{
		}
		return result;
	}

}
