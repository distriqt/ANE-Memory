built by [distriqt //](https://airnativeextensions.com) 


![Memory](https://raw.githubusercontent.com/distriqt/ANE-Memory/master/images/promo.png)


# Memory

Memory is an AIR Native Extension to receive the low memory notifications on iOS which indicate when 
your application should clear up as much memory as possible to avoid facing termination by the operating system.


### Features

- Low Memory Warning Event 
- Memory Information
- Single API interface - your code works across supported platforms with no modifications
- Sample project code and ASDocs reference



## Documentation


### Low Memory Warning

This extension is very simple in the implementation, you simply add a listener for the `MemoryEvent.LOW_MEMORY_WARNING` and respond accordingly.  

```as3
if (Memory.isSupported)
{
	Memory.service.addEventListener( MemoryEvent.LOW_MEMORY_WARNING, lowMemoryWarningHandler );
}
```

Then in your handler you can respond appropriately, clearing any unnecessary memory usage:  

```as3
private function lowMemoryWarningHandler( event:MemoryEvent ):void
{
	trace( "low memory warning" );
}
```


### Memory Information

You can retrieve some basic information about the current memory statistics using the `MemoryInfo` class.
You retrieve a current version of this by using the `getMemoryInfo` function:

```as3
var info:MemoryInfo = Memory.service.getMemoryInfo();
			
trace( "available memory = " + info.availableMemory );
trace( "total memory     = " + info.totalMemory );
```

These values are gathered from the operating system directly which should be more accurate representation
than the values reported from `System`.



## Native Extensions

The highest quality and widest range of Native Extensions for Adobe AIR

With many native extensions available, we are the largest provider of native extensions for AIR developers. 
Our mobile solutions allow developers to fast-forward development and focus on building great games and apps.

[https://airnativeextensions.com](https://airnativeextensions.com)



## Acknowledgements

This extension was made possible with support by [MovieStarPlanet](http://corporate.moviestarplanet.com/) 

![MovieStarPlanet](https://raw.githubusercontent.com/distriqt/ANE-Memory/master/images/msp_logo.png)


