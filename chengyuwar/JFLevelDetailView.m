//
//  JFLevelDetailView.m
//  chengyuwar
//
//  Created by ran on 14-1-10.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFLevelDetailView.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"
#import "JFAudioPlayerManger.h"
@implementation JFLevelDetailView

- (id)initWithFrame:(CGRect)frame
{
    frame = [UIScreen mainScreen].bounds;
    
    self = [super initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.width)];
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
    
    [m_arrayData removeAllObjects];
    [m_arrayData addObject:[JFLevelModel levelModelWithType:JFLevelModelTypebuyi]];
    [m_arrayData addObject:[JFLevelModel levelModelWithType:JFLevelModelTypexiucai]];
    [m_arrayData addObject:[JFLevelModel levelModelWithType:JFLevelModelTypejuren]];
    [m_arrayData addObject:[JFLevelModel levelModelWithType:JFLevelModelTypejinshi]];
    [m_arrayData addObject:[JFLevelModel levelModelWithType:JFLevelModelTypebangyan]];
    [m_arrayData addObject:[JFLevelModel levelModelWithType:JFLevelModelTypetahua]];
    [m_arrayData addObject:[JFLevelModel levelModelWithType:JFLevelModelTypezhuangyuan]];
    [m_arrayData addObject:[JFLevelModel levelModelWithType:JFLevelModelTypeshangshu]];
    [m_arrayData addObject:[JFLevelModel levelModelWithType:JFLevelModelTypechenxiang]];
    [m_arrayData addObject:[JFLevelModel levelModelWithType:JFLevelModelTypehuangdi]];
    [m_tableView reloadData];
    // JFPropModel  *model
}
-(void)defaultInit
{
    
    
    self.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    
    UIImageView  *bgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-236)/2, (self.frame.size.height-296)/2, 236, 296)];
    bgView.image = [PublicClass getImageAccordName:@"gameexplain_frame_bg.png"];
    bgView.userInteractionEnabled = YES;
    bgView.clipsToBounds = YES;
    [self addSubview:bgView];
    
    
    
    
    CGFloat   fwidth = 236-40;
    CGFloat   fheight = 296-65;
    
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
    [btnBack setImage:[UtilitiesFunction getImageAccordTitle:@"我知道了"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(clickbackButton:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnBack];
    
    
    UIImageView  *imageTitle = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-69)/2, 0, 70, 36)];
    imageTitle.image = [PublicClass getImageAccordName:@"level_title.png"];
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
    [self addobserverForBarOrientationNotification];
    UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    UIWindow  *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    self.center = window.center;
    self.transform = CGAffineTransformMakeRotation(fValue);
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

#pragma mark  tableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_arrayData count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JFLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"level"];
    if (!cell)
    {
        cell = [[[JFLevelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"level"] autorelease];
        
    }
    
    
    [cell.contentView setBackgroundColor:indexPath.row%2 == 0?TABLECELLCOLORFORFIRSTBG:TABLECELLCOLORFORSECONDEBG];
    [cell updateViewAccordCell:[m_arrayData objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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
