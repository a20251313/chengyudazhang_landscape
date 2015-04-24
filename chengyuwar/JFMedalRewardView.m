//
//  JFMedalRewardView.m
//  chengyuwar
//
//  Created by ran on 14-1-10.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFMedalRewardView.h"
#import "PublicClass.h"
#import "JFAudioPlayerManger.h"
#import "JFLocalPlayer.h"

@implementation JFMedalRewardView
@synthesize model;
@synthesize bHasOther;
@synthesize getType;

+(void)showMedalViewwithType:(JFMedalModelGetType)getType
{
    NSMutableArray  *array = [JFMedalModel getMedalModelArrayAccordtype:getType];
    if ([array count])
    {
        JFMedalRewardView   *view = [[JFMedalRewardView alloc] initWithModel:[array objectAtIndex:0]];
        
        if ([array count] > 1)
        {
            view.bHasOther = YES;
            view.getType = getType;
        }
        [view show];
        [view release];
       
    }
}

- (id)initWithModel:(JFMedalModel*)tempModel
{
    
    CGSize  size = [UIScreen mainScreen].bounds.size;
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    if (self)
    {
        
        self.model = tempModel;
        [self defaultInit];
        // Initialization code
    }
    return self;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_overlayView release];
    _overlayView = nil;
    [_backgroundImageView release];
    _backgroundImageView = nil;
    [_contentLabel release];
    _contentLabel = nil;
    self.model = nil;
    [super dealloc];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


- (void)defaultInit
{
    _overlayView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    CGRect  frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    [_overlayView setFrame:frame];
    [self setFrame:frame];
    _overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 237, 228)];
    _backgroundImageView.center = self.center;
    _backgroundImageView.image = [UIImage imageNamed:@"medal_notice_bg.png"];
    _backgroundImageView.userInteractionEnabled = YES;
    [self addSubview:_backgroundImageView];
    
    
    CGFloat   fwidth = 237-40;
    CGFloat   fheight = 228-70;
    UIView  *bg1View = [[UIView alloc] initWithFrame:CGRectMake((_backgroundImageView.frame.size.width-fwidth)/2, (_backgroundImageView.frame.size.height-fheight)/2+5, fwidth, fheight)];
    bg1View.backgroundColor = [UIColor colorWithRed:0xB7*1.0/255.0 green:0x8E*1.0/255.0 blue:0x66*1.0/255.0 alpha:1];
    [_backgroundImageView addSubview:bg1View];
    bg1View.layer.masksToBounds = YES;
    bg1View.layer.cornerRadius = 10;
    
    UIView  *bg2View = [[UIView alloc] initWithFrame:CGRectMake(8, 8, fwidth-16, fheight-16)];
    bg2View.backgroundColor = [UIColor colorWithRed:0xE5*1.0/255.0 green:0xC8*1.0/255.0 blue:0x9C*1.0/255.0 alpha:1];
    [bg1View addSubview:bg2View];
    bg2View.layer.masksToBounds = YES;
    bg2View.layer.cornerRadius = 10;
    
    
    
    
    
    UIImage  *imageTitle = [PublicClass getImageAccordName:model.medalNoticeTitleImageName];
    
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake((_backgroundImageView.frame.size.width-imageTitle.size.width/2)/2, 0, imageTitle.size.width/2, imageTitle.size.height/2)];
    titleView.image = imageTitle;
    [_backgroundImageView addSubview:titleView];
    [titleView release];
    
    
    
    
    self.model.isGained = YES;
    JFMedalView   *medalView = [[JFMedalView alloc] initWithFrame:CGRectMake(10, 40, 50, 50) withModel:self.model];
    [bg2View addSubview:medalView];
    [medalView release];
    
    //NSString *content = [NSString stringWithFormat:@"使用1张%d秒免费体验卡，本次服务前%d秒将不产生费用，是否使用？", _card_mean, _card_mean];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70,32, bg2View.frame.size.width-70, 60)];
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.textColor = TEXTCOMMONCOLORSecond;
    _contentLabel.shadowColor = [UIColor whiteColor];
    _contentLabel.shadowOffset = CGSizeMake(245, 82);
    _contentLabel.text = self.model.medalDesription;
    // _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.numberOfLines = 2;
    _contentLabel.font = TEXTFONTWITHSIZE(12);
    _contentLabel.shadowColor = [UIColor whiteColor];
    _contentLabel.shadowOffset = CGSizeMake(1, 1);
    [bg2View addSubview:_contentLabel];
    
    
    
    
    
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake((_backgroundImageView.frame.size.width-92)/2, _backgroundImageView.frame.size.height-70,92, 30)];
    // [_leftButton setTitle:self.leftTitle forState:UIControlStateNormal];
    // [_leftButton setTitleColor:[UIColor colorWithRed:61.0/255.0f green:61.0/255.0f blue:61.0/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
    [backbtn setImage:[PublicClass getImageAccordName:@"alert_gainward.png"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(clickGainMedealButton:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundImageView addSubview:backbtn];
    [backbtn release];
    
    
    [bg2View release];
    [bg1View release];
    
    
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
        [self setTransform:CGAffineTransformMakeRotation(-M_PI_2*3)];
    }else if (type == 3)
    {
        [self setTransform:CGAffineTransformMakeRotation(M_PI_2*3)];
    }
    DLOG(@"note:%@  note userInfo:%@",note,[note userInfo]);
}

- (void)show
{
    [self addobserverForBarOrientationNotification];
    UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
                       _overlayView.transform = CGAffineTransformMakeRotation(fValue);
                       self.transform = CGAffineTransformMakeRotation(fValue);
                       _overlayView.center = window.center;
                       self.center = window.center;
                       [window addSubview:_overlayView];
                       [window addSubview:self];
                   });
    
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeGainMedal];
    
}

-(void)clickGainMedealButton:(id)sender
{
    int addgoldNumber = self.model.rewardGold;
    [JFLocalPlayer addgoldNumber:addgoldNumber];
    [JFPlayAniManger addGoldWithAni:addgoldNumber];
    [JFMedalModel storeUserRewarded:YES type:self.model.medalType];

    
    if (bHasOther)
    {
        [JFMedalRewardView showMedalViewwithType:self.getType];
    }
        DLOG(@"clickBackButton:%@",sender);
    [_overlayView removeFromSuperview];
    [self removeFromSuperview];
    
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
