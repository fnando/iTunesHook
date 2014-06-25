//
//  HBAppDelegate.h
//  iTunesHook
//
//  Created by Nando Vieira on 6/10/14.
//  Copyright (c) 2014 Nando Vieira. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HBAppDelegate : NSObject <NSApplicationDelegate> {
    NSDistributedNotificationCenter *dnc;
}

@property (assign) IBOutlet NSWindow *window;
- (void) updateTrackInfo:(NSNotification *)notification;
- (void) startOnLogin;
@end
