//
//  JFMedalViewController.m
//  chengyuwar
//
//  Created by ran on 13-12-16.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFMedalViewController.h"
#import "PublicClass.h"
#import "JFLocalPlayer.h"
#import "JFAudioPlayerManger.h"
@interface JFMedalViewController ()

@end

@implementation JFMedalViewController

-(id)init
{
    self = [super init];
    if (self)
    {
        m_arrayNormal = [[NSMutableArray alloc] init];
        m_arrayRace = [[NSMutableArray alloc] init];
        
    }
    return self;
}

-(void)dealloc
{
    [m_labelInfo release];
    m_labelInfo = nil;
    [m_arrayNormal release];
    m_arrayNormal = nil;
    [m_arrayRace release];
    m_arrayRace = nil;
    [m_scrollViewNormal release];
    m_scrollViewNormal = nil;
    [m_scrollViewRace release];
    m_scrollViewRace = nil;
    [super dealloc];
}

-(void)addDataSource
{
    
    m_ihasGainMedals = 0;
    JFMedalModel  *model1 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyucainiao];
    JFMedalModel  *model2 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyudaren];
    JFMedalModel  *model3 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyugaoshou];
    JFMedalModel  *modeldashi = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyudashi];
    
    int maxlevel = [[JFLocalPlayer shareInstance] lastLevel];
    if (maxlevel >= 10)
    {
        model1.isGained = YES;
        m_ihasGainMedals++;
    }
    if (maxlevel >= 50)
    {
        model2.isGained = YES;
         m_ihasGainMedals++;
    }
    if (maxlevel >= 200)
    {
        model3.isGained = YES;
         m_ihasGainMedals++;
    }
    if (maxlevel >= 500)
    {
        modeldashi.isGained = YES;
         m_ihasGainMedals++;
    }
    
    
    /*
    JFMedalModel  *model4 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypezanlutoujiao];
    JFMedalModel  *model5 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypemingdongyifang];
    JFMedalModel  *model6 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypegaoshoujimo];
    JFMedalModel  *model7 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypetiaozhanzhiwang];
    JFMedalModel  *model8 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypeshirenzhan];
    JFMedalModel  *model9 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypebairenzhan];
    JFMedalModel  *model10 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypeqianrenzhan];

    

    int maxConwinnumber = [[JFLocalPlayer shareInstance] maxConWinNumber];
    if (maxConwinnumber >= 5)
    {
        model4.isGained = YES;
         m_ihasGainMedals++;
    }
    if (maxConwinnumber >= 15)
    {
        model5.isGained = YES;
         m_ihasGainMedals++;
    }
    if (maxConwinnumber >= 30)
    {
        model6.isGained = YES;
         m_ihasGainMedals++;
    }
    if (maxConwinnumber >= 50)
    {
        model7.isGained = YES;
         m_ihasGainMedals++;
    }
    
    
    int winNumber = [[JFLocalPlayer shareInstance] winNumber];
    if (winNumber >= 10)
    {
        model8.isGained = YES;
         m_ihasGainMedals++;
    }
    if (winNumber >= 100)
    {
        model9.isGained = YES;
         m_ihasGainMedals++;
    }
    if (winNumber >= 1000)
    {
        model10.isGained = YES;
         m_ihasGainMedals++;
    }

    
    
    
    

    
    
    [m_arrayNormal addObject:model1];
    [m_arrayNormal addObject:model2];
    [m_arrayNormal addObject:model3];
    [m_arrayNormal addObject:modeldashi];
    
    [m_arrayRace addObject:model4];
    [m_arrayRace addObject:model5];
    [m_arrayRace addObject:model6];
    [m_arrayRace addObject:model7];
    [m_arrayRace addObject:model8];
    [m_arrayRace addObject:model9];
    [m_arrayRace addObject:model10];*/
    
    
    [m_arrayNormal addObject:model1];
    [m_arrayNormal addObject:model2];
    [m_arrayNormal addObject:model3];
    [m_arrayNormal addObject:modeldashi];
    
    [model1 release];
    [model2 release];
    [model3 release];
    [modeldashi release];
}


-(void)addDataSourceTest
{
    
    m_ihasGainMedals = 0;
    JFMedalModel  *model1 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyucainiao];
    JFMedalModel  *model2 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyudaren];
    JFMedalModel  *model3 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyugaoshou];
    JFMedalModel  *modeldashi = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyudashi];
    
    int maxlevel = [[JFLocalPlayer shareInstance] lastLevel];
    if (maxlevel >= 5)
    {
        model1.isGained = YES;
        m_ihasGainMedals++;
    }
    if (maxlevel >= 10)
    {
        model2.isGained = YES;
        m_ihasGainMedals++;
    }
    if (maxlevel >= 15)
    {
        model3.isGained = YES;
        m_ihasGainMedals++;
    }
    if (maxlevel >= 20)
    {
        modeldashi.isGained = YES;
        m_ihasGainMedals++;
    }
    
    
    
    JFMedalModel  *model4 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypezanlutoujiao];
    JFMedalModel  *model5 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypemingdongyifang];
    JFMedalModel  *model6 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypegaoshoujimo];
    JFMedalModel  *model7 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypetiaozhanzhiwang];
    JFMedalModel  *model8 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypeshirenzhan];
    JFMedalModel  *model9 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypebairenzhan];
    JFMedalModel  *model10 = [[JFMedalModel alloc] initWithMedalType:JFMedalModelTypeqianrenzhan];
    
    
    
    int maxConwinnumber = [[JFLocalPlayer shareInstance] maxConWinNumber];
    if (maxConwinnumber >= 1)
    {
        model4.isGained = YES;
        m_ihasGainMedals++;
    }
    if (maxConwinnumber >= 3)
    {
        model5.isGained = YES;
        m_ihasGainMedals++;
    }
    if (maxConwinnumber >= 5)
    {
        model6.isGained = YES;
        m_ihasGainMedals++;
    }
    if (maxConwinnumber >= 7)
    {
        model7.isGained = YES;
        m_ihasGainMedals++;
    }
    
    
    int winNumber = [[JFLocalPlayer shareInstance] winNumber];
    if (winNumber >= 2)
    {
        model8.isGained = YES;
        m_ihasGainMedals++;
    }
    if (winNumber >= 4)
    {
        model9.isGained = YES;
        m_ihasGainMedals++;
    }
    if (winNumber >= 6)
    {
        model10.isGained = YES;
        m_ihasGainMedals++;
    }
    
    
    
    
    
    /*  model6.isGained = YES;
     model7.isGained = YES;
     model8.isGained = YES;
     model9.isGained = YES;
     model10.isGained = YES;*/
    
    
    [m_arrayNormal addObject:model1];
    [m_arrayNormal addObject:model2];
    [m_arrayNormal addObject:model3];
    [m_arrayNormal addObject:modeldashi];
    
    [m_arrayRace addObject:model4];
    [m_arrayRace addObject:model5];
    [m_arrayRace addObject:model6];
    [m_arrayRace addObject:model7];
    [m_arrayRace addObject:model8];
    [m_arrayRace addObject:model9];
    [m_arrayRace addObject:model10];
    
    [model1 release];
    [model2 release];
    [model3 release];
    [model4 release];
    [model5 release];
    [model6 release];
    [model7 release];
    [model8 release];
    [model9 release];
    [model10 release];
    [modeldashi release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)loadView
{
    [super loadView];
/*
#if USETESTDATA
     [self addDataSourceTest];
#else
     [self addDataSource];
#endif*/
    
    
    [self addDataSource];
    CGSize  size = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
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
    
    
    UIImageView  *bgView = [[UIImageView alloc] initWithFrame:CGRectMake((size.width-472)/2, 25, 472, 291)];
    bgView.image = [PublicClass getImageAccordName:@"check_scrollerbg.png"];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    [bgView release];
    
    
    UIImageView  *medalBg = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-406)/2, (bgView.frame.size.height-226)/2, 406, 228)];
    medalBg.image = [PublicClass getImageAccordName:@"medal_bg.png"];
    [bgView addSubview:medalBg];
    medalBg.userInteractionEnabled = YES;
    [medalBg release];
    
    
    
    
    UIImage  *imagetitle = [PublicClass getImageAccordName:@"medal_title.png"];
    UIImageView     *imagetitleView = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-imagetitle.size.width/2)/2, -10, imagetitle.size.width/2, imagetitle.size.height/2)];
    imagetitleView.image = imagetitle;
    [bgView addSubview:imagetitleView];
    [imagetitleView release];
    
    
    CGFloat  fYpoint = 20;
    CGFloat  fXpoint = 20;
   /* UIImageView    *imageTitleone = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint,fYpoint, 70, 20)];
    imageTitleone.image = [PublicClass getImageAccordName:@"medal_normal_title.png"];
    [medalBg addSubview:imageTitleone];
    [imageTitleone release];*/
    
    fYpoint += 60;
    if (!m_scrollViewNormal)
    {
        m_scrollViewNormal = [[UIScrollView alloc] initWithFrame:CGRectMake(fXpoint-10, fYpoint, medalBg.frame.size.width-fXpoint, 50)];
        m_scrollViewNormal.showsHorizontalScrollIndicator = NO;
        [medalBg addSubview:m_scrollViewNormal];
    }
    
    
    /*
    fYpoint += 50+20;
    UIImageView    *imageTitleTwo = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint,fYpoint, 70, 20)];
    imageTitleTwo.image = [PublicClass getImageAccordName:@"medal_race_words.png"];
    [medalBg addSubview:imageTitleTwo];
    [imageTitleTwo release];
    
    fYpoint += 20+10;
    if (!m_scrollViewRace)
    {
        m_scrollViewRace = [[UIScrollView alloc] initWithFrame:CGRectMake(fXpoint-10, fYpoint, medalBg.frame.size.width-fXpoint, 50)];
        m_scrollViewRace.showsHorizontalScrollIndicator = NO;
        [medalBg addSubview:m_scrollViewRace];
    }*/
    
    UIImageView  *imageScoreBg = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-155)/2, bgView.frame.size.height-45, 155, 25)];
    [imageScoreBg setImage:[PublicClass getImageAccordName:@"check_bottomword_bg.png"]];
    [bgView addSubview:imageScoreBg];
    [imageScoreBg release];
    
    if (!m_labelInfo)
    {
        m_labelInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, (imageScoreBg.frame.size.height-21)/2, imageScoreBg.frame.size.width, 21)];
        [m_labelInfo setTextColor:[UIColor colorWithRed:0x69*1.0/255.0 green:0x46*1.0/255.0 blue:0x2F*1.0/255.0 alpha:1]];
        [m_labelInfo setFont:TEXTFONTWITHSIZE(11)];
        [m_labelInfo setText:[NSString stringWithFormat:@"已完成成就%d/%d",m_ihasGainMedals,([m_arrayNormal count]+[m_arrayRace count])]];
        [m_labelInfo setBackgroundColor:[UIColor clearColor]];
        [m_labelInfo setTextAlignment:NSTextAlignmentCenter];
        [imageScoreBg addSubview:m_labelInfo];
    }
    [self refreshUserMedal];
}



-(void)refreshUserMedal
{
    
    if (![m_arrayRace count] || [m_arrayNormal count])
    {
        DLOG(@"refreshUserMedal fail,no data m_arrayRace:%@ m_arrayNormal :%@",m_arrayRace,m_arrayNormal);
    }
    
    
    CGFloat   fXsep = (m_scrollViewNormal.frame.size.width-50*4)/5;
    CGFloat   fXpoint = fXsep;
    for (int i = 0;i < [m_arrayNormal count];i++)
    {
        JFMedalView  *medalView = (JFMedalView*)[m_scrollViewNormal viewWithTag:1000+i];
        if (!medalView)
        {
            medalView = [[JFMedalView alloc] initWithFrame:CGRectMake(fXpoint, 0, 50, 50) withModel:[m_arrayNormal objectAtIndex:i]];
            [m_scrollViewNormal addSubview:medalView];
            medalView.delegate = self;
            [medalView release];
        }
        
        fXpoint += 50+fXsep;
    }
    
    [m_scrollViewNormal setContentSize:CGSizeMake(fXpoint, m_scrollViewNormal.frame.size.height)];
    
    
    /*
    fXpoint = 0;
    
    
    for (int i = 0;i < [m_arrayRace count];i++)
    {
        JFMedalView  *medalView = (JFMedalView*)[m_scrollViewNormal viewWithTag:1000+i];
        if (!medalView)
        {
            medalView = [[JFMedalView alloc] initWithFrame:CGRectMake(fXpoint, 0, 50, 50) withModel:[m_arrayRace objectAtIndex:i]];
            [m_scrollViewRace addSubview:medalView];
            medalView.delegate = self;
            [medalView release];
        }
        
        fXpoint += 50+fXsep;
    }
    
    [m_scrollViewRace setContentSize:CGSizeMake(fXpoint, m_scrollViewRace.frame.size.height)];*/
}


-(void)clickBackbtn:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  JFMedalViewDelegate
-(void)clickMedalMode:(JFMedalModel*)model
{
    
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];

    UIWindow    *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    for (JFMedalNoticeView *view in window.subviews)
    {
        if ([view isKindOfClass:[JFMedalNoticeView class]])
        {
            return;
        }
    }
    JFMedalNoticeView  *noticeview = [[JFMedalNoticeView alloc] initWithModel:model];
    [noticeview show];
    [noticeview release];
    
    DLOG(@"clickMedalMode:%@",model);
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
    
    
    //return UIInterfaceOrientationMaskLandscape;
    
    //  DLOG(@"supportedInterfaceOrientations :%d",UIInterfaceOrientationMaskLandscape);
    return  UIInterfaceOrientationMaskLandscape;
}


@end
