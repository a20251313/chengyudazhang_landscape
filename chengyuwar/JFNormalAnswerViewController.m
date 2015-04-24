//
//  JFNormalAnswerViewController.m
//  chengyuwar
//
//  Created by ran on 13-12-17.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFNormalAnswerViewController.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"
#import "JFLocalPlayer.h"
#import "JFChargeView.h"
#import "JFShareView.h"
#import "JFShareManger.h"
#import "JFCheckPointViewController.h"
#import "JFMedalModel.h"
#import "JFYouMIManger.h"
#import "JFMedalRewardView.h"
#import "JFSendAdInfo.h"


@interface JFNormalAnswerViewController ()

@end

@implementation JFNormalAnswerViewController
@synthesize idiomModel;
@synthesize avoidProp;
@synthesize trashProp;
@synthesize ideaShowProp;

-(id)initWithWithIdiomModel:(JFIdiomModel*)model arrayIdioms:(NSMutableArray*)array
{
    self = [super init];
    if (self)
    {
        
        
        m_arrayIdioms = [[NSMutableArray alloc] init];
        [m_arrayIdioms addObjectsFromArray:array];
        self.idiomModel = model;
        
        JFLocalPlayer   *player = [JFLocalPlayer shareInstance];
        [player addObserver:self forKeyPath:@"goldNumber" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
        
        extern  NSString    *const  BNRChargeSuc;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanFreeGoldInfo:) name:BNRChargeSuc object:nil];
        
    }
    return self;
}

-(void)WillEnterForeground:(NSNotification*)note
{
     [self cleanStoreData:nil];
}

-(void)WillResignActive:(NSNotification*)note
{
     [self storeCurrentState];
}

-(void)cleanFreeGoldInfo:(id)thread
{

    m_idiomView.userInteractionEnabled = YES;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self refreshSelfView:nil];
    if ([[JFLocalPlayer shareInstance] goldNumber] > 0)
    {
        [self cleanFreeGoldInfo:nil];
        [self setPropGrayAccordGoldNumber];
        [self setPropGrayAccordRemainCount];
    }else
    {
        [self addGoldWithAni];
    }
    
}


-(void)dealloc
{
    
    DLOG(@"JFNormalAnswerViewController dealloc");
    JFLocalPlayer   *player = [JFLocalPlayer shareInstance];
    [player removeObserver:self forKeyPath:@"goldNumber"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.idiomModel = nil;
    [m_idiomView stopTimer:nil];
    [m_idiomView release];
    m_idiomView = nil;
    [m_levelView release];
    m_levelView = nil;
    [m_goldView release];
    m_goldView = nil;
    if (m_freeGiftView)
    {
  
        [m_freeGiftView release];
        m_freeGiftView = nil;
    }
    self.avoidProp = nil;
    self.ideaShowProp = nil;
    self.trashProp = nil;
    
    [m_arrayIdioms release];
    m_arrayIdioms = nil;
    
    if (m_playerbgManger)
    {
        [m_playerbgManger stopPlay];
        [m_playerbgManger release];
        m_playerbgManger = nil;
    }
    [super dealloc];
}
-(void)loadView
{
    [super loadView];
    
    [self initview];
    
    [self initViewAccordStoreData];    
   // [m_idiomView startAnswer:30];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!m_playerbgManger)
    {
        m_playerbgManger = [[JFAudioPlayerManger alloc] initWithType:JFAudioPlayerMangerTypeNormalBg];
    }
    [m_playerbgManger playWithLoops:YES];
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [m_playerbgManger pausePlay];
}
-(void)initview
{
    CGSize  size = [[UIScreen mainScreen] bounds].size;
    CGRect  frame = CGRectMake(0, 0, size.width, size.height);
    [self.view setFrame:frame];
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

    UIButton      *btnback = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 27+40, 22+4)];
    [btnback setImageEdgeInsets:UIEdgeInsetsMake(2, 20, 2, 20)];
    [btnback setImage:[PublicClass getImageAccordName:@"about_back.png"] forState:UIControlStateNormal];
    [btnback addTarget:self action:@selector(clickBackbtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnback];
    
    
    
    UIImageView  *levelViewbg = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-76)/2, 5, 76, 25)];
    levelViewbg.image = [PublicClass getImageAccordName:@"answer_level_bg.png"];
    [self.view addSubview:levelViewbg];
    
    if (!m_levelView)
    {
        m_levelView = [[UtilitiesFunction getImagewithNumber:[self.idiomModel.idiomlevelString intValue] type:JFPicNumberTypeLevelNumber] retain];
        [m_levelView setFrame:CGRectMake((levelViewbg.frame.size.width-m_levelView.frame.size.width)/2, (levelViewbg.frame.size.height-m_levelView.frame.size.height)/2, m_levelView.frame.size.width, m_levelView.frame.size.height)];
        [levelViewbg addSubview:m_levelView];
    }
    
    
    
    
    
    UIImageView     *imagegoldbg = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-115, 5, 87, 23)];
    imagegoldbg.image = [PublicClass getImageAccordName:@"check_goldnumber_bg.png"];
    imagegoldbg.userInteractionEnabled = YES;
    [self.view addSubview:imagegoldbg];
    imagegoldbg.tag = 10001011;
    
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
    CGFloat    fYpoint = 50;
    JFPropModel  *modelTrash = [[JFPropModel alloc] initWithPropType:JFPropModelTypeTrash];
    JFPropButton  *btnTrash = [[JFPropButton alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, 40, 40) withModel:modelTrash];
     btnTrash.delegate =  self;
    [bgView addSubview:btnTrash];
    self.trashProp = btnTrash;
    [modelTrash release];
    [btnTrash release];
    
    fXpoint += 40+10;
    fYpoint +=  20;
    JFPropModel  *modelidea = [[JFPropModel alloc] initWithPropType:JFPropModelTypeIdeaShow];
    JFPropButton  *btnIdea = [[JFPropButton alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, 40, 40) withModel:modelidea];
    btnIdea.delegate =  self;
    self.ideaShowProp = btnIdea;
    [bgView addSubview:btnIdea];
    [modelidea release];
    [btnIdea release];
    
    
    
    fXpoint += 40+190;
   // fYpoint -=  20;
    JFPropModel  *modelavoid = [[JFPropModel alloc] initWithPropType:JFPropModelTypeAvoidAnswer];
    JFPropButton  *btnavoid = [[JFPropButton alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, 40, 40) withModel:modelavoid];
 //   [btnavoid setGoldIconGray:YES];
    btnavoid.delegate =  self;
    self.avoidProp = btnavoid;
    [bgView addSubview:btnavoid];
    [modelavoid release];
    [btnavoid release];
    
    
    fXpoint += 10+40;
    fYpoint -=  20;
    JFPropModel  *modelshare = [[JFPropModel alloc] initWithPropType:JFPropModelTypeShareForHelp];
    JFPropButton  *btnshare = [[JFPropButton alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, 40, 40) withModel:modelshare];
    btnshare.delegate =  self;
    [bgView addSubview:btnshare];
    [modelshare release];
    [btnshare release];
    
}


-(void)addYouMiadView
{
    
    if ([[JFLocalPlayer shareInstance] isPayedUser])
    {
        return;
    }
    
    ad_exhibition_type  type = [[JFAppSet shareInstance] exhibitiontype];
    if (type == 0)
    {
        return;
    }
    
    if (type == ad_exhibition_typeYouMi)
    {
    //    [JFYouMIManger addYouMiadView:self.view frame:CGRectMake((self.view.frame.size.width-320)/2, 0, 320, 25)];
        [JFSendAdInfo sendShowAD:[[JFLocalPlayer shareInstance] userID] adType:ad_exhibition_typeYouMi];
    }else if(type == ad_exhibition_typeLiMei)
    {
        /*
        if (!m_bannerView)
        {
            m_bannerView = [[immobView alloc] initWithAdUnitID:LIMEIADBANNERUNITID];
            m_bannerView.delegate = self;
            [m_bannerView immobViewRequest];
        }
        [JFSendAdInfo sendShowAD:[[JFLocalPlayer shareInstance] userID] adType:ad_exhibition_typeLiMei];*/
    }
   
    
}
-(void)removeYouMiView
{
   // [JFYouMIManger removeYouMiView];
  //  [m_bannerView removeFromSuperview];
}


-(void)addAnswerInSuperview:(UIView*)bgView
{
    
    if (!m_idiomView)
    {
        m_idiomView = [[JFIdiomDetailView alloc] initWithFrame:bgView.bounds withModel:self.idiomModel];
        m_idiomView.delegate = self;
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
    [self storeCurrentState];
    [self backToCheckPointControlNeedShowMaxOffset:NO];
    
    //[self.navigationController popViewControllerAnimated:YES];
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
    }
}

- (void)viewDidUnload
{
    [m_goldView release];
    m_goldView = nil;
    
    [super viewDidUnload];
}

-(void)resetPropRemainCount
{
    self.avoidProp.propModel.remainCount = self.avoidProp.propModel.useCount;
    self.trashProp.propModel.remainCount = self.trashProp.propModel.useCount;
    self.ideaShowProp.propModel.remainCount = self.ideaShowProp.propModel.useCount;
    
   
}

-(void)setPropGrayAccordGoldNumber
{
    if (self.avoidProp.propModel.propPrice <= [[JFLocalPlayer shareInstance] goldNumber])
    {
        [self.avoidProp setGoldIconGray:NO];
    }else
    {
        [self.avoidProp setGoldIconGray:YES];
    }
    
    if (self.trashProp.propModel.propPrice <= [[JFLocalPlayer shareInstance] goldNumber])
    {
        [self.trashProp setGoldIconGray:NO];
    }else
    {
        [self.trashProp setGoldIconGray:YES];
    }
    if (self.ideaShowProp.propModel.propPrice <= [[JFLocalPlayer shareInstance] goldNumber])
    {
        [self.ideaShowProp setGoldIconGray:NO];
    }else
    {
        [self.ideaShowProp setGoldIconGray:YES];
    }
    
}


-(void)setPropGrayAccordRemainCount
{
    if (self.avoidProp.propModel.remainCount > 0)
    {
        [self.avoidProp setGoldIconGray:NO];
    }else
    {
        [self.avoidProp setGoldIconGray:YES];
    }
    
    if (self.trashProp.propModel.remainCount > 0)
    {
        [self.trashProp setGoldIconGray:NO];
    }else
    {
        [self.trashProp setGoldIconGray:YES];
    }
    if (self.ideaShowProp.propModel.remainCount > 0)
    {
        [self.ideaShowProp setGoldIconGray:NO];
    }else
    {
        [self.ideaShowProp setGoldIconGray:YES];
    }
    
}

-(void)showNetCannotUserAlert
{
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示"
                                                 message:@"无法连接网络。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
    [av show];
    [av release];
}
-(void)clickPropButton:(JFPropModel*)model button:(JFPropButton*)btnProp
{
    
  
    if (model.modelType == JFPropModelTypeShareForHelp)
    {
    
        
        if (![UtilitiesFunction networkCanUsed])
        {
            [self showNetCannotUserAlert];
            return;
        }
        UIImage *image = [UIImage getScreenImageWithView:self.view size:self.view.frame.size];
        [JFShareManger shareWithMsg:@"hello" image:image];
        
    }else
    {
        /*
        if (m_idiomView.viewStatus != JFIdiomDetailViewStatusCounting)
        {
            return;
        }*/
        
        if (model.remainCount <= 0)
        {
            return;
        }
        if (model.propPrice > [[JFLocalPlayer shareInstance] goldNumber])
        {
            JFAlertView  *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"金币不足，是否购买金币?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"购买"];
            av.tag = 2000;
            [av show];
            [av release];
            return;
        }
        
        if ([m_idiomView isRightAnswerInForm])
        {
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
            default:
                break;
        }
        
        
       
        [m_idiomView usePropWithType:model.modelType];
        model.remainCount--;
        [JFLocalPlayer deletegoldNumber:model.propPrice];
        [self setPropGrayAccordGoldNumber];
        if (model.remainCount <= 0)
        {
            [btnProp setGoldIconGray:YES];
        }
        
        [JFPlayAniManger deleteGoldWithAni:model.propPrice];
        
       
    
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
        }else if (alertView.tag == 3000)
        {
            NSString *url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%d",785258787];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
    }
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
    
    UIView   *superlevelview = [m_levelView superview];
    if (m_levelView)
    {
        [m_levelView removeFromSuperview];
        [m_levelView release];
        m_levelView = nil;
    }
    
    
    m_levelView = [[UtilitiesFunction getImagewithNumber:[self.idiomModel.idiomlevelString intValue] type:JFPicNumberTypeLevelNumber] retain];
    [m_levelView setFrame:CGRectMake((superlevelview.frame.size.width-m_levelView.frame.size.width)/2, (superlevelview.frame.size.height-m_levelView.frame.size.height)/2, m_levelView.frame.size.width, m_levelView.frame.size.height)];
    [superlevelview addSubview:m_levelView];
    
    UIView   *supergoldview = [self.view viewWithTag:10001011];//[m_goldView superview];
    if (m_goldView)
    {
        [m_goldView removeFromSuperview];
        [m_goldView release];
        m_goldView = nil;
    }
    m_goldView = [[UtilitiesFunction getImagewithNumber:[[JFLocalPlayer shareInstance] goldNumber] type:JFPicNumberTypeGoldNumber] retain];
    [m_goldView setFrame:CGRectMake(5, (supergoldview.frame.size.height-m_goldView.frame.size.height)/2, m_goldView.frame.size.width, m_goldView.frame.size.height)];
    [supergoldview addSubview:m_goldView];
    
  
    
    DLOG(@"supergoldview:%@ m_goldView:%@",supergoldview,m_goldView);
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


#pragma mark JFIdiomDetailViewDelegate
-(void)answerIdiomSuc:(JFIdiomModel*)model isUsedAvoidprop:(BOOL)isUsed isTimeOut:(BOOL)isTimeOut
{
    
    
    if ([model.idiomlevelString intValue] < 4)
    {
        isTimeOut = NO;
    }
    
   /* JFFreeGoldVew  *goldView = [[JFFreeGoldVew alloc] initWithFrame:CGRectMake((self.view.frame.size.width-265)/2, (self.view.frame.size.height-221)/2, 265, 221)];
    [self.view addSubview:goldView];
    [goldView startCountOntime:nil];
    [goldView release];
    return;*/
    int     goldNumber = 20;
    
    if (model.isAnswed)
    {
        if (isTimeOut)
        {
            goldNumber = 0;
        }else
        {
            goldNumber = 2;
        }
        
    }else
    {
        if (!isTimeOut)
        {
            goldNumber = 20;
        }else
        {
            goldNumber = 2;
        }
        if ([self.idiomModel.idiomlevelString intValue] == 3)
        {
            JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"请赐一个5星评价吧，大人！" delegate:self cancelButtonTitle:@"残忍拒绝" otherButtonTitles:@"赐个5星"];
            av.tag = 3000;
            [av show];
            [av release];
        }
       
    }
    if (isUsed)
    {
        goldNumber = 0;
    }
    
    CGFloat fprogress = [model.idiomlevelString floatValue]/([m_arrayIdioms count]*1.0);
    BOOL    bisLst = NO;
    if ([model.idiomlevelString intValue] == [m_arrayIdioms count])
    {
        bisLst = YES;
    }
    
    
    [JFSQLManger setLevelAnswerAndUnlocked:[self.idiomModel.idiomlevelString intValue]];
    [JFSQLManger setLevelUnlocked:[self.idiomModel.idiomlevelString intValue]+1];
    
    JFIdiomModel    *lastModel = self.idiomModel;
    if (!lastModel.isAnswed)
    {
        [[JFLocalPlayer shareInstance] setLastLevel:[self.idiomModel.idiomlevelString intValue]];
        [JFSQLManger updateUserLevelNumberToDB:[self.idiomModel.idiomlevelString intValue] playerID:[[JFLocalPlayer shareInstance] userID]];
        [[JFLocalPlayer shareInstance] setLastLevel:[self.idiomModel.idiomlevelString intValue]];
    }
    
    [JFLocalPlayer addgoldNumber:goldNumber];

    
    
    
    JFAnswerRightView  *view = [[JFAnswerRightView alloc] initWithFrame:CGRectZero withModel:model gold:goldNumber progress:fprogress islastidiom:bisLst];
    view.delegate =  self;
    [view show];
    [view release];
    
    [JFPlayAniManger addGoldWithAni:goldNumber];
    
    
    [JFMedalRewardView showMedalViewwithType:JFMedalModelGetTypeNormalMode];
  //  [self performSelector:@selector(checkGetMedal) withObject:nil afterDelay:1];
  //  [self checkGetMedal];
    DLOG(@"answerIdiomSuc:%@",model);
}


-(void)answerIdiomOverTime:(JFIdiomModel *)model
{
    
    if (!model.isAnswed)
    {
         [JFLocalPlayer deletegoldNumber:0];
       // [JFPlayAniManger deleteGoldWithAni:0];
    }else
    {
         [JFLocalPlayer deletegoldNumber:0];
        //[JFPlayAniManger deleteGoldWithAni:0];
    }
   
    [self refreshSelfView:nil];
    if ([[JFLocalPlayer shareInstance] goldNumber] <= 0)
    {
        [self addFreeGoldWithCountDown:30];
        
    }
    DLOG(@"answerIdiomOverTime:%@",model);
}


-(void)startNextIdiom:(JFIdiomModel*)TempidiomModel
{
    
   
    [self resetPropRemainCount];
    [self setPropGrayAccordGoldNumber];
    
    self.idiomModel = TempidiomModel;
    [self refreshSelfView:nil];
    [m_idiomView updateViewAccordModel:TempidiomModel];
    if ([self.idiomModel.idiomlevelString intValue] <= 3)
    {
        [m_idiomView setProgreViewHidden:YES];
    }else
    {
        [m_idiomView setProgreViewHidden:NO];
    }
    
    [m_idiomView startAnswer:30];
    [JFSQLManger setLevelUnlocked:[self.idiomModel.idiomlevelString intValue]];
    
}

#pragma mark JFAnswerRightViewDelegate
-(void)clickToshare:(id)sender
{
    
    
    if (![UtilitiesFunction networkCanUsed])
    {
        [self showNetCannotUserAlert];
        return;
    }
    UIImage *image = [UIImage getScreenImageWithView:self.view size:self.view.frame.size];
    [JFShareManger shareWithMsg:@"hello" image:image];
    DLOG(@"clickToshare:%@",sender);
}
-(void)clickToNextIdiom:(JFIdiomModel*)model addGoldNumber:(int)number;
{
    
    int index = [m_arrayIdioms indexOfObject:model];
    if (index+1 < [m_arrayIdioms count])
    {
        JFIdiomModel  *nextModel = [m_arrayIdioms objectAtIndex:index+1];
        [self startNextIdiom:nextModel];
    }else
    {
        [self backToCheckPointControlNeedShowMaxOffset:YES];
        DLOG(@" clickToNextIdiom  lastidiom");
    }
    
}
-(void)clickMoreIdioms:(id)sender addGoldNumber:(int)number
{
    [self backToCheckPointControlNeedShowMaxOffset:YES];
    DLOG(@"clickMoreIdioms:%@",sender);
}


-(void)clickBackButtonInAnswerview:(id)sender
{
    [self backToCheckPointControlNeedShowMaxOffset:NO];
}

-(void)backToCheckPointControlNeedShowMaxOffset:(BOOL)bNeedShowMaxOff
{

    for (UIViewController   *control in self.navigationController.viewControllers)
    {
        if ([control isKindOfClass:[JFCheckPointViewController class]])
        {
            JFCheckPointViewController *tempControl = (JFCheckPointViewController*)control;
              tempControl.showMaxPage = bNeedShowMaxOff;
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }
    
    
    JFCheckPointViewController  *control = [[JFCheckPointViewController alloc] init];
     control.showMaxPage = bNeedShowMaxOff;
    [self.navigationController pushViewController:control animated:YES];
    [control release];
    
    NSMutableArray  *arrayControl = [NSMutableArray array];
    for (UIViewController   *control in self.navigationController.viewControllers)
    {
        if (![control isKindOfClass:[self class]])
        {
            [arrayControl addObject:control];
        }
        
    }
    
    [self.navigationController setViewControllers:[NSArray arrayWithArray:arrayControl]];
    
}

#pragma mark    JFFreeGoldVewDelegate

-(void)addFreeGoldWithCountDown:(int)countDownSeconds
{
    
    
    
    /*
    if (m_freeGoldView && [m_freeGoldView superview])
    {
        return;
    }
    
    if ([[JFLocalPlayer shareInstance] goldNumber] > 0)
    {
        [self cleanFreeGoldInfo:nil];
        return;
    }
    m_idiomView.userInteractionEnabled = NO;
    if (m_freeGoldView)
    {
        [m_freeGoldView stopTimer];
        [m_freeGoldView removeFromSuperview];
        [m_freeGoldView release];
        m_freeGoldView = nil;
    }
    [self addYouMiadView];
    m_freeGoldView = [[JFFreeGoldVew alloc] initWithFrame:CGRectMake((self.view.frame.size.width-265)/2, (self.view.frame.size.height-221)/2, 265, 221)];
    [self.view addSubview:m_freeGoldView];
    m_freeGoldView.delegate = self;
    
    if (countDownSeconds <= 0)
    {
        m_freeGoldView.needPlayCangain = NO;
    }
    [m_freeGoldView startCountOntime:countDownSeconds];
    
    [JFSendAdInfo sendShowAD:[[JFLocalPlayer shareInstance] userID] adType:ad_exhibition_typeYouMi];*/
    
}
-(void)clickToAddGoldNumber:(int)addgoldNumber
{
    
    m_idiomView.userInteractionEnabled = YES;
  
    [self removeYouMiView];
    [JFLocalPlayer addgoldNumberWithNoAudio:addgoldNumber];
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeGainGold];
    [JFPlayAniManger addGoldWithAni:addgoldNumber];
 
    
}
-(void)clickToGainreward:(id)thread
{
    DLOG(@"clickToGainreward:%@",thread);
}

-(void)cleanStoreData:(id)Thread
{
    NSString    *strStoreKey = [NSString stringWithFormat:@"NormalLevelInfo%@%@",[[JFLocalPlayer shareInstance] userID],self.idiomModel.idiomlevelString];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:strStoreKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)storeCurrentState
{
    
    NSString    *strStoreKey = [NSString stringWithFormat:@"NormalLevelInfo%@%@",[[JFLocalPlayer shareInstance] userID],self.idiomModel.idiomlevelString];
    int  nowtimer = [[NSDate date] timeIntervalSince1970];
    NSMutableDictionary     *dicInfo = [NSMutableDictionary dictionary];
    
    
    if (!m_idiomView.answerRight)
    {
        if ([self.idiomModel.idiomlevelString intValue] > 3)
        {
            [dicInfo setObject:@(nowtimer) forKey:@"answerTimerInterval"];
            [dicInfo setObject:@(m_idiomView.remainCountDown) forKey:@"answerremainCountDown"];
            [dicInfo setObject:@(self.avoidProp.propModel.remainCount) forKey:@"avoidPropremainCount"];
            [dicInfo setObject:@(self.trashProp.propModel.remainCount) forKey:@"trashPropPropremainCount"];
            [dicInfo setObject:@(self.ideaShowProp.propModel.remainCount) forKey:@"ideaShowPropremainCount"];
            [dicInfo setObject:[m_idiomView getNowAnswerStr] forKey:@"ANSWERSTR"];
            [dicInfo setObject:[m_idiomView getNowOptionStr] forKey:@"OPTIONSTR"];
            [[NSUserDefaults standardUserDefaults] setObject:dicInfo forKey:strStoreKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
       
        
    }
    

    DLOG(@"storeCurrentState strStoreKey:%@",dicInfo);

}

-(void)initViewAccordStoreData
{
    
    if ([self.idiomModel.idiomlevelString intValue] <= 3)
    {
        [m_idiomView setProgreViewHidden:YES];
    }
    NSString    *strStoreKey = [NSString stringWithFormat:@"NormalLevelInfo%@%@",[[JFLocalPlayer shareInstance] userID],self.idiomModel.idiomlevelString];
    
    NSString    *strStoreEnterKey = [NSString stringWithFormat:@"NormalLevelEnter%@",[[JFLocalPlayer shareInstance] userID]];
    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:strStoreEnterKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSDictionary    *dicLevelinfo = [[NSUserDefaults standardUserDefaults] valueForKey:strStoreKey];
    NSTimeInterval  nowtimeinter = [[NSDate date] timeIntervalSince1970];
    if (dicLevelinfo && [[dicLevelinfo allKeys] count])
    {
        
      
        int  oldtimerinter = [[dicLevelinfo objectForKey:@"answerTimerInterval"] intValue];
        int remainCount = [[dicLevelinfo objectForKey:@"answerremainCountDown"] intValue];
        int countdown = remainCount-(nowtimeinter-oldtimerinter);
        int avoidCount = [[dicLevelinfo valueForKey:@"avoidPropremainCount"] intValue];
        int ideaCount = [[dicLevelinfo valueForKey:@"ideaShowPropremainCount"] intValue];
        int trashCount = [[dicLevelinfo valueForKey:@"trashPropPropremainCount"] intValue];
        
        //  [dicInfo setObject:[m_idiomView getNowAnswerStr] forKey:@"ANSWERSTR"];
       // [dicInfo setObject:[m_idiomView getNowOptionStr] forKey:@"OPTIONSTR"];
        
        NSString    *strOption = [dicLevelinfo valueForKey:@"OPTIONSTR"];
        NSString    *strAnswer = [dicLevelinfo valueForKey:@"ANSWERSTR"];
        self.avoidProp.propModel.remainCount = avoidCount;
        self.ideaShowProp.propModel.remainCount = ideaCount;
        self.trashProp.propModel.remainCount = trashCount;
        
        if (self.avoidProp.propModel.remainCount  <= 0)
        {
            [self.avoidProp setGoldIconGray:YES];
        }
        if (self.ideaShowProp.propModel.remainCount  <= 0)
        {
            [self.ideaShowProp setGoldIconGray:YES];
        }
        if (self.trashProp.propModel.remainCount  <= 0)
        {
            [self.trashProp setGoldIconGray:YES];
        }
        
        [self setPropGrayAccordGoldNumber];
        if (remainCount <= 0)
        {
            [m_idiomView setIsFailed:YES];
        }
        
          DLOG(@"initViewAccordStoreData %@ \ncountdown:%d remainCount:%d nowtimeinter：%f oldtimer:%d  diclevelInfo:%@",dicLevelinfo,countdown,remainCount,nowtimeinter,oldtimerinter,dicLevelinfo);
        if (countdown > 30)
        {
            countdown = 30;
        }
        [m_idiomView setStringAfterLoadModel:strOption answerStr:strAnswer];
        [m_idiomView startAnswer:countdown];
        
    }else
    {
        [m_idiomView startAnswer:30];
    }
    
 
    if ([[JFLocalPlayer shareInstance] goldNumber] <= 0)
    {
        [self addGoldWithAni];
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

#if 0
//immob
#pragma mark -immobViewDelegate
/**
 *查询积分接口回调
 */
- (void) immobViewQueryScore:(NSUInteger)score WithMessage:(NSString *)message
{
    DLOG(@"immobViewQueryScore:%d message:%@",score,message);
    // [uA release];
}

/**
 *减少积分接口回调
 */
- (void) immobViewReduceScore:(BOOL)status WithMessage:(NSString *)message
{
    DLOG(@"immobViewReduceScore:%d message:%@",status,message);
}

- (void) immobView: (immobView*) immobView didFailReceiveimmobViewWithError: (NSInteger) errorCode
{
    
    NSLog(@"errorCode:%i",errorCode);
}
- (void) onDismissScreen:(immobView *)immobView
{
    
    [m_bannerView removeFromSuperview];
    NSLog(@"onDismissScreen:%@",immobView);
}


/**
 * Called when an page is created in front of the app.
 * 当广告页面被创建并且显示在覆盖在屏幕上面时调用本方法。
 */
- (void) onPresentScreen:(immobView *)immobView;
{
    [immobView setFrame:CGRectMake((480-immobView.frame.size.width)/2, 0, immobView.frame.size.width, immobView.frame.size.height)];
    
    immobView.center = CGPointMake(self.view.frame.size.width/2, immobView.frame.size.height/2);
    DLOG(@"onPresentScreen:%@",immobView);
}
/**
 *email phone sms等所需要
 *返回当前添加immobView的ViewController
 */
- (UIViewController *)immobViewController{
    
    NSLog(@"immobViewController:%@",self);
    return nil;
}


- (void) immobViewDidReceiveAd:(immobView *)immobView
{
    if (immobView != nil)
    {
        [self.view addSubview:immobView];
        [immobView immobViewDisplay];
        immobView.hidden = NO;
        
    }
    NSLog(@"immobViewDidReceiveAd:%@",immobView);
}
#endif




@end
