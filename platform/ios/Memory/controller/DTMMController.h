//
//  DTMMController.h
//  Memory
//
//  Created by Michael Archbold on 29/04/2016.
//  Copyright © 2015 distriqt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTMMEventDispatcherDelegate.h"


@interface DTMMController : NSObject

@property id<DTMMEventDispatcherDelegate> delegate;


-(void) dispose;


-(void) startMonitoringMemory;

-(void) stopMonitoringMemory;

-(NSDictionary*) getMemoryInfo;



@end
