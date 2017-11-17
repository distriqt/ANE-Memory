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

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.distriqt.extension.memory.controller.MemoryController;
import com.distriqt.extension.memory.functions.GetMemoryInfoFunction;
import com.distriqt.extension.memory.functions.ImplementationFunction;
import com.distriqt.extension.memory.functions.IsSupportedFunction;
import com.distriqt.extension.memory.functions.StartMonitoringMemoryFunction;
import com.distriqt.extension.memory.functions.StopMonitoringMemoryFunction;
import com.distriqt.extension.memory.functions.VersionFunction;
import com.distriqt.extension.memory.util.IExtensionContext;

import java.util.HashMap;
import java.util.Map;

public class MemoryContext extends FREContext implements IExtensionContext
{
	public static String VERSION = "1.0";
	public static String IMPLEMENTATION = "Android";
	


	public MemoryContext()
	{
	}


	@Override
	public void dispose() 
	{
		if (_controller != null)
		{
			_controller.dispose();
			_controller = null;
		}
	}

	
	@Override
	public Map<String, FREFunction> getFunctions() 
	{
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		
		functionMap.put( "isSupported", 	new IsSupportedFunction() );
		functionMap.put( "version",   		new VersionFunction() );
		functionMap.put( "implementation", 	new ImplementationFunction() );

		functionMap.put( "startMonitoringMemory", 	new StartMonitoringMemoryFunction() );
		functionMap.put( "stopMonitoringMemory", 	new StopMonitoringMemoryFunction() );
		functionMap.put( "getMemoryInfo", 			new GetMemoryInfoFunction() );

		return functionMap;
	}


	//
	//	Controller
	//

	private MemoryController _controller = null;

	public MemoryController controller()
	{
		if (_controller == null)
		{
			_controller = new MemoryController( this );
		}
		return _controller;
	}



	//
	//	IExtensionContext
	//
	
	@Override
	public void dispatchEvent( final String code, final String data )
	{
		try
		{
			dispatchStatusEventAsync( code, data );
		}
		catch (Exception e)
		{
		}
	}

}
