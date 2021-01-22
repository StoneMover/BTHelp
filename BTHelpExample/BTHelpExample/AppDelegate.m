//
//  AppDelegate.m
//  BTHelpExample
//
//  Created by Motion Code on 2019/2/13.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "AppDelegate.h"
#import "NSString+BTString.h"
#import "NSDate+BTDate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"randomStr:%@",[NSString bt_randomStr]);
    
    
//    NSDate * dateSys = [NSDate date];
//    NSDate * dateBT = [NSDate bt_initLocalDate];
    
    NSString * dateStr = @"2020-01-04 21:09:34";
    NSDateFormatter * formatter =[[NSDateFormatter alloc] init];
//    formatter.timeZone = NSTimeZone.systemTimeZone;
    formatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSDate * dateSys = [formatter dateFromString:dateStr];
//    NSDate * dateBt = [NSDate bt_dateFromStr:dateStr formatter:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString * dateSysStr = [dateSys bt_dateStr:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString * dateSysStr2 = [formatter stringFromDate:dateSys];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
