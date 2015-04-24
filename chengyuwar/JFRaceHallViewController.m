//
//  JFRaceHallViewController.m
//  chengyuwar
//
//  Created by ran on 13-12-16.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFRaceHallViewController.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"
#import "JFLocalPlayer.h"
#import "JFChargeView.h"
#import "JFMedalViewController.h"
#import "UtilitiesFunction.h"
#import "JFRaceAnswerViewController.h"
#import "JFSQLManger.h"
#import "JFLevelDetailView.h"
#import "JFRankViewController.h"
@interface JFRaceHallViewController ()

@end

@implementation JFRaceHallViewController

-(id)init
{
    self = [super init];
    if (self)
    {
        
        JFLocalPlayer   *player = [JFLocalPlayer shareInstance];
        [player addObserver:self forKeyPath:@"goldNumber" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        [self startTimer:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendRequestInfo) name:@"BNRGetUserInfo" object:nil];
    }
    return self;
}

-(void)dealloc
{
    
    
    JFLocalPlayer   *player = [JFLocalPlayer shareInstance];
    [player removeObserver:self forKeyPath:@"goldNumber"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [m_labelLevel release];
    m_labelLevel = nil;
    [m_labelLoseCount release];
    m_labelLoseCount = nil;
    [m_labelOnlineNumber release];
    m_labelOnlineNumber = nil;
    [m_labelwincount release];
    m_labelwincount = nil;
    [m_lableMaxwinnumber release];
    m_lableMaxwinnumber = nil;
    [m_lableScore release];
    m_lableScore  = nil;
    [m_raceReq release];
    m_raceReq = nil;
    [m_textName release];
    m_textName = nil;
    [m_imageRole release];
    m_imageRole = nil;

    [m_goldView release];
    m_goldView = nil;
    [m_arrayNickName release];
    m_arrayNickName = nil;
    
    [super dealloc];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
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

-(void)loadView
{
    [super loadView];
    [self initview];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self sendRequestInfo];
  //  [m_raceReq insertDataToSQLForRace];
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
    
    

    /*
    UIButton   *btnGaingold = [[UIButton alloc] initWithFrame:CGRectMake(22, bgView.frame.size.height-60, 40, 48)];
    [btnGaingold setImage:[PublicClass getImageAccordName:@"check_gaingold_btn.png"] forState:UIControlStateNormal];
    [btnGaingold addTarget:self action:@selector(clickGainGoldbtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnGaingold];*/
    
    
    UIButton   *btnmedal = [[UIButton alloc] initWithFrame:CGRectMake(bgView.frame.size.width-20-33, bgView.frame.size.height-55, 28, 43)];
    [btnmedal setImage:[PublicClass getImageAccordName:@"check_medal_btn.png"] forState:UIControlStateNormal];
    [btnmedal addTarget:self action:@selector(clickMedalbtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnmedal];
    

    
    
    UIButton      *btnback = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 27+40, 22+4)];
    [btnback setImageEdgeInsets:UIEdgeInsetsMake(2, 20, 2, 20)];
    [btnback setImage:[PublicClass getImageAccordName:@"about_back.png"] forState:UIControlStateNormal];
    [btnback addTarget:self action:@selector(clickBackbtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnback];
    
    
    UIImageView  *imageuserBg = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-415)/2, 45, 415, 182)];
    imageuserBg.image = [PublicClass getImageAccordName:@"racehall_papgebg.png"];
    [bgView addSubview:imageuserBg];
    imageuserBg.userInteractionEnabled = YES;
    [self addUserInfoView:imageuserBg];
    
    
    
    
    UIButton *btnstart = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width-100*2)/3+20, imageuserBg.frame.size.height+imageuserBg.frame.origin.y+35, 100, 32)];
    [btnstart setBackgroundImage:[PublicClass getImageAccordName:@"racehall_startgame_btn.png"] forState:UIControlStateNormal];
    [btnstart setBackgroundImage:[PublicClass getImageAccordName:@"racehall_startgame_btnpressed.png"] forState:UIControlStateHighlighted];
    [btnstart setImage:[PublicClass getImageAccordName:@"racehall_startgame_word.png"] forState:UIControlStateNormal];
    [btnstart addTarget:self action:@selector(clickStartBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnstart];
    
    
    
    [self addBtn:@"racehall_myrank.png" frame:CGRectMake((frame.size.width-100*2)/3+80+(frame.size.width-100*2)/3, imageuserBg.frame.size.height+imageuserBg.frame.origin.y+35, 100, 32) selector:@selector(clickMyRank:) superview:self.view];
    
    
    [btnstart release];
    [imageuserBg release];
    [bgView release];
    [btnback release];

    [btnmedal release];
    
    [self addGoldBgView];
 //   [btnGaingold release];
}



-(void)addGoldBgView
{
    
    CGSize  size = [[UIScreen mainScreen] bounds].size;
    CGRect  frame = CGRectMake(0, 0, size.height, size.width);
    
    
    UIView  *viewBg = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width-115-28, 5, 87, 23)];
    
    UIImageView  *goldIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 28, 15)];
    goldIcon.image = [PublicClass getImageAccordName:@"check_gold_icon.png"];
    [viewBg addSubview:goldIcon];
    
    
    UIImageView     *imagegoldbg = [[UIImageView alloc] initWithFrame:CGRectMake(28, 5, 87, 23)];
    imagegoldbg.image = [PublicClass getImageAccordName:@"check_goldnumber_bg.png"];
    imagegoldbg.userInteractionEnabled = YES;
    [viewBg addSubview:imagegoldbg];
    imagegoldbg.tag = 1000;
    
    
    
    
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAddGold:)];
    [imagegoldbg addGestureRecognizer:tap];
    [viewBg addGestureRecognizer:tap];
    
    UIButton      *btnaddgold = [[UIButton alloc] initWithFrame:CGRectMake(imagegoldbg.frame.size.width-22, (imagegoldbg.frame.size.height-20)/2, 20, 20)];
    [btnaddgold setBackgroundImage:[PublicClass getImageAccordName:@"check_add.png"] forState:UIControlStateNormal];
    [btnaddgold setBackgroundImage:[PublicClass getImageAccordName:@"check_add_pressed.png"] forState:UIControlStateHighlighted];
    [btnaddgold addTarget:self action:@selector(clickAddGold:) forControlEvents:UIControlEventTouchUpInside];
    [imagegoldbg addSubview:btnaddgold];
    
    
    m_goldView = [[UtilitiesFunction getImagewithNumber:[[JFLocalPlayer shareInstance] goldNumber] type:JFPicNumberTypeGoldNumber] retain];
    [m_goldView setFrame:CGRectMake(5, (imagegoldbg.frame.size.height-m_goldView.frame.size.height)/2, m_goldView.frame.size.width, m_goldView.frame.size.height)];
    [imagegoldbg addSubview:m_goldView];
    imagegoldbg.tag = 10001011;
    
    viewBg.userInteractionEnabled = YES;
    [self.view addSubview:viewBg];
    [viewBg release];
    [btnaddgold release];
    [imagegoldbg release];
    [goldIcon release];
      [tap release];
    
    
}

-(void)updateViewInfo
{
    
}

-(void)addUserInfoView:(UIView*)bgView
{
    
    
    JFLocalPlayer  *player = [JFLocalPlayer shareInstance];
    CGFloat   fxpoint = 5;
    CGFloat   fypoint = -25;
    
    
    UILabel  *labelOnline = [[UILabel alloc] initWithFrame:CGRectMake(fxpoint, fypoint, 100, 24)];
    [labelOnline setText:@"在线人数："];
    [labelOnline setTextColor:[UIColor colorWithRed:0x4B*1.0/255.0 green:0x26*1.0/255.0 blue:0x12*1.0/255.0 alpha:1]];
    [labelOnline setBackgroundColor:[UIColor clearColor]];
    [labelOnline setFont:TEXTFONTWITHSIZE(17)];
    [bgView addSubview:labelOnline];
    [labelOnline release];
    
    fxpoint += 70+10;
    
    
    if (!m_labelOnlineNumber)
    {
        m_labelOnlineNumber = [[UILabel alloc] initWithFrame:CGRectMake(fxpoint, fypoint+3, 100, 24)];
        [m_labelOnlineNumber setText:@"0"];
        [m_labelOnlineNumber setTextColor:[UIColor colorWithRed:0x4B*1.0/255.0 green:0x26*1.0/255.0 blue:0x12*1.0/255.0 alpha:1]];
        [m_labelOnlineNumber setBackgroundColor:[UIColor clearColor]];
        [m_labelOnlineNumber setFont:TEXTHEITIWITHSIZE(17)];
        [bgView addSubview:m_labelOnlineNumber];
        
    }
    
    
    fxpoint = 55;
    fypoint = 10;
    if (!m_imageRole)
    {
        m_imageRole = [[UIImageView alloc] initWithFrame:CGRectMake(fxpoint-20, fypoint, 130, 130)];
        [bgView addSubview:m_imageRole];
    }
    [m_imageRole setImage:[PublicClass getImageAccordName:player.roleModel.ownPhoto]];
    

    UIButton *btnCreate = [[UIButton alloc] initWithFrame:CGRectMake(m_imageRole.frame.origin.x+(m_imageRole.frame.size.width-75)/2, m_imageRole.frame.size.height+m_imageRole.frame.origin.y+2, 75, 28)];
    [btnCreate setBackgroundImage:[PublicClass getImageAccordName:@"racehall_modifyrole_btn.png"] forState:UIControlStateNormal];
    [btnCreate setBackgroundImage:[PublicClass getImageAccordName:@"racehall_modifyrole_btnpressed.png"] forState:UIControlStateHighlighted];
    [btnCreate setImage:[PublicClass getImageAccordName:@"racehall_modifyrole_word.png"] forState:UIControlStateNormal];
    [btnCreate addTarget:self action:@selector(clickCreateBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnCreate];
    [btnCreate release];
    
    
    fxpoint = 190;
    fypoint = 30;
    
    CGFloat    fysep = 10;
    UIView  *nickBg = nil;
    
    if (!nickBg)
    {
        nickBg =    [[UIView alloc] initWithFrame:CGRectMake(fxpoint, fypoint, bgView.frame.size.width-fxpoint, 24)];
        [bgView addSubview:nickBg];
        nickBg.userInteractionEnabled = YES;
        UIImageView  *imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, 40, 17)];
        imageIcon.image = [PublicClass getImageAccordName:@"createrole_nickname_titile.png"];
        [nickBg addSubview:imageIcon];
        
        UIImageView  *imagenamebg = [[UIImageView alloc] initWithFrame:CGRectMake(40+20, 0, 98, 24)];
        imagenamebg.image = [PublicClass getImageAccordName:@"createrole_name_bg.png"];
        [nickBg addSubview:imagenamebg];
        
        imagenamebg.userInteractionEnabled = YES;
        m_textName = [[UITextField alloc] initWithFrame:CGRectMake(3, 3, imagenamebg.frame.size.width-5, 20)];
        [m_textName setText:player.nickName];
       // m_textName.minimumFontSize = 9;
      //  m_textName.adjustsFontSizeToFitWidth = YES;
        [m_textName setFont:[UIFont systemFontOfSize:12]];
        [m_textName setDelegate:self];
        [m_textName setPlaceholder:@"请输入昵称"];
        [m_textName setBorderStyle:UITextBorderStyleNone];
        [m_textName setTextColor:[UIColor whiteColor]];
    
        [imagenamebg addSubview:m_textName];
        
        /*
        UIButton  *btndice = [[UIButton alloc] initWithFrame:CGRectMake(98+40+20, 2, 15, 16)];
        [btndice setBackgroundImage:[PublicClass getImageAccordName:@"createrole_dice.png"] forState:UIControlStateNormal];
        [btndice addTarget:self action:@selector(clickChangeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [nickBg addSubview:btndice];
        
        [btndice release];*/
        [imagenamebg release];
        [imageIcon release];
        [nickBg release];
        
        
        
        UIButton  *btndice = [[UIButton alloc] initWithFrame:CGRectMake(98+40+20, -3, 15+10, 16+10)];
        [btndice setImage:[PublicClass getImageAccordName:@"createrole_dice.png"] forState:UIControlStateNormal];
        [btndice setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [btndice addTarget:self action:@selector(clickChangeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [nickBg addSubview:btndice];
        [btndice release];
        
        //createrole_nickname_titile
    }
    
    fypoint += fysep+24;
    
    UIImageView     *imageviewin = [[UIImageView alloc] initWithFrame:CGRectMake(fxpoint, fypoint, 71, 17)];
    imageviewin.image = [PublicClass getImageAccordName:@"racehall_wincount_word.png"];
    [bgView addSubview:imageviewin];
    [imageviewin release];
    
    m_labelwincount = [[UILabel alloc] initWithFrame:CGRectMake(fxpoint+71+10, fypoint, 100, 17)];
    [m_labelwincount setTextColor:[UIColor colorWithRed:0xBB*1.0/255.0 green:0x83*1.0/255.0 blue:0x4A*1.0/255.0 alpha:1]];
    [m_labelwincount setText:[NSString stringWithFormat:@"%d",player.winNumber]];
    [m_labelwincount setBackgroundColor:[UIColor clearColor]];
    [m_labelwincount setFont:TEXTFONTWITHSIZE(17)];
    [bgView addSubview:m_labelwincount];

    
    fypoint += fysep+17;
    UIImageView     *imagevielose = [[UIImageView alloc] initWithFrame:CGRectMake(fxpoint, fypoint, 71, 17)];
    imagevielose.image = [PublicClass getImageAccordName:@"racehall_losecount_word.png"];
    [bgView addSubview:imagevielose];
    [imagevielose release];
    
    m_labelLoseCount = [[UILabel alloc] initWithFrame:CGRectMake(fxpoint+71+10, fypoint, 100, 17)];
    [m_labelLoseCount setTextColor:[UIColor colorWithRed:0xBB*1.0/255.0 green:0x83*1.0/255.0 blue:0x4A*1.0/255.0 alpha:1]];
    [m_labelLoseCount setText:[NSString stringWithFormat:@"%d",player.loseNumber]];
    [m_labelLoseCount setBackgroundColor:[UIColor clearColor]];
    [m_labelLoseCount setFont:TEXTFONTWITHSIZE(17)];
    [bgView addSubview:m_labelLoseCount];

    
    
    fypoint += fysep+17;
    UIImageView     *imagevieconnumber = [[UIImageView alloc] initWithFrame:CGRectMake(fxpoint, fypoint, 71, 17)];
    imagevieconnumber.image = [PublicClass getImageAccordName:@"racehall_maxconwin_word.png"];
    [bgView addSubview:imagevieconnumber];
    [imagevieconnumber release];
    
    m_lableMaxwinnumber = [[UILabel alloc] initWithFrame:CGRectMake(fxpoint+71+10, fypoint, 100, 17)];
    [m_lableMaxwinnumber setTextColor:[UIColor colorWithRed:0xFF*1.0/255.0 green:0x33*1.0/255.0 blue:0x00*1.0/255.0 alpha:1]];
    [m_lableMaxwinnumber setText:[NSString stringWithFormat:@"%d",player.maxConWinNumber]];
    [m_lableMaxwinnumber setBackgroundColor:[UIColor clearColor]];
    [m_lableMaxwinnumber setFont:TEXTFONTWITHSIZE(17)];
    [bgView addSubview:m_lableMaxwinnumber];

    
    
    fypoint += fysep+17;
    UIImageView     *imagevieescore = [[UIImageView alloc] initWithFrame:CGRectMake(fxpoint, fypoint, 71, 17)];
    imagevieescore.image = [PublicClass getImageAccordName:@"racehall_totalscore_word.png"];
    [bgView addSubview:imagevieescore];
    [imagevieescore release];
    
    m_lableScore = [[UILabel alloc] initWithFrame:CGRectMake(fxpoint+71+10, fypoint, 100, 17)];
    [m_lableScore setTextColor:[UIColor colorWithRed:0xFF*1.0/255.0 green:0x66*1.0/255.0 blue:0x00*1.0/255.0 alpha:1]];
    [m_lableScore setText:[NSString stringWithFormat:@"%d",player.score]];
    [m_lableScore setBackgroundColor:[UIColor clearColor]];
    [m_lableScore setFont:TEXTFONTWITHSIZE(17)];
    [bgView addSubview:m_lableScore];

    
    
    fxpoint = 15;
    fypoint = 15;
    
    UIImageView   *viewlevelbg = [[UIImageView alloc] initWithFrame:CGRectMake(fxpoint, fypoint, 30, 46)];
    viewlevelbg.image = [PublicClass getImageAccordName:@"racehall_level_bg.png"];
    viewlevelbg.userInteractionEnabled = YES;
    [bgView addSubview:viewlevelbg];
    
    
    
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLevelDetail:)];
    [viewlevelbg addGestureRecognizer:tap];
    [tap release];
    
    m_labelLevel = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, 24, 46)];
    [m_labelLevel setNumberOfLines:2];
    [m_labelLevel setBackgroundColor:[UIColor clearColor]];
    [m_labelLevel setText:[UtilitiesFunction getLevelStringAccordWinCount:player.winNumber]];
    [m_labelLevel setTextColor:[UIColor colorWithRed:0x25*1.0/255.0 green:0x00*1.0/255.0 blue:0x00*1.0/255.0 alpha:1.0]];
    [m_labelLevel setFont:TEXTFONTWITHSIZE(17)];
    [viewlevelbg addSubview:m_labelLevel];
    
    [viewlevelbg release];
    
    //racehall_modifyrole_word
    
    
    
}
-(void)clickLevelDetail:(UITapGestureRecognizer*)tap
{
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    JFLevelDetailView   *view = [[JFLevelDetailView alloc] initWithFrame:CGRectZero];
    [view show];
    [view release];
}

-(void)clickCreateBtn:(id)sender
{
    
    JFCreateRoleView  *view = [[JFCreateRoleView alloc] initWithType:JFCreateRoleViewTypeModify];
    view.delegate =  self;
    [view show];
    [view release];
    
}

-(void)clickChangeBtn:(id)sender
{
    
    [m_textName setTextColor:[UIColor whiteColor]];
  
    if (!m_arrayNickName)
    {
        m_arrayNickName = [[NSMutableArray alloc] init];
        NSString  *strPath = [[NSBundle mainBundle] pathForResource:@"nickname" ofType:@"txt"];
        NSError  *error = nil;
        NSString  *strContent = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:&error];
        if (error)
        {
            DLOG(@"strPath read error:%@ error:%@",strPath,error);
        }else
        {
            NSArray  *array = [strContent componentsSeparatedByString:@","];
            [m_arrayNickName addObjectsFromArray:array];
            DLOG(@"get array nick name:%@",array);
        }
        
    }
    
    if (![m_arrayNickName count])
    {
        return;
    }
    
    static int i = 0;
    srandom(time(NULL)+i);
    i++;
    int index = random()%[m_arrayNickName count];
    [m_textName setText:[m_arrayNickName objectAtIndex:index]];
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    
    
    [[JFLocalPlayer shareInstance] setNickName:m_textName.text];
    [JFSQLManger UpdateUserInfoToDB:[JFLocalPlayer shareInstance]];
    
   // DLOG(@"clickChangeBtn:%@ timeinter:%f index:%d number:%d",sender,timeinter,index,number);
    
}

-(void)clickMyRank:(id)sender
{
    
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (![UtilitiesFunction networkCanUsed])
    {
        JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"无法连接网络。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
        av.tag = 111;
        [av show];
        [av release];
        return;
    }

    
    JFRankViewController  *controler = [[JFRankViewController alloc] init];
    [self.navigationController pushViewController:controler animated:YES];
    [controler release];
    
}
-(void)clickStartBtn:(id)sender
{
    
    
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    
    if (!m_textName.text ||
        [m_textName.text isEqualToString:@""] ||
        [m_textName.text isEqualToString:@"请输入昵称"])
    {
        [self flash];
        return;
    }
    
    if (![[JFLocalPlayer shareInstance] lanchModel].iwvs_server_ip ||
        [[[[JFLocalPlayer shareInstance] lanchModel] iwvs_server_ip] length] < 5)
    {
        
        if (!m_raceReq)
        {
            m_raceReq = [[JFRaceReq alloc] init];
            m_raceReq.delegate = self;
        }
        [m_raceReq getCommonInfo:nil];
        return;
    }
   // BOOL  needUpdateidiom = NO;
    if ([[JFLocalPlayer shareInstance] goldNumber] < 50)
    {
        JFAlertView  *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"挑战需要花费50金币，金币不足，是否需要购买金币？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"购买"];
        av.tag = 1000;
        [av show];
        [av release];
    }else
    {
      
        [m_raceReq resetWarProtrol];
        
        [self showChangeView:nil];
        JFRaceAnswerViewController  *control = [[JFRaceAnswerViewController alloc] initWithWithIdiomModel:nil];
        [self.navigationController pushViewController:control animated:YES];
        [control release];
    }
    
    DLOG(@"clickStartBtn:%@",sender);
}







#pragma mark    JFRaceReqDelegate

-(void)getNetErrorOccur:(NSString*)errorCode
{

    if (![self isEqual:[self.navigationController topViewController]])
    {
        DLOG(@"getNetErrorOccur not in self view");
        return;
    }
    if (!m_bIsAlert)
    {
        m_bIsAlert = YES;
        JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"无法连接网络。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
        av.tag = 111;
        [av show];
        [av release];
        
    }
  
}
-(void)getStartGameResult:(NSDictionary*)dicInfo
{
    
    
    eSDStatus  status = [[dicInfo valueForKey:@"result"] intValue];
    if (status > eSDS_Ok)
    {
        
        if (status == eSDS_QuestionVersionTooLowError)
        {
            
            DownloadHttpInfo  *object = [[DownloadHttpInfo alloc] initWithDelegate:self fileUrl:[[[JFLocalPlayer shareInstance] lanchModel] question_db_xml_url] fileName:DOWNXMLFILENAME downType:DownloadHttpFileDownTypeNormalXml];
            [DownloadHttpFile addDownFileObjects:object];
            [object release];
            
        }
        DLOG(@"");
    }else if (status == eSDS_Ok)
    {
       
        JFRaceAnswerViewController  *control = [[JFRaceAnswerViewController alloc] initWithWithIdiomModel:nil];
        [self.navigationController pushViewController:control animated:YES];
        [control release];
      //  [self removeChangeView];
    }
    
  
    DLOG(@"getStartGameResult:%@",dicInfo);
}
-(void)getOnlineNumber:(eSDStatus)status number:(int)onlineNumber
{
    [m_labelOnlineNumber setText:[NSString stringWithFormat:@"%d",onlineNumber]];
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
        player.score = winNumber*3;
        player.weekMaxConWinCount = [[dicInfo valueForKey:@"week_max_keep_win_times"] intValue];
        player.weekConWinCount = [[dicInfo valueForKey:@"week_curr_keep_win_times"] intValue];
        
        [self refreshUserView];
        [JFSQLManger UpdateUserInfoToDB:player];
    }
    
}


-(void)sendRequestInfo
{
    if (!m_raceReq)
    {
        m_raceReq = [[JFRaceReq alloc] init];
        m_raceReq.delegate = self;
    }
    [m_raceReq requestOnlineNumber:[[JFLocalPlayer shareInstance] userID]];
    [m_raceReq requestPersonalInfo:[[JFLocalPlayer shareInstance] userID]];
}

-(void)refreshUserView
{
    JFLocalPlayer   *player = [JFLocalPlayer shareInstance];
    [m_textName setText:player.nickName];
    [m_imageRole setImage:[PublicClass getImageAccordName:player.roleModel.ownPhoto]];
    [m_labelwincount setText:[NSString stringWithFormat:@"%d",player.winNumber]];
    [m_lableMaxwinnumber setText:[NSString stringWithFormat:@"%d",player.maxConWinNumber]];
    [m_labelLoseCount setText:[NSString stringWithFormat:@"%d",player.loseNumber]];
    [m_lableScore setText:[NSString stringWithFormat:@"%d",player.score]];
    [m_labelLevel setText:[UtilitiesFunction getLevelStringAccordWinCount:player.winNumber]];
    
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
    [self stopTimer:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickGainGoldbtn:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    DLOG(@"clickGainGoldbtn:%@",sender);
}
-(void)clickMedalbtn:(id)sender
{
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    JFMedalViewController  *contrlller = [[JFMedalViewController alloc] init];
    [self.navigationController pushViewController:contrlller animated:YES];
    [contrlller release];
    DLOG(@"clickMedalbtn:%@",sender);
}

#pragma mark  JFAlertClickViewDelegate
-(void)JFAlertClickView:(JFAlertView *)alertView index:(JFAlertViewClickIndex)buttonIndex
{
    if (buttonIndex == JFAlertViewClickIndexRight)
    {
        
        if (alertView.tag == 1000)
        {
            JFChargeView  *av = [[JFChargeView alloc] initWithFrame:CGRectZero];
            [av show];
            [av release];
        }else if (alertView.tag == 2000)
        {
            JFAlertUpdateView  *av = [[JFAlertUpdateView alloc] initWithFrame:CGRectZero];
            //av.delegate = self;
            [av setProgress:0];
            [av show];
            NSMutableArray  *arrZip = [JFPhaseXmlData phaseUrlInfoAccordPath:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME] xmlType:JFPhaseXmlDataTypeNormalXml rootPath:nil];
            [av loadDownZipArray:arrZip];
            [av release];
            
        }
       
        
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

-(void)startTimer:(id)Thread
{
    if (m_timer)
    {
        [m_timer invalidate];
        [m_timer release];
        m_timer = nil;
    }
    
    m_timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:60*5 target:self selector:@selector(sendRequestInfo) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:m_timer forMode:NSDefaultRunLoopMode];
}

-(void)stopTimer:(id)Thread
{
    if (m_timer)
    {
        [m_timer invalidate];
        [m_timer release];
        m_timer = nil;
    }
    
}

#pragma mark downloadhttpfiledelegate
-(void)downNormalXmlSuc:(DownloadHttpInfo*)object
{
    

    
     CGFloat size = [JFPhaseXmlData phaseXmlZipSize:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME] xmlType:JFPhaseXmlDataTypeNormalXml];
    
     NSString  *strMsg = [NSString stringWithFormat:@"需更新题库,大小%0.1fM,现在更新?",size];
     JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:strMsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新"];
     av.tag = 2000;
     [av show];
     [av release];
}
-(void)downNormalXmlFail:(DownloadHttpInfo *)object
{
    
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


#pragma mark

-(void)userHasCreateRole:(id)Thread
{
    [self refreshUserView];
}
#pragma mark uitextfielddelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField setTextColor:[UIColor whiteColor]];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.length == 1)
    {
        return YES;
    }
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([toBeString length] > 8)
    {
        return NO;
    }
    
    
    
    return YES;
}

//- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (![UtilitiesFunction checkStringSize:textField.text minSize:0 maxSize:16])
    {
        JFAlertView *alert = [[JFAlertView alloc] initWithTitle:@"提示" message:@"昵称不合法!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定"];
        [alert show];
        [alert release];
    }else
    {
        [[JFLocalPlayer shareInstance] setNickName:textField.text];
        [JFSQLManger UpdateUserInfoToDB:[JFLocalPlayer shareInstance]];
    }
    [textField resignFirstResponder];
    return YES;
}


-(void)flash
{
    
    [m_textName setAlpha:0];
    [m_textName setText:@"请输入昵称"];
    [m_textName setTextColor:[UIColor whiteColor]];
    
    [UIView beginAnimations:@"flash screen" context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationRepeatCount:2];
    //  [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    //    [UIView setAnimationDelegate:self];
    [m_textName setAlpha:1];
    [m_textName setText:@"请输入昵称"];
    [m_textName setTextColor:[UIColor redColor]];
    
    [UIView commitAnimations];
}

//73*23
-(void)addBtn:(NSString*)strName frame:(CGRect)frame selector:(SEL)selctor superview:(UIView*)supreView
{
    UIButton  *btn = [[UIButton alloc] initWithFrame:frame];
    [btn addTarget:self action:selctor forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[PublicClass getImageAccordName:@"racehall_btn_bg.png"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[PublicClass getImageAccordName:@"racehall_btn_bg_pressed.png"] forState:UIControlStateNormal];
    [btn setImage:[PublicClass getImageAccordName:strName] forState:UIControlStateNormal];
    [supreView addSubview:btn];
    [btn release];
}


-(void)getCommonInfoInRace:(eSDStatus)status LanchModel:(JFLanchModel*)model
{
    
    if (status == eSDS_Ok)
    {
        [[JFLocalPlayer shareInstance] setLanchModel:model];
        [self clickStartBtn:nil];
    }else
    {
        [self removeChangeView];
        JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"无法连接网络。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
        av.tag = 111;
        [av show];
        [av release];
        
    }

    
}



@end
