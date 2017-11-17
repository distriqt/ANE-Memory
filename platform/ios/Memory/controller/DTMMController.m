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

#import <mach/mach.h>
#import <mach/mach_host.h>

@implementation DTMMController

@synthesize delegate;



-(id) init
{
	self = [super init];
	if (self)
	{
	}
	return self;
}


-(void) dispose
{
	[self stopMonitoringMemory];
}


-(void) startMonitoringMemory
{
	[[NSNotificationCenter defaultCenter] addObserver: self
											 selector: @selector(handleMemoryWarning:)
												 name: UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

-(void) stopMonitoringMemory
{
	[[NSNotificationCenter defaultCenter] removeObserver: self];
}


-(NSDictionary*) getMemoryInfo
{
	NSMutableDictionary* info = [[NSMutableDictionary alloc] init];
	
	unsigned long long totalMemory = [NSProcessInfo processInfo].physicalMemory;
	
	
	mach_port_t host_port;
	mach_msg_type_number_t host_size;
	vm_size_t pagesize;
	
	host_port = mach_host_self();
	host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
	host_page_size(host_port, &pagesize);
	
	vm_statistics_data_t vm_stat;
	
	if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) == KERN_SUCCESS)
	{
		/* Stats in bytes */
//		unsigned long mem_used = (vm_stat.active_count +
//								  vm_stat.inactive_count +
//								  vm_stat.wire_count) * pagesize;
		unsigned long mem_free = vm_stat.free_count * pagesize;
//		unsigned long mem_total = mem_used + mem_free;
		
		[info setObject: [NSNumber numberWithUnsignedLong: mem_free] forKey: @"availableMemory"];
		[info setObject: [NSNumber numberWithLongLong: totalMemory] forKey: @"totalMemory"];
	}
	
	
	return info;
}



//
//
//

-(void) handleMemoryWarning:(NSNotification *)notification
{
	[delegate dispatch: DTMM_MEMORYEVENT_LOWMEMORYWARNING
				  data: [DTMMMemoryEvent formatForEvent]];
}



@end
