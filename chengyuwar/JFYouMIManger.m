//
//  JFYouMIManger.m
//  i366
//
//  Created by ran on 13-11-22.
//
//
#if 0
#import "JFYouMIManger.h"
#import "YouMiWall.h"
#import "JFAppDelegate.h"
#import "YouMiView.h"
#import "JFLocalPlayer.h"
#define  YOUMISDKAPPID  @"dbab71e4686f0d3e"
#define  YOUMISDKAPPSECRECT  @"4cb7892a392e2049"

static  JFYouMIManger   *youMiinstance = nil;

static  YouMiView       *youmiViewshanece = nil;

@implementation JFYouMIManger
@synthesize delegate;
@synthesize app_userID;

+(id)shareInstanceWithUserID:(int)userID
{
    if (youMiinstance == nil)
    {
        youMiinstance = [[JFYouMIManger alloc] init];
    }
    [youMiinstance setApp_userID:userID];
    
    return youMiinstance;
}

+(void)addYouMiadView:(UIView*)superView frame:(CGRect)frame
{
    if (!youmiViewshanece)
    {
        if (!youMiinstance)
        {
            youMiinstance = [JFYouMIManger shareInstanceWithUserID:[[[JFLocalPlayer shareInstance] userID] intValue]];
        }
        youmiViewshanece = [[YouMiView alloc] initWithContentSizeIdentifier:YouMiBannerContentSizeIdentifier320x50 delegate:nil];
        [youmiViewshanece start];
    }
    [youmiViewshanece setFrame:frame];
    if ([youmiViewshanece superview])
    {
        [youmiViewshanece removeFromSuperview];
    }
    [superView addSubview:youmiViewshanece];
    
}

+(void)removeYouMiView
{
    if (youmiViewshanece && youmiViewshanece.superview)
    {
        [youmiViewshanece removeFromSuperview];
    }
    
}

+(void)sharedealloc
{
    if (youMiinstance == nil)
    {
        [youMiinstance release];
        youMiinstance = nil;
    }
    
}

+(void)showSpotView
{
    [YouMiWallSpot showSpotViewWithBlock:^
    {
        DLOG(@"showSpotView ");
    }];
}

-(void)setUserID:(int)TempuserID
{
    self.app_userID = TempuserID;
   [YouMiConfig setUserID:[NSString stringWithFormat:@"%d",TempuserID]];
    
}
-(id)init
{
 
    self = [super init];
    if (self)
    {
        
        m_arrayData = [[NSMutableArray alloc] init];
        
        JFAppDelegate  *appdelegate = (JFAppDelegate*)[UIApplication sharedApplication].delegate;
        [YouMiConfig launchWithAppID:YOUMISDKAPPID appSecret:YOUMISDKAPPSECRECT];
        [YouMiConfig setChannelID:100 description:@"App Store"];
        [YouMiPointsManager enable];
        [YouMiWall enable];
        [YouMiPointsManager enableManually];
    
#if DEBUG
        [YouMiConfig setIsTesting:YES];
#else
        [YouMiConfig setIsTesting:NO];
#endif
        [YouMiConfig setFullScreenWindow:appdelegate.window];
        [YouMiConfig setUseInAppStore:NO];
        [YouMiConfig setShouldGetLocation:NO];
        [YouMiConfig setUserID:[NSString stringWithFormat:@"%d",self.app_userID]];
       
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pointerGeted:) name:kYouMiPointsManagerRecivedPointsNotification object:nil];
    }
    return self;
}

/*-(void)showYouMiPointAppViewController
{
    
    
    I366_V1_4AppDelegate  *appdelegate = (I366_V1_4AppDelegate*)[UIApplication sharedApplication].delegate;
    
    static   UIWindow  *view = nil;
    if (view == nil)
    {
        view =     [[UIWindow alloc] initWithFrame:appdelegate.window.bounds];
        [view setBackgroundColor:[UIColor whiteColor]];
        [appdelegate.window addSubview:view];
        [view makeKeyAndVisible];
    }
    view.hidden = NO;

    [YouMiConfig setFullScreenWindow:view];
    [YouMiWall showOffers:YES didShowBlock:^
    {
        DLOG(@"showYouMiPointAppViewController");
    } didDismissBlock:^
    {
      
        [self performSelectorOnMainThread:@selector(makeOnMainThread:) withObject:view waitUntilDone:YES];
        DLOG(@"dismiss showYouMiPointAppViewController");
    }];
    
}

-(void)makeOnMainThread:(UIWindow*)window
{
    
     I366_V1_4AppDelegate  *appdelegate = (I366_V1_4AppDelegate*)[UIApplication sharedApplication].delegate;
     [window setHidden:YES];
     [window resignFirstResponder];
     [appdelegate.window makeKeyAndVisible];
    
}*/


-(void)showYouMiPointAppViewController
{
    
    
    JFAppDelegate  *appdelegate = (JFAppDelegate*)[UIApplication sharedApplication].delegate;
    
    static   UIWindow  *view = nil;
    if (view != nil)
    {
        [view release];
        view = nil;
    }
    
    view =     [[UIWindow alloc] initWithFrame:appdelegate.window.bounds];
    [view setBackgroundColor:[UIColor whiteColor]];
    [appdelegate.window addSubview:view];
    [view makeKeyAndVisible];

    
    [YouMiConfig setFullScreenWindow:view];
    [YouMiWall showOffers:YES didShowBlock:^
     {
         DLOG(@"showYouMiPointAppViewController");
     } didDismissBlock:^
     {
         
         [self performSelectorOnMainThread:@selector(makeOnMainThread:) withObject:view waitUntilDone:YES];
         DLOG(@"dismiss showYouMiPointAppViewController");
     }];
    
}

-(void)makeOnMainThread:(UIWindow*)window
{
    
    JFAppDelegate  *appdelegate = (JFAppDelegate*)[UIApplication sharedApplication].delegate;
    [window setHidden:YES];
    [window resignKeyWindow];
   // [window resignFirstResponder];
    [window removeFromSuperview];
    [appdelegate.window makeKeyAndVisible];
    
}


-(void)GetYouMiAppSourceData:(int)page count:(int)count
{
    [YouMiWall requestOffersOpenData:YES page:page count:count revievedBlock:^(NSArray *arraydata,NSError *error)
     {
         if (!error)
         {
             DLOG(@"arraydata:%@ ",arraydata);
         }else
         {
             DLOG(@"GetYouMiAppSourceData error:%@",error);
         }
     }];
}


- (void)pointerGeted:(NSNotification *)notification
{
    
    NSDictionary *dict = [notification userInfo];
    // 手动积分管理可以通过下面这种方法获得每份积分的信息。
    NSArray *pointInfos = [dict objectForKey:kYouMiPointsManagerPointInfosKey];
    for (NSDictionary *aPointInfo in pointInfos)
    {
        // aPointInfo 是每份积分的信息，包括积分数，userID，下载的APP的名字
        DLOG(@"积分数：%@", aPointInfo[kYouMiPointsManagerPointAmountKey]);
        DLOG(@"userID：%@", aPointInfo[kYouMiPointsManagerPointUserIDKey]);
        DLOG(@"产品名字：%@", aPointInfo[kYouMiPointsManagerPointProductNameKey]);
        
        // TODO 按需要处理
    }
}

-(void)dealloc

{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [m_arrayData release];
    m_arrayData = nil;
    [super dealloc];
}

/*
- (void)didReceiveAd:(YouMiView *)adView;

- (void)didFailToReceiveAd:(YouMiView *)adView  error:(NSError *)error;*/
@end
#endif
