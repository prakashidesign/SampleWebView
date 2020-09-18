//
//  AppDelegate.m
//  WKWebview
//
//  Created by Abbie on 17/09/20.
//  Copyright © 2020 Abbie. All rights reserved.
//

#import "AppDelegate.h"
#import "OverLayViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    OverLayViewController *blankViewController = [OverLayViewController new];
    blankViewController.view.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    UIViewController *rvc = self.window.rootViewController;
    UIViewController *pvc = rvc.presentedViewController;  // you may need to loop through presentedViewControllers if you have more than one
    if(pvc != nil) {
        [pvc presentViewController: blankViewController animated: NO completion:nil];
    }
    else{
        [self.window.rootViewController presentViewController: blankViewController animated: NO completion:nil];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    UIViewController *test = [self topViewController];
    if ([test isKindOfClass:[OverLayViewController class]]) {
           [test dismissViewControllerAnimated:false completion:nil];
    }
}

- (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

-(UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}
@end
