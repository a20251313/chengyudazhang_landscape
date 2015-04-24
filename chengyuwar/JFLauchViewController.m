//
//  JFViewController.m
//  chengyuwar
//
//  Created by ran on 13-12-10.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFLauchViewController.h"
#import "JFAlertView.h"
#import "PublicClass.h"
#import "MCProgressBarView.h"
#import "JFRankManger.h"
#import "JFNormalAnswerViewController.h"
#import "JFPhaseXmlData.h"
#import "DownloadHttpInfo.h"
#import "iToast.h"
#import "ZipArchive.h"

#define IDIOMZIPFILESNAME1           @"54e7becf57df4a68c915a4f8a9d30d9b"
#define IDIOMZIPFILESNAME2           @"f963a6267d06d0b3b4b07127422d0729"

@interface JFLauchViewController ()

@end

@implementation JFLauchViewController
@synthesize model;

-(void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (m_playManger)
    {
        [m_playManger stopPlay];
    }
    [m_playManger release];
    m_playManger = nil;
    [m_lanchReq release];
    m_lanchReq = nil;
    self.model = nil;
    [m_arrAllUrl release];
    m_arrAllUrl = nil;
    [DownloadHttpFile CleanDelegateOfObject:self];
    [m_undealNet release];
    m_undealNet = nil;
    [super dealloc];
}

-(id)init
{
    self = [super init];
    if (self)
    {
        
        [JFLocalPlayer shareInstance];      //初始化个人资料，非常重要
        m_arrAllUrl = [[NSMutableArray alloc] init];
        m_playManger = [[JFAudioPlayerManger alloc] initWithType:JFAudioPlayerMangerTypeMainBg];
        m_lanchReq = [[JFLanchRequest alloc] init];
        m_lanchReq.delegate = self;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterForenground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        
    }
    return self;
}

//DFPHaiBaoW12-GB
- (void)viewDidLoad
{
    [super viewDidLoad];
}



-(void)willEnterForenground:(NSNotification*)note
{
    if ([self.navigationController.topViewController isEqual:self])
    {
        [m_playManger playWithLoops:YES];
        UIImageView   *bgView = (UIImageView *)[self.view viewWithTag:2000];
        if (bgView)
        {
            [self addconloginView];
        }
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [m_playManger playWithLoops:YES];
    UIImageView   *bgView = (UIImageView *)[self.view viewWithTag:2000];
    if (bgView)
    {
        [self addconloginView];
    }
    
  //  DLOG(@"font:%@",TEXTHEITIWITHSIZE(15));
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [m_playManger stopPlay];
}
-(void)loadView
{
    [super loadView];
    
    [JFGameCenterManger shareInstanceWithDelgate:self];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.layer.contents = (id)[PublicClass getImageAccordName:@"main_interface_bg.png"].CGImage;
    
    
    extern  NSString   *const   BNRShowSetView;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clicksetBtn:) name:BNRShowSetView object:nil];
    
    
    [self checkNeedLoadProgressView];
  //  [self checkHasUnDealchargeInfo];
}




-(void)checkHasUnDealchargeInfo
{
    BOOL  has = [JFSQLManger isHasUnDealChargeinfo];
    if (has)
    {
        NSDictionary    *dicInfo = [JFSQLManger getUndealChargeInfoAccordbyUserID];
        if (dicInfo)
        {
            if (!m_undealNet)
            {
                m_undealNet = [[JFChargeNet alloc] init];
                m_undealNet.delegate = self;
                [m_undealNet requestChargeResultWithPayID:[dicInfo valueForKey:@"payID"] chanelID:[[dicInfo valueForKey:@"channelID"] intValue]];
            }
        }
    }
}



#pragma mark  app is need copy from bundle to doc
-(BOOL)needCopyFilesFromBundleToDoc
{
   
    NSString    *strName1 = IDIOMZIPFILESNAME1;
    NSString    *strName2 = IDIOMZIPFILESNAME2;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[UtilitiesFunction getNormalQustionZip:strName1]])
    {
        return YES;
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[UtilitiesFunction getNormalQustionZip:strName2]])
    {
        return YES;
    }
    return NO;
}
-(void)moveLocaleidiomFromBundleToDoc
{
    dispatch_queue_t queue = dispatch_queue_create("gcdtest.rongfzh.check", NULL);
    dispatch_async(queue, ^{
        
        
            m_bIsMovePath = YES;
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               [self setProgressViewProgress:0.01];
                           });
            
            NSError *error = nil;
            if ([self moveZipFromBundleToDocAndUnzip:&error])
            {
                JFDownUrlModel  *modelurl  = [[JFDownUrlModel alloc] init];
                modelurl.md5String = IDIOMZIPFILESNAME1;
                modelurl.packageSize = 0;
                modelurl.urlType = JFDownUrlModelTypeNormalQustion;
                modelurl.urlString = @"";
                JFDownUrlModel  *modelurl2  = [[JFDownUrlModel alloc] init];
                modelurl2.md5String = IDIOMZIPFILESNAME2;
                modelurl2.packageSize = 0;
                modelurl2.urlType = JFDownUrlModelTypeNormalQustion;
                modelurl2.urlString = @"";
                NSMutableArray  *arrZip = [NSMutableArray arrayWithObjects:modelurl,modelurl2, nil];
                [self writeIdiomDataToDB:arrZip];

            }else
            {
                DLOG(@"checkNeedMoveLocaleidiom removeZipAndUnzip:%@",error);
            }
            
        
        
        
        });
    dispatch_release(queue);
    queue = NULL;
    
}

-(NSMutableArray*)getIdiomInfoFromLocalBundle
{
    NSString    *strName1 = IDIOMZIPFILESNAME1;
    NSString    *strName2 = IDIOMZIPFILESNAME2;
    NSMutableArray  *array = [NSMutableArray array];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[UtilitiesFunction getNormalQustionZip:strName1]])
    {
        NSMutableArray  *arrayIdiom = [JFPhaseXmlData phaseUrlInfoAccordPath:[[UtilitiesFunction getNormalQustionZip:strName1] stringByAppendingPathComponent:DOWNDEScription] xmlType:JFPhaseXmlDataTypeNormalIdiom rootPath:[UtilitiesFunction getNormalQustionZip:strName1]];
        [array addObjectsFromArray:arrayIdiom];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[UtilitiesFunction getNormalQustionZip:strName2]])
    {
        NSMutableArray  *arrayIdiom = [JFPhaseXmlData phaseUrlInfoAccordPath:[[UtilitiesFunction getNormalQustionZip:strName2] stringByAppendingPathComponent:DOWNDEScription] xmlType:JFPhaseXmlDataTypeNormalIdiom rootPath:[UtilitiesFunction getNormalQustionZip:strName2]];
        [array addObjectsFromArray:arrayIdiom];
    }
    
    
    DLOG(@"getIdiomInfoFromLocalBundle:count:%d",array.count);
    return array;
}

-(BOOL)moveIdiomXmlFromBundleToDoc:(NSError**)error
{
    NSString    *strName = DOWNXMLFILENAME;
    NSString    *strBundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:strName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:strBundlePath])
    {
        *error = [NSError errorWithDomain:[NSString stringWithFormat:@"file is not exist:%@",strBundlePath] code:1000 userInfo:nil];
        DLOG(@"removeIdiomXml:%@",*error);
        return NO;
    }
    
    NSString    *strMovePath = [UtilitiesFunction getNormalXmlPath:strName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:strMovePath])
    {
        
        NSData *data = [NSData dataWithContentsOfFile:strBundlePath];
        BOOL suc =   [data writeToFile:strMovePath atomically:NO];
        
        // BOOL buc =  [[NSFileManager defaultManager] moveItemAtPath:strBundlePath toPath:strMovePath error:error];
        if (!suc)
        {
            *error = [NSError errorWithDomain:[NSString stringWithFormat:@"data write to file fail:%@",strName] code:1000 userInfo:nil];
            DLOG(@"removeIdiomXml writeToFile:%@ to path:%@ fail,error:%@",strBundlePath,strMovePath,*error);
            return NO;
        }
    }
    return YES;
}

-(BOOL)moveZipFromBundleToDocAndUnzip:(NSError**)error
{
    
    NSString    *strName1 = IDIOMZIPFILESNAME1;
    NSString    *strName2 = IDIOMZIPFILESNAME2;
    
    NSMutableArray  *array = [NSMutableArray array];
    [array addObject:strName1];
    [array addObject:strName2];
    for (NSString *strName in array)
    {
        NSString    *strZipName = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip",strName]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:strZipName])
        {
            *error = [NSError errorWithDomain:[NSString stringWithFormat:@"file is not is exist:%@",strZipName] code:1000 userInfo:nil];
            DLOG(@"moveZipFromBundleToDocAndUnzip:%@",*error);
            return NO;
        }
        NSString    *strMovepath = [UtilitiesFunction getNormalQustionZip:[NSString stringWithFormat:@"%@.zip",strName]];
        
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:strMovepath])
        {
            NSData  *data = [NSData dataWithContentsOfFile:strZipName];
            BOOL    suc = [data writeToFile:strMovepath options:NSDataWritingFileProtectionComplete error:error];
            
            //BOOL  suc = [[NSFileManager defaultManager] moveItemAtPath:strZipName toPath:strMovepath error:error];
            if (!suc)
            {
                
                *error = [NSError errorWithDomain:[NSString stringWithFormat:@"writeToFile fail:%@",strZipName] code:1000 userInfo:nil];
                DLOG(@"moveZipFromBundleToDocAndUnzip:%@",*error);
                return NO;
            }
        }
        
        
        ZipArchive  *zipInfo = [[ZipArchive alloc] init];
        if ([zipInfo UnzipOpenFile:strMovepath])
        {
            BOOL    result = [zipInfo UnzipFileTo:[UtilitiesFunction getNormalQustionZip:strName] overWrite:YES];
            
            if (!result)
            {
                *error = [NSError errorWithDomain:[NSString stringWithFormat:@"file zip fail:%@",strZipName] code:1001 userInfo:nil];
                [zipInfo release];
                zipInfo = nil;
                DLOG(@"UnzipFileTo fail:%@",*error);
                return NO;
            }
            
        }else
        {
            *error = [NSError errorWithDomain:[NSString stringWithFormat:@"file zip open fail:%@",strZipName] code:1002 userInfo:nil];
            [zipInfo release];
            zipInfo = nil;
            DLOG(@"UnzipOpenFile fail:%@",*error);
            return NO;
        }
        [zipInfo release];
        zipInfo = nil;
    }
    
    
    return YES;
}

#pragma mark    checkNeedLoadProgressView
/**
 *
 *
 *  @return 检查是否需要更新题库
 */
-(BOOL)checkNeedLoadProgressView
{
    
    if ([self needCopyFilesFromBundleToDoc])
    {
        [self moveLocaleidiomFromBundleToDoc];
        return NO;
    }
   
    [self addOtherbtns];
    

    return NO;
}
-(void)addconloginView
{
    
    
    if (m_bIsShowGClogin)
    {
        DLOG(@"addconloginView return because m_bIsShowGClogin is YES");
        return;
    }
    
    DLOG(@"addconloginView");
    int willgetday = [[JFLocalPlayer shareInstance] getConloginDays];
    if (willgetday <= 0)
    {
        return;
    }
  /*  NSMutableArray  *array = [NSMutableArray array];
    
    for (int i = 0; i < 5; i++)
    {
        JFConLoginModel  *model1 = [[JFConLoginModel alloc] init];
        model1.day = 1+i;
        model1.rewardType = JFRewardTypeNormal;
        model1.reward_value = 20;
        
        if (i+1 < willgetday)
        {
            model1.rewardType = JFRewardTypeCover;
        }else if (i+1 == willgetday)
        {
            model1.rewardType = JFRewardTypeWillGet;
        }
        
        switch (i)
        {
            case 0:
                model1.reward_value = 20;
                break;
            case 1:
                model1.reward_value = 40;
                break;
            case 2:
                model1.reward_value = 60;
                break;
            case 3:
                model1.reward_value = 80;
                break;
            case 4:
                model1.reward_value = 100;
                break;
                
            default:
                break;
        }
        [array addObject:model1];
        [model1 release];
        
    }
    
    
    UIWindow    *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    for (JFConLoginView *subView in window.subviews)
    {
        if ([subView isKindOfClass:[JFConLoginView class]])
        {
            [subView removeFromSuperview];
        }
    }*/
    JFConLoginView   *conView = [[JFConLoginView alloc] initWithFrame:CGRectZero];
    [conView loadWholeWithVip:JFUserVipTypeNone nextSignID:0 withArray:nil];
     conView.delegate = self;
    [conView show];
    [conView release];
//    [m_conView release];
    
    
}






-(void)clickRaceBtn:(id)sender
{
    

    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (![UtilitiesFunction networkCanUsed])
    {
        [self showNetCannotUserAlert];
        return;
    }
    
   
    if ([[[JFLocalPlayer shareInstance] userID] intValue] <=0 )
    {
        JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示"
                                                     message:@"该模式需登录Game Center账号才能进入" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
        [av show];
        [av release];
        return;
    }
/*
    
    if ([[JFLocalPlayer shareInstance] roleModel]  && [[[JFLocalPlayer shareInstance] roleModel] roleType] != 0)
    {
        JFRaceHallViewController  *controll = [[JFRaceHallViewController alloc] init];
        [self.navigationController pushViewController:controll animated:YES];
        [controll release];
        
    }else
    {
        
        [m_playManger stopPlay];
        JFCreateRoleView  *createView = [[JFCreateRoleView alloc] initWithType:JFCreateRoleViewTypeCreate];
        createView.delegate = self;
        [createView show];
        [createView release];
    }
    
    */
    DLOG(@"clickRaceBtn:%@",sender);
}



-(void)clickpassBtn:(id)sender
{
    
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    NSString    *strStoreEnterKey = [NSString stringWithFormat:@"NormalLevelEnter%@",[[JFLocalPlayer shareInstance] userID]];
     [self resetNormalIdiomForCurrentUser];
    
    NSMutableArray  *arrayModel = [JFSQLManger getAllIdiomInfo:JFIdiomTypeNormal];
    for (int i = 0; i < [arrayModel count]; i++)
    {
        JFIdiomModel    *idiommodel = [arrayModel objectAtIndex:i];
        if (idiommodel.isAnswed)
        {
            continue;
        }else
        {
            
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:strStoreEnterKey] boolValue])
            {
                if (!idiommodel.isUnlocked)
                {
                    [JFSQLManger setLevelUnlocked:[idiommodel.idiomlevelString intValue]];
                }
                
                JFNormalAnswerViewController    *control = [[JFNormalAnswerViewController alloc] initWithWithIdiomModel:idiommodel arrayIdioms:arrayModel];
                [self.navigationController pushViewController:control animated:YES];
                [control release];
                
                return;
            }
        }
        
    }
    
    
 //   [JFSQLManger setIdiomInfoFromZeroToNowUser:[JFLocalPlayer shareInstance]];
    
  
    DLOG(@"clickpassBtn:%@",sender);
    JFCheckPointViewController  *viewcontroller = [[JFCheckPointViewController alloc] init];
    [self.navigationController pushViewController:viewcontroller animated:YES];
    [viewcontroller release];
    
}
-(void)clickRankBtn:(id)sender
{

    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (![UtilitiesFunction networkCanUsed])
    {
        [self showNetCannotUserAlert];
        return;
    }
    if ([[[JFLocalPlayer shareInstance] userID] intValue] <=0 )
    {
        JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示"
                                                     message:@"该模式需登录Game Center账号才能进入" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
        [av show];
        [av release];
        return;
    }

    JFRankViewController  *controler = [[JFRankViewController alloc] init];
    [self.navigationController pushViewController:controler animated:YES];
    [controler release];
        

    
    DLOG(@"clickRankBtn:%@",sender);
}

-(void)showNetCannotUserAlert
{
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示"
                                                 message:@"无法连接网络。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
    [av show];
    [av release];
}
-(void)clicksetBtn:(id)sender
{
    
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    JFSetView *setview = [[JFSetView alloc] initWithFrame:CGRectZero];
    setview.delegate = self;
    [setview show];
    [setview release];
    
    DLOG(@"clicksetBtn:%@",sender);
}
-(void)clicknoticeBtn:(id)sender
{
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (![UtilitiesFunction networkCanUsed])
    {
        [self showNetCannotUserAlert];
        return;
    }
    
    JFNoticeUserView   *noticeView = [[JFNoticeUserView alloc] initWithmessage:self.model.notice];
    [noticeView show];
    [noticeView release];
    DLOG(@"clicknoticeBtn:%@",sender);
}


-(void)addSetBtnAndnoticebtn
{
    CGRect  frame = [UIScreen mainScreen].bounds;
    CGFloat  fYpoint = 20;
    
    UIButton  *btnnotice = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-33-20, fYpoint, 33, 37)];
    [btnnotice setBackgroundImage:[PublicClass getImageAccordName:@"main_notice.png"] forState:UIControlStateNormal];
    [btnnotice setBackgroundImage:[PublicClass getImageAccordName:@"main_notice_pressed.png"] forState:UIControlStateHighlighted];
    [btnnotice addTarget:self action:@selector(clicknoticeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnnotice];
    
    fYpoint += 37+20;
    UIButton  *btnset = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-33-20, fYpoint, 33, 37)];
    [btnset setBackgroundImage:[PublicClass getImageAccordName:@"main_set.png"] forState:UIControlStateNormal];
    [btnset setBackgroundImage:[PublicClass getImageAccordName:@"main_set_pressed.png"] forState:UIControlStateHighlighted];
    [btnset addTarget:self action:@selector(clicksetBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnset];
    
    
    [btnnotice release];
    [btnset release];
}

-(void)addScorllPage
{
    
    
    CGRect  frame = [UIScreen mainScreen].bounds;
    UIImageView   *bgView = (UIImageView *)[self.view viewWithTag:2000];
    if (!bgView)
    {
        bgView =  [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-440)/2, (frame.size.height-80), 440, 73)];
        bgView.userInteractionEnabled = YES;
        bgView.image = [PublicClass getImageAccordName:@"main_scroll_bg.png"];
        [self.view addSubview:bgView];
        bgView.tag = 2000;
        
        CGFloat  fbtnwidth = 130;
        CGFloat  fbtnHeight = 57;
        CGFloat   fsep = (bgView.frame.size.width-fbtnwidth*3)/4-5;
        CGFloat  fbtnXpoint = fsep+19;
        
        UIImage *bgImage = [PublicClass getImageAccordName:@"main_race.png"];
        fbtnwidth = bgImage.size.width/2;
        fbtnHeight = bgImage.size.height/2;
        UIButton  *btnrace = [[UIButton alloc] initWithFrame:CGRectMake(fbtnXpoint, (bgView.frame.size.height-fbtnHeight)/2, fbtnwidth, fbtnHeight)];
        [btnrace setBackgroundImage:bgImage forState:UIControlStateNormal];
        [btnrace setBackgroundImage:[PublicClass getImageAccordName:@"main_race_pressed.png"] forState:UIControlStateHighlighted];
        [btnrace addTarget:self action:@selector(clickRaceBtn:) forControlEvents:UIControlEventTouchUpInside];
        // [bgView addSubview:btnrace];
        
        fbtnXpoint += fbtnwidth+fsep;
        
        bgImage = [PublicClass getImageAccordName:@"main_normal.png"];
        fbtnwidth = bgImage.size.width/2;
        fbtnHeight = bgImage.size.height/2;
        UIButton  *btnpass = [[UIButton alloc] initWithFrame:CGRectMake(fbtnXpoint, (bgView.frame.size.height-fbtnHeight)/2, fbtnwidth, fbtnHeight)];
        [btnpass setBackgroundImage:bgImage forState:UIControlStateNormal];
        [btnpass setBackgroundImage:[PublicClass getImageAccordName:@"main_normal_pressed.png"] forState:UIControlStateHighlighted];
        [btnpass addTarget:self action:@selector(clickpassBtn:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btnpass];
        
        fbtnXpoint += fbtnwidth+fsep;
        bgImage = [PublicClass getImageAccordName:@"main_rank.png"];
        fbtnwidth = bgImage.size.width/2;
        fbtnHeight = bgImage.size.height/2;
        UIButton  *btnrank = [[UIButton alloc] initWithFrame:CGRectMake(fbtnXpoint, (bgView.frame.size.height-fbtnHeight)/2, fbtnwidth, fbtnHeight)];
        [btnrank setBackgroundImage:bgImage forState:UIControlStateNormal];
        [btnrank setBackgroundImage:[PublicClass getImageAccordName:@"main_rank_pressed.png"] forState:UIControlStateHighlighted];
        [btnrank addTarget:self action:@selector(clickRankBtn:) forControlEvents:UIControlEventTouchUpInside];
        //[bgView addSubview:btnrank];
        
        [btnrace release];
        [btnrank release];
        [btnpass release];
        [bgView release];
        
        
    }
    
}

-(void)removeScrollView
{
    UIImageView   *bgView = (UIImageView *)[self.view viewWithTag:2000];
    [bgView removeFromSuperview];
}

-(void)setProgressViewProgress:(CGFloat)fprogress
{
    
    fprogress = fprogress >=1?1:fprogress;
    CGRect  frame = [UIScreen mainScreen].bounds;
    
    MCProgressBarView   *sliderprogress = (MCProgressBarView *)[self.view viewWithTag:1000];
    if (!sliderprogress)
    {
        sliderprogress = [[MCProgressBarView alloc] initWithFrame:CGRectMake((frame.size.width-293)/2, (frame.size.height-60), 293, 20) backgroundImage:[PublicClass getImageAccordName:@"main_slider_bg.png"] foregroundImage:[PublicClass getImageAccordName:@"main_slider_progress.png"]];
        [sliderprogress setFrame:CGRectMake((frame.size.width-293)/2, (frame.size.height-60), 293, 20)];
        //  [sliderprogress setProgressImage:[PublicClass getImageAccordName:@"main_slider_bg.png"]];
        //   [sliderprogress setTrackImage:[PublicClass getImageAccordName:@"main_slider_progress.png"]];
        //   [sliderprogress setProgress:0.2 animated:YES];
        sliderprogress.tag = 1000;
        [self.view addSubview:sliderprogress];
        
        UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sliderprogress.frame.size.width, sliderprogress.frame.size.height)];
        [label setTextColor:[UIColor whiteColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont fontWithName:@"DFPHaiBaoW12" size:11]];
        label.backgroundColor = [UIColor clearColor];
        [sliderprogress addSubview:label];
        label.tag = 10001;
        
        [label release];
        [sliderprogress release];
    }
    
    [sliderprogress setProgress:fprogress];
    UILabel  *labelprogress = (UILabel *)[sliderprogress viewWithTag:10001];
    [labelprogress setText:[NSString stringWithFormat:@"Loading...%0.2f%%",fprogress*100]];
    //   DLOG(@"labelprogress text:%@",labelprogress.text);
}
/**
 *  remove progress view
 */
-(void)removeProgressView
{
    UIView  *view = [self.view viewWithTag:1000];
    [view removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return  [[JFAppSet shareInstance] curreninterface];
}


#pragma mark alertView

-(void)JFAlertClickView:(JFAlertView *)alertView index:(JFAlertViewClickIndex)buttonIndex
{
    if (alertView.tag == 2000)
    {
        if (buttonIndex == JFAlertViewClickIndexRight)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.model.last_verion_url]];
            exit(0);
        }else
        {
            exit(0);
           // [self checkNeedLoadProgressView];
        }
    }
}
#pragma mark JFGameCenterMangerDelegate
-(void)needShowLoginView:(UIViewController*)control
{
    

    [[JFAppSet shareInstance] setCurreninterface:UIInterfaceOrientationMaskAllButUpsideDown];
    [self presentViewController:control animated:YES completion:^{}];
    
    m_bIsShowGClogin = YES;
}

#pragma mark JFConLoginViewDelegate
-(void)sendGetReward:(JFConLoginView*)sender
{
    int  rewardnumber = 200;//[sender getRewardNumber];
    [JFPlayAniManger addGoldWithAni:rewardnumber];
    [JFLocalPlayer addgoldNumber:rewardnumber];
    [JFLocalPlayer storeConLoginDays:[sender getConLoginDays]];
    //  [m_lanchReq sendDailySignedReq:[[[JFLocalPlayer shareInstance] userID] intValue]];
    
}


#pragma mark    JFCreateRoleViewDelegate
-(void)userHasCreateRole:(id)Thread
{
    
}

-(void)userCancelCreateRole:(id)Thread
{
     [m_playManger playWithLoops:YES];
}

#pragma mark JFSetViewdelegate
-(void)clickAboutView:(JFSetView*)view
{
    // view.hidden = YES;
    [view removeFromSuperview];
    JFAboutViewController  *viewcontroll = [[JFAboutViewController alloc] init];
    [self.navigationController pushViewController:viewcontroll animated:YES];
    [viewcontroll release];
    
}


-(void)clickResetBtn:(id)sender
{
    [JFLocalPlayer resetUserInfo];
}

#pragma mark
-(void)startDownLoadQustions:(NSMutableArray*)arrayInfo
{
    [self setProgressViewProgress:0.0];
    
    if (!m_downzipManger)
    {
        m_downzipManger = [[JFDownZipManger alloc] init];
        m_downzipManger.delegate = self;
        
    }
    [m_downzipManger startDownLoadZip:arrayInfo];
    
}

-(void)showBtnAni
{
    [self addScorllPage];
    [self addSetBtnAndnoticebtn];
}

#pragma mark    JFLanchRequestDelegate
-(void)getCommoninfo:(int)status lanchModel:(JFLanchModel*)Tempmodel
{
    if (status == 1)
    {
        self.model = Tempmodel;
        
        if (self.model.last_verion > APP_VERSION)
        {
            
            int nextversion = self.model.last_verion-self.model.last_verion/1000000*1000000;
            
            int nextnextversion = self.model.last_verion-self.model.last_verion/1000*1000;
            NSString    *strVersion = [NSString stringWithFormat:@"v%d.%d.%d",self.model.last_verion/1000000,nextversion/1000,nextnextversion];
            NSString    *updateStr = [NSString stringWithFormat:@"发现新版本%@,是否更新?",strVersion];
            JFAlertView *alert = [[JFAlertView alloc] initWithTitle:@"提示"
                                                            message:updateStr
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"更新"];
            [alert show];
            alert.tag = 2000;
            [alert release];
        }else
        {
            [self checkNeedLoadProgressView];
        }
        
        
        if (self.model)
        {
            JFAppSet  *appset = [JFAppSet shareInstance];
            appset.exhibitiontype = self.model.exhibition_type;
            appset.scorewalltype =  self.model.scorewallType;
        }
         
    }else
    {
        [self getNetError:0];
    }
    [[JFLocalPlayer shareInstance] setLanchModel:Tempmodel];
    
    
}
-(void)getDailySignResult:(int)status
{
    if (status != 1)
    {
        DLOG(@"getDailySignResult fail:%@",[[JFLocalPlayer shareInstance] userID]);
       // [m_lanchReq sendDailySignedReq:[[[JFLocalPlayer shareInstance] userID] intValue]];
    }
    
}

-(void)getUserIDResult:(int)status dicInfo:(NSDictionary*)dicInfo
{
    //   return;
    if (status == 1)
    {
        m_bhasgetUserID = YES;
        JFLocalPlayer   *playEr = [JFLocalPlayer shareInstance];
        playEr.userID = [[dicInfo valueForKey:@"user_id"] description];
        playEr.isPayedUser = [[dicInfo valueForKey:@"is_payed_user"] boolValue];
        // [m_lanchReq getCommonInfo:nil];
        

        [JFSQLManger updateGameCenterLoginInfo:[playEr.GamePlayerInfo valueForKey:@"playerID"] userID:playEr.userID];
        [JFSQLManger UpdateUserInfoToDB:playEr];
        
        
        dispatch_queue_t queue = dispatch_queue_create("gcdtest.rongfzh.cd", NULL);
        dispatch_async(queue, ^{
             [self resetNormalIdiomForCurrentUser];
            
        });
        dispatch_release(queue);
        queue = NULL;
       
    }else
    {
        DLOG(@"getUserIDResult:%d dicInfo:",status);
    }
}

-(BOOL)removeAlertView:(id)Thread
{

    UIWindow    *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    for (JFAlertView *view in window.subviews)
    {
        if ([view isKindOfClass:[JFAlertView class]])
        {
            [view dismiss];
        }
        
    }
    return YES;
}
-(void)getNetError:(int)statusCode
{
    [self removeAlertView:nil];
    
    NSMutableArray  *arrayIdiom = [JFSQLManger getAllIdiomInfo:JFIdiomTypeNormal];
    if (![arrayIdiom count])
    {
        if ([self needCopyFilesFromBundleToDoc])
        {
            [self moveLocaleidiomFromBundleToDoc];
            return;
        }
        [self showNetCannotUserAlert];
    }else
    {
        [self addOtherbtns];
    }
    
}
#pragma gamecenterID get

-(void)getGameCenterID:(NSString*)playerID
{
    
     m_bIsShowGClogin = NO;
    if (!m_bhasgetUserID && playerID)
    {
        NSString    *userid = [JFSQLManger getUserIDAccordGameCenterInfo:playerID];
     
        
        if ([userid intValue] > 0)
        {
            [JFSQLManger updateGameCenterLoginInfo:playerID userID:playerID];
            
            JFLocalPlayer   *player = [JFLocalPlayer shareInstance];
            player.userID = userid;
            
            [JFSQLManger getDataForUserInfoFromDB:[JFLocalPlayer shareInstance]];
            DLOG(@"getGameCenterID no need get userdID");
        }else
        {
            [m_lanchReq getUserID:playerID];
        }
        //  [m_lanchReq getUserID:playerID];
        DLOG(@"getGameCenterID:%@",playerID);
    }else
    {
        DLOG(@"no need get userID getGameCenterID:%@",playerID);
    }
    
    if (playerID && CURRENTVERSIONNUMBER >= 6.0)
    {
        [[JFAppSet shareInstance] setCurreninterface:UIInterfaceOrientationMaskLandscape];
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
        if (type != UIDeviceOrientationLandscapeRight && type != UIDeviceOrientationLandscapeLeft)
        {
            
            if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
            {
                
                DLOG(@"[[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)");
                [[UIDevice currentDevice] performSelector:@selector(setOrientation:)
                                               withObject:(id)UIInterfaceOrientationLandscapeRight];
            }
            
        }
    }
   
}



-(void)addOtherbtns
{
    
    [self addScorllPage];
    [self addSetBtnAndnoticebtn];
   // [self addconloginView];
}

#pragma mark    DownloadHttpFileDelegate

-(void)downNormalXmlSuc:(DownloadHttpInfo*)object
{
    
    
    NSMutableArray  *outArray = [NSMutableArray array];
    NSMutableArray  *arrZip = [JFPhaseXmlData phaseUrlInfoAccordPath:[UtilitiesFunction getNormalXmlPath:object.fileName] xmlType:JFPhaseXmlDataTypeNormalXml rootPath:nil];
    BOOL    bNeed = [JFPhaseXmlData checkArrayZip:arrZip outArray:outArray];
    
    [m_arrAllUrl removeAllObjects];
    [m_arrAllUrl addObjectsFromArray:arrZip];
    
    if (bNeed)
    {
        [self setProgressViewProgress:0];
        [self startDownLoadQustions:outArray];
    }else
    {
        [self addOtherbtns];
    }
    DLOG(@"downNormalXmlSuc:%@",object);
}
-(void)downNormalXmlFail:(DownloadHttpInfo *)object
{
    DLOG(@"downNormalXmlFail:%@",object);
}

#pragma mark    JFDownZipMangerDelegate
- (void)setProgress:(float)newProgress
{
    [self setProgressViewProgress:newProgress];
}


- (void)downLoadZipSuc:(NSMutableArray*)arrDownload
{
    DLOG(@"downLoadZipSuc:%@",arrDownload);
    [self performSelector:@selector(writeIdiomDataToDB:) withObject:arrDownload];
    
}



-(BOOL)checkHasSameModel:(JFIdiomModel*)Tempmodel inarray:(NSMutableArray*)array
{
    for (JFIdiomModel  *temp in array)
    {
        if (temp.index == Tempmodel.index && Tempmodel.packageIndex == temp.packageIndex)
        {
            return YES;
        }
    }
    
    return NO;
}

-(void)resetNormalIdiomForCurrentUser
{
    return;
    if (m_bIsWritingDB)
    {
        return;
    }
    int count = [JFSQLManger getAllIdiomCountAccordTypeFromSql:JFIdiomTypeNormal];
    if (count < LEVELIMPORTCOUNT)
    {
        [JFSQLManger deleteAllItiomAccordType:JFIdiomTypeNormal];
        NSMutableArray  *arrZip = [JFPhaseXmlData phaseUrlInfoAccordPath:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME] xmlType:JFPhaseXmlDataTypeNormalXml rootPath:nil];
        [self writeNormalidiom:arrZip];
    }
    
}
-(void)writeIdiomDataToDB:(NSMutableArray*)arrUrlModel
{
    
    [self writeNormalidiom:arrUrlModel];
    [JFSQLManger insertDataToSQLForRace];
}



-(JFIdiomModel*)getIdomAccordAnswer:(NSString*)strAnswer inAarray:(NSArray*)arrayIdioms
{
    for (JFIdiomModel  *idiomModel in arrayIdioms)
    {
        if ([idiomModel.idiomAnswer rangeOfString:strAnswer].location != NSNotFound)
        {
            return idiomModel;
        }
    }
    return nil;
}


-(void)writeNormalidiom:(NSMutableArray*)arrUrlModel
{
    if (m_bIsWritingDB)
    {
        return;
    }
    if ([JFSQLManger getAllIdiomCountAccordTypeFromSql:JFIdiomTypeNormal] > 1)
    {
        return;
    }
    m_bIsWritingDB = YES;
    int    maxcount = LEVELIMPORTCOUNT;
    int    level = 1;
    NSMutableArray  *arrayOld = [JFSQLManger getAllIdiomInfo:JFIdiomTypeNormal];
    if ([arrayOld count])
    {
        
    }else
    {
        
        NSMutableArray  *arrayAll = [NSMutableArray array];
        NSMutableArray  *arrayInsertArray = [NSMutableArray array];
        for (JFDownUrlModel *tempModel in arrUrlModel)
        {
            NSMutableArray  *arrayIdiom = [JFPhaseXmlData phaseUrlInfoAccordPath:[[UtilitiesFunction getNormalQustionZip:tempModel.md5String] stringByAppendingPathComponent:DOWNDEScription] xmlType:JFPhaseXmlDataTypeNormalIdiom rootPath:[UtilitiesFunction getNormalQustionZip:tempModel.md5String]];
            [arrayAll addObjectsFromArray:arrayIdiom];
        }
        
        if ([arrayAll count])
        {
            maxcount = arrayAll.count;
            DLOG(@"[arrayAll count] :%d",[arrayAll count]);
        }
        
        /*
        if ([arrayAll count] < LEVELIMPORTCOUNT)
        {       
            [arrayAll addObjectsFromArray:[self getIdiomInfoFromLocalBundle]];
        }*/
        
        JFIdiomModel    *idiomShouz = [self getIdomAccordAnswer:@"守株待兔" inAarray:arrayAll];
        if (!idiomShouz)
        {
            
            DLOG(@"cannot find idiom that answer is 守株待兔");
            for (int i = 0; i < [arrayAll count] && i < 3; i++)
            {
                JFIdiomModel  *ididomModel = [arrayAll objectAtIndex:i];
                ididomModel.type = JFIdiomTypeNormal;
                ididomModel.isAnswed = NO;
                ididomModel.isUnlocked = NO;
                ididomModel.idiomlevelString = [NSString stringWithFormat:@"%d",level];
                [JFSQLManger insertIdiomTotable:ididomModel type:JFIdiomTypeNormal];
                DLOG(@"++++++++++++write path:%@",idiomShouz.idiomImageName);
                if (level == 1)
                {
                    [JFSQLManger setLevelUnlocked:1];
                }
                level++;
                
             
                //   DLOG(@"insert ididomModel:%@",ididomModel);
            }
            
        }else
        {
            idiomShouz.type = JFIdiomTypeNormal;
            idiomShouz.isAnswed = NO;
            idiomShouz.isUnlocked = NO;
            idiomShouz.idiomlevelString = [NSString stringWithFormat:@"%d",level];
           
            [JFSQLManger insertIdiomTotable:idiomShouz type:JFIdiomTypeNormal];
            [JFSQLManger setLevelUnlocked:1];
            level++;
            [arrayInsertArray addObject:idiomShouz];
            [arrayAll removeObject:idiomShouz];
            JFIdiomModel    *idiomDuiNiu = [self getIdomAccordAnswer:@"对牛弹琴" inAarray:arrayAll];
            if (idiomDuiNiu)
            {
                idiomDuiNiu.type = JFIdiomTypeNormal;
                idiomDuiNiu.isAnswed = NO;
                idiomDuiNiu.isUnlocked = NO;
                idiomDuiNiu.idiomlevelString = [NSString stringWithFormat:@"%d",level];
                
                [JFSQLManger insertIdiomTotable:idiomDuiNiu type:JFIdiomTypeNormal];
                level++;
                [arrayInsertArray addObject:idiomDuiNiu];
                [arrayAll removeObject:idiomDuiNiu];
            }
            
            
            
            JFIdiomModel    *idiomManren = [self getIdomAccordAnswer:@"盲人摸象" inAarray:arrayAll];
            if (idiomManren)
            {
                idiomManren.type = JFIdiomTypeNormal;
                idiomManren.isAnswed = NO;
                idiomManren.isUnlocked = NO;
                idiomManren.idiomlevelString = [NSString stringWithFormat:@"%d",level];
                
                [JFSQLManger insertIdiomTotable:idiomManren type:JFIdiomTypeNormal];
                level++;
                [arrayInsertArray addObject:idiomManren];
                [arrayAll removeObject:idiomManren];
            }
            
            
        }
        
      
        
        maxcount -= 3;
        if ([arrayAll count] < 3)
        {
            DLOG(@"it is a joke");
            m_bIsWritingDB = NO;
            return;
        }
        int allCount = arrayAll.count;
        
        while (maxcount > 0 && [arrayAll count] > 0)
        {
            // 、、time(NULL);
            srandom(time(NULL)+[arrayAll count]);
            int  index = random()%[arrayAll count];
            
            
            BOOL  bget = NO;
            while (!bget)
            {
                JFIdiomModel *ididomModel = [arrayAll objectAtIndex:index];
                if (![self checkHasSameModel:ididomModel inarray:arrayInsertArray])
                {
                    
                    ididomModel.type = JFIdiomTypeNormal;
                    ididomModel.isAnswed = NO;
                    ididomModel.isUnlocked = NO;
                    ididomModel.idiomlevelString = [NSString stringWithFormat:@"%d",level];
                    [JFSQLManger insertIdiomTotable:ididomModel type:JFIdiomTypeNormal];
                    [arrayInsertArray addObject:ididomModel];
                    [arrayAll removeObject:ididomModel];
                    maxcount--;
                    level++;
                    bget = YES;
                    
                    if (m_bIsMovePath)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^
                                       {
                                           [self setProgress:level*1.0/(allCount*1.0)];
                                       });
                        
                    }
                }else
                {
                    index = (index+1)%[arrayAll count];
                }
            }
            
            
        }
        
    }
    m_bIsMovePath = NO;
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       [self removeProgressView];
                       [self addOtherbtns];
                   });
    m_bIsWritingDB = NO;
    
}


#pragma mark  JfchargeNetdelegate
-(void)getServerRemainChargeFail:(int)status
{
    
}
-(void)getServerRemainChargeSuc:(int)goldNum isFirstCharge:(BOOL)isfirstCharge;
{
    [JFLocalPlayer addgoldNumber:goldNum];
    [JFPlayAniManger addGoldWithAni:goldNum];
    [[JFLocalPlayer shareInstance] setIsPayedUser:YES];
    [JFSQLManger UpdateUserInfoToDB:[JFLocalPlayer shareInstance]];
    
    DLOG(@"getServerRemainChargeSuc:%d",goldNum);
}


@end
