//
//  DTMMEventDispatcher.m
//  Memory
//
//  Created by Michael Archbold on 29/04/2016.
//  Copyright © 2015 distriqt. All rights reserved.
//

#import "DTMMEventDispatcher.h"
#import <CoreNativeExtension/CoreNativeExtension.h>

@implementation DTMMEventDispatcher

@synthesize context;


-(void) log: (NSString*) tag message: (NSString*) message, ...
{
    va_list args;
    va_start(args, message);
    NSString* formatedMessage = [[NSString alloc] initWithFormat: message arguments: args];
    va_end(args);
    
    NSLog( @"%@::%@", tag, formatedMessage );
}


-(void) dispatch: (NSString*) code data: (NSString*) data
{
	dispatch_async(dispatch_get_main_queue(), ^{
		FREDispatchStatusEventAsync( context, (const uint8_t*)[code UTF8String], (const uint8_t*)[data UTF8String]);
	});
}

@end
