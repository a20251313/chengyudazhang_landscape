//
//  JFSetView.m
//  chengyuwar
//
//  Created by ran on 13-12-12.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFSetView.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"
#import "JFAppSet.h"
#import "JFAppSet.h"
#import "JFAudioPlayerManger.h"
@implementation JFSetView
@synthesize delegate;

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
    JFSetModel  *modelvolum = [[JFSetModel alloc] initwithName:@"音乐" despcription:nil type:JFSetModelTypeSwitchType];
    modelvolum.fprogress = [[JFAppSet shareInstance] bgvolume];
    JFSetModel  *modeleffect = [[JFSetModel alloc] initwithName:@"音效" despcription:nil type:JFSetModelTypeSwitchType];
    modeleffect.fprogress = [[JFAppSet shareInstance] SoundEffect];
    
    JFSetModel  *modelReset = [[JFSetModel alloc] initwithName:@"重置关卡" despcription:nil type:JFSetModelTypeNormalType];
    JFSetModel  *modelweixin = [[JFSetModel alloc] initwithName:@"微信" despcription:@"关注微信:chengyudazhang更多活动和惊喜" type:JFSetModelTypeNormalType];
    JFSetModel  *modelgame = [[JFSetModel alloc] initwithName:@"游戏说明" despcription:@"" type:JFSetModelTypeNormalType];
    JFSetModel  *modelgood = [[JFSetModel alloc] initwithName:@"给个好评吧" despcription:@"" type:JFSetModelTypeNormalType];
    JFSetModel  *modelabout = [[JFSetModel alloc] initwithName:@"关于" despcription:@"v1.2.0" type:JFSetModelTypeNormalType];
    
    [m_arrayData addObject:modelvolum];
    [m_arrayData addObject:modeleffect];
    [m_arrayData addObject:modelReset];
    [m_arrayData addObject:modelgame];
    [m_arrayData addObject:modelgood];
    [m_arrayData addObject:modelabout];
   
    
    [modelReset release];
    [modelvolum release];
    [modeleffect release];
    [modelweixin release];
    [modelgood release];
    [modelabout release];
    [modelgame release];
    [m_tableView reloadData];
}
-(void)defaultInit
{
    

    self.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    
    UIImageView  *bgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-236)/2, (self.frame.size.height-296)/2, 236, 296)];
    bgView.image = [PublicClass getImageAccordName:@"set_frame_bg.png"];
    bgView.userInteractionEnabled = YES;
    bgView.clipsToBounds = YES;
    [self addSubview:bgView];
    
   
    
    
    CGFloat   fwidth = 236-40;
    CGFloat   fheight = 296-60;
    
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
    
    
    
    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, imagebg2.frame.size.width, imagebg2.frame.size.height)];
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    [m_tableView setBackgroundColor:[UIColor clearColor]];
    [m_tableView setBackgroundView:nil];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [imagebg2 addSubview:m_tableView];
    
    
    UIButton    *btnBack = [[UIButton alloc] initWithFrame:CGRectMake((bgView.frame.size.width-92)/2, bgView.frame.size.height-42, 92, 30)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
    [btnBack setImage:[UtilitiesFunction getImageAccordTitle:@"返回"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(clickbackButton:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnBack];
    
    
    UIImageView  *imageTitle = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-69)/2, 0, 69, 36)];
    imageTitle.image = [PublicClass getImageAccordName:@"set_title.png"];
    [bgView addSubview:imageTitle];
    
    [btnBack release];
    [imageBg1 release];
    [imagebg2 release];
    [bgView release];
    [imageTitle release];
    
    
    [self addDatasource];
}


-(void)clickbackButton:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
     [JFAppSet storeShareInstance];
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
    //  UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    //CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    //[self addobserverForBarOrientationNotification];
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
    JFSetCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"11"];
    if (!cell)
    {
        cell = [[[JFSetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"11"] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell updateCellModel:[m_arrayData objectAtIndex:indexPath.row]];
    
    [cell.contentView setBackgroundColor:indexPath.row%2 == 0?TABLECELLCOLORFORFIRSTBG:TABLECELLCOLORFORSECONDEBG];
    cell.delegate = self;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3)
    {
        
         [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
        JFGameExplainView  *view = [[JFGameExplainView alloc] initWithFrame:CGRectZero];
        [view show];
        [view release];
    }else if (indexPath.row == 5)
    {
        [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
        if (delegate  && [delegate respondsToSelector:@selector(clickAboutView:)])
        {
            [delegate clickAboutView:self];
        }
    }else if (indexPath.row == 4)
    {
        //785258787
        [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
        NSString *url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%d",785258787];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else if (indexPath.row == 2)
    {
        
        [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
        JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"重置关卡将清除已完成关卡、关卡成就及金币!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重置"];
        av.tag = 100;
        [av show];
        [av release];
    
    }
    
}

#pragma mark JFAlertViewDelegate
-(void)JFAlertClickView:(JFAlertView *)alertView index:(JFAlertViewClickIndex)buttonIndex
{
    if (alertView.tag == 100)
    {
        if (buttonIndex == JFAlertViewClickIndexRight)
        {
           
            if (delegate && [delegate respondsToSelector:@selector(clickResetBtn:)])
            {
                [delegate clickResetBtn:nil];
            }
        }
    }
    
}

#pragma mark UITableViewdelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return m_tableView.frame.size.height/5;
}





-(void)sliderValueChange:(CGFloat)value cell:(UITableViewCell*)cell
{
    int row = [[m_tableView indexPathForCell:cell] row];
    if (row == 0)
    {
        [[JFAppSet shareInstance] setBgvolume:value];
    }else
    {
        [[JFAppSet shareInstance] setSoundEffect:value];
    }
//    DLOG(@"sliderValueChange:%@",slider);
    
}
@end
