---
title: Usage
sidebar_label: Usage
---


## Low Memory Warning

This extension is very simple in the implementation, you simply add a listener for the `MemoryEvent.LOW_MEMORY_WARNING` and respond accordingly.  

```actionscript
if (Memory.isSupported)
{
	Memory.service.addEventListener( MemoryEvent.LOW_MEMORY_WARNING, lowMemoryWarningHandler );
}
```

Then in your handler you can respond appropriately, clearing any unnecessary memory usage:  

```actionscript
function lowMemoryWarningHandler( event:MemoryEvent ):void
{
	trace( "low memory warning" );
}
```


### Level

On Android you will receive additional information in the event, pertaining to the "level" (in the `event.level` property). The level of the low memory warning gives a hint as to the amount of trimming the application may like to perform. Levels and associated descriptions can be found in the `MemoryWarningLevel` class. 


```actionscript
function lowMemoryWarningHandler( event:MemoryEvent ):void
{
	switch (event.level)
	{
		case MemoryWarningLevel.RUNNING_LOW:
			break; 

		case MemoryWarningLevel.RUNNING_MODERATE:
			break; 

		// Other state handlers
	}
}
```

On unsupported platforms the level will be "unknown".



## Memory Information

You can retrieve some basic information about the current memory statistics using the `MemoryInfo` class.
You retrieve a current version of this by using the `getMemoryInfo` function:

```actionscript
var info:MemoryInfo = Memory.service.getMemoryInfo();
			
trace( "available memory = " + info.availableMemory );
trace( "total memory     = " + info.totalMemory );
```

These values are gathered from the operating system directly which should be more accurate representation
than the values reported from `System`.

