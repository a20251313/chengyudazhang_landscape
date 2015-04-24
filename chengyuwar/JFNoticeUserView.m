//
//  JFNoticeUserView.m
//  chengyuwar
//
//  Created by ran on 13-12-18.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFNoticeUserView.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"
#import "JFAudioPlayerManger.h"
#import <QuartzCore/QuartzCore.h>


@implementation JFNoticeUserView
@synthesize message;

-(id)initWithmessage:(NSString *)strMsg
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        
        DLOG(@"alloc JFNoticeUserView<<%p>>,tag:%d",self,self.tag);
        m_bIsWillRemove = NO;
        self.message = strMsg;
        [self defaultInit];
        
        // [self addobserverForBarOrientationNotification];
        
    }
    
    
    
    return self;
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
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)defaultInit
{
    _overlayView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    CGRect  mainframe = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    [_overlayView setFrame:mainframe];
    [self setFrame:mainframe];
    _overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 228)];
    _backgroundImageView.center = self.center;
    _backgroundImageView.image = [UIImage imageNamed:@"alert_bg.png"];
    _backgroundImageView.userInteractionEnabled = YES;
    [self addSubview:_backgroundImageView];
    
    
    CGFloat   fwidth = 280-40;
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
 
    
    
    
    
    UIImage  *imageTitle = [UIImage imageNamed:@"alert_notice_title.png"];
    
    
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake((_backgroundImageView.frame.size.width-imageTitle.size.width/2)/2, 0, imageTitle.size.width/2, imageTitle.size.height/2)];
    titleView.image = imageTitle;
    [_backgroundImageView addSubview:titleView];
    [titleView release];
    
    
    
    
    //NSString *content = [NSString stringWithFormat:@"使用1张%d秒免费体验卡，本次服务前%d秒将不产生费用，是否使用？", _card_mean, _card_mean];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10, bg2View.frame.size.width-20, bg2View.frame.size.height-30)];
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.textColor = [UIColor colorWithRed:0x59*1.0/255.0f green:0x37*1.0/255.0f blue:0x22*1.0f/255.0f alpha:1.0f];
    _contentLabel.shadowColor = [UIColor whiteColor];
    _contentLabel.shadowOffset = CGSizeMake(245, 82);
    _contentLabel.text = self.message;
   // _contentLabel.textAlignment = UITextAlignmentCenter;
    _contentLabel.numberOfLines = 13;
    _contentLabel.font = TEXTFONTWITHSIZE(15);
    
    _contentLabel.shadowColor = [UIColor whiteColor];
    _contentLabel.shadowOffset = CGSizeMake(0.5, 0.5);
    [bg2View addSubview:_contentLabel];
    
    
    
    
   
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake((bg2View.frame.size.width-92)/2, bg2View.frame.size.height-12, 92, 31)];
    [_backButton setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
    [_backButton setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
    [_backButton setImage:[UtilitiesFunction getImageAccordTitle:@"确定"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(clickbackButton:) forControlEvents:UIControlEventTouchUpInside];
    CGRect  frame = [self convertRect:_backButton.frame fromView:bg2View];
    [_backButton setFrame:frame];
    [self addSubview:_backButton];
    [bg2View release];
    [bg1View release];
   
    
}

- (void)show
{
    
    // UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    //CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
                       //  _overlayView.transform = CGAffineTransformMakeRotation(fValue);
                       // self.transform = CGAffineTransformMakeRotation(fValue);
                       _overlayView.center = window.center;
                       self.center = window.center;
                       [window addSubview:_overlayView];
                       [window addSubview:self];
                   });
    
}


- (void)dismiss
{
    
    if (m_bIsWillRemove)
    {
        return;
    }
    
    m_bIsWillRemove = YES;
    
    [_overlayView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)clickbackButton:(id)sender
{

     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    [self dismiss];
    
}




- (void)dealloc
{
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    DLOG(@"JFAlertView<%p> dealloc",self);
    [_overlayView release];
    _overlayView = nil;
    
    [_backgroundImageView release];
    _backgroundImageView = nil;
    
    [_contentLabel release];
    _contentLabel = nil;
    
    [_backButton release];
    _backButton = nil;
    
    self.message = nil;
    

    
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

@end
