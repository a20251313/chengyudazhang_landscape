//
//  JFCreateRoleView.m
//  chengyuwar
//
//  Created by ran on 13-12-16.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFCreateRoleView.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"
#import "JFLocalPlayer.h"
#import "JFSQLManger.h"
#import "JFChargeView.h"
#define BGVIEWTAG           111012
@implementation JFCreateRoleView
@synthesize delegate;

- (id)initWithType:(JFCreateRoleViewType)type
{
    
   
    
    CGSize  size = CGSizeMake([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    CGRect  frame = CGRectMake(0, 0, size.width, size.height);
    self = [super initWithFrame:frame];
    if (self)
    {
         m_itype = type;
        
        m_arrayData  = [[NSMutableArray alloc] init];
        m_arrayViews = [[NSMutableArray alloc] init];
        
        if (iPhone5)
        {
            self.layer.contents = (id)[UIImage imageNamed:@"main_bg_withnothing_iphone5.png"].CGImage;
            //main_bg_withnothing
        }else
        {
            self.layer.contents = (id)[UIImage imageNamed:@"main_bg_withnothing.png"].CGImage;
        }
        
        UIImageView *cloudView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-479)/2, frame.size.height-60-30, 479, 60)];
        cloudView.image = [PublicClass getImageAccordName:@"main_bg_clouds.png"];
        cloudView.userInteractionEnabled = NO;
        [self addSubview:cloudView];
      
        
        
        UIImageView  *bgView = [[UIImageView alloc] initWithFrame:CGRectMake((size.width-370)/2, 55, 370, 240)];
        bgView.image = [PublicClass getImageAccordName:@"createrole_redbg.png"];
        bgView.userInteractionEnabled = YES;
        [self addSubview:bgView];
        bgView.tag = BGVIEWTAG;
        
        
        UIImageView  *medalBg = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-331)/2, (bgView.frame.size.height-226)/2+10, 331, 205)];
        medalBg.image = [PublicClass getImageAccordName:@"createrole_paperbg.png"];
        [bgView addSubview:medalBg];
        medalBg.userInteractionEnabled = YES;
        
        
        m_scrollView = [[UIScrollView alloc] initWithFrame:medalBg.bounds];
        m_scrollView.delegate = self;
        m_scrollView.pagingEnabled = YES;
        [medalBg addSubview:m_scrollView];
        
        
        UIImage  *imagetitle = [PublicClass getImageAccordName:@"createrole_createroletitle.png"];
        if (m_itype == JFCreateRoleViewTypeModify)
        {
            imagetitle = [PublicClass getImageAccordName:@"createrole_changerole_title.png"];
        }
        UIImageView     *imagetitleView = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-imagetitle.size.width/2)/2, -10, imagetitle.size.width/2, imagetitle.size.height/2)];
        imagetitleView.image = imagetitle;
        [bgView addSubview:imagetitleView];
        
        
        UIButton  *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(-30, (medalBg.frame.size.height-22)/2-20, 19+40, 22+40)];
        [btnLeft setImage:[PublicClass getImageAccordName:@"createrole_angle_left.png"] forState:UIControlStateNormal];
        [btnLeft setImageEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
        [btnLeft addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [medalBg addSubview:btnLeft];
        
        
        UIButton  *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(medalBg.frame.size.width-10-20, (medalBg.frame.size.height-22)/2-20, 19+40, 22+40)];
        [btnRight setImage:[PublicClass getImageAccordName:@"createrole_angle_right.png"] forState:UIControlStateNormal];
        [btnRight setImageEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
        [btnRight addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
        [medalBg addSubview:btnRight];
    
        
      
        
        if (m_itype == JFCreateRoleViewTypeCreate)
        {
            UIButton  *btnback = [[UIButton alloc] initWithFrame:CGRectMake(50, medalBg.frame.size.height-38, 90, 28)];
            [btnback setBackgroundImage:[PublicClass getImageAccordName:@"createrole_btnwood.png"] forState:UIControlStateNormal];
            [btnback setBackgroundImage:[PublicClass getImageAccordName:@"createrole_btnwood_pressed.png"] forState:UIControlStateHighlighted];
            [btnback setImage:[PublicClass getImageAccordName:@"createrole_back.png"] forState:UIControlStateNormal];
            [btnback addTarget:self action:@selector(clickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
            [medalBg addSubview:btnback];
            [btnback release];
            
            
            m_btnCreate = [[UIButton alloc] initWithFrame:CGRectMake(80+90+20, medalBg.frame.size.height-38, 90, 28)];
            [m_btnCreate setBackgroundImage:[PublicClass getImageAccordName:@"createrole_greenbtn.png"] forState:UIControlStateNormal];
            [m_btnCreate setBackgroundImage:[PublicClass getImageAccordName:@"createrole_greenbtn_pressed.png"] forState:UIControlStateHighlighted];
            [m_btnCreate setImage:[PublicClass getImageAccordName:@"createrole_createword.png"] forState:UIControlStateNormal];
            [m_btnCreate addTarget:self action:@selector(clickCreateBtn:) forControlEvents:UIControlEventTouchUpInside];
            [medalBg addSubview:m_btnCreate];

            
        }else
        {
            
            m_btnCreate = [[UIButton alloc] initWithFrame:CGRectMake((medalBg.frame.size.width-90)/2, medalBg.frame.size.height-38, 90, 28)];
            [m_btnCreate setBackgroundImage:[PublicClass getImageAccordName:@"createrole_greenbtn.png"] forState:UIControlStateNormal];
            [m_btnCreate setBackgroundImage:[PublicClass getImageAccordName:@"createrole_greenbtn_pressed.png"] forState:UIControlStateHighlighted];
            [m_btnCreate setImage:[PublicClass getImageAccordName:@"createrole_createword.png"] forState:UIControlStateNormal];
            [m_btnCreate addTarget:self action:@selector(clickCreateBtn:) forControlEvents:UIControlEventTouchUpInside];
            [medalBg addSubview:m_btnCreate];
            
        }
        
        
        [medalBg release];
        [btnLeft release];
        [btnRight release];
        [imagetitleView release];
        [bgView release];
        [cloudView release];
        
        [self addDataInScrollView];
        // Initialization code
    }
    return self;
}


-(void)addDataInScrollView
{
    
    if (![m_arrayData count])
    {
        
 //       NSNull  *null = [NSNull null];
        JFRoleModel  *model1 = [[JFRoleModel alloc] initWithType:JFRoleModelTypebaijingjing];
        JFRoleModel  *model2 = [[JFRoleModel alloc] initWithType:JFRoleModelTypeshaheshang];
        JFRoleModel  *model3 = [[JFRoleModel alloc] initWithType:JFRoleModelTypezhuyuanshuai];
        JFRoleModel  *model4 = [[JFRoleModel alloc] initWithType:JFRoleModelTypetangxiaozang];
        JFRoleModel  *model5 = [[JFRoleModel alloc] initWithType:JFRoleModelTypesundashen];
  //      [m_arrayData addObject:null];
        [m_arrayData addObject:model1];
        [m_arrayData addObject:model2];
        [m_arrayData addObject:model3];
        [m_arrayData addObject:model4];
        [m_arrayData addObject:model5];
     //   [m_arrayData addObject:null];
        
        if (m_itype == JFCreateRoleViewTypeModify)
        {
            for (JFRoleModel  *model in m_arrayData)
            {
                if ([model isKindOfClass:[NSNull class]])
                {
                    continue;
                }
                if (model.roleType == [[[JFLocalPlayer shareInstance] roleModel] roleType])
                {
                    model.needCheckView = YES;
                }
            }
        }
        [model5 release];
        [model4 release];
        [model3 release];
        [model2 release];
        [model1 release];
    }
    
    CGFloat  fxpoint = 0;
    for (int i = 0; i < [m_arrayData count]; i++)
    {
        JFSingRoleView  *view = [[JFSingRoleView alloc] initWithFrame:CGRectMake(fxpoint, 0, m_scrollView.frame.size.width, m_scrollView.frame.size.height)];
        [m_scrollView addSubview:view];
        view.delegate = self;
        [view updateRoleViewWithModel:[m_arrayData objectAtIndex:i] needNickName:(m_itype == JFCreateRoleViewTypeCreate?YES:NO)];
        [view release];
        fxpoint += m_scrollView.frame.size.width;
        [m_arrayViews addObject:view];
    }
    [m_scrollView setContentSize:CGSizeMake(m_scrollView.frame.size.width*[m_arrayData count], m_scrollView.frame.size.height)];
    [self updateCurrentCreatebtn];

}
-(void)clickLeftBtn:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (m_ipage-1 < 0)
    {
         [m_scrollView setContentOffset:CGPointMake((m_scrollView.contentSize.width-m_scrollView.frame.size.width), 0) animated:NO];
         m_ipage = [m_arrayData count]-1;
    }else
    {
         [m_scrollView setContentOffset:CGPointMake(m_scrollView.frame.size.width*(m_ipage-1), 0)];
         m_ipage--;
    }
    DLOG(@"clickLeftBtn:%@",sender);
    [self updateCurrentCreatebtn];
}
-(void)clickRightBtn:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (m_ipage+1 >= [m_arrayData count])
    {
        [m_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        m_ipage = 0;
    }else
    {
        [m_scrollView setContentOffset:CGPointMake(m_scrollView.frame.size.width*(m_ipage+1), 0)];
        m_ipage++;
    }
    
    [self updateCurrentCreatebtn];
    DLOG(@"clickRightBtn:%@",sender);
}


-(void)updateCurrentCreatebtn
{
    JFRoleModel  *model = [m_arrayData objectAtIndex:m_ipage];
    
    if ([model isKindOfClass:[NSNull class]])
    {
        return;
    }
    if (m_itype == JFCreateRoleViewTypeCreate)
    {
        if (model.needUnlock)
        {
            [m_btnCreate setImage:[PublicClass getImageAccordName:[NSString stringWithFormat:@"createrole_gold%d.png",model.unlockGold]] forState:UIControlStateNormal];
        }else
        {
            [m_btnCreate setImage:[PublicClass getImageAccordName:@"createrole_createword.png"] forState:UIControlStateNormal];
        }
        
    }else
    {
        if (model.needUnlock)
        {
            [m_btnCreate setImage:[PublicClass getImageAccordName:[NSString stringWithFormat:@"createrole_gold%d.png",model.unlockGold]] forState:UIControlStateNormal];
        }else
        {
            [m_btnCreate setImage:[PublicClass getImageAccordName:@"createrole_choose.png"] forState:UIControlStateNormal];
        }
        
    }
   
    
    //createrole_choose
}
-(void)clickBackBtn:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (delegate && [delegate respondsToSelector:@selector(userCancelCreateRole:)])
    {
        [delegate userCancelCreateRole:sender];
    }
    DLOG(@"clickBackBtn:%@",sender);
    [self removeFromSuperview];
    

}
-(void)clickCreateBtn:(id)sender
{
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    NSString    *nickName = [[m_arrayViews objectAtIndex:m_ipage] getTextValue];
    
    if (m_itype == JFCreateRoleViewTypeCreate)
    {
        if (!nickName || [nickName isEqualToString:@""] || [nickName isEqualToString:@"请输入昵称"] )
        {
            [[m_arrayViews objectAtIndex:m_ipage] flash];
            return;
        }
    }
   
    if (![UtilitiesFunction checkStringSize:nickName minSize:0 maxSize:16])
    {
        JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"昵称输入不合法!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定"];
        [av show];
        [av release];
    }else
    {
        
        
        JFRoleModel *model = [m_arrayData objectAtIndex:m_ipage];
        if ([model isKindOfClass:[NSNull class]])
        {
            return;
        }
        if (model.needUnlock)
        {
            NSString    *strMsg = [NSString stringWithFormat:@"花费%d金币解锁%@",model.unlockGold,model.name];
            JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:strMsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"解锁"];
            [av show];
            av.tag = 1000;
            [av release];
        }else
        {
            [self createUser];
        }
    }
    
    
    
    DLOG(@"clickCreateBtn:%@",sender);
}

-(void)JFAlertClickView:(JFAlertView *)alertView index:(JFAlertViewClickIndex)buttonIndex
{
    
    if (alertView.tag == 1000)
    {
        
        if (buttonIndex == JFAlertViewClickIndexRight)
        {
            JFRoleModel *model = [m_arrayData objectAtIndex:m_ipage];
            int gold = [[JFLocalPlayer shareInstance] goldNumber];
            if (gold >= model.unlockGold)
            {
                [JFSQLManger UpdateRoleUnck:model.roleType isUnlock:1];
                [JFLocalPlayer deletegoldNumber:model.unlockGold];
                [JFPlayAniManger deleteGoldWithAni:model.unlockGold];
                [self createUser];
            }else
            {
                NSString    *strMsg = [NSString stringWithFormat:@"金币不足，是否购买金币?"];
                JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示" message:strMsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"购买"];
                [av show];
                av.tag = 2000;
                [av release];
            }
        }
        
    }else if (alertView.tag == 2000)
    {
        
        if (buttonIndex == JFAlertViewClickIndexRight)
        {
            JFChargeView    *chargeView = [[JFChargeView alloc] initWithFrame:CGRectZero];
            [chargeView show];
            [chargeView release];
        }
       
    }
}
-(void)createUser
{
     NSString    *nickName = [[m_arrayViews objectAtIndex:m_ipage] getTextValue];
    JFRoleModel *model = [[JFRoleModel alloc] initWithType:[[m_arrayData objectAtIndex:m_ipage] roleType]];
    JFLocalPlayer   *player = [JFLocalPlayer shareInstance];
    
    if (m_itype == JFCreateRoleViewTypeCreate)
    {
      player.nickName = nickName;
    }
    player.roleModel = model;
    [model release];
    [JFSQLManger UpdateUserInfoToDB:player];
    
    if (delegate && [delegate respondsToSelector:@selector(userHasCreateRole:)])
    {
        [delegate userHasCreateRole:nil];
    }
    
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
    [self addobserverForBarOrientationNotification];
    UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    UIWindow  *winddow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    self.center = winddow.center;
    self.transform = CGAffineTransformMakeRotation(fValue);
    [winddow addSubview:self];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [m_arrayData release];
    m_arrayData = nil;
    [m_scrollView release];
    m_scrollView = nil;
    [m_btnCreate release];
    m_btnCreate = nil;
    [m_arrayViews release];
    m_arrayViews = nil;
    
    [super dealloc];
}

#pragma mark scrollViewdelegate
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x < 0)
    {
        [scrollView setContentOffset:CGPointMake((scrollView.contentSize.width-scrollView.frame.size.width), 0) animated:NO];
        m_ipage = [m_arrayData count]-1;
        [self updateCurrentCreatebtn];
    }else if(scrollView.contentOffset.x > scrollView.contentSize.width-scrollView.frame.size.width)
    {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        m_ipage = 0;
        [self updateCurrentCreatebtn];
    }
    DLOG(@"scrollViewWillBeginDecelerating:%@",scrollView);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGFloat pageWidth = scrollView.frame.size.width;
    m_ipage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    /*
    CGFloat pageWidth = scrollView.frame.size.width;
    // 0 1 2
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if(page == 1)
    {
        //用户拖动了，但是滚动事件没有生效
        return;
    } else if (page == 0) {
        //[self ];
    } else if(page == 5)
    {
        [scrollView setContentOffset:CGPointMake(0, 0)];;
    }*/

    
  
    
    
    
   /* if (CGPointEqualToPoint(scrollView.contentOffset, CGPointZero))
    {
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width*[m_arrayData count], 0)];
      //  [scrollView setContentSize:CGPointMake(scrollView.frame.size.width*m_scrollView.frame.size.width, 0)];
        
    }else if (CGPointEqualToPoint(scrollView.contentOffset, CGPointMake(scrollView.frame.size.width*([m_arrayData count]-1), 0)))
    {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }*/
    
    [self updateCurrentCreatebtn];
    DLOG(@"scrollViewDidEndDecelerating:%@  contentSize:%@",scrollView,[NSValue valueWithCGSize:scrollView.contentSize]);
}


- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    DLOG(@"scrollViewDidScrollToTop:%@",scrollView);
}




-(void)textDidBegin:(UITextField*)textField
{
    UIView  *bgView = [self viewWithTag:BGVIEWTAG];
     [bgView setFrame:CGRectMake((self.frame.size.height-370)/2, 55-120, 370, 240)];
    
}
-(void)textDidResign:(UITextField*)textField
{
    
    UIView  *bgView = [self viewWithTag:BGVIEWTAG];
    [bgView setFrame:CGRectMake((self.frame.size.height-370)/2, 55, 370, 240)];
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
