//
//  JFExchangeView.m
//  chengyuwar
//
//  Created by ran on 14-1-9.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFExchangeView.h"
#import "PublicClass.h"
#import "JFAudioPlayerManger.h"
#import "UtilitiesFunction.h"
#import "JFLocalPlayer.h"
#import "MBProgressHUD.h"
#import "iToast.h"
@implementation JFExchangeView

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
    UIImageView  *bgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-280)/2, (self.frame.size.height-228)/2-5, 280, 228)];
    bgView.image = [PublicClass getImageAccordName:@"shareword_bg.png"];
    bgView.userInteractionEnabled = YES;
    bgView.clipsToBounds = NO;
    bgView.tag = 1000;
    [self addSubview:bgView];
    
    
    CGFloat   fwidth = 280-40;
    CGFloat   fheight = 228-60;
    
    UIImageView  *imageBg1 = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-fwidth)/2, (bgView.frame.size.height-fheight)/2, fwidth, fheight)];
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
    
  
    UIImageView *textBg = [[UIImageView alloc] initWithFrame:CGRectMake((imagebg2.frame.size.width-182)/2, (imagebg2.frame.size.height-25)/2-15, 182, 25)];
    textBg.image = [PublicClass getImageAccordName:@"shareword_textbg.png"];
    [imagebg2 addSubview:textBg];
    textBg.userInteractionEnabled = YES;
    
    m_textWord = [[UITextField alloc] initWithFrame:CGRectMake(1, 3, 180, 21)];
    m_textWord.delegate = self;
    [m_textWord setFont:TEXTHEITIWITHSIZE(16)];
    [m_textWord setTextColor:TEXTCOMMONCOLORSecond];
    [m_textWord setPlaceholder:@"请输入兑换码!"];
    [textBg addSubview:m_textWord];
    
    
    UIButton    *btnShare = [[UIButton alloc] initWithFrame:CGRectMake((imagebg2.frame.size.width-2*92)/3*2+92, imagebg2.frame.size.height-36, 92, 31)];
    [btnShare setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
    [btnShare setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
    [btnShare setImage:[PublicClass getImageAccordName:@"exchange_word.png"] forState:UIControlStateNormal];
    [btnShare addTarget:self action:@selector(clickExchangeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [imagebg2 addSubview:btnShare];
    
    
    
    UIButton    *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake((imagebg2.frame.size.width-2*92)/3, imagebg2.frame.size.height-36, 92, 31)];
    [btnCancel setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
    [btnCancel setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
    [btnCancel setImage:[UtilitiesFunction getImageAccordTitle:@"取消"] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [imagebg2 addSubview:btnCancel];
    
    
    
    UIImageView  *imageTitle = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-100)/2, -10, 100, 36)];
    imageTitle.image = [PublicClass getImageAccordName:@"exchange_title.png"];
   [bgView addSubview:imageTitle];
    
  //  CGRect  frame = [self convertRect:imageTitle.frame fromView:bgView];
    //[imageTitle setFrame:frame];
  //  [self addSubview:imageTitle];
    /*
     
     UIImageView  *imageTitle = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-78)/2, 0, 78, 36)];
     imageTitle.image = [PublicClass getImageAccordName:@"alert_title_notice.png"];
     [bgView addSubview:imageTitle];*/
    
    

    [btnShare release];
    [btnCancel release];
    [imageBg1 release];
    [imagebg2 release];
    [bgView release];
    [textBg release];
    [imageTitle release];
    //   [imageTitle release];
}

-(void)updateMsg:(NSString*)strMsg  UIImage:(UIImage*)image
{
    [m_textWord setText:strMsg];

}

-(void)clickExchangeBtn:(id)sender
{
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (!m_textWord.text || [m_textWord.text isEqualToString:@""])
    {
        
        return;
    }
    
    if (!m_exchangeNet)
    {
        m_exchangeNet = [[JFExchangeNet alloc] init];
        m_exchangeNet.delegate = self;
    }
    
    [m_exchangeNet requestExchangeCode:[[JFLocalPlayer shareInstance] userID] exchangeCode:m_textWord.text ];
    [m_textWord endEditing:YES];
   /* if (delegate && [delegate respondsToSelector:@selector(shareWithMsg:image:)])
    {
        [delegate shareWithMsg:m_textWord.text image:m_imageScreen.image];
    }*/
  //  [self removeFromSuperview];
    
}

-(void)clickCancelBtn:(id)sender
{
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    [self removeFromSuperview];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    m_exchangeNet.delegate = nil;
    [m_exchangeNet release];
    m_exchangeNet = nil;
    [m_textWord release];
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
    [textField setTextColor:TEXTCOMMONCOLORSecond];
    
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


//-(void)getExchangeCoderesult:(int)status addNumber:(int)addnumber
//{
//    if (status == 1)
//    {
//        [JFLocalPlayer addgoldNumber:addnumber];
//        iToast  *toast = [[iToast alloc] initWithText:@"兑换成功"];
//        [toast show];
//        [toast release];
//        
//        [self removeFromSuperview];
//    }else if(status == eSDS_HttpVerifyExchangeCodeFailed)
//    {
//        
//        
//        [m_textWord setTextColor:[UIColor redColor]];
//        /*
//        JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"验证码过期。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定"];
//        [av show];
//        [av release];*/
//    }else
//    {
//        [m_textWord setTextColor:[UIColor redColor]];
//    }
//}
-(void)networkOccurError:(NSString*)statusCode
{
    [self hideProgress];
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"无法连接网络。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
    [av show];
    [av release];
}


-(void)showProgress
{
    MBProgressHUD  *progress = [[MBProgressHUD alloc] initWithView:self];
    progress.labelText = @"充值中,请稍后.......";
    [self addSubview:progress];
    [progress show:YES];
    [progress release];
}

-(void)hideProgress
{
    for (UIView *view in self.subviews)
    {
        if ([view isKindOfClass:[MBProgressHUD class]])
        {
            [view removeFromSuperview];
        }
    }
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
