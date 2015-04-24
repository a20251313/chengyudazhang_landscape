//
//  JFShareWordView.m
//  chengyuwar
//
//  Created by ran on 13-12-27.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFShareWordView.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"
#import "JFAudioPlayerManger.h"

@implementation JFShareWordView
@synthesize delegate;
-(id)initWithFrame:(CGRect)frame
{
    
    frame = [UIScreen mainScreen].bounds;    
    self = [super initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.width)];

    if (self)
    {
        [self defaultInit];
    }
    
    return self;
}



-(void)defaultInit
{
    
    
    self.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    UIImageView  *bgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-280)/2, (self.frame.size.height-228)/2, 280, 211)];
    bgView.image = [PublicClass getImageAccordName:@"shareword_bg.png"];
    bgView.userInteractionEnabled = YES;
    bgView.clipsToBounds = YES;
    bgView.tag = 1000;
    [self addSubview:bgView];
    
    
    CGFloat   fwidth = 280-40;
    CGFloat   fheight = 211-50;
    
    UIImageView  *imageBg1 = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-fwidth)/2, (bgView.frame.size.height-fheight)/2+8, fwidth, fheight)];
    imageBg1.backgroundColor = BGCOLORFORFIRSTBG;
    imageBg1.userInteractionEnabled = YES;
    imageBg1.layer.masksToBounds = YES;
    imageBg1.layer.cornerRadius = 10;
    imageBg1.clipsToBounds = YES;
    [bgView addSubview:imageBg1];
    
    
    
    
    UIImageView *imagebg2 = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, fwidth-16, fheight-16)];
    imagebg2.backgroundColor = BGCOLORFORSECONDBG;
    imagebg2.userInteractionEnabled = YES;
    imagebg2.layer.masksToBounds = YES;
    imagebg2.layer.cornerRadius = 10;
    [imageBg1 addSubview:imagebg2];
    
    //CGFloat     fxpoint = 0;
    
    CGFloat     fyPoint = 5;
    UIImageView *imageviewbg = [[UIImageView alloc] initWithFrame:CGRectMake((imagebg2.frame.size.width-75)/2, fyPoint, 75, 50)];
    imageviewbg.image = [PublicClass getImageAccordName:@"shareword_imagebg.png"];
    [imagebg2 addSubview:imageviewbg];
    
    m_imageScreen = [[UIImageView alloc] initWithFrame:imageviewbg.bounds];
    m_imageScreen.image = nil;
    [imageviewbg addSubview:m_imageScreen];
    
    
    //check_gold_icon   27 15
    fyPoint += 5+50;
    UILabel    *labelFrom = [[UILabel alloc] initWithFrame:CGRectMake(0, fyPoint,imagebg2.frame.size.width, 17)];
    [labelFrom setTextColor:TEXTCOMMONCOLOR];
    [labelFrom setFont:TEXTFONTWITHSIZE(12)];
    [labelFrom setText:@"来自成语大战"];
    [labelFrom setTextAlignment:NSTextAlignmentCenter];
    [labelFrom setBackgroundColor:[UIColor clearColor]];
    [labelFrom setTextAlignment:NSTextAlignmentCenter];
    [imagebg2 addSubview:labelFrom];
    
    
    fyPoint +=  3+17;
    UIImageView *textBg = [[UIImageView alloc] initWithFrame:CGRectMake((imagebg2.frame.size.width-182)/2, fyPoint, 182, 25)];
    textBg.image = [PublicClass getImageAccordName:@"shareword_textbg.png"];
    [imagebg2 addSubview:textBg];
    textBg.userInteractionEnabled = YES;
    
    m_textWord = [[UITextField alloc] initWithFrame:CGRectMake(1, 3, 180, 21)];
    m_textWord.delegate = self;
    [m_textWord setFont:TEXTHEITIWITHSIZE(21)];
    [m_textWord setTextColor:TEXTCOMMONCOLORSecond];
    [textBg addSubview:m_textWord];
    
    
    UIButton    *btnShare = [[UIButton alloc] initWithFrame:CGRectMake((imagebg2.frame.size.width-92)/2+40, imagebg2.frame.size.height-36, 92, 31)];
    [btnShare setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
    [btnShare setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
    [btnShare setImage:[UtilitiesFunction getImageAccordTitle:@"分享"] forState:UIControlStateNormal];
    [btnShare addTarget:self action:@selector(clickShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    [imagebg2 addSubview:btnShare];
    
    
    
    UIButton    *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake((imagebg2.frame.size.width-92)/2-50, imagebg2.frame.size.height-36, 92, 31)];
    [btnCancel setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
    [btnCancel setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
    [btnCancel setImage:[UtilitiesFunction getImageAccordTitle:@"取消"] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [imagebg2 addSubview:btnCancel];
    
    
    /*
    
    UIImageView  *imageTitle = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-78)/2, 0, 78, 36)];
    imageTitle.image = [PublicClass getImageAccordName:@"alert_title_notice.png"];
    [bgView addSubview:imageTitle];*/
    

    [labelFrom release];
    [btnShare release];
    [btnCancel release];
    [imageBg1 release];
    [imagebg2 release];
    [bgView release];
    [imageviewbg release];
    [textBg release];
 //   [imageTitle release];
}

-(void)updateMsg:(NSString*)strMsg  UIImage:(UIImage*)image
{
    [m_textWord setText:strMsg];
    [m_imageScreen setImage:image];
}

-(void)clickShareBtn:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (delegate && [delegate respondsToSelector:@selector(shareWithMsg:image:)])
    {
        [delegate shareWithMsg:m_textWord.text image:m_imageScreen.image];
    }
    [self removeFromSuperview];
    
}

-(void)clickCancelBtn:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    [self removeFromSuperview];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [m_imageScreen release];
    [m_textWord release];
    m_imageScreen = nil;
    m_textWord = nil;
    [super dealloc];
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

-(void)show
{
    
    UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    [self addobserverForBarOrientationNotification];
    UIWindow  *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    self.center = window.center;
    self.transform = CGAffineTransformMakeRotation(fValue);
    [window addSubview:self];
}

#pragma mark uitextfielddelegate
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGRect  frame = [[UIScreen mainScreen] bounds];
    UIView  *view = [self viewWithTag:1000];
    [view setFrame:CGRectMake((frame.size.height-280)/2, (self.frame.size.width-228)/2-100, 280, 228)];
    DLOG(@"textFieldDidBeginEditing:%@",textField);
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    CGRect  frame = [[UIScreen mainScreen] bounds];
    UIView  *view = [self viewWithTag:1000];
    [view setFrame:CGRectMake((frame.size.height-280)/2, (frame.size.width-228)/2, 280, 228)];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect  frame = [[UIScreen mainScreen] bounds];
    UIView  *view = [self viewWithTag:1000];
    [view setFrame:CGRectMake((frame.size.height-280)/2, (frame.size.width-228)/2, 280, 228)];
    [textField resignFirstResponder];
    
}


@end
