//
//  JFRankManger.m
//  chengyuwar
//
//  Created by ran on 13-12-14.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFRankManger.h"
#import "JFLocalPlayer.h"
#import "JFAlertView.h"
#import "JFSQLManger.h"
@implementation JFRankManger
@synthesize selfModel;


-(id)init
{
    self = [super init];
    if (self)
    {
        m_arrayData = [[NSMutableArray alloc] init];
       
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [m_arrayData release];
    m_arrayData = nil;
    [m_rankView release];
    m_rankView = nil;
    [m_rankReq release];
    m_rankReq = nil;
    self.selfModel = nil;

    [super dealloc];
}
-(void)addTestData
{
    for (int i = 0; i < 100; i++)
    {
        JFRankModel  *model = [[JFRankModel alloc] init];
        model.nickName = [NSString stringWithFormat:@"用户hello%i",i];
        model.rankIndex = i+1;
        time(NULL);
        model.userRankScore = random()%1000000;
        [m_arrayData addObject:model];
        [model release];
    }
    
    
    
    JFRankModel  *model = [[JFRankModel alloc] init];
    model.nickName = [NSString stringWithFormat:@"我是丑八怪%d",10];
    model.rankIndex = 102;
    time(NULL);
    model.userRankScore = random()%1000000;
    self.selfModel = model;
    [model release];
    
    
}


-(void)addobserverForBarOrientationNotification
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeInterface:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}
-(void)changeInterface:(NSNotification*)note
{
    
    int type = [[[note userInfo] valueForKey:UIApplicationStatusBarOrientationUserInfoKey] intValue];
    if (type == 4)
    {
        [m_rankView setTransform:CGAffineTransformMakeRotation(-M_PI_2*3)];
    }else if (type == 3)
    {
        [m_rankView setTransform:CGAffineTransformMakeRotation(M_PI_2*3)];
    }
    DLOG(@"note:%@  note userInfo:%@",note,[note userInfo]);
}

-(void)requestRankeData
{
    if (!m_rankReq)
    {
        m_rankReq = [[JFRankReq alloc] init];
        m_rankReq.delegate = self;
    }
    [m_rankReq requestPersonalInfo:[[JFLocalPlayer shareInstance] userID]];
    [m_rankReq sendToGetRankList:[[JFLocalPlayer shareInstance] userID] rankType:JFRankListTypeWeek];
}


#pragma mark JFRankReqDelegate
-(void)getRankIndexArray:(NSMutableArray*)arrayRank type:(JFRankListType)type selfModel:(JFRankModel *)tempselfmodel
{
    [m_arrayData removeAllObjects];
    [m_arrayData addObjectsFromArray:arrayRank];
    
    JFRankView  *view = (JFRankView*)[m_rankView viewWithTag:200];
    
    self.selfModel = tempselfmodel;
    self.selfModel.nickName = [[JFLocalPlayer shareInstance] nickName];
    if ([self.selfModel.nickName isEqualToString:@""] || !selfModel.nickName)
    {
        self.selfModel.nickName = [[JFLocalPlayer shareInstance] userID];
    }
    
    [view updateWithModelWithArray:m_arrayData type:JFRankViewTypeNone userSelf:tempselfmodel];
    
   // [m_rankView ];
}

-(void)getNetError:(NSString *)statusCode
{
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示"
                                                 message:@"无法连接网络。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
    [av show];
    [av release];
}


-(void)getPersionalInfo:(int)status info:(NSDictionary*)dicInfo
{
    JFRankView  *view = (JFRankView*)[m_rankView viewWithTag:200];
    
 
    if (1 == status)
    {
        //  int     roleID = [[dicInfo valueForKey:@"role_id"] intValue];
        //   NSString  *nickName = [dicInfo valueForKey:@"nick_name"];
        int     winNumber = [[dicInfo valueForKey:@"win_times"] intValue];
        int     loseNumber = [[dicInfo valueForKey:@"lose_times"] intValue];
        int     max_keep_win_times = [[dicInfo valueForKey:@"max_keep_win_times"] intValue];
        int     current = [[dicInfo valueForKey:@"curr_keep_win_times"] intValue];
        
        JFLocalPlayer  *player = [JFLocalPlayer shareInstance];
        //  player.roleModel = [[[JFRoleModel alloc] initWithType:roleID] autorelease];
        //player.nickName = nickName;
        player.winNumber = winNumber;
        player.loseNumber = loseNumber;
        player.maxConWinNumber = max_keep_win_times;
        player.currentMaxWinCount = current;
        player.weekMaxConWinCount = [[dicInfo valueForKey:@"week_max_keep_win_times"] intValue];
        player.weekConWinCount = [[dicInfo valueForKey:@"week_curr_keep_win_times"] intValue];
        player.score = winNumber*3;
        [view setWinNumber:max_keep_win_times];
        [JFSQLManger UpdateUserInfoToDB:player];
    }
    
    
    
}


-(void)showRankView
{
    [self addobserverForBarOrientationNotification];
    if (m_rankView)
    {
        [m_rankView release];
        m_rankView = nil;
        
    }
    
    
    
    
    CGRect  frame = [UIScreen mainScreen].bounds;
    
    m_rankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.width)];
    [m_rankView setBackgroundColor:[UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5]];

    JFRankView *rankView = [[JFRankView alloc] initWithFrame:CGRectMake(0, 0, 450, 262) withType:JFRankViewTypeNone];
    rankView.tag = 200;
    rankView.delegate = self;
    
    /*
    int roleid = [[[JFLocalPlayer shareInstance] roleModel] roleType];
    if (roleid < 1)
    {
        rankView.showSelf = NO;
    }else
    {
        rankView.showSelf = YES;
    }*/
    [rankView updateWithModelWithArray:m_arrayData type:JFRankViewTypeNone userSelf:selfModel];
    [self requestRankeData];
    
    rankView.center = m_rankView.center;
    [m_rankView addSubview:rankView];
    
    
    
    
    
    UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    UIWindow  *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    m_rankView.transform = CGAffineTransformMakeRotation(fValue);
    m_rankView.center = window.center;
    [window addSubview:m_rankView];
    
 //   [m_rankView show];
}


#pragma 
-(void)clickBackBtn:(id)sender
{
    [m_rankView removeFromSuperview];
}
@end
