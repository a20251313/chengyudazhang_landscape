//
//  JFConLoginView.m
//  i366
//
//  Created by ran on 13-10-21.
//
//

#import "JFUnlockView.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"
#import "JFAudioPlayerManger.h"
@implementation JFUnlockView
@synthesize level;
- (id)initWithFrame:(CGRect)frame withLevel:(int)templelel
{
    
    frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.width)];
    
    if (self)
    {
        self.level = templelel;
        //   CGRect  frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0.16 green:0.17 blue:0.25 alpha:0.5];
        self.userInteractionEnabled = YES;
         [self initView];
        //[self addTestdaa];
        // Initialization code
        
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
        UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
        CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
        self.transform = CGAffineTransformMakeRotation(fValue);
        self.center = window.center;
        [window addSubview:self];
        
        // DLOG(@"show window:%@  \n\nUIWindows:%@",window,[[UIApplication sharedApplication] windows]);
    });
    
    //  DLOG(@"show UIInterfaceOrientation:%d fValue:%f",type,fValue);
}




-(void)initView
{
    
    
    CGRect frame = [UIScreen mainScreen].bounds;
    if (m_bgView == nil)
    {
        m_bgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.height-280)/2, (frame.size.width-228)/2, 280, 228)];
        [self addSubview:m_bgView];
        m_bgView.image = [PublicClass getImageAccordName:@"alert_bg.png"];
        m_bgView.userInteractionEnabled = YES;
    }
    CGFloat fxpoint = 0;
    CGFloat fsep = 0;
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
        
        
        
        
        
        UIImageView     *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((imagebgsecond.frame.size.width-82)/2, 5, 82, 87)];
        imageView.image = [PublicClass getImageAccordName:@"con_frame_bg.png"];
        [imagebgsecond addSubview:imageView];
        
        
        UIImageView     *goldiconview = [[UIImageView alloc] initWithFrame:imageView.bounds];
        goldiconview.image = [PublicClass getImageAccordName:@"con_key.png"];
        [imageView addSubview:goldiconview];

        [goldiconview release];
        [imageView release];
        
        
        m_labelNotice = [[UILabel alloc] initWithFrame:CGRectMake(5, 87, imagebgsecond.frame.size.width-10, 40)];
        [m_labelNotice setBackgroundColor:[UIColor clearColor]];
        [m_labelNotice setText:@"需消耗3200金币即可解锁更多精彩关卡~"];//或支付￥6.00元
        [m_labelNotice setFont:TEXTFONTWITHSIZE(13)];
        [imagebgsecond addSubview:m_labelNotice];
        
        [m_labelNotice setTextColor:TEXTCOMMONCOLORSecond];
        [m_labelNotice setShadowColor:[UIColor whiteColor]];
        [m_labelNotice setNumberOfLines:2];
        [m_labelNotice setShadowOffset:CGSizeMake(1, 1)];
        
        
        fxpoint = m_littleBgView.frame.origin.x+(m_littleBgView.frame.size.width-92*2)/3;
        fsep = (m_littleBgView.frame.size.width-92*2)/3;
    }
    
    
    if (m_topView == nil)
    {
        m_topView = [[UIImageView alloc] initWithFrame:CGRectMake((m_bgView.frame.size.width-135)/2, 0, 135, 37)];
        m_topView.image = [PublicClass getImageAccordName:@"unlock_title.png"];
        [m_bgView addSubview:m_topView];
    }
    
    
    
    
    if (m_btnGetReward == nil)
    {
        m_btnGetReward = [[UIButton alloc] initWithFrame:CGRectMake(fxpoint+fsep+92, m_bgView.frame.size.height-45, 92, 31)];
        [m_btnGetReward setBackgroundImage:[PublicClass getImageAccordName:@"alert_btn_bg.png"] forState:UIControlStateNormal];
        [m_btnGetReward setBackgroundImage:[PublicClass getImageAccordName:@"alert_btn_bg_pressed.png"] forState:UIControlStateSelected];
        [m_btnGetReward setImage:[UtilitiesFunction getImageAccordTitle:@"立即解锁"] forState:UIControlStateNormal];
        [m_btnGetReward addTarget:self action:@selector(clickUnlock:) forControlEvents:UIControlEventTouchUpInside];
        [m_bgView addSubview:m_btnGetReward];
        
    }
    
    
    if (1)
    {
       UIButton  *btncancel = [[UIButton alloc] initWithFrame:CGRectMake(fxpoint, m_bgView.frame.size.height-45, 92, 31)];
        [btncancel setBackgroundImage:[PublicClass getImageAccordName:@"alert_btn_bg.png"] forState:UIControlStateNormal];
        [btncancel setBackgroundImage:[PublicClass getImageAccordName:@"alert_btn_bg_pressed.png"] forState:UIControlStateSelected];
        [btncancel setImage:[UtilitiesFunction getImageAccordTitle:@"取消"] forState:UIControlStateNormal];
        [btncancel addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
        [m_bgView addSubview:btncancel];
        [btncancel release];
        
    }
    
  
    
    //   [self loadArrayInfo:m_arrayData];
    
}


-(void)clickCancel:(id)sender
{
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    [self removeFromSuperview];
}


-(void)clickUnlock:(id)sender
{
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if ([[JFLocalPlayer shareInstance] goldNumber] < 3200)
    {
        
        NSString    *strMsg = [NSString stringWithFormat:@"金币不足，是否购买金币?"];
        JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示"
                                                     message:strMsg
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:@"购买"];
        av.tag = 8000;
        [av show];
        [av release];
        
      
        return;
        
        if (![UtilitiesFunction networkCanUsed])
        {
            JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示"
                                                         message:@"无法连接网络"
                                                        delegate:nil
                                               cancelButtonTitle:nil
                                               otherButtonTitles:@"我知道了"];
            [av show];
            [av release];
            return;
        }
        
        
        //com.17cb.cyunlockmore
        //com.17cb.cymore
        JFChargeProductModel    *model = [JFChargeProductModel productWithType:JFChargeProductModelTypeUnlock productID:@"com.17cb.cymore" value:1000 money:6 title:@"6" description:@"6"];
        if (!m_chargeNet)
        {
            m_chargeNet = [[JFChargeNet alloc] init];
            m_chargeNet.delegate =  self;
        }
        
        [self showProgress];
        [m_chargeNet requestChanel:model];
        return;
    }else
    {
        [JFLocalPlayer deletegoldNumber:3200];
        [JFPlayAniManger deleteGoldWithAni:3200];
        [JFSQLManger updatePuchased:1 accordLevel:self.level];
        [self performSelector:@selector(addGoldAni) withObject:nil afterDelay:1.0];
        
    }
    


    
      DLOG(@"clickGetReward:%@",sender);
    
}

-(void)addGoldAni
{
    [JFLocalPlayer addgoldNumber:1000];
    [JFPlayAniManger addGoldWithAni:1000];
    [self removeFromSuperview];
}


#pragma mark JFChargeCellDelegate
-(void)chargeProductModel:(JFChargeProductModel*)model
{
    
    
 
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


#pragma mark
-(void)getPayIDFail:(NSDictionary*)dicInfo
{
    [self hideProgress];
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"获取订单号失败，请稍后再试！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定"];
    [av show];
    [av release];
    
    
}
-(void)chargeGoldSuc:(JFChargeProductModel*)model
{
    [self hideProgress];
    [JFLocalPlayer addgoldNumber:model.productValue];
    
    [[JFLocalPlayer shareInstance] setIsPayedUser:YES];
    [JFSQLManger UpdateUserInfoToDB:[JFLocalPlayer shareInstance]];
    NSString    *strMsg = [NSString stringWithFormat:@"充值成功，成功获得%0.0f金币",model.productValue];
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:strMsg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定"];
    [av show];
    [av release];
    
    
    [JFPlayAniManger addGoldWithAni:model.productValue];
    
}
-(void)chargeGoldFail:(int )status
{
    [self hideProgress];
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"充值失败！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定"];
    [av show];
    [av release];
    
}

-(void)networkOccurError:(NSString*)statusCode
{
    [self hideProgress];
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"无法连接网络!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
    [av show];
    [av release];
    
}
-(void)getShopListInAppStoreSuccess:(id)thread
{
}
-(void)getShopListInAppStoreFail:(id)Thread
{
    [self hideProgress];
    
    if ([Thread isKindOfClass:[NSError class]])
    {
        NSError *error = (NSError*)(Thread);
        if ([error code] == 0)
        {
            JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"无法连接到 iTunes Store!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定"];
            [av show];
            [av release];
            return;
            
        }
    }
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"获取商品列表失败！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定"];
    [av show];
    [av release];
    
}


-(void)getServerRemainChargeFail:(int)status
{
    [self hideProgress];
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"充值失败！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定"];
    [av show];
    [av release];
    
}
-(void)getServerRemainChargeSuc:(int)goldNum isFirstCharge:(BOOL)isfirstCharge
{
    [self hideProgress];
    
    if (isfirstCharge)
    {
        goldNum += 800;
    }
    
    goldNum = 1000;
    [JFLocalPlayer addgoldNumber:1000];
    [[JFLocalPlayer shareInstance] setIsPayedUser:YES];
    [JFSQLManger UpdateUserInfoToDB:[JFLocalPlayer shareInstance]];
    [JFSQLManger updatePuchased:1 accordLevel:self.level];
    //[JFYouMIManger removeYouMiView];
    NSString    *strMsg = [NSString stringWithFormat:@"充值成功，成功解锁更多关卡！"];
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:strMsg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定"];
    [av show];
    [av release];
    [JFPlayAniManger addGoldWithAni:goldNum];
    
}


#pragma mark JFAlertViewDelegate
-(void)JFAlertClickView:(JFAlertView *)alertView index:(JFAlertViewClickIndex)buttonIndex
{
    
    if (alertView.tag == 8000)
    {
        
        if (buttonIndex == JFAlertViewClickIndexRight)
        {
            JFChargeView    *chagreView = [[JFChargeView alloc] initWithFrame:CGRectZero];
            [chagreView show];
            [chagreView release];
        }
      
    }
   
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

    [m_littleBgView release];
    m_littleBgView = nil;
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
