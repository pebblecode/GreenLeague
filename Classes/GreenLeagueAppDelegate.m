//
//  GreenLeagueAppDelegate.m
//  GreenLeague
//
//  Created by Tak Tran on 23/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GreenLeagueAppDelegate.h"
#import "FindViewController.h"
#import "CompareViewController.h"
#import "AboutViewController.h"
#import	"UniversitiesModel.h"

@implementation GreenLeagueAppDelegate

@synthesize window;
@synthesize tabBarController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	UniversitiesModel *universitiesModel = [[UniversitiesModel alloc] init];
    
    // Find view controller	
    FindViewController *findVC = [[FindViewController alloc] initWithUniversitiesModel:universitiesModel];
    UINavigationController *findNavController = [[UINavigationController alloc] initWithRootViewController:findVC];
    [findVC release];

    
    // Compare view controller
    CompareViewController *compareVC = [[CompareViewController alloc] initWithUniversitiesModel:universitiesModel];    
    UINavigationController *compareNavController = [[UINavigationController alloc] initWithRootViewController:compareVC];
    [compareVC release];
    
	AboutViewController *aboutVC = [[AboutViewController alloc] init];    
    
    NSArray *tabVCs = [NSArray arrayWithObjects:findNavController, compareNavController, aboutVC, nil];
    [tabBarController setViewControllers:tabVCs animated:YES]; // Doesn't seem to animate	
	
	[findNavController release];
	[compareNavController release];
	[aboutVC release];
	[universitiesModel release];

    // Self as delegate
    tabBarController.delegate = self;
    
    // Add the tab bar controller's view to the window and display.
    [self.window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark UITabBarControllerDelegate methods


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    // If the compare tab is selected and hte find selector view controller is shown, a tab press should be the same as pressing done
    if (self.tabBarController.selectedIndex == 1) { // Selected compare view
                
        if ([viewController class] == [UINavigationController class]) {
            UINavigationController *navController = (UINavigationController *)viewController;
            
            if ([[navController topViewController] class] == [CompareViewController class]) {
                
                CompareViewController *compareVC = (CompareViewController *)[navController topViewController];
                
                // It's as if you selected done
                [compareVC.findSelectorViewController doneButtonPressed];                
            }
        }
    }
}


/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}


@end

