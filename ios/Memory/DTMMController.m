//
//  DTMMController.m
//  Memory
//
//  Created by Michael Archbold on 29/04/2016.
//  Copyright © 2015 distriqt. All rights reserved.
//

#import "DTMMController.h"
#import "DTMMMemoryEvent.h"

#import <UIKit/UIKit.h>

@implementation DTMMController

@synthesize delegate;



-(id) init
{
	self = [super init];
	if (self)
	{
		[self setup];
	}
	return self;
}


-(void) setup
{
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector: @selector(handleMemoryWarning:)
												 name: UIApplicationDidReceiveMemoryWarningNotification object:nil];
}


-(void) dispose
{
	[[NSNotificationCenter defaultCenter] removeObserver: self];
}





-(void) handleMemoryWarning:(NSNotification *)notification
{
	[delegate dispatch: DTMM_MEMORYEVENT_LOWMEMORYWARNING
				  data: [DTMMMemoryEvent formatForEvent]];
}



@end
