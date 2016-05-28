//
//  DTMMEventDispatcher.h
//  Memory
//
//  Created by Michael Archbold on 29/04/2016.
//  Copyright © 2015 distriqt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTMMEventDispatcherDelegate.h"
#import "FlashRuntimeExtensions.h"


@interface DTMMEventDispatcher : NSObject<DTMMEventDispatcherDelegate>

@property FREContext context;

@end
