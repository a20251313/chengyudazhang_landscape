//
//  JFAlertView.m
//  i366
//
//  Created by ran on 13-7-12.
//
//

#import "JFAlertView.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"
#import <QuartzCore/QuartzCore.h>

@implementation JFAlertView

@synthesize delegate;
@synthesize leftTitle;
@synthesize RightTitle;
@synthesize prompt;
@synthesize warningMsg;
@synthesize cancelButtonIndex;
@synthesize leftButtonIndex;
@synthesize rightButtonIndex;


/*UIAlertView  *av = [[UIAlertView alloc] initWithTitle:@"提示"
                                              message:@"放弃认证"
                                             delegate:self
                                    cancelButtonTitle:@"取消"
                                    otherButtonTitles:@"放弃", nil];*/




-(id)initWithTitle:(NSString *)strPrompt  message:(NSString *)strMsg  delegate:(id<JFAlertViewDeledate>)Jfdelegate cancelButtonTitle:(NSString *)strLeft otherButtonTitles:(NSString *)strRight
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        
        DLOG(@"alloc JFAlertView<<%p>>,tag:%d",self,self.tag);
        m_bIsWillRemove = NO;
        
        if (strLeft)
        {
            self.leftButtonIndex = JFAlertViewClickIndexLeft;
            self.cancelButtonIndex = JFAlertViewClickIndexLeft;
        }else
        {
            self.leftButtonIndex = JFAlertViewClickIndexNone;
            self.cancelButtonIndex = JFAlertViewClickIndexNone;
        }
        
        if (strRight)
        {
            self.rightButtonIndex = JFAlertViewClickIndexRight;
        }else
        {
            self.rightButtonIndex = JFAlertViewClickIndexNone;
        }
        
        self.delegate = Jfdelegate;
        self.leftTitle = strLeft;
        self.RightTitle = strRight;
        self.prompt = strPrompt;
        self.warningMsg = strMsg;
        [self defaultInit];
        
    }

    
    
    return self;
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
    CGRect  frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    [_overlayView setFrame:frame];
    [self setFrame:frame];
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
    [bg2View release];
    [bg1View release];
    
    
    
    
    UIImage  *imageTitle = [UIImage imageNamed:@"alert_title_notice.png"];
    
    
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake((_backgroundImageView.frame.size.width-imageTitle.size.width/2)/2, 0, imageTitle.size.width/2, imageTitle.size.height/2)];
    titleView.image = imageTitle;
    [_backgroundImageView addSubview:titleView];
    [titleView release];
    
    

    
    //NSString *content = [NSString stringWithFormat:@"使用1张%d秒免费体验卡，本次服务前%d秒将不产生费用，是否使用？", _card_mean, _card_mean];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake((_backgroundImageView.frame.size.width-205)/2,(_backgroundImageView.frame.size.height-121)/2-15, 205, 121)];
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.textColor = TEXTCOMMONCOLORSecond;
    _contentLabel.shadowColor = [UIColor whiteColor];
    _contentLabel.shadowOffset = CGSizeMake(245, 82);
    _contentLabel.text = self.warningMsg;
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = TEXTFONTWITHSIZE(17);
    _contentLabel.shadowColor = [UIColor whiteColor];
    _contentLabel.shadowOffset = CGSizeMake(0.5, 0.5);
    [_backgroundImageView addSubview:_contentLabel];
    
    
    
    
    if (self.leftTitle  && self.RightTitle)
    {
        _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(32+5, _backgroundImageView.frame.size.height-70, 92, 31)];
       // [_leftButton setTitle:self.leftTitle forState:UIControlStateNormal];
       // [_leftButton setTitleColor:[UIColor colorWithRed:61.0/255.0f green:61.0/255.0f blue:61.0/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
        [_leftButton setImage:[UtilitiesFunction getImageAccordTitle:self.leftTitle] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundImageView addSubview:_leftButton];
        
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(167-15, _backgroundImageView.frame.size.height-70, 92, 31)];
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
        [_rightButton setImage:[UtilitiesFunction getImageAccordTitle:self.RightTitle] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundImageView addSubview:_rightButton];
        
    }else
    {
        if (self.leftTitle)
        {
            _leftButton = [[UIButton alloc] initWithFrame:CGRectMake((_backgroundImageView.frame.size.width-92)/2, _backgroundImageView.frame.size.height-70, 92, 31)];
            // [_leftButton setTitle:self.leftTitle forState:UIControlStateNormal];
            // [_leftButton setTitleColor:[UIColor colorWithRed:61.0/255.0f green:61.0/255.0f blue:61.0/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [_leftButton setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
            [_leftButton setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
            [_leftButton setImage:[UtilitiesFunction getImageAccordTitle:self.leftTitle] forState:UIControlStateNormal];
            [_leftButton addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
            [_backgroundImageView addSubview:_leftButton];
            
        }else
        {
            _rightButton = [[UIButton alloc] initWithFrame:CGRectMake((_backgroundImageView.frame.size.width-92)/2, _backgroundImageView.frame.size.height-70, 92, 31)];
            [_rightButton setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
            [_rightButton setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
            [_rightButton setImage:[UtilitiesFunction getImageAccordTitle:self.RightTitle] forState:UIControlStateNormal];
            [_rightButton addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
            [_backgroundImageView addSubview:_rightButton];
            
            
        }
        
    }
    
    
  
    
}



-(void)addCloseButton
{
     UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 133+(iPhone5?44:0), 26, 26)];
     [closeButton setImage:[PublicClass getImageAccordName:@"use_card_close_default.png"] forState:UIControlStateNormal];
     [closeButton setImage:[PublicClass getImageAccordName:@"use_card_close_down.png"] forState:UIControlStateHighlighted];
     [closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
     [self addSubview:closeButton];
     [closeButton release];
    
}

- (void)show
{
    
    //  [self addobserverForBarOrientationNotification];
    //  UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    // CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    dispatch_async(dispatch_get_main_queue(), ^
    {
        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        // _overlayView.transform = CGAffineTransformMakeRotation(fValue);
        //  self.transform = CGAffineTransformMakeRotation(fValue);
        _overlayView.center = window.center;
        self.center = window.center;
        [window addSubview:_overlayView];
        [window addSubview:self];
    });
   
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
-(void)removeFromSuperview
{
    [super removeFromSuperview];
  //  NSLog(@"super removeFromSuperview ");
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

- (void)clickRightButton:(id)sender
{
    if (delegate  && [delegate respondsToSelector:@selector(JFAlertClickView:index:)])
    {
        [delegate JFAlertClickView:self index:JFAlertViewClickIndexRight];
    }
    [self dismiss];
    
}

- (void)clickLeftButton:(id)sender
{
    if (delegate  && [delegate respondsToSelector:@selector(JFAlertClickView:index:)])
    {
        [delegate JFAlertClickView:self index:JFAlertViewClickIndexLeft];
    }
      
    [self dismiss];
}



- (void)dismissWithClickedButtonIndex:(JFAlertViewClickIndex)buttonIndex animated:(BOOL)animated
{
    

    if (delegate  && [delegate respondsToSelector:@selector(dismissWithClickedButtonIndex:animated:)])
    {
        [delegate dismissWithClickedButtonIndex:buttonIndex animated:animated];
    }
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
    
    [_leftButton release];
    _leftButton = nil;
    
    [_rightButton release];
    _rightButton = nil;
    
    
    self.prompt = nil;
    self.leftTitle = nil;
    self.RightTitle = nil;
    self.warningMsg = nil;
    self.delegate = nil;
    
  
    
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
