---
title: Usage
sidebar_label: Usage
---


### Low Memory Warning

This extension is very simple in the implementation, you simply add a listener for the `MemoryEvent.LOW_MEMORY_WARNING` and respond accordingly.  

```actionscript
if (Memory.isSupported)
{
	Memory.service.addEventListener( MemoryEvent.LOW_MEMORY_WARNING, lowMemoryWarningHandler );
}
```

Then in your handler you can respond appropriately, clearing any unnecessary memory usage:  

```actionscript
private function lowMemoryWarningHandler( event:MemoryEvent ):void
{
	trace( "low memory warning" );
}
```


### Memory Information

You can retrieve some basic information about the current memory statistics using the `MemoryInfo` class.
You retrieve a current version of this by using the `getMemoryInfo` function:

```actionscript
var info:MemoryInfo = Memory.service.getMemoryInfo();
			
trace( "available memory = " + info.availableMemory );
trace( "total memory     = " + info.totalMemory );
```

These values are gathered from the operating system directly which should be more accurate representation
than the values reported from `System`.

