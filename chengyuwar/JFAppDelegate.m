//
//  JFAppDelegate.m
//  chengyuwar
//
//  Created by ran on 13-12-10.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFAppDelegate.h"
#import "JFLauchViewController.h"
#import "JFSQLManger.h"
#import "MyStoreObserver.h"
#import "DomainNameParser.h"
//#import <Frontia/Frontia.h>



#define BAIDUAPP_KEY        @"YRRMgFecELULphcNmpTvc9FL"
@implementation JFAppDelegate
- (void)SaveLogInfo
{
    
#if DEBUG
    pid_t   ppid = getppid();
    if (ppid == 1)
    {
        NSString  *strFileName = @"log0.txt";
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        //strFileName = [documentsDirectory stringByAppendingPathComponent:strFileName];
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[[NSDateFormatter alloc]init] autorelease];
        [formatter setDateFormat:@"yyyyMMddHHmm"];
        NSString *timeStr = [formatter stringFromDate:date];
        
        NSString  *strDoc = [documentsDirectory stringByAppendingPathComponent:@"lelechat_debuglogdoc"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:strDoc])
        {
            BOOL  suc =  [[NSFileManager defaultManager] createDirectoryAtPath:strDoc withIntermediateDirectories:NO attributes:nil error:nil];
            if (!suc)
            {
                DLOG(@"createDirectoryAtPath :%@  fail",strDoc);
            }
        }
        strFileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"lelechat_debuglogdoc/log%@.txt", timeStr]];
        // freopen([strFileName UTF8String],"w",stdout);
        freopen([strFileName UTF8String],"w",stderr);
        
    }
#endif
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    /*
    DomainNameParser    *level = [DomainNameParser sharedInstance];
    [level loadBLDBIPs];*/
    
    [JFSQLManger CreateDataTable];
    
    
    JFLauchViewController   *control = [[JFLauchViewController alloc] init];
    UINavigationController  *nav = [[UINavigationController alloc] initWithRootViewController:control];
    [control release];
    
    [self.window addSubview:nav.view];
    [self.window makeKeyAndVisible];
    

    self.window.rootViewController = nav;
    

   
    
    MyStoreObserver *tempObserver = [[MyStoreObserver alloc] init];
	[[SKPaymentQueue defaultQueue] addTransactionObserver:tempObserver];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    [self SaveLogInfo];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
   // [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationWillResignActiveNotification object:nil];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   // [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationWillEnterForegroundNotification object:nil];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (NSUInteger)supportedInterfaceOrientationsForWindow:(UIWindow *)window 
{
    
    //return UIInterfaceOrientationMaskAll;
    
    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
    //return [[JFAppSet shareInstance] curreninterface];
}



- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return [[JFAppSet shareInstance] curreninterface];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return YES;
}

@end
