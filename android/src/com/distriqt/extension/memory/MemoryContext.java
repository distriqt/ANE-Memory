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
 * @file   		MemoryContext.java
 * @brief  		Main Context for an ActionScript Native Extension
 * @author 		Michael Archbold
 * @created		19/05/2016
 */
package com.distriqt.extension.memory;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.distriqt.extension.memory.functions.ImplementationFunction;
import com.distriqt.extension.memory.functions.IsSupportedFunction;
import com.distriqt.extension.memory.functions.VersionFunction;
import com.distriqt.extension.memory.util.IEventDispatcher;

public class MemoryContext extends FREContext implements IEventDispatcher
{
	public static String VERSION = "1.0";
	public static String IMPLEMENTATION = "Android";
	
	
	@Override
	public void dispose() 
	{
	}

	
	@Override
	public Map<String, FREFunction> getFunctions() 
	{
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		
		functionMap.put( "isSupported", 	new IsSupportedFunction() );
		functionMap.put( "version",   		new VersionFunction() );
		functionMap.put( "implementation", 	new ImplementationFunction() );
		
		return functionMap;
	}
	
	
	@Override
	public void dispatchEvent( String code, String data )
	{
		dispatchStatusEventAsync( code, data );
	}
	
}
