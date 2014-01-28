//
//  DSAppDelegate.m
//  iOSCar
//
//  Created by Denis Stas on 28.01.14.
//  Copyright (c) 2014 Denis Stas. All rights reserved.
//

#import "DSAppDelegate.h"

@interface DSAppDelegate ()

@property (nonatomic, strong) NSDictionary *lastSession;

@end

@implementation DSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                        selector:@selector(notification:)
                                                            name:@"com.apple.iphonesimulator.startSession"
                                                          object:nil];
}
- (IBAction)startSimulator:(id)sender
{
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.apple.iphonesimulator.startSession"
                                                                   object:nil userInfo:self.lastSession];
}
- (IBAction)endSimulator:(id)sender
{
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.apple.iphonesimulator.endSession"
                                                                   object:nil
                                                                 userInfo:nil];
}

- (void)notification:(NSNotification *)aNotification
{
    NSMutableDictionary *mutableUserInfo = [aNotification.userInfo mutableCopy];
    mutableUserInfo[@"forceCarDisplay"] = @( NO );
    self.lastSession = [mutableUserInfo copy];
}

@end
