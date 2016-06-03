This extension was built by distriqt // 


It was made possible with support by [MovieStarPlanet](http://corporate.moviestarplanet.com/) ![MovieStarPlanet](https://raw.githubusercontent.com/distriqt/ANE-Memory/master/images/msp_logo.png)



# Memory

Memory is an AIR Native Extension to receive the low memory notifications on iOS which indicate when your application should clear up as much memory as possible to avoid facing termination by the operating system.


### Features

- Low Memory Warning Event 
- Single API interface - your code works across supported platforms with no modifications
- Sample project code and ASDocs reference



## Documentation

This extension is very simple in the implementation, you simply add a listener for the `MemoryEvent.LOW_MEMORY_WARNING` and respond accordingly.  


```actionscript
if (Memory.isSupported)
{
	Memory.service.addEventListener( MemoryEvent.LOW_MEMORY_WARNING, lowMemoryWarningHandler );
}

...

private function lowMemoryWarningHandler( event:MemoryEvent ):void
{
	trace( "low memory warning" );
}
```


## Native Extensions

The highest quality and widest range of Native Extensions for Adobe AIR

With many native extensions available, we are the largest provider of native extensions for AIR developers. Our mobile solutions allow developers to fast-forward development and focus on building great games and apps.

http://airnativeextensions.com

