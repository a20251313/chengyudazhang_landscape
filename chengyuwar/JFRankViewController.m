//
//  JFRankViewController.m
//  chengyuwar
//
//  Created by ran on 13-12-14.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFRankViewController.h"
#import "PublicClass.h"
#import "JFLocalPlayer.h"
#import "JFAudioPlayerManger.h"
#import "JFAlertView.h"
#import "JFSQLManger.h"
@interface JFRankViewController ()

@end

@implementation JFRankViewController

@synthesize modelMonth;
@synthesize modelTotal;
@synthesize modelWeek;

-(void)dealloc
{
    self.modelWeek = nil;
    self.modelMonth = nil;
    self.modelTotal = nil;
    [m_arrayWeek release];
    m_arrayWeek = nil;
    [m_arrayTotal release];
    m_arrayTotal = nil;
    [m_arrayMonth release];
    m_arrayWeek = nil;
    
    [m_rankView release];
    m_rankView = nil;
    m_rankReq.delegate = nil;
    [m_rankReq release];
    m_rankReq = nil;
    [super dealloc];
}
-(id)init
{
    self = [super init];
    if (self)
    {
        m_arrayMonth = [[NSMutableArray alloc] init];
        m_arrayTotal = [[NSMutableArray alloc] init];
        m_arrayWeek = [[NSMutableArray alloc] init];
        m_rankReq = [[JFRankReq alloc] init];
        m_rankReq.delegate = self;
      //  [self addTestData];
    }
    return self;
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
        [m_arrayMonth addObject:model];
        [model release];
    }
    for (int i = 0; i < 100; i++)
    {
        JFRankModel  *model = [[JFRankModel alloc] init];
        model.nickName = [NSString stringWithFormat:@"用户hello%i",i];
        model.rankIndex = i+1;
        time(NULL);
        model.userRankScore = random()%1000000;
        [m_arrayTotal addObject:model];
        [model release];
    }
    for (int i = 0; i < 100; i++)
    {
        JFRankModel  *model = [[JFRankModel alloc] init];
        model.nickName = [NSString stringWithFormat:@"用户hello%i",i];
        model.rankIndex = i+1;
        time(NULL);
        model.userRankScore = random()%1000000;
        [m_arrayWeek addObject:model];
        [model release];
    }
    
    
    
    JFRankModel  *model = [[JFRankModel alloc] init];
    model.nickName = [NSString stringWithFormat:@"我是丑八怪%d",10];
    model.rankIndex = 102;
    time(NULL);
    model.userRankScore = random()%1000000;
    self.modelTotal = model;
    self.modelWeek = model;
    self.modelMonth = model;
    
    [model release];
    
    
}

-(void)loadView
{
    [super loadView];
    
    
    CGSize  size = CGSizeMake(self.view.frame.size.height, self.view.frame.size.width);
    if (iPhone5)
    {
        self.view.layer.contents = (id)[UIImage imageNamed:@"main_bg_withnothing_iphone5.png"].CGImage;
        //main_bg_withnothing
    }else
    {
        self.view.layer.contents = (id)[UIImage imageNamed:@"main_bg_withnothing.png"].CGImage;
    }
    
    UIButton      *btnback = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 27+40, 22+4)];
    [btnback setImageEdgeInsets:UIEdgeInsetsMake(2, 20, 2, 20)];
    [btnback setImage:[PublicClass getImageAccordName:@"about_back.png"] forState:UIControlStateNormal];
    [btnback addTarget:self action:@selector(clickBackbtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnback];
    [btnback release];
    
    
    if (!m_rankView)
    {
        m_rankView = [[JFRankView alloc] initWithFrame:CGRectMake((size.width-472)/2, 25, 472, 291) withType:JFRankViewTypeWeek];
        
        JFLocalPlayer *localPlayer = [JFLocalPlayer shareInstance];
        if (localPlayer.roleModel  && localPlayer.roleModel.roleType > 0)
        {
            m_rankView.showSelf = YES;
        }else
        {
            m_rankView.showSelf = NO;
        }

        m_rankView.delegate = self;
        [self.view addSubview:m_rankView];
    }
     [m_rankView updateWithModelWithArray:m_arrayWeek type:JFRankViewTypeWeek userSelf:self.modelWeek];
     [m_rankReq sendToGetRankList:[[JFLocalPlayer shareInstance] userID] rankType:JFRankListTypeWeek];
    
     [m_rankReq requestPersonalInfo:[[JFLocalPlayer shareInstance] userID]];
    
    
}
-(void)clickBackbtn:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
     [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark    JFRankViewDelegate

-(void)requestData:(JFRankViewType)type
{
    m_irankviewtype = type;
    switch (type)
    {
        case JFRankViewTypeWeek:
            if ([m_arrayWeek count])
            {
               [m_rankView updateWithModelWithArray:m_arrayWeek type:type userSelf:self.modelWeek];
            }else
            {
                [m_rankView updateWithModelWithArray:nil type:type userSelf:self.modelWeek];
                [m_rankReq sendToGetRankList:[[JFLocalPlayer shareInstance] userID] rankType:JFRankListTypeWeek];
            }
            
            break;
        case JFRankViewTypeMonth:
            if ([m_arrayMonth count])
            {
                 [m_rankView updateWithModelWithArray:m_arrayMonth type:type userSelf:self.modelMonth];
            }else
            {
                 [m_rankView updateWithModelWithArray:nil type:type userSelf:self.modelMonth];
                 [m_rankReq sendToGetRankList:[[JFLocalPlayer shareInstance] userID] rankType:JFRankListTypeMonth];
            }
           
            break;
        case JFRankViewTypeTotal:
            if ([m_arrayTotal count])
            {
                [m_rankView updateWithModelWithArray:m_arrayTotal type:type userSelf:self.modelTotal];
            }else
            {
                [m_rankView updateWithModelWithArray:nil type:type userSelf:self.modelTotal];
                [m_rankReq sendToGetRankList:[[JFLocalPlayer shareInstance] userID] rankType:JFRankListTypetotal];
            }
            // [m_rankView updateWithModelWithArray:m_arrayTotal type:JFRankViewTypeTotal userSelf:self.modelTotal];
            break;
            
        default:
            break;
    }
}


#pragma mark    JFRankReqDelegate
-(void)getRankIndexArray:(NSMutableArray*)arrayRank type:(JFRankListType)type selfModel:(JFRankModel *)selfmodel
{
    
    selfmodel.nickName = [[JFLocalPlayer shareInstance] nickName];
    switch (type)
    {
        case JFRankListTypeWeek:
            self.modelWeek =  selfmodel;
            [m_arrayWeek removeAllObjects];
            [m_arrayWeek addObjectsFromArray:arrayRank];
            [m_rankView updateWithModelWithArray:m_arrayWeek type:JFRankViewTypeWeek userSelf:self.modelWeek];
            break;
        case JFRankListTypeMonth:
            self.modelMonth =  selfmodel;
            [m_arrayMonth removeAllObjects];
            [m_arrayMonth addObjectsFromArray:arrayRank];
            [m_rankView updateWithModelWithArray:m_arrayMonth type:JFRankViewTypeMonth userSelf:self.modelMonth];
            break;
        case JFRankListTypetotal:
            self.modelTotal =  selfmodel;
            [m_arrayTotal removeAllObjects];
            [m_arrayTotal addObjectsFromArray:arrayRank];
            [m_rankView updateWithModelWithArray:m_arrayTotal type:JFRankViewTypeTotal userSelf:self.modelTotal];
            break;
        default:
            break;
    }
  //  [self requestData:m_irankviewtype];
    
}

-(void)getNetError:(NSString *)statusCode
{
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示"
                                                 message:@"无法连接网络。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
    [av show];
    [av release];
}


-(void)getPersionalInfo:(eSDStatus)status info:(NSDictionary*)dicInfo
{
    if (eSDS_Ok == status)
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
        [m_rankView setWinNumber:max_keep_win_times];
        [JFSQLManger UpdateUserInfoToDB:player];
    }
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    
    
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
    
}


- (BOOL)shouldAutorotate
{
    DLOG(@"shouldAutorotate");
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations
{
    return  UIInterfaceOrientationMaskLandscape;
}

@end
