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
 * @file IExtensionContext.java
 * @brief
 * @author Michael Archbold (https://github.com/marchbold)
 * @created 03/07/2015
 */
package com.distriqt.extension.memory.util;

import android.app.Activity;

public interface IExtensionContext
{

	Activity getActivity();

	void dispatchEvent( String code, String data );

}
