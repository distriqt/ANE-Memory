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
package com.distriqt.extension.memory.controller;

import android.app.ActivityManager;
import android.content.ComponentCallbacks2;
import android.content.Context;
import android.content.res.Configuration;
import android.os.Build;
import android.util.Log;

import com.distriqt.extension.memory.events.MemoryEvent;
import com.distriqt.extension.memory.util.IExtensionContext;


public class MemoryController implements ComponentCallbacks2
{
	////////////////////////////////////////////////////////////
	//	CONSTANTS
	//

	private static final String TAG = MemoryController.class.getSimpleName();


	////////////////////////////////////////////////////////////
	//	VARIABLES
	//

	private IExtensionContext _extContext;


	////////////////////////////////////////////////////////////
	//	FUNCTIONALITY
	//

	public MemoryController( IExtensionContext extensionContext )
	{
		_extContext = extensionContext;
	}


	public void dispose()
	{
		stopMonitoringMemory();
		_extContext = null;
	}


	public static boolean isSupported()
	{
		return Build.VERSION.SDK_INT >= 16;
	}


	public ActivityManager.MemoryInfo getMemoryInfo()
	{
		Log.d( TAG, "getMemoryInfo()" );

		ActivityManager.MemoryInfo info = new ActivityManager.MemoryInfo();
		ActivityManager activityManager = (ActivityManager) _extContext.getActivity().getSystemService( Context.ACTIVITY_SERVICE );
		activityManager.getMemoryInfo( info );

		return info;
	}


	public void startMonitoringMemory()
	{
		Log.d( TAG, "startMonitoringMemory()" );
		_extContext.getActivity().registerComponentCallbacks( this );
	}


	public void stopMonitoringMemory()
	{
		Log.d( TAG, "stopMonitoringMemory()" );
		_extContext.getActivity().unregisterComponentCallbacks( this );
	}


	//
	//	ComponentCallbacks2
	//

	@Override
	public void onConfigurationChanged( Configuration newConfig )
	{
		Log.d( TAG, "onConfigurationChanged()" );
	}


	@Override
	public void onLowMemory()
	{
		Log.d( TAG, "onLowMemory()" );
	}


	@Override
	public void onTrimMemory( int level )
	{
		Log.d( TAG, String.format( "onTrimMemory( %d )", level ) );
		_extContext.dispatchEvent(
				MemoryEvent.LOWMEMORYWARNING,
				MemoryEvent.formatForEvent(
						trimMemoryLevelToString( level )
				)
		);
	}


	private String trimMemoryLevelToString( int level )
	{
		switch (level)
		{
			case ComponentCallbacks2.TRIM_MEMORY_UI_HIDDEN:
				return "ui_hidden";
			case ComponentCallbacks2.TRIM_MEMORY_RUNNING_MODERATE:
				return "running_moderate";
			case ComponentCallbacks2.TRIM_MEMORY_RUNNING_LOW:
				return "running_low";
			case ComponentCallbacks2.TRIM_MEMORY_RUNNING_CRITICAL:
				return "running_critical";
			case ComponentCallbacks2.TRIM_MEMORY_BACKGROUND:
				return "background";
			case ComponentCallbacks2.TRIM_MEMORY_MODERATE:
				return "moderate";
			case ComponentCallbacks2.TRIM_MEMORY_COMPLETE:
				return "complete";
		}
		return "unknown";
	}


}
