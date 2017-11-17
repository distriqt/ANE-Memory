//
//  DTMMMemoryEvent.h
//  Memory
//
//  Created by Michael Archbold on 29/04/2016.
//  Copyright © 2016 distriqt. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DTMM_MEMORYEVENT_LOWMEMORYWARNING	@"memory:lowmemorywarning"


@interface DTMMMemoryEvent : NSObject


+(NSString*) formatForEvent;


@end
