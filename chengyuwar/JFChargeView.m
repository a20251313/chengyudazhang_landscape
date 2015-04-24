//
//  JFChargeView.m
//  chengyuwar
//
//  Created by ran on 13-12-14.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFChargeView.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"
#import "JFLocalPlayer.h"
#import "JFSQLManger.h"
#import "JFAudioPlayerManger.h"
@implementation JFChargeView

- (id)initWithFrame:(CGRect)frame
{
    frame = [UIScreen mainScreen].bounds;
    
    self = [super initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    if (self)
    {
        m_arrayData = [[NSMutableArray alloc] init];
        [self defaultInit];
        
        // Initialization code
    }
    
    return self;
}




-(void)addDatasource
{
    
    
    
    JFChargeProductModel  *model6 = [JFChargeProductModel productWithType:JFChargeProductModelTypeDefault productID:@"com.17cb.cy300gold" value:300 money:6 title:@"" description:@"300金币"];
    JFChargeProductModel  *model12 = [JFChargeProductModel productWithType:JFChargeProductModelTypeDefault productID:@"com.17cb.cy780gold" value:780 money:12 title:@"" description:@"780金币"];
    JFChargeProductModel  *model30 = [JFChargeProductModel productWithType:JFChargeProductModelTypeDefault productID:@"com.17cb.cy2000gold" value:2000 money:30 title:@"" description:@"2000金币"];
    JFChargeProductModel  *model128 = [JFChargeProductModel productWithType:JFChargeProductModelTypeDefault productID:@"com.17cb.cy9600gold" value:9600 money:128 title:@"" description:@"9600金币"];
    JFChargeProductModel  *model328 = [JFChargeProductModel productWithType:JFChargeProductModelTypeDefault productID:@"com.17cb.cy40000gold" value:40000 money:328 title:@"" description:@"40000金币"];
    JFChargeProductModel    *model = [[JFChargeProductModel alloc] init];
    model.productType = JFChargeProductModelTypeExchange;
    
    [m_arrayData addObject:model6];
    [m_arrayData addObject:model12];
    [m_arrayData addObject:model30];
    [m_arrayData addObject:model128];
    [m_arrayData addObject:model328];
 //   [m_arrayData addObject:model];
    [model release];
    [m_tableView reloadData];
}
-(void)defaultInit
{
    
    
    self.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    
    UIImageView  *bgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-386)/2, (self.frame.size.height-282)/2, 386, 282)];
    bgView.image = [PublicClass getImageAccordName:@"charge_frame_bg.png"];
    bgView.userInteractionEnabled = YES;
    bgView.clipsToBounds = YES;
    [self addSubview:bgView];
    
    
    CGFloat   fwidth = 386-60;
    CGFloat   fheight = 286-100;
    
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
    
    
    /*
    UIImageView *viewicon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 22, 88, 75)];
    viewicon.image = [PublicClass getImageAccordName:@"charge_shouchongicon.png"];
    viewicon.userInteractionEnabled = YES;
    [bgView addSubview:viewicon];
    [viewicon release];*/
    
    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, imagebg2.frame.size.width, imagebg2.frame.size.height)];
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    [m_tableView setBackgroundColor:[UIColor clearColor]];
    [m_tableView setBackgroundView:nil];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [imagebg2 addSubview:m_tableView];
    
    
    UIButton    *btnBack = [[UIButton alloc] initWithFrame:CGRectMake((bgView.frame.size.width-92)/2, bgView.frame.size.height-42-15, 92, 31)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
    [btnBack setImage:[UtilitiesFunction getImageAccordTitle:@"返回"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(clickbackButton:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnBack];
    
    
    UIImageView  *imageTitle = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-67)/2, 0, 67, 36)];
    imageTitle.image = [PublicClass getImageAccordName:@"charge_title.png"];
    [bgView addSubview:imageTitle];
    
    
    
    UILabel *labeladwarn = [[UILabel alloc] initWithFrame:CGRectMake(0, imageBg1.frame.origin.y, bgView.frame.size.width, 16)];
 //   [labeladwarn setText:@"成功充值，即可去除广告"];
    [labeladwarn setBackgroundColor:[UIColor clearColor]];
    [labeladwarn setTextAlignment:NSTextAlignmentCenter];
    [labeladwarn setTextColor:[UIColor colorWithRed:0xE8*1.0/255.0 green:0 blue:0 alpha:1]];
    labeladwarn.shadowColor = TEXTCOMMONCOLORSecond;
    labeladwarn.shadowOffset = CGSizeMake(1, 1);
    [labeladwarn setFont:TEXTFONTWITHSIZE(13)];
    [bgView addSubview:labeladwarn];
    
    
    [btnBack release];
    [imageBg1 release];
    [imagebg2 release];
    [bgView release];
    [imageTitle release];
    [labeladwarn release];
    
    
    
 
    
    [self addDatasource];
}


-(void)clickExchange:(id)sender
{
    JFExchangeView *changeView = [[JFExchangeView alloc] initWithFrame:CGRectZero];
    [changeView show];
    [changeView release];
    DLOG(@"clickExchange:%@",sender);
}
-(void)clickbackButton:(id)sender
{
    
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    DLOG(@"clickbackButton:%@",sender);
    [self removeFromSuperview];

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
    
    // UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    //CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    // [self addobserverForBarOrientationNotification];
    UIWindow  *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    self.center = window.center;
    //self.transform = CGAffineTransformMakeRotation(fValue);
    [window addSubview:self];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [m_tableView release];
    m_tableView = nil;
    [m_chargeNet release];
    m_chargeNet = nil;
    [m_arrayData release];
    m_arrayData = nil;
    [super dealloc];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_arrayData count];
    //UIFont
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JFChargeCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"11"];
    if (!cell)
    {
        cell = [[[JFChargeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"11"] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell updateDataWithModel:[m_arrayData objectAtIndex:indexPath.row]];
    
    [cell.contentView setBackgroundColor:indexPath.row%2 == 0?TABLECELLCOLORFORFIRSTBG:TABLECELLCOLORFORSECONDEBG];
    cell.delegate = self;
    return cell;
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

#pragma mark JFChargeCellDelegate
-(void)chargeProductModel:(JFChargeProductModel*)model
{
    
    
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
    if (model.productType == JFChargeProductModelTypeExchange)
    {
        [self clickExchange:nil];
        return;
    }
    if (!m_chargeNet)
    {
        m_chargeNet = [[JFChargeNet alloc] init];
        m_chargeNet.delegate = self;
    }
    
  
    [self showProgress];
    [m_chargeNet requestChanel:model];
    
  DLOG(@"chargeProductModel:%@",model);
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
    [JFLocalPlayer addgoldNumber:goldNum];
    [[JFLocalPlayer shareInstance] setIsPayedUser:YES];
    [JFSQLManger UpdateUserInfoToDB:[JFLocalPlayer shareInstance]];
   //[JFYouMIManger removeYouMiView];
    NSString    *strMsg = [NSString stringWithFormat:@"充值成功，成功获得%0.0d金币",goldNum];
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:strMsg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定"];
    [av show];
    [av release];
    [JFPlayAniManger addGoldWithAni:goldNum];
    
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
