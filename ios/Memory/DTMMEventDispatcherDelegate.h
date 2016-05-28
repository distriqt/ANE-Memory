//
//  DTMMEventDispatcherDelegate.h
//  Memory
//
//  Created by Michael Archbold on 29/04/2016.
//  Copyright © 2015 distriqt. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DTMMEventDispatcherDelegate <NSObject>

-(void) log: (NSString*) tag message: (NSString*) message, ...;

-(void) dispatch: (NSString*) code data: (NSString*) data;

@optional

@end
