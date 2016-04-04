//
//  AppDelegate.m
//  Journe
//
//  Created by admin on 19/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize Login;
static NSString * const  kClientID = @"162564169527-3t8cgrvkvhiih7vugjt8p9rdqvhqlthv.apps.googleusercontent.com";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  
     [self registerForPushNotification];
    [NSThread sleepForTimeInterval:0];
    [GIDSignIn sharedInstance].clientID = kClientID;
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    Login = [[SplashVC alloc]initWithNibName:@"SplashVC" bundle:nil];
    self.window.rootViewController = Login;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:Login];
    [navigation setNavigationBarHidden:YES animated:YES];
    self.window.rootViewController = navigation;
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:YES];
    [self.window makeKeyAndVisible];
    
    
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (BOOL)application: (UIApplication *)application
            openURL: (NSURL *)url
  sourceApplication: (NSString *)sourceApplication
         annotation: (id)annotation {
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:sourceApplication
                                      annotation:annotation];
    
    //return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation]
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - Notifications Delegate Methods
#pragma mark -

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString *str=[[[deviceToken description]stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:str forKey:@"DEVICE_TOKEN"];
    [def synchronize];
    
    NSLog(@"DEVICE_TOKEN is: %@", str);
    
}

#pragma mark - Notifications Delegate Methods
#pragma mark -

- (void) registerForPushNotification

{
    
    NSLog(@"registerForPushNotification");
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        
    {
        
        
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0 //
        
        
        
        
        
        NSLog(@"registerForPushNotification: For iOS >= 8.0");
        
        
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:
         
         [UIUserNotificationSettings settingsForTypes:
          
          (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
          
                                           categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
#endif
        
        
        
    } else {
        
        NSLog(@"registerForPushNotification: For iOS < 8.0");
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         
         (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
        
        
    }
    
    [[UIApplication sharedApplication]  setApplicationIconBadgeNumber:0];
    
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    
    
    NSLog(@"notification methodcall");
    
    
    
    //[UIApplication sharedApplication].applicationIconBadgeNumber++;
    
    
    
    /* int badgeCount = [UIApplication sharedApplication].applicationIconBadgeNumber;
     
     badgeCount = badgeCount + 1;
     
     
     
     [UIApplication sharedApplication].applicationIconBadgeNumber = badgeCount;
     
     //[UIApplication sharedApplication].applicationIconBadgeNumber = [[[userInfo objectForKey:@"aps"] objectForKey: @"badgecount"] intValue];
     
     
     
     
     
     NSLog(@"notification ===%ld",(long)[UIApplication sharedApplication].applicationIconBadgeNumber);
     
     */
    
    NSMutableArray *noteArray = [userInfo valueForKey:@"aps"];
    
    NSLog(@"noteArray",noteArray);
    
    //NSString *message = [noteArray valueForKey:@"alert"];
    
    NSString *mssss=[noteArray valueForKey:@"msg"];
    
    NSLog(@"notification iddd=%@",noteArray);
    
    //
    
    NSError *error;
    
    NSData *data = [mssss dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"print string in dictinaty form=%@",jsonResponse);
    // meeting_id=[jsonResponse objectForKey:@"meeting_id"];
    NSString *msg=[jsonResponse objectForKey:@"message"];
    UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [a show];
   
}



-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSString *str=@"5c2fccfd81d7a0d1a3b";
    NSUserDefaults *def1=[NSUserDefaults standardUserDefaults];
    [def1 setObject:str forKey:@"DEVICE_TOKEN_Custom"];
}


-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    //  [UIApplication sharedApplication].applicationIconBadgeNumber++;
    //
    //
    //
    //    int badgeCount = [UIApplication sharedApplication].applicationIconBadgeNumber;
    //
    //     badgeCount = badgeCount + 1;
    //
    //
    //
    //     [UIApplication sharedApplication].applicationIconBadgeNumber = badgeCount;
    //
    //     [UIApplication sharedApplication].applicationIconBadgeNumber = [[[userInfo objectForKey:@"aps"] objectForKey: @"badgecount"] intValue];
    NSDictionary *dict = [userInfo objectForKey:@"aps"];
    NSString *msg =[dict valueForKey:@"message"];//dict[@"msg"];
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSString *msgs=[jsonResponse objectForKey:@"message"];
    UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:msgs delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [a show];
    
}

@end
