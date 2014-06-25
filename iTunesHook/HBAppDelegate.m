//
//  HBAppDelegate.m
//  iTunesHook
//
//  Created by Nando Vieira on 6/10/14.
//  Copyright (c) 2014 Nando Vieira. All rights reserved.
//

#import "HBAppDelegate.h"

@implementation HBAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    dnc = [NSDistributedNotificationCenter defaultCenter];
    [dnc addObserver:self selector:@selector(updateTrackInfo:) name:@"com.apple.iTunes.playerInfo" object:nil];
    [self startOnLogin];
}

- (void) updateTrackInfo:(NSNotification *)notification {
    NSDictionary *information = [notification userInfo];
    NSString *status = [information objectForKey:@"Player State"];
    
    if ([status isEqual: @"Playing"]) {
        NSString *artist = [information objectForKey:@"Artist"];
        NSString *album = [information objectForKey:@"Album"];
        NSString *track = [information objectForKey:@"Name"];
        
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath: [@"~/.ituneshook" stringByExpandingTildeInPath]];
        
        NSArray *arguments = [NSArray arrayWithObjects: artist, album, track, nil];
        [task setArguments: arguments];
        [task launch];
    }
}

- (void) startOnLogin {
    NSString *appPath = [[NSBundle mainBundle] bundlePath];
    
	// This will retrieve the path for the application
	// For example, /Applications/test.app
	CFURLRef url = (__bridge CFURLRef)[NSURL fileURLWithPath: appPath];
    
	// Create a reference to the shared file list.
    // We are adding it to the current user only.
    // If we want to add it all users, use
    // kLSSharedFileListGlobalLoginItems instead of
    //kLSSharedFileListSessionLoginItems
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL,
                                                            kLSSharedFileListSessionLoginItems, NULL);
	if (loginItems) {
		//Insert an item to the list.
		LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(loginItems,
                                                                     kLSSharedFileListItemLast, NULL, NULL,
                                                                     url, NULL, NULL);
		if (item){
			CFRelease(item);
        }
	}
    
	CFRelease(loginItems);
}

@end
