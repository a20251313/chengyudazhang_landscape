//
//  JFRankView.m
//  chengyuwar
//
//  Created by ran on 13-12-14.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFRankView.h"
#import "PublicClass.h"
#import "JFLocalPlayer.h"
#import "JFAudioPlayerManger.h"
#import "UIImge-GetSubImage.h"


//JFRankViewTypeNone        450*262

//others                    472 291
@implementation JFRankView
@synthesize userSelfModel;
@synthesize rankType;
@synthesize delegate;
@synthesize showSelf;
- (id)initWithFrame:(CGRect)frame  withType:(JFRankViewType)viewType
{
  ///  frame = [UIScreen mainScreen].bounds;
    
    self = [super initWithFrame:frame];
    if (self)
    {
         self.rankType = viewType;
        if (self.rankType == JFRankViewTypeNone)
        {
            self.layer.contents = (id)[PublicClass getImageAccordName:@"rank_singview_bg.png"].CGImage;
        }else
        {
            self.layer.contents = (id)[PublicClass getImageAccordName:@"check_scrollerbg.png"].CGImage;
        }
        
        m_arrdata = [[NSMutableArray alloc] init];
        // Initialization code
    }
    return self;
}



-(void)setWinNumber:(int)winNumber
{
    UILabel *labelConWin = (UILabel*)[self viewWithTag:1000];
    NSString  *strwinstring = [NSString stringWithFormat:@"%d",[[JFLocalPlayer shareInstance] maxConWinNumber]];
    [labelConWin setText:strwinstring];
    
}
-(void)updateWithModelWithArray:(NSMutableArray*)arrdata type:(JFRankViewType)type userSelf:(JFRankModel*)model
{
    [m_arrdata removeAllObjects];
    [m_arrdata addObjectsFromArray:arrdata];
    self.userSelfModel = model;
    self.rankType = type;
    
    
    CGFloat   fwidth = 472-80;
    CGFloat   fheight = 291-100;
    
    fcellHeight = 35;
    if (type == JFRankViewTypeNone)
    {
        fwidth = 450-75;
        fheight = 262-75;
     //   fcellHeight = 33;
    }
    
    UIView  *bg1View = [self viewWithTag:111111];
 
    if (!bg1View)
    {
        bg1View =  [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width-fwidth)/2+8, (self.frame.size.height-fheight)/2+3, fwidth, fheight)];
        bg1View.backgroundColor = BGCOLORFORFIRSTBG;
        bg1View.userInteractionEnabled = YES;
        [self addSubview:bg1View];
        bg1View.layer.masksToBounds = YES;
        bg1View.layer.cornerRadius = 5;
        bg1View.tag = 111111;
        
        [bg1View release];
        
    }
    
    UIView  *bg2View =  [bg1View viewWithTag:100011];
    if (!bg2View)
    {
        bg2View = [[UIView alloc] initWithFrame:CGRectMake(8, 8, fwidth-16, fheight-16)];
        bg2View.backgroundColor = BGCOLORFORSECONDBG;
      
        bg2View.layer.masksToBounds = YES;
        bg2View.layer.cornerRadius = 5;
        bg2View.tag = 100011;
        [bg1View addSubview:bg2View];
        [bg2View release];
    }
   
    if (!m_tableView)
    {
        m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, bg2View.frame.size.width, bg2View.frame.size.height-fcellHeight)];
        m_tableView.delegate = self;
        m_tableView.dataSource = self;
        [m_tableView setBackgroundColor:[UIColor clearColor]];
        [m_tableView setBackgroundView:nil];
        m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [bg2View addSubview:m_tableView];
    }
    
    if (!m_tableMe)
    {
        m_tableMe = [[UITableView alloc] initWithFrame:CGRectMake(0,bg2View.frame.size.height-fcellHeight+2, bg2View.frame.size.width,fcellHeight)];
        m_tableMe.delegate = self;
        m_tableMe.dataSource = self;
        m_tableMe.separatorStyle = UITableViewCellSeparatorStyleNone;
        [m_tableMe setBackgroundColor:[UIColor clearColor]];
        [m_tableMe setBackgroundView:nil];
        m_tableMe.scrollEnabled = NO;
        [bg2View addSubview:m_tableMe];
    }
    
    if (!self.showSelf)
    {
       [m_tableView setFrame:CGRectMake(0, 0, bg2View.frame.size.width, bg2View.frame.size.height)];
        m_tableMe.hidden = YES;
    }
    
    if (!m_imageViewtitle)
    {
        UIImage  *image = nil;
       
        
        if (self.rankType == JFRankViewTypeNone)
        {
            image = [PublicClass getImageAccordName:@"rank_weekkingwords.png"];
        }else
        {
            image = [PublicClass getImageAccordName:@"rank_kingwords.png"];
            //self.clipsToBounds = NO;
          
        }
        
        
        m_imageViewtitle = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-image.size.width/2)/2, 0, image.size.width/2, image.size.height/2)];
        
        if (self.rankType != JFRankViewTypeNone)
        {
             [m_imageViewtitle setFrame:CGRectMake((self.frame.size.width-image.size.width/2)/2, -10, image.size.width/2, image.size.height/2)];
            //image = [PublicClass getImageAccordName:@"rank_weekkingwords.png"];
        }
        m_imageViewtitle.image = image;
        [self addSubview:m_imageViewtitle];
    }
    
    
    CGFloat  fYpoint = bg1View.frame.origin.y-20;
    fwidth = fwidth/3;
    if (!m_imageViewType && self.rankType != JFRankViewTypeNone)
    {
        
        
        m_imageViewType = [[UIImageView alloc] initWithFrame:CGRectMake(bg1View.frame.origin.x, fYpoint, fwidth, 28)];
        m_imageViewType.layer.masksToBounds = YES;
        m_imageViewType.layer.cornerRadius = 5;
     //   CGRect desRect = CGRectZero;
       // [m_imageViewType setFrame:desRect];
        [m_imageViewType setBackgroundColor:BGCOLORFORFIRSTBG];
        [self addSubview:m_imageViewType];
        
        
        UIButton  *btnweek = [[UIButton alloc] initWithFrame:CGRectMake(bg1View.frame.origin.x+(fwidth-45)/2,fYpoint-10, 45, 23)];
        [btnweek setBackgroundImage:[PublicClass getImageAccordName:@"rank_weekwords.png"] forState:UIControlStateNormal];
        [btnweek addTarget:self action:@selector(clickWeekBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnweek];
        
        
        UIButton  *btnmonth = [[UIButton alloc] initWithFrame:CGRectMake(bg1View.frame.origin.x+(fwidth-45)/2+fwidth,fYpoint-10, 45, 23)];
        [btnmonth setBackgroundImage:[PublicClass getImageAccordName:@"rank_monthwords.png"] forState:UIControlStateNormal];
        [btnmonth addTarget:self action:@selector(clickMonthBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnmonth];
        
        
        UIButton  *btntotal = [[UIButton alloc] initWithFrame:CGRectMake(bg1View.frame.origin.x+(fwidth-45)/2+fwidth*2,fYpoint-10, 45, 23)];
        [btntotal setBackgroundImage:[PublicClass getImageAccordName:@"rank_totalwords.png"] forState:UIControlStateNormal];
        [btntotal addTarget:self action:@selector(clickTotalBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btntotal];
        
        
        [btnweek release];
        [btntotal release];
        [btnmonth release];
        
    }
    
    switch (self.rankType)
    {
        case JFRankViewTypeNone:
            break;
        case JFRankViewTypeWeek:
            [m_imageViewType setFrame:CGRectMake(bg1View.frame.origin.x, fYpoint, fwidth, 28)];
            break;
        case JFRankViewTypeMonth:
            [m_imageViewType setFrame:CGRectMake(fwidth+bg1View.frame.origin.x, fYpoint, fwidth, 28)];
            break;
        case JFRankViewTypeTotal:
            [m_imageViewType setFrame:CGRectMake(fwidth*2+bg1View.frame.origin.x, fYpoint, fwidth, 28)];
            break;
            
        default:
            break;
    }
    
    
    
    if (self.rankType == JFRankViewTypeNone)
    {
        UIButton   *backbtn = [[UIButton alloc] initWithFrame:CGRectMake((bg1View.frame.size.width-92)/2, bg1View.frame.size.height-20, 92, 30)];
        [backbtn setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
        [backbtn setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
        [backbtn setImage:[PublicClass getImageAccordName:@"alert_back.png"] forState:UIControlStateNormal];
        [backbtn addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
        
        CGRect frame = [self convertRect:backbtn.frame fromView:bg1View];
        [backbtn setFrame:frame];
        [self addSubview:backbtn];
        [backbtn release];
        
    }else
    {

        //[UIColor colorWithRed:0xFF*1.0/255.0 green:0x33*1.0/255.0 blue:0 alpha:1]
        
        if (self.showSelf)
        {
            CGFloat  ftempypoint = bg1View.frame.origin.y+10+bg1View.frame.size.height;
            
            UILabel  *labelname = [[UILabel alloc] initWithFrame:CGRectMake(50,ftempypoint-3, 150, 17)];
            [labelname setTextColor:TEXTCOMMONCOLOR];
            [labelname setBackgroundColor:[UIColor clearColor]];
            [labelname setText:self.userSelfModel.nickName];
            [labelname setFont:TEXTHEITIWITHSIZE(13)];
            [self addSubview:labelname];
            [labelname release];
            
            UIImageView  *imageConwin = [[UIImageView alloc] initWithFrame:CGRectMake(100+50+10, ftempypoint, 71, 17)];
            imageConwin.image = [PublicClass getImageAccordName:@"racehall_maxconwin_word.png"];
            [self addSubview:imageConwin];
            [imageConwin release];
            
            UILabel  *labelConWin = [[UILabel alloc] initWithFrame:CGRectMake(imageConwin.frame.size.width+imageConwin.frame.origin.x+10,ftempypoint, 150, 17)];
            [labelConWin setTextColor:[UIColor colorWithRed:0xFF*1.0/255.0 green:0x33*1.0/255.0 blue:0 alpha:1]];
            [labelConWin setBackgroundColor:[UIColor clearColor]];
            
            [labelConWin setFont:TEXTFONTWITHSIZE(13)];
            [self addSubview:labelConWin];
            labelConWin.tag = 1000;
            [labelConWin release];
            
            UIImageView *viewconwin = [[UIImageView alloc] initWithFrame:CGRectMake(280, ftempypoint-5, 21, 20)];
            viewconwin.image = [PublicClass getImageAccordName:@"change_historyhighest.png"];
            [self addSubview:viewconwin];
            [viewconwin release];
            
            [self addBtn:@"race_win_share.png" frame:CGRectMake(270+60, ftempypoint-2, 90, 32) selector:@selector(clickShare:) superview:self];
            
        }
        
    }
    
    UILabel *labelConWin = (UILabel*)[self viewWithTag:1000];
    NSString  *strwinstring = [NSString stringWithFormat:@"%d",[[JFLocalPlayer shareInstance] maxConWinNumber]];
    [labelConWin setText:strwinstring];
    
    [m_tableView reloadData];
    [m_tableMe reloadData];
  
    
    
}


//73*23
-(void)addBtn:(NSString*)strName frame:(CGRect)frame selector:(SEL)selctor superview:(UIView*)supreView
{
    UIButton  *btn = [[UIButton alloc] initWithFrame:frame];
    [btn addTarget:self action:selctor forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[PublicClass getImageAccordName:@"alert_btn_bg.png"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[PublicClass getImageAccordName:@"alert_btn_bg_pressed.png"] forState:UIControlStateNormal];
    [btn setImage:[PublicClass getImageAccordName:strName] forState:UIControlStateNormal];
    [supreView addSubview:btn];
    [btn release];
}



-(void)clickBackButton:(id)sender
{
    
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (delegate  && [delegate respondsToSelector:@selector(clickBackBtn:)])
    {
        [delegate clickBackBtn:sender];
    }

    DLOG(@"clickBackButton:%@",sender);
}


-(void)updatViewFrameAccord:(JFRankViewType)type
{
    
    UIView  *bgview = [self viewWithTag:111111];
    
    self.rankType = type;
    CGFloat  fYpoint = bgview.frame.origin.y-20;
    CGFloat  fXpoint = bgview.frame.origin.x;
    CGFloat     fwidth = m_imageViewType.frame.size.width;
    switch (self.rankType)
    {
        case JFRankViewTypeNone:
            break;
        case JFRankViewTypeWeek:
            [m_imageViewType setFrame:CGRectMake(fXpoint, fYpoint, fwidth, 28)];
            break;
        case JFRankViewTypeMonth:
            [m_imageViewType setFrame:CGRectMake(fwidth+fXpoint, fYpoint, fwidth, 28)];
            break;
        case JFRankViewTypeTotal:
            [m_imageViewType setFrame:CGRectMake(fwidth*2+fXpoint, fYpoint, fwidth, 28)];
            break;
        default:
            break;
    }
}
-(void)clickWeekBtn:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (self.rankType == JFRankViewTypeWeek)
    {
        return;
    }
    
    self.rankType = JFRankViewTypeWeek;
    [self updatViewFrameAccord:self.rankType];
    if (delegate  && [delegate respondsToSelector:@selector(requestData:)])
    {
        [delegate requestData:self.rankType];
    }

    DLOG(@"clickWeekBtn:%@",sender);
}
-(void)clickMonthBtn:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (self.rankType == JFRankViewTypeMonth)
    {
        return;
    }
    
    self.rankType = JFRankViewTypeMonth;
    [self updatViewFrameAccord:self.rankType];
    
    if (delegate  && [delegate respondsToSelector:@selector(requestData:)])
    {
        [delegate requestData:self.rankType];
    }
    DLOG(@"clickMonthBtn:%@",sender);
}
-(void)clickTotalBtn:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (self.rankType == JFRankViewTypeTotal)
    {
        return;
    }
    
    self.rankType = JFRankViewTypeTotal;
    [self updatViewFrameAccord:self.rankType];
    
    if (delegate  && [delegate respondsToSelector:@selector(requestData:)])
    {
        [delegate requestData:self.rankType];
    }
    DLOG(@"clickTotalBtn:%@",sender);
}


-(void)clickShare:(id)sender
{
    
    if (![UtilitiesFunction networkCanUsed])
    {
        [self showNetCannotUserAlert];
        return;
    }
    //UIImage *image = [UIImage getScreenImageWithView:self size:CGSizeMake([UIScreen mainScreen].//bounds.size.height, [UIScreen mainScreen].bounds.size.width)];
    
    //[JFShareManger shareWithMsg:@"猜猜吧" image:image viewController:self];
    // [JFShareManger shareWithMsg:@"hello" image:image];
    DLOG(@"clickToshare:%@",sender);
    
}

-(void)showNetCannotUserAlert
{
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示"
                                                 message:@"无法连接网络。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
    [av show];
    [av release];
}

-(void)dealloc
{
    [m_arrdata release];
    m_arrdata = nil;
    [m_tableView release];
    m_tableView = nil;
    [m_tableMe release];
    m_tableMe = nil;
    [m_imageViewtitle release];
    m_imageViewtitle = nil;
    [m_imageViewType release];
    m_imageViewType = nil;

    self.userSelfModel = nil;
    [super dealloc];
}

#pragma mark  tableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (m_tableMe == tableView)
    {
        return 1;
    }
    return [m_arrdata count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (m_tableView == tableView)
    {
        JFRankCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"11"];
        if (!cell)
        {
            cell = [[[JFRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"11"] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.cellHeight = fcellHeight;
        }
        
        [cell updateCellWithModel:[m_arrdata objectAtIndex:indexPath.row]];
        
        [cell.contentView setBackgroundColor:indexPath.row%2 == 0?TABLECELLCOLORFORFIRSTBG:TABLECELLCOLORFORSECONDEBG];
        return cell;
        
    }else
    {
        JFRankCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"12"];
        if (!cell)
        {
            cell = [[[JFRankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"12"] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.cellHeight = fcellHeight;
        }
        
        [cell updateCellWithModel:self.userSelfModel];
        
        [cell.contentView setBackgroundColor:[UIColor colorWithRed:0xFC*1.0/255.0 green:0xEC*1.0/255.0 blue:0x6E*1.0/255.0 alpha:1.0]];
        return cell;
        
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return fcellHeight;
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
