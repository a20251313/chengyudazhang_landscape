//
//  JFConLoginView.m
//  i366
//
//  Created by ran on 13-10-21.
//
//

#import "JFConLoginView.h"
#import "UtilitiesFunction.h"
#import "JFAudioPlayerManger.h"

@implementation JFConLoginView
@synthesize vipType = m_iType;
@synthesize delegate;
@synthesize conLogInDays;
- (id)initWithFrame:(CGRect)frame
{
 
    frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
    if (self)
    {
        
        m_arrayData = [[NSMutableArray alloc] init];
     //   CGRect  frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0.16 green:0.17 blue:0.25 alpha:0.5];
        self.userInteractionEnabled = YES;
        
        //[self addTestdaa];
        // Initialization code

    }
    return self;
}


-(void)loadAfterGainReward
{
    [self removeFromSuperview];
}


-(void)loadWholeWithVip:(JFUserVIPType)TempvipType nextSignID:(int)TempnextSignID withArray:(NSMutableArray *)arrayInfo
{

    [m_arrayData removeAllObjects];
    [m_arrayData addObjectsFromArray:arrayInfo];
    

    [self initView];
    
}
-(void)clickSelf:(id)sender
{
    
}


-(void)addobserverForBarOrientationNotification
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeInterface:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}
-(void)changeInterface:(NSNotification*)note
{
    return;
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
    

    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        
        if (CURRENTVERSIONNUMBER < 6.0)
        {
            for (UIAlertView *av in window.subviews)
            {
                if ([av isKindOfClass:[UIAlertView class]])
                {
                    [av dismissWithClickedButtonIndex:0 animated:YES];
                    DLOG(@"dismissWithClickedButtonIndex:0");
                }
            }
        }
        
       
        [self addobserverForBarOrientationNotification];
        //  UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
        //CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
        //self.transform = CGAffineTransformMakeRotation(fValue);
        self.center = window.center;
        [window addSubview:self];
        
       // DLOG(@"show window:%@  \n\nUIWindows:%@",window,[[UIApplication sharedApplication] windows]);
    });
   
  //  DLOG(@"show UIInterfaceOrientation:%d fValue:%f",type,fValue);
}



-(void)addTestdaa
{
    for (int i = 0; i < 5; i++)
    {
        JFConLoginModel  *model = [[JFConLoginModel alloc] init];
        model.reward_value = 100+i;
        [m_arrayData addObject:model];
        [model release];
    }
    
}

-(void)initView
{
    
    
    CGRect frame = [UIScreen mainScreen].bounds;
    if (m_bgView == nil)
    {
        m_bgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-280)/2, (frame.size.height-228)/2, 280, 228)];
        [self addSubview:m_bgView];
        m_bgView.image = [PublicClass getImageAccordName:@"alert_bg.png"];
        m_bgView.userInteractionEnabled = YES;
    }
 
    if (m_littleBgView == nil)
    {
        CGFloat  fwidth = 280-60;
        CGFloat  fheight = 228-80;
        m_littleBgView = [[UIImageView alloc] initWithFrame:CGRectMake((m_bgView.frame.size.width-fwidth)/2, (m_bgView.frame.size.height-fheight)/2+10, fwidth, fheight)];
        m_littleBgView.backgroundColor = BGCOLORFORFIRSTBG;
        m_littleBgView.layer.masksToBounds = YES;
        m_littleBgView.layer.cornerRadius = 10;
        
        UIImageView  *imagebgsecond = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, fwidth-16, fheight-16)];
        imagebgsecond.backgroundColor = BGCOLORFORSECONDBG;
        imagebgsecond.layer.masksToBounds = YES;
        imagebgsecond.layer.cornerRadius = 10;
        
        [m_littleBgView addSubview:imagebgsecond];
        
       
        [imagebgsecond release];
       // m_littleBgView.image = [PublicClass getImageAccordName:@"con_login_bg.png"];
        [m_bgView addSubview:m_littleBgView];
        
        
        
        
        
        UIImageView     *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((imagebgsecond.frame.size.width-82)/2, 10, 82, 87)];
        imageView.image = [PublicClass getImageAccordName:@"con_frame_bg.png"];
        [imagebgsecond addSubview:imageView];
        
        
        UIImageView     *goldiconview = [[UIImageView alloc] initWithFrame:imageView.bounds];
        goldiconview.image = [PublicClass getImageAccordName:@"con_login_box.png"];
        [imageView addSubview:goldiconview];
        
        
        
        UIImageView     *goldbgview = [[UIImageView alloc] initWithFrame:CGRectMake((imagebgsecond.frame.size.width-72)/2, 10+87+5, 72, 15)];
        goldbgview.image = [PublicClass getImageAccordName:@"200gold_word.png"];
        [imagebgsecond addSubview:goldbgview];
        
        [goldbgview release];
        [goldiconview release];
        [imageView release];

    }
    
    
    if (m_topView == nil)
    {
        m_topView = [[UIImageView alloc] initWithFrame:CGRectMake((m_bgView.frame.size.width-135)/2, 0, 135, 37)];
        m_topView.image = [PublicClass getImageAccordName:@"con_login_title.png"];
        [m_bgView addSubview:m_topView];
    }
    
  
    
    if (m_btnGetReward == nil)
    {
        m_btnGetReward = [[UIButton alloc] initWithFrame:CGRectMake((m_bgView.frame.size.width-92)/2, m_bgView.frame.size.height-45, 92, 31)];
        [m_btnGetReward setBackgroundImage:[PublicClass getImageAccordName:@"alert_btn_bg.png"] forState:UIControlStateNormal];
        [m_btnGetReward setBackgroundImage:[PublicClass getImageAccordName:@"alert_btn_bg_pressed.png"] forState:UIControlStateSelected];
        [m_btnGetReward setImage:[UtilitiesFunction getImageAccordTitle:@"领取奖励"] forState:UIControlStateNormal];
        [m_btnGetReward addTarget:self action:@selector(clickGetReward:) forControlEvents:UIControlEventTouchUpInside];
        [m_bgView addSubview:m_btnGetReward];
        
    }
    
 //   [self loadArrayInfo:m_arrayData];

}


-(void)loadArrayInfo:(NSMutableArray *)array
{
    for (UIView  *view in m_littleBgView.subviews)
    {
        if ([view isEqual:m_littleBgView])
        {
            continue;
        }
       // [view removeFromSuperview];
        
    }
    
 //   int rowCount = 5;
  //  CGFloat   fwidth = m_littleBgView.frame.size.width;
    CGFloat   fSingleWidth = 66;
    CGFloat   fsingHeight = 71;
    CGFloat  fXpoint = 0;
    CGFloat  fYpoint = 30;
    
    CGFloat  fsep =  8;//(fwidth-fSingleWidth*rowCount)/(rowCount+1);
    fsep = 8;
    for (int i = 0; i < [array count] ; i++)
    {
        
        JFConLoginModel  *model = [m_arrayData objectAtIndex:i];
         fXpoint = 14 +(fSingleWidth+fsep)*i;
        
        int  rewardValue = model.reward_value;
        
        JFRewardView  *singView = [[JFRewardView alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, fSingleWidth, fsingHeight) withType:model.rewardType withDay:model.day withScroes:rewardValue];
        [m_littleBgView addSubview:singView];
        [singView release];
        
    }
    
    
    
}


-(int)getRewardNumber
{
    for (JFConLoginModel  *model in m_arrayData)
    {
        if (model.rewardType == JFRewardTypeWillGet)
        {
            return model.reward_value;
        }
    }
    return 0;
}
-(int)getConLoginDays
{
    for (JFConLoginModel  *model in m_arrayData)
    {
        if (model.rewardType == JFRewardTypeWillGet)
        {
            return [m_arrayData indexOfObject:model]+1;
        }
    }
    return 0;
}

-(void)clickUpgrade:(id)sender
{
    
    if (delegate && [delegate respondsToSelector:@selector(GotoChareCenter:)])
    {
        [delegate GotoChareCenter:sender];
    }
    
    DLOG(@"clickUpgrade:%@",sender);
}

-(void)clickGetReward:(id)sender
{
   
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (delegate  && [delegate respondsToSelector:@selector(sendGetReward:)])
    {
        [delegate sendGetReward:self];
    }
    
    DLOG(@"clickGetReward:%@",sender);
    [self removeFromSuperview];
  
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [m_bgView release];
    m_bgView = nil;
    [m_topView release];
    m_topView = nil;
    [m_labelNotice release];
    m_labelNotice = nil;
    
    [m_btnGetReward release];
    m_btnGetReward = nil;
    
    [m_btnUpgread release];
    m_btnUpgread = nil;
    
    [m_littleBgView release];
    m_littleBgView = nil;
    
    self.delegate = nil;
    [m_arrayData release];
    m_arrayData = nil;
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
