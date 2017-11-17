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
 * @file   		Memory.m
 * @brief  		ActionScript Native Extension
 * @author 		Michael Archbold
 * @created		19/05/2016
 *
 */

#define MAP_FUNCTION(fn, name, data) { (const uint8_t*)(name), (data), &(fn) }


#import "FlashRuntimeExtensions.h"
#import "DTMMController.h"
#import "DTMMEventDispatcher.h"



NSString * const Memory_VERSION = @"1.0";
NSString * const Memory_IMPLEMENTATION = @"iOS";

FREContext distriqt_memory_ctx = nil;
Boolean distriqt_memory_v = false;
DTMMEventDispatcher* distriqt_memory_eventDispatcher = nil;
DTMMController* distriqt_memory_controller = nil;


////////////////////////////////////////////////////////
//	ACTIONSCRIPT INTERFACE METHODS 
//

FREObject MemoryVersion(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
    @autoreleasepool
    {
        FRENewObjectFromUTF8( (uint32_t)strlen((const char*)[Memory_VERSION UTF8String]) + 1, (const uint8_t*)[Memory_VERSION UTF8String], &result);
    }
    return result;
}


FREObject MemoryImplementation(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
    @autoreleasepool
    {
		FRENewObjectFromUTF8( (uint32_t)strlen((const char*)[Memory_IMPLEMENTATION UTF8String]) + 1, (const uint8_t*)[Memory_IMPLEMENTATION UTF8String], &result);
    }
    return result;
}


FREObject MemoryIsSupported(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
    @autoreleasepool
    {
        FRENewObjectFromBool( true, &result );
    }
    return result;
}


FREObject Memory_startMonitoringMemory(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
	@autoreleasepool
	{
		[distriqt_memory_controller startMonitoringMemory];
	}
	return result;
}


FREObject Memory_stopMonitoringMemory(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
	@autoreleasepool
	{
		[distriqt_memory_controller stopMonitoringMemory];
	}
	return result;
}


FREObject Memory_getMemoryInfo(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
	@autoreleasepool
	{
		NSDictionary* info = [distriqt_memory_controller getMemoryInfo];

		if (FRE_OK == FRENewObject( (const uint8_t*)"Object", 0, NULL, &result, NULL))
		{
			for (NSString* key in info)
			{
				FREObject value;
				if (FRE_OK == FRENewObjectFromDouble( [((NSNumber*)[info objectForKey: key]) doubleValue], &value))
				{
					FRESetObjectProperty( result, (const uint8_t*)[key UTF8String], value, NULL );
				}
			}
		}
		
	}
	return result;
}




////////////////////////////////////////////////////////
// FRE CONTEXT 
//

void MemoryContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{

    //
	//	Add the ACTIONSCRIPT interface
	
	static FRENamedFunction distriqt_memoryFunctionMap[] =
    {
        MAP_FUNCTION( MemoryVersion,          "version",          NULL ),
        MAP_FUNCTION( MemoryImplementation,   "implementation",   NULL ),
        MAP_FUNCTION( MemoryIsSupported,      "isSupported",      NULL ),
		
		
		MAP_FUNCTION( Memory_startMonitoringMemory,		"startMonitoringMemory",	NULL ),
		MAP_FUNCTION( Memory_stopMonitoringMemory,		"stopMonitoringMemory",		NULL ),
		MAP_FUNCTION( Memory_getMemoryInfo,				"getMemoryInfo",			NULL ),
		
    };
    
    *numFunctionsToTest = sizeof( distriqt_memoryFunctionMap ) / sizeof( FRENamedFunction );
    *functionsToSet = distriqt_memoryFunctionMap;
    
	
	//
	//	Store the global states
	
    distriqt_memory_ctx = ctx;
    distriqt_memory_v = false;
    
    distriqt_memory_eventDispatcher = [[DTMMEventDispatcher alloc] init];
    distriqt_memory_eventDispatcher.context = distriqt_memory_ctx;
    
    distriqt_memory_controller = [[DTMMController alloc] init];
    distriqt_memory_controller.delegate = distriqt_memory_eventDispatcher;
}


void MemoryContextFinalizer(FREContext ctx) 
{
    if (distriqt_memory_controller != nil)
    {
		[distriqt_memory_controller dispose];
        distriqt_memory_controller.delegate = nil;
        distriqt_memory_controller = nil;
    }
    
    if (distriqt_memory_eventDispatcher != nil)
    {
        distriqt_memory_eventDispatcher.context = nil;
        distriqt_memory_eventDispatcher = nil;
    }

	distriqt_memory_ctx = nil;
}


void MemoryExtInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet ) 
{
	*extDataToSet = NULL;
	*ctxInitializerToSet = &MemoryContextInitializer;
	*ctxFinalizerToSet   = &MemoryContextFinalizer;
} 


void MemoryExtFinalizer( void* extData ) 
{
	// Nothing to clean up.	
}

