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
@property (nonatomic, strong) NSString *sessionId;

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
                                                                 userInfo:@{ @"error" : @( 0 ),
                                                                             @"errorString" : @"lol",
                                                                             @"sessionUUID" : self.sessionId }];
}

- (void)notification:(NSNotification *)aNotification
{
    self.sessionId = aNotification.userInfo[@"sessionUUID"];
    NSMutableDictionary *mutableUserInfo = [aNotification.userInfo mutableCopy];
    mutableUserInfo[@"forceCarDisplay"] = @( YES );
    self.lastSession = [mutableUserInfo copy];
}

@end
