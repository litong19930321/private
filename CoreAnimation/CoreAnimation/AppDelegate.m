//
//  AppDelegate.m
//  CoreAnimation
//
//  Created by 李曈 on 2017/2/27.
//  Copyright © 2017年 lt. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreAnimationViewController.h"


//chapter--1
#import "ContentRectViewController.h"
#import "CustomdrawingViewController.h"
//chapter--2
#import "LayoutViewController.h"
#import "HitTestViewController.h"
//chapter--3
#import "LayerPropertyViewController.h"
#import "ScalingfilterViewController.h"
//chapter--4
#import "AffineTransViewController.h"
#import "Layer0flatteningViewController.h"
#import "SolidViewController.h"
//chapter--5
#import "ShapLayerViewController.h"
#import "CAScrollerViewController.h"
#import "ReplicatorViewController.h"
#import "AvplayerViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
//    CoreAnimationViewController * root = [[CoreAnimationViewController alloc] init];
    
    //chapter--1
//    ContentRectViewController * root = [[ContentRectViewController alloc] init];
//    CustomdrawingViewController * root = [[CustomdrawingViewController alloc] init];
    
    
    //chapter--2
//    LayoutViewController * root = [[LayoutViewController alloc] init];
//    HitTestViewController * root = [[HitTestViewController alloc] init];

    //chapter--3
//    LayerPropertyViewController * root = [[LayerPropertyViewController alloc] init];
//    ScalingfilterViewController * root = [[ScalingfilterViewController alloc] init];
    
    
    //chapter--4
//    AffineTransViewController * root = [[AffineTransViewController alloc] init];
//    SolidViewController * root = [[SolidViewController alloc] init];
    
    
    //chapter--5
//    ShapLayerViewController * root = [[ShapLayerViewController alloc] init];
//    CAScrollerViewController * root = [[CAScrollerViewController alloc] init];
//    ReplicatorViewController * root = [[ReplicatorViewController alloc] init];
    AvplayerViewController *root = [[AvplayerViewController alloc] init];
    self.window.rootViewController = root;
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
