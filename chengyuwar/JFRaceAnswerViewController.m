//
//  JFNormalAnswerViewController.m
//  chengyuwar
//
//  Created by ran on 13-12-17.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFRaceAnswerViewController.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"
#import "JFLocalPlayer.h"
#import "JFChargeView.h"
#import "JFRankManger.h"
#import "JFSQLManger.h"
#import "JFMedalModel.h"
#import "JFMedalRewardView.h"



#define SHOWANSWERINDEBUG       0
@interface JFRaceAnswerViewController ()

@end

@implementation JFRaceAnswerViewController
@synthesize idiomModel;
@synthesize firstButton;
@synthesize secondButton;
@synthesize currentuserID;
@synthesize currentWinUserID;

-(id)initWithWithIdiomModel:(JFIdiomModel*)model
{
    self = [super init];
    if (self)
    {
        
        m_raceManger = [[JFRaceManger alloc] init];
        m_raceManger.delegate = self;

        self.idiomModel = model;
        m_itotalLevels = 0;
        m_bIsFirstLoad = YES;
        [[JFLocalPlayer shareInstance] addObserver:self forKeyPath:@"goldNumber" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:NULL];
        m_bIsRacing = NO;
        
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self refreshSelfView:nil];
    
    if ([[JFLocalPlayer shareInstance] goldNumber] <= 0)
    {
        [self addGoldWithAni];
    }
    
}

-(void)addGoldWithAni
{
    
    NSDictionary   *dicInfo = [[NSUserDefaults standardUserDefaults] valueForKey:@"storeFreeGoldCount"];
    if (dicInfo)
    {
        int count = [[dicInfo valueForKey:@"count"] intValue];
        if (count >= 3)
        {
            return;
        }
    }
    
    if (m_freeGiftView.superview)
    {
        return;
    }else if (m_freeGiftView)
    {
        [m_freeGiftView release];
        m_freeGiftView = nil;
    }
    m_freeGiftView = [[JFFreeGiftView alloc] initWithFrame:CGRectZero];
    m_freeGiftView.delegate = self;
    [m_freeGiftView show];
    
}



-(void)setUserCanTouch:(BOOL)bCan
{
    self.firstButton.userInteractionEnabled = bCan;
    self.secondButton.userInteractionEnabled = bCan;
    m_idiomView.userInteractionEnabled = bCan;
    m_goldView.userInteractionEnabled = bCan;
}



-(void)dealloc
{
    [[JFLocalPlayer shareInstance] removeObserver:self forKeyPath:@"goldNumber"];
    self.idiomModel = nil;
    self.firstButton = nil;
    self.secondButton = nil;
    self.currentuserID = nil;
    self.currentWinUserID = nil;
    [DownloadHttpFile CleanDelegateOfObject:self];
    
    [m_idiomView stopTimer:nil];
    [m_idiomView release];
    m_idiomView = nil;
    [m_levelView release];
    m_levelView = nil;
    [m_goldView release];
    m_goldView = nil;
    [m_leftView release];
    m_leftView = nil;
    [m_rightView release];
    m_rightView = nil;
    [m_raceManger release];
    m_raceManger = nil;
    [m_aniManger stopAni];
    [m_aniManger release];
    m_aniManger = nil;
    


    if (m_playbgManger)
    {
        [m_playbgManger stopPlay];
        [m_playbgManger release];
        m_playbgManger = nil;
    }
    

    [super dealloc];
}
-(void)loadView
{
    [super loadView];
    
    [self initview];
    
  // [m_idiomView startAnswer:30];
    
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!m_playbgManger)
    {
        m_playbgManger = [[JFAudioPlayerManger alloc] initWithType:JFAudioPlayerMangerTypeChangeBg];
    }
    
   // [m_playbgManger playWithLoops:YES];
    
    if (m_bIsFirstLoad)
    {
        [m_raceManger startGame];
        m_bIsFirstLoad = NO;
    }
    [self setUserCanTouch:NO];
//    [self addYouMiadView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [m_playbgManger pausePlay];
}

-(void)initview
{
    CGSize  size = [[UIScreen mainScreen] bounds].size;
    CGRect  frame = CGRectMake(0, 0, size.height, size.width);
    
    if (iPhone5)
    {
        self.view.layer.contents = (id)[UIImage imageNamed:@"main_bg_withnothing_iphone5.png"].CGImage;
        //main_bg_withnothing
    }else
    {
        self.view.layer.contents = (id)[UIImage imageNamed:@"main_bg_withnothing.png"].CGImage;
    }

    
    
    
    UIImageView  *bgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-472)/2, 25, 472, 291)];
    bgView.image = [PublicClass getImageAccordName:@"check_scrollerbg.png"];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    //UIButton      *btnback = [[UIButton alloc] initWithFrame:CGRectMake(25, 5, 27, 22)];
    UIButton      *btnback = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 27+40, 22+4)];
    [btnback setImageEdgeInsets:UIEdgeInsetsMake(2, 20, 2, 20)];
    [btnback setImage:[PublicClass getImageAccordName:@"about_back.png"] forState:UIControlStateNormal];
    [btnback addTarget:self action:@selector(clickBackbtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnback];
    
    
    
    UIImageView  *levelViewbg = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-76)/2, 5, 76, 25)];
    levelViewbg.image = [PublicClass getImageAccordName:@"answer_level_bg.png"];
    levelViewbg.tag = 456321;
    [self.view addSubview:levelViewbg];
    
    if (!m_levelView)
    {
        m_levelView = [[UtilitiesFunction getImagewithNumber:m_itotalLevels type:JFPicNumberTypeLevelNumber] retain];
        [m_levelView setFrame:CGRectMake((levelViewbg.frame.size.width-m_levelView.frame.size.width)/2, (levelViewbg.frame.size.height-m_levelView.frame.size.height)/2, m_levelView.frame.size.width, m_levelView.frame.size.height)];
        [levelViewbg addSubview:m_levelView];
    }
    
    
    
    
    
    UIImageView     *imagegoldbg = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-115, 5, 87, 23)];
    imagegoldbg.image = [PublicClass getImageAccordName:@"check_goldnumber_bg.png"];
    imagegoldbg.userInteractionEnabled = YES;
    [self.view addSubview:imagegoldbg];
    imagegoldbg.tag = 123456;
    
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAddGold:)];
    [imagegoldbg addGestureRecognizer:tap];
    [tap release];
    
    
    UIButton      *btnaddgold = [[UIButton alloc] initWithFrame:CGRectMake(imagegoldbg.frame.size.width-22, (imagegoldbg.frame.size.height-20)/2, 20, 20)];
    [btnaddgold setBackgroundImage:[PublicClass getImageAccordName:@"check_add.png"] forState:UIControlStateNormal];
    [btnaddgold setBackgroundImage:[PublicClass getImageAccordName:@"check_add_pressed.png"] forState:UIControlStateHighlighted];
    [btnaddgold addTarget:self action:@selector(clickAddGold:) forControlEvents:UIControlEventTouchUpInside];
    [imagegoldbg addSubview:btnaddgold];
    
    
    m_goldView = [[UtilitiesFunction getImagewithNumber:[[JFLocalPlayer shareInstance] goldNumber] type:JFPicNumberTypeGoldNumber] retain];
    [m_goldView setFrame:CGRectMake(5, (imagegoldbg.frame.size.height-m_goldView.frame.size.height)/2, m_goldView.frame.size.width, m_goldView.frame.size.height)];
    [imagegoldbg addSubview:m_goldView];
    
    
    
    UIImageView  *goldIcon = [[UIImageView alloc] initWithFrame:CGRectMake((imagegoldbg.frame.origin.x-35), 10, 28, 15)];
    goldIcon.image = [PublicClass getImageAccordName:@"check_gold_icon.png"];
    [self.view addSubview:goldIcon];
    
    
    [self addAnswerInSuperview:bgView];
    [self addPropButton:bgView];
    
    
    [bgView release];
    [goldIcon release];
    [btnaddgold release];
    [imagegoldbg release];
    [btnback release];
    [levelViewbg release];
    
}//622150713100066826




-(void)addPropButton:(UIView*)bgView
{
    CGFloat    fXpoint = 50;
    CGFloat    fYpoint = 120;
    JFPropModel  *modelTrash = [[JFPropModel alloc] initWithPropType:JFPropModelTypeTrash isRaceMode:YES];
    JFPropButton  *btnTrash = [[JFPropButton alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, 40, 40) withModel:modelTrash];
    btnTrash.delegate =  self;
    self.firstButton = btnTrash;
    [bgView addSubview:btnTrash];
    [modelTrash release];
    [btnTrash release];
    
    fXpoint += 40+10;
    JFPropModel  *modelidea = [[JFPropModel alloc] initWithPropType:JFPropModelTypeIdeaShow isRaceMode:YES];
    JFPropButton  *btnIdea = [[JFPropButton alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, 40, 40) withModel:modelidea];
    btnIdea.delegate =  self;
    self.secondButton = btnIdea;
    [bgView addSubview:btnIdea];
    [modelidea release];
    [btnIdea release];
    
    
    fXpoint = 35;
    fYpoint = 30;
    
    
    m_leftView = [[JFPlayerChangeView alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, 110, 90) Player:[JFLocalPlayer shareInstance] locationType:JFPlayerChangeViewNameLocationTypeLeft];
    [bgView addSubview:m_leftView];
    
    
    fXpoint +=  285;
    
    
    m_rightView = [[JFPlayerChangeView alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, 110, 90) Player:nil locationType:JFPlayerChangeViewNameLocationTypeRight];
    [bgView addSubview:m_rightView];
    
    [self updatePropAccrodRoletype];
    [self resetPropButtonGrayInfo];
    
}


-(void)setPropGrayInfo
{
  
    
   
    
    
    int goldNumber = [[JFLocalPlayer shareInstance] goldNumber];
    if (goldNumber < self.firstButton.propModel.propPrice || self.firstButton.propModel.remainCount < 1)
    {
        [self.firstButton setGoldIconGray:YES];
    }else
    {
        [self.firstButton setGoldIconGray:NO];
    }
    
    if (goldNumber < self.secondButton.propModel.propPrice || self.secondButton.propModel.remainCount < 1)
    {
        [self.secondButton setGoldIconGray:YES];
    }else
    {
        [self.secondButton setGoldIconGray:NO];
    }
    
    
    /*
    if (self.firstButton.propModel.remainCount < 1)
    {
        [self.firstButton setGoldIconGray:YES];
    }else
    {
        [self.firstButton setGoldIconGray:NO];
    }
    
    if (self.secondButton.propModel.remainCount < 1)
    {
        [self.secondButton setGoldIconGray:YES];
    }else
    {
        [self.secondButton setGoldIconGray:NO];
    }*/
    
}

-(void)resetPropButtonGrayInfo
{
    self.firstButton.propModel.remainCount = self.firstButton.propModel.useCount;
    self.secondButton.propModel.remainCount = self.secondButton.propModel.useCount;
    
    [self setPropGrayInfo];
}
-(void)updatePropAccrodRoletype
{
    JFRoleModelType type = [[[JFLocalPlayer shareInstance] roleModel] roleType];
    JFPropModelType firstType = JFPropModelTypeTrash;
    JFPropModelType secondType = JFPropModelTypeTimeMachine;
    switch (type)
    {
        case JFRoleModelTypebaijingjing:
            firstType = JFPropModelTypeTrash;
            secondType = JFPropModelTypeTimeMachine;
            break;
        case JFRoleModelTypezhuyuanshuai:
            firstType = JFPropModelTypeTrash;
            secondType = JFPropModelTypeTimeMachine;
            break;
        case JFRoleModelTypetangxiaozang:
            firstType = JFPropModelTypeIdeaShow;
            secondType = JFPropModelTypeExchangeUser;
            break;
        case JFRoleModelTypesundashen:
            firstType = JFPropModelTypeIdeaShow;
            secondType = JFPropModelTypeAvoidAnswer;
            break;
        case JFRoleModelTypeshaheshang:
            firstType = JFPropModelTypeTrash;
            secondType = JFPropModelTypeTimeMachine;
            break;
        default:
            break;
    }
    
    JFPropModel  *modelfirst = [[JFPropModel alloc] initWithPropType:firstType isRaceMode:YES];
    JFPropModel  *second = [[JFPropModel alloc] initWithPropType:secondType isRaceMode:YES];
    [self.firstButton updatePropBtn:modelfirst];
    [self.secondButton updatePropBtn:second];
    [modelfirst release];
    [second release];
}

-(void)addAnswerInSuperview:(UIView*)bgView
{
    
    if (!m_idiomView)
    {
        m_idiomView = [[JFIdiomDetailView alloc] initWithFrame:bgView.bounds withModel:self.idiomModel];
        m_idiomView.delegate = self;
        [m_idiomView setViewType:JFIdiomDetailViewTypeRace];
        [bgView addSubview:m_idiomView];
    }
    
}


-(void)clickAddGold:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    JFChargeView  *chargeView = [[JFChargeView alloc] initWithFrame:CGRectZero];
    [chargeView show];
    [chargeView release];
    DLOG(@"clickAddGold:%@",sender);
}

-(void)clickBackbtn:(id)sender
{
    
   
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (m_bIsRacing)
    {
        JFAlertView *alert = [[JFAlertView alloc] initWithTitle:@"提示" message:@"正在挑战中，离开将挑战失败，是否离开？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"离开"];
        alert.tag = 100;
        [alert show];
        [alert release];
        
    }else
    {
        [m_aniManger stopAni];
        [JFRaceAnswerViewController cancelPreviousPerformRequestsWithTarget:self];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
    
    if ([self isViewLoaded] && self.view.window == nil) {
        
        self.view = nil;
        
        [m_goldView release];
        m_goldView = nil;
        
        [m_leftView release];
        m_leftView = nil;
        
        [m_rightView release];
        m_rightView = nil;
    }
}

- (void)viewDidUnload
{
    [m_goldView release];
    m_goldView = nil;
    
    [m_leftView release];
    m_leftView = nil;
    
    [m_rightView release];
    m_rightView = nil;
    
    [super viewDidUnload];
}

-(void)clickPropButton:(JFPropModel*)model button:(JFPropButton *)btnProp
{

    if (model.modelType == JFPropModelTypeShareForHelp)
    {
        
    }else
    {
        if (model.propPrice > [[JFLocalPlayer shareInstance] goldNumber])
        {
            JFAlertView  *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"金币不足，无法使用。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
            [av show];
            [av release];
        }else
        {
            if (model.remainCount <= 0 )
            {
                 [btnProp setGoldIconGray:YES];
                return;
            }
            
            switch (model.modelType)
            {
                case JFPropModelTypeAvoidAnswer:
                    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeAvoidAnswer];
                    break;
                case JFPropModelTypeIdeaShow:
                    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeIdeaShow];
                    break;
                case JFPropModelTypeTrash:
                    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeTrash];
                    break;
                case JFPropModelTypeExchangeUser:
                    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeExchangeUser];
                    break;
                case JFPropModelTypeTimeMachine:
                    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeTimemachine];
                    break;
                default:
                    break;
            }
            
            model.remainCount--;
            [JFLocalPlayer deletegoldNumber:model.propPrice];
            [JFPlayAniManger deleteGoldWithAni:model.propPrice];
            [self setPropGrayInfo];
            
            if (model.remainCount <= 0)
            {
                [btnProp setGoldIconGray:YES];
            }
            
          
            
            [m_raceManger sendUseProp:model.modelType];
            [m_idiomView usePropWithType:model.modelType];
            
            
        }
    }
    DLOG(@"clickPropButton:%@",model);
}


-(void)JFAlertClickView:(JFAlertView *)alertView index:(JFAlertViewClickIndex)buttonIndex
{
    if (buttonIndex == JFAlertViewClickIndexRight)
    {
        if (alertView.tag == 2000)
        {
            JFChargeView  *chargeView = [[JFChargeView alloc] initWithFrame:CGRectZero];
            [chargeView show];
            [chargeView release];
        }else if (alertView.tag == 100)
        {
            [m_raceManger sendPlayResult:eIDWPR_Quit];
            [m_idiomView stopTimer:nil];
            
            [JFRaceAnswerViewController cancelPreviousPerformRequestsWithTarget:self];
           // [m_raceManger resetWarProtrol];
           // [self.navigationController popViewControllerAnimated:YES];
        }else if(alertView.tag == 1100 || alertView.tag == 1200)
        {
            [self removeChangeView];
             [m_idiomView stopTimer:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else if (alertView.tag == 4000)
        {
            JFAlertUpdateView  *av = [[JFAlertUpdateView alloc] initWithFrame:CGRectZero];
            av.delegate = self;
            [av setProgress:0];
            [av show];
            
            NSMutableArray  *arrZip = [JFPhaseXmlData phaseUrlInfoAccordPath:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME] xmlType:JFPhaseXmlDataTypeNormalXml rootPath:nil];
            [av loadDownZipArray:arrZip];
            
            [av release];
            
        }else if (alertView.tag == 3000)
        {
            NSString *url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%d",785258787];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
    }else
    {
        if (alertView.tag == 4000)
        {
            [self removeAlertView];
            [m_idiomView stopTimer:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
    }
}


-(void)startBeginAni
{
    if (!m_aniManger)
    {
        m_aniManger = [[JFPlayRaceManger alloc] init];
        m_aniManger.delegate = self;
    }
    [m_aniManger playReadyAni];
    
}

-(void)playAniFinish:(id)Thread
{
    [self startPlayWithUserID:self.currentuserID];
}

#pragma mark
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
    
    
    //return UIInterfaceOrientationMaskLandscape;
    
    //  DLOG(@"supportedInterfaceOrientations :%d",UIInterfaceOrientationMaskLandscape);
    return  UIInterfaceOrientationMaskLandscape;
}






-(void)refreshSelfView:(id)Thread
{
    
    UIView   *superlevelview = [self.view viewWithTag:456321];
    if (m_levelView)
    {
        [m_levelView removeFromSuperview];
        [m_levelView release];
        m_levelView = nil;
    }
    
    
    m_levelView = [[UtilitiesFunction getImagewithNumber:m_itotalLevels type:JFPicNumberTypeLevelNumber] retain];
    [m_levelView setFrame:CGRectMake((superlevelview.frame.size.width-m_levelView.frame.size.width)/2, (superlevelview.frame.size.height-m_levelView.frame.size.height)/2, m_levelView.frame.size.width, m_levelView.frame.size.height)];
    [superlevelview addSubview:m_levelView];
    
    
    
    UIView   *supergoldview = [self.view viewWithTag:123456];
    if (m_goldView)
    {
        [m_goldView removeFromSuperview];
        [m_goldView release];
        m_goldView = nil;
    }
    
    
    m_goldView = [[UtilitiesFunction getImagewithNumber:[[JFLocalPlayer shareInstance] goldNumber] type:JFPicNumberTypeGoldNumber] retain];
    [m_goldView setFrame:CGRectMake(5, (supergoldview.frame.size.height-m_goldView.frame.size.height)/2, m_goldView.frame.size.width, m_goldView.frame.size.height)];
    [supergoldview addSubview:m_goldView];
    
    
    
    
}





#pragma mark JFIdiomDetailViewDelegate
-(void)answerIdiomSuc:(JFIdiomModel*)model isUsedAvoidprop:(BOOL)isUsed isTimeOut:(BOOL)isTimeOut
{
    if (isUsed)
    {
        return;
    }
    [m_raceManger sendPlayResult:eIDWPR_CorrectAnswer];
    DLOG(@"answerIdiomSuc:%@",model);
}


-(void)answerIdiomOverTime:(JFIdiomModel *)model
{
    if (!m_bIsRacing)
    {
        return;
    }
   
    JFLocalPlayer *player = [JFLocalPlayer shareInstance];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BNRGetUserInfo" object:nil];
    
    if ([self.currentuserID isEqualToString:player.userID])
    {
        m_bIsRacing = NO;
        [m_raceManger sendPlayResult:eIDWPR_TimeOut];
        [self localUserFail];
        DLOG(@"++++++++++++answerIdiomOverTime:%@",model.idiomAnswer);
    }
    
}



-(void)showChangeView:(id)thread
{
 
    [self removeChangeView];
    JFChangeView  *m_changeView = [[JFChangeView alloc] initWithRoleType:[[[JFLocalPlayer shareInstance] roleModel] roleType]];
    [m_changeView show];
    [m_changeView release];
    
}

-(void)removeChangeView
{
    UIWindow    *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    for (JFChangeView *view in window.subviews)
    {
        if ([view isKindOfClass:[JFChangeView class]])
        {
            [view removeFromSuperview];
        }
    }
    
}

#pragma mark  JFAnswerResultDelegate
-(void)continueChange:(id)sender
{
    
    [m_raceManger resetWarProtrol];
    [m_idiomView updateViewAccordModel:nil];
    [m_leftView setAnswerStatus:JFPlayerChangeViewAnswerStatusNormal];
    [m_rightView setAnswerStatus:JFPlayerChangeViewAnswerStatusNormal];
    [m_idiomView removeCoverView:nil];

    if ([[JFLocalPlayer shareInstance] goldNumber] < 50)
    {
        JFAlertView  *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"挑战需要花费50金币，金币不足，是否需要购买金币？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"购买"];
        av.tag = 2000;
        [av show];
        [av release];
    }else
    {
        DLOG(@"continueChange startGame m_bIsRacing:%d",m_bIsRacing);
        [m_raceManger resetWarProtrol];
        m_bIsRacing = NO;
        [self showChangeView:nil];
        [m_raceManger startGame];
       
    }
}
-(void)clickMyRank:(id)sender
{
    [m_idiomView updateViewAccordModel:nil];
    [m_leftView setAnswerStatus:JFPlayerChangeViewAnswerStatusNormal];
    [m_rightView setAnswerStatus:JFPlayerChangeViewAnswerStatusNormal];
    [m_idiomView removeCoverView:nil];

}

-(void)clickRaceResultBackBtn:(id)sender
{
    [JFRaceAnswerViewController cancelPreviousPerformRequestsWithTarget:self];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark JFRaceMangerdelegate
-(void)getJoinGameResult:(NSDictionary*)dicInfo
{
    
   
    eSDStatus  status = [[dicInfo valueForKey:@"result"] intValue];
    if (status == eSDS_Ok)
    {
        m_itotalLevels = 0;
        m_imytotalLevels = 0;
        m_bIsRacing = YES;
        DLOG(@"getJoinGameResult suc:%d",[[dicInfo valueForKey:@"reconnect"] intValue]);
    }else
    {
        
        if (status == eSDS_QuestionVersionTooLowError)
        {
            
            NSString    *strUrl = [dicInfo valueForKey:@"xml_link"];
            
            if (!strUrl || [strUrl length] < 10)
            {
                strUrl = [[JFLocalPlayer shareInstance] lanchModel].question_db_xml_url;
            }
            DownloadHttpInfo  *object = [[DownloadHttpInfo alloc] initWithDelegate:self fileUrl:strUrl fileName:DOWNXMLFILENAME downType:DownloadHttpFileDownTypeNormalXml];
            [DownloadHttpFile addDownFileObjects:object];
            [object release];
            
        }else if(status == eSDS_NoSessionError)
        {
            
            if (m_bIsRacing)
            {
                
                
                DLOG(@"getJoinGameResult FAIL WHILE m_bIsRacing = %d self.currentuserID:%@",m_bIsRacing,self.currentuserID);
                m_bIsRacing = NO;
                [self removeAlertView];
                
                if ([self.currentuserID isEqualToString:[[JFLocalPlayer shareInstance] userID]])
                {
                    [self localUserFail];
                }else
                {
                    
                    [self localUserwin];
                }
            }
            
           
         
        }else
        {
            
            [self removeChangeView];
            JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"数据发生错误，请重新开始游戏！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定"];
            av.tag = 1200;
            [av show];
            [av release];

        }
        
        DLOG(@"getJoinGameResult fail:%@",dicInfo);
    }
    
}

-(void)giveAGoodpraise
{
 
    if ([[JFLocalPlayer shareInstance] winNumber]+[[JFLocalPlayer shareInstance] loseNumber] != 3)
    {
        return;
    }
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"请赐一个5星评价吧，大人！" delegate:self cancelButtonTitle:@"残忍拒绝" otherButtonTitles:@"赐个5星"];
    av.tag = 3000;
    [av show];
    [av release];
}


-(void)showSucView
{
    [self removeAlertView];
    JFAnswerSucView *sucView = [[JFAnswerSucView alloc] initwithPlayer:[JFLocalPlayer shareInstance] goldValue:80 answerNumber:m_imytotalLevels];
    [sucView show];
    sucView.delegate = self;
    [sucView release];
    
    [JFLocalPlayer addgoldNumber:80];
    [JFPlayAniManger addGoldWithAni:80];
    
    [m_rightView setAnswerStatus:JFPlayerChangeViewAnswerStatusAnswerfail];
    [m_leftView setAnswerStatus:JFPlayerChangeViewAnswerStatusNormal];
    
    
    
    [JFMedalRewardView showMedalViewwithType:JFMedalModelGetTypeRaceMode];
    //[self checkHasMedal];
    
}
-(void)showFailView
{
    
    [self removeAlertView];
    JFAnswerFailView   *failView = [[JFAnswerFailView alloc] initwithPlayer:[JFLocalPlayer shareInstance] goldValue:0];
    failView.delegate = self;
    [failView show];
    [failView release];
    

    [m_rightView setAnswerStatus:JFPlayerChangeViewAnswerStatusNormal];
    
   // [self checkHasMedal];
    [self giveAGoodpraise];
    
    
    
}

-(void)removeAlertView
{
    UIWindow    *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    for (JFAlertView *view in window.subviews)
    {
        if ([view isKindOfClass:[JFAlertView class]])
        {
            [view dismiss];
            continue;
        }
        
        if ([view isKindOfClass:[JFAnswerFailView class]])
        {
            [view removeFromSuperview];
            continue;
        }
        if ([view isKindOfClass:[JFAnswerSucView class]])
        {
            [view removeFromSuperview];
            continue;
        }
        if ([view isKindOfClass:[JFChangeView class]])
        {
            [view removeFromSuperview];
            continue;
        }
        if ([view isKindOfClass:[JFChargeView class]])
        {
            [view removeFromSuperview];
            continue;
        }
        if ([view isKindOfClass:[JFExchangeView class]])
        {
            [view removeFromSuperview];
            continue;
        }
    }
    
}
-(void)PlayResult:(NSDictionary*)dicInfo
{
    
    
    if (!m_bIsRacing)
    {
        DLOG(@"PlayResult fail");
        return;
    }
    m_bIsRacing = NO;
    [m_idiomView stopTimer:nil];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"BNRGetUserInfo" object:nil];
    NSString  *userID = [NSString stringWithFormat:@"%@",[dicInfo valueForKey:@"winner"]];
    self.currentWinUserID = userID;
    //   int  reasonCode = [[dicInfo valueForKey:@"reason"] intValue];
    JFLocalPlayer  *player = [JFLocalPlayer shareInstance];
    if ([userID isEqualToString:[player userID]] || [userID isEqualToString:@"0"])
    {
        
        [self localUserwin];
        //[self performSelector:@selector(showSucView) withObject:nil afterDelay:1.6];
    }else
    {
        [self localUserFail];
      
    }
}


-(void)localUserFail
{
    DLOG(@"localUserFail");
    JFLocalPlayer  *player = [JFLocalPlayer shareInstance];
    player.loseNumber++;
    [m_idiomView stopTimer:nil];
    self.currentWinUserID = m_rightView.player.userID;
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeChangeFail];
    [m_aniManger playFailAni:3.0];
    [m_rightView setAnswerStatus:JFPlayerChangeViewAnswerStatusNormal];
    [m_leftView setAnswerStatus:JFPlayerChangeViewAnswerStatusAnswerfail];
    [self performSelector:@selector(showFailView) withObject:nil afterDelay:3.1];

    
}

-(void)localUserwin
{
    
    m_fOldtimer = [[NSDate date] timeIntervalSince1970];
    DLOG(@"localUserwin");
    [m_idiomView stopTimer:nil];
    JFLocalPlayer  *player = [JFLocalPlayer shareInstance];
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeChangeSuc];
    [m_aniManger playSucAni:3.0];
    [m_rightView setAnswerStatus:JFPlayerChangeViewAnswerStatusAnswerfail];
    [m_leftView setAnswerStatus:JFPlayerChangeViewAnswerStatusNormal];
    [m_raceManger requestPersonalInfo:[player userID]];
    
}

-(void)startPlayWithUserID:(NSString*)userID
{
    
    if (self.idiomModel)
    {
        [m_idiomView updateViewAccordModel:self.idiomModel];
    }
    
#if DEBUG
#if SHOWANSWERINDEBUG
    iToast  *toast = [[iToast alloc] initWithText:self.idiomModel.idiomAnswer];
    [toast show];
    [toast release];
#endif
#endif
    if ([userID isEqualToString:[[JFLocalPlayer shareInstance] userID]])
    {
        [self setUserCanTouch:YES];
        [m_idiomView removeCoverView:nil];
        [m_leftView setAnswerStatus:JFPlayerChangeViewAnswerStatusAnswering];
        [m_rightView setAnswerStatus:JFPlayerChangeViewAnswerStatusNormal];
        m_imytotalLevels++;
    }else
    {
        [self setUserCanTouch:NO];
        [m_idiomView addCoverView:nil];
        [m_rightView setAnswerStatus:JFPlayerChangeViewAnswerStatusAnswering];
        [m_leftView setAnswerStatus:JFPlayerChangeViewAnswerStatusNormal];
    }
    m_itotalLevels++;
    [self refreshSelfView:nil];
    self.currentuserID = userID;
    [m_idiomView startAnswer:30];
}


-(void)startPlaySelector:(NSDictionary *)dicInfo
{
    
    
    int roleType = [[dicInfo valueForKey:@"opponent_role"] intValue];
    [self removeChangeView];
    
    
    [JFLocalPlayer deletegoldNumber:50];
    [self refreshSelfView:nil];
    
    
    JFLocalPlayer  *player = [[JFLocalPlayer alloc] init];
    player.userID = [[dicInfo valueForKey:@"opponent_id"] description];
    player.nickName = [dicInfo valueForKey:@"opponent_name"];
    int  winnumber = [[dicInfo valueForKey:@"opponent_win"] intValue];
    player.winNumber = winnumber;
    player.roleModel = [[[JFRoleModel alloc] initWithType:roleType] autorelease];
    m_rightView.player = player;
    [m_rightView updateViewAccordPlayInfo:player];
    [m_leftView updateViewAccordPlayInfo:[JFLocalPlayer shareInstance]];
    [player release];
    
    
    
    NSString    *userID = [[dicInfo valueForKey:@"player_id"] description];
    int packageindex = [[dicInfo valueForKey:@"package_id"] intValue];
    int secondIndex = [[dicInfo valueForKey:@"question_id"] intValue];
    JFIdiomModel   *model = [JFSQLManger getIdiomAccordPackage:packageindex secondeIndex:secondIndex];
    self.idiomModel = model;
    self.currentuserID = userID;
    
    [self startBeginAni];
    [self resetPropButtonGrayInfo];
    
    [m_playbgManger playWithLoops:YES];
}

-(void)startPlay:(NSDictionary*)dicInfo
{

    
    if ([[dicInfo valueForKey:@"reconnect"] intValue] == 1 && m_bIsRacing)
    {
        DLOG(@"[[dicInfo valueForKey:@\"reconnect\"] intValue] == 1 && m_bIsRacing");
        return;
    }
    
    int roleType = [[dicInfo valueForKey:@"opponent_role"] intValue];
    UIWindow    *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    for (JFChangeView *view in window.subviews)
    {
        if ([view isKindOfClass:[JFChangeView class]])
        {
            [view setRightRoleImage:roleType];
            break;
        }
    }
    NSString    *userID = [[dicInfo valueForKey:@"player_id"] description];
    self.currentuserID = userID;
    [self performSelector:@selector(startPlaySelector:) withObject:dicInfo afterDelay:0.5];
    

    
}
-(void)Play:(NSDictionary*)dicInfo
{
    
    if (!m_bIsRacing)
    {
        DLOG(@"Play fail");
        return;
    }
    int packageindex = [[dicInfo valueForKey:@"package_id"] intValue];
    int secondIndex = [[dicInfo valueForKey:@"question_id"] intValue];
     NSString    *userID = [[dicInfo valueForKey:@"player_id"] description];
    JFIdiomModel   *model = [JFSQLManger getIdiomAccordPackage:packageindex secondeIndex:secondIndex];
    self.idiomModel = model;
    [self startPlayWithUserID:userID];
    [self setPropGrayInfo];
}
-(void)usePropInfo:(NSDictionary*)dicInfo
{
    /*
    parser.getUInt32(player,              "player_id");
    parser.getUInt32(item,                "item");
    parser.getUInt32(pkg_id,              "package_id");
    parser.getUInt32(ques_id,             "question_id");*/
    if (!m_bIsRacing)
    {
        DLOG(@"usePropInfo fail");
        return;
    }
    
    NSString    *userID = [[dicInfo valueForKey:@"player_id"] description];
    JFPropModelType type = [[dicInfo valueForKey:@"item"] intValue];
    
    if (![userID isEqualToString:[[JFLocalPlayer shareInstance] userID]])
    {
        if (type == JFPropModelTypeAvoidAnswer || type == JFPropModelTypeExchangeUser)
        {
            int packageindex = [[dicInfo valueForKey:@"package_id"] intValue];
            int index = [[dicInfo valueForKey:@"question_id"] intValue];
            JFIdiomModel  *model = [JFSQLManger getIdiomAccordPackage:packageindex secondeIndex:index];
        
            if (model)
            {
                self.idiomModel =  model;
                [self startPlayWithUserID:[[JFLocalPlayer shareInstance] userID]];
                [self setPropGrayInfo];
            }else
            {
                DLOG(@"usePropInfo by query db fail");
            }
        }else if (type == JFPropModelTypeTimeMachine)
        {
            
            DLOG(@"userID:%@ user time machine",userID);
            [m_idiomView usePropWithType:type];
        }
        
    }else
    {
        if (type == JFPropModelTypeAvoidAnswer || type == JFPropModelTypeExchangeUser)
        {
            userID = m_rightView.player.userID;
            int packageindex = [[dicInfo valueForKey:@"package_id"] intValue];
            int index = [[dicInfo valueForKey:@"question_id"] intValue];
            JFIdiomModel  *model = [JFSQLManger getIdiomAccordPackage:packageindex secondeIndex:index];
            
            if (model)
            {
                self.idiomModel =  model;
                [self startPlayWithUserID:userID];
                [self setPropGrayInfo];
            }else
            {
                DLOG(@"usePropInfo by query db fail");
            }
        }
        DLOG(@"i use prop:%@",dicInfo);
    }
    
}

-(void)QuitSuc:(id)sender
{
    [m_raceManger resetWarProtrol];
    [m_aniManger stopAni];
    [JFRaceAnswerViewController cancelPreviousPerformRequestsWithTarget:self];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ReConnect:(NSDictionary*)dicInfo
{
    
    if (!m_bIsRacing)
    {
        DLOG(@"ReConnect fail");
        return;
    }
    NSString    *userID = [[dicInfo valueForKey:@"player_id"] description];
    int packageIndex = [[dicInfo valueForKey:@"package_id"] intValue];
    int index = [[dicInfo valueForKey:@"question_id"] intValue];
    int timeout = [[dicInfo valueForKey:@"timeout"] intValue];
    int nowtime = [[dicInfo valueForKey:@"now"] intValue];
    int  realtimeout = timeout-nowtime;
    
    JFIdiomModel   *model = [JFSQLManger getIdiomAccordPackage:packageIndex secondeIndex:index];
    
    if (realtimeout > 0)
    {
        
        self.idiomModel = model;
        if (!(self.idiomModel.packageIndex == packageIndex && self.idiomModel.index == index))
        {
            [self startPlayWithUserID:userID];
            [m_idiomView startAnswer:realtimeout];
        }else
        {
            [m_idiomView startAnswer:realtimeout];
        }
    }else
    {
        DLOG(@"ReConnect error:%@",dicInfo);
    }
    
    
    DLOG(@"++++++++++++++++++++++ReConnect++++++++++++++++++++++++++:\n%@",dicInfo);
    /*
     parser.getUInt32(curr_player,     "player_id");
     parser.getUInt32(pkg_id,          "package_id");
     parser.getUInt32(question_id,     "question_id");
     parser.getUInt32(now,             "now");
     parser.getUInt32(timeout,         "timeout");
     */
    
}
-(void)Relogin:(NSDictionary*)dicInfo
{
    
    JFAlertView *alertView = [[JFAlertView alloc] initWithTitle:@"提示" message:@"您的账号错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
    [alertView show];
    alertView.tag = 1200;
    [alertView release];
    [m_raceManger resetWarProtrol];
    
}


-(void)netOccouError:(id)Thread
{
   
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示"
                                                 message:@"无法连接网络。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
    av.tag = 1200;
    [av show];
    [av release];
    
}


-(void)getPersonInfostats:(eSDStatus)status dic:(NSDictionary*)dicInfo
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
        player.score = winNumber*3;
        player.weekMaxConWinCount = [[dicInfo valueForKey:@"week_max_keep_win_times"] intValue];
        player.weekConWinCount = [[dicInfo valueForKey:@"week_curr_keep_win_times"] intValue];
        
        [JFSQLManger UpdateUserInfoToDB:player];
    }
     NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
     NSTimeInterval afterTimer = 3.1-(nowTime-m_fOldtimer);
    if (afterTimer < 0)
    {
        afterTimer = 0;
    }
     [self performSelector:@selector(showSucView) withObject:nil afterDelay:afterTimer];
}

#pragma mark downloadhttpfiledelegate
-(void)downNormalXmlSuc:(DownloadHttpInfo*)object
{
    
    
    [self removeChangeView];
    CGFloat size = [JFPhaseXmlData phaseXmlZipSize:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME] xmlType:JFPhaseXmlDataTypeNormalXml];
    
    NSString  *strMsg = [NSString stringWithFormat:@"需更新题库,大小%0.1fM,现在更新?",size];
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:strMsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新"];
    av.tag = 4000;
    [av show];
    [av release];
}
-(void)downNormalXmlFail:(DownloadHttpInfo *)object
{
    
    [self removeChangeView];
    CGFloat size = [JFPhaseXmlData phaseXmlZipSize:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME] xmlType:JFPhaseXmlDataTypeNormalXml];
    
    
    if (size > 0)
    {
        NSString  *strMsg = [NSString stringWithFormat:@"需更新题库,大小%0.1fM,现在更新?",size];
        JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:strMsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新"];
        av.tag = 4000;
        [av show];
        [av release];
    }
 
    
}

#pragma mark 

-(void)sendGetRewardGold:(id)sender
{
    [JFLocalPlayer addgoldNumber:500];
    [JFPlayAniManger addGoldWithAni:500];
    
    NSDictionary   *dicInfo = [[NSUserDefaults standardUserDefaults] valueForKey:@"storeFreeGoldCount"];
    
    int count = 0;
    if (dicInfo)
    {
        count = [[dicInfo valueForKey:@"count"] intValue];
    }
    
    count++;
    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithObjectsAndKeys:@(count),@"count", nil] forKey:@"storeFreeGoldCount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self refreshSelfView:nil];
}

#pragma mark

-(void)downLoadUpdateInfoSuc:(id)thread
{
    [self showChangeView:nil];
    [m_raceManger startGame];
    NSLog(@"downLoadUpdateInfoSuc:%@",thread);
}
-(void)clickCancelUpdateAction:(id)sender
{

    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
