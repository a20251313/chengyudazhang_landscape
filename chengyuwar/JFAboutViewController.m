//
//  JFAboutViewController.m
//  chengyuwar
//
//  Created by ran on 13-12-13.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFAboutViewController.h"
#import "PublicClass.h"
#import "JFAudioPlayerManger.h"


NSString   *const   BNRShowSetView = @"BNRShowSetView";

@implementation aboutDataModel

@synthesize title;
@synthesize textColor;
@synthesize textfont;
@synthesize type;
@synthesize imageName;


+(aboutDataModel*)aboutmodelwithtitle:(NSString*)strTitle color:(UIColor*)temptextColor textfont:(UIFont*)usefont
{
    aboutDataModel  *model = [[aboutDataModel alloc] init];
    model.title = strTitle;
    model.textColor = temptextColor;
    model.textfont = usefont;
    model.type = aboutDataModelTypeNone;
    return [model autorelease];
}
+(aboutDataModel*)aboutmodelwithImageName:(NSString*)strImageName
{
    aboutDataModel  *model = [[aboutDataModel alloc] init];
    model.imageName = strImageName;
    model.type = aboutDataModelTypeImage;
    return [model autorelease];
}


-(void)dealloc
{
    self.title = nil;
    self.textfont = nil;
    self.textColor = nil;
    self.imageName = nil;
    [super dealloc];
}

@end
@interface JFAboutViewController ()

@end

@implementation JFAboutViewController

-(id)init
{
    self = [super init];
    if (self)
    {
        
        m_arrayData = [[NSMutableArray alloc] init];
        
    }
    return self;
}


-(void)loadView
{
    [super loadView];
    
    [self initView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [m_tableView startScrolling];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [m_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}


-(void)initView
{
    CGSize  size = [UIScreen mainScreen].bounds.size;
    CGRect  frame = CGRectMake(0, 0, size.width, size.height);

    if (!m_bgView)
    {
        m_bgView = [[UIView alloc] initWithFrame:frame];
        [self.view addSubview:m_bgView];
    }
    
    if (iPhone5)
    {
         m_bgView.layer.contents = (id)[UIImage imageNamed:@"main_bg_withnothing_iphone5.png"].CGImage;
        //main_bg_withnothing
    }else
    {
         m_bgView.layer.contents = (id)[UIImage imageNamed:@"main_bg_withnothing.png"].CGImage;
    }
   
    /*
    UIImageView  *imageword = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-232)/2, 50, 232, 52)];
    imageword.image = [PublicClass getImageAccordName:@"about_chengyu_words.png"];
    [self.view addSubview:imageword];
    [imageword release];*/
    
    
    
    UIImageView  *imageclouds = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-479)/2, frame.size.height-90, 479, 60)];
    imageclouds.image = [PublicClass getImageAccordName:@"main_bg_clouds.png"];
    [self.view addSubview:imageclouds];
    [imageclouds release];
    
    if (!m_tableView)
    {
        m_tableView = [[DAAutoTableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        [m_tableView setBackgroundColor:[UIColor clearColor]];
        [m_tableView setBackgroundView:nil];
        m_tableView.delegate = self;
        m_tableView.dataSource = self;
        m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        m_tableView.showsVerticalScrollIndicator = NO;
        [m_tableView setPointsPerSecond:50];
        [self.view addSubview:m_tableView];
        
    }
    
    //@"公司名称"
    
    aboutDataModel  *ModelNUll = [[aboutDataModel alloc] init];
    ModelNUll.type = aboutDataModelTypeNULL;
    
    aboutDataModel  *imageModel = [aboutDataModel aboutmodelwithImageName:@"about_chengyu_words.png"];
//    aboutDataModel  *model1 = [aboutDataModel aboutmodelwithtitle:@"公司" color:[UIColor blackColor] textfont:TEXTFONTWITHSIZE(25)];
//    aboutDataModel  *model2 = [aboutDataModel aboutmodelwithtitle:@"上海鱼游网络科技有限公司" color:TEXTCOMMONCOLORSecond textfont:TEXTFONTWITHSIZE(21)];
//    aboutDataModel  *model3 = [aboutDataModel aboutmodelwithtitle:@"产品" color:[UIColor blackColor] textfont:TEXTFONTWITHSIZE(25)];
//    aboutDataModel  *model4 = [aboutDataModel aboutmodelwithtitle:@"江山" color:TEXTCOMMONCOLORSecond textfont:TEXTFONTWITHSIZE(21)];
//    aboutDataModel  *model5 = [aboutDataModel aboutmodelwithtitle:@"陈虹志" color:TEXTCOMMONCOLORSecond textfont:TEXTFONTWITHSIZE(21)];
//    aboutDataModel  *model6 = [aboutDataModel aboutmodelwithtitle:@"美术" color:[UIColor blackColor] textfont:TEXTFONTWITHSIZE(25)];
//    aboutDataModel  *model7 = [aboutDataModel aboutmodelwithtitle:@"张驰" color:TEXTCOMMONCOLORSecond textfont:TEXTFONTWITHSIZE(21)];
//    aboutDataModel  *model8 = [aboutDataModel aboutmodelwithtitle:@"杨庆元" color:TEXTCOMMONCOLORSecond textfont:TEXTFONTWITHSIZE(21)];
//     aboutDataModel  *model9 = [aboutDataModel aboutmodelwithtitle:@"毕源泉" color:TEXTCOMMONCOLORSecond textfont:TEXTFONTWITHSIZE(21)];
    aboutDataModel  *model10 = [aboutDataModel aboutmodelwithtitle:@"开发" color:[UIColor blackColor] textfont:TEXTFONTWITHSIZE(25)];
    aboutDataModel  *model11 = [aboutDataModel aboutmodelwithtitle:@"Joshon" color:TEXTCOMMONCOLORSecond textfont:TEXTFONTWITHSIZE(21)];
   aboutDataModel  *model12 = [aboutDataModel aboutmodelwithtitle:@"版本" color:[UIColor blackColor] textfont:TEXTFONTWITHSIZE(25)];
    aboutDataModel  *model13 = [aboutDataModel aboutmodelwithtitle:@"1.0.0" color:TEXTCOMMONCOLORSecond textfont:TEXTFONTWITHSIZE(21)];
//    aboutDataModel  *model14 = [aboutDataModel aboutmodelwithtitle:@"卢健勋" color:TEXTCOMMONCOLORSecond textfont:TEXTFONTWITHSIZE(21)];
//    
//    
//    aboutDataModel  *model15 = [aboutDataModel aboutmodelwithtitle:@"测试" color:[UIColor blackColor] textfont:TEXTFONTWITHSIZE(25)];
//    aboutDataModel  *model16 = [aboutDataModel aboutmodelwithtitle:@"刘明星" color:TEXTCOMMONCOLORSecond textfont:TEXTFONTWITHSIZE(21)];
//    aboutDataModel  *model17 = [aboutDataModel aboutmodelwithtitle:@"陈爱琴" color:TEXTCOMMONCOLORSecond textfont:TEXTFONTWITHSIZE(21)];

    
    
    [m_arrayData addObject:ModelNUll];
    [m_arrayData addObject:imageModel];
    [m_arrayData addObject:model10];
    [m_arrayData addObject:model11];
    [m_arrayData addObject:model12];
    [m_arrayData addObject:model13];
    [m_arrayData addObject:ModelNUll];

    [ModelNUll release];
    
    UIButton      *btnback = [[UIButton alloc] initWithFrame:CGRectMake(5, frame.size.height-45+2, 27+40, 22+4)];
    [btnback setImageEdgeInsets:UIEdgeInsetsMake(2, 20, 2, 20)];
    [btnback setImage:[PublicClass getImageAccordName:@"about_back.png"] forState:UIControlStateNormal];
    [btnback addTarget:self action:@selector(clickBackbtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnback];
    [btnback release];
    
}


-(void)clickBackbtn:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    [[NSNotificationCenter defaultCenter] postNotificationName:BNRShowSetView object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_arrayData count];
}


// Section header & footer information. Views are preferred over title should you decide to provide both

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    aboutDataModel  *model = [m_arrayData objectAtIndex:indexPath.row];
    if (model.type == aboutDataModelTypeNone)
    {
        UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"11"];
        
        if (!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"11"] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, m_tableView.frame.size.width, 30)];
            [label setFont:TEXTFONTWITHSIZE(21)];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTag:110];
            [label setBackgroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:label];
            [label release];
        }
        
        
        UILabel  *label = (UILabel*)[cell.contentView viewWithTag:110];
        [label setText:model.title];
        [label setFont:model.textfont];
        [label setTextColor:model.textColor];
        
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setBackgroundView:[[UIView alloc] initWithFrame:CGRectZero]];
        return cell;
        
    }else if(model.type == aboutDataModelTypeImage)
    {
        UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"image"];

        if (!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"image"] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView  *imageword = [[UIImageView alloc] initWithFrame:CGRectMake((m_tableView.frame.size.width-232)/2, 0, 232, 52)];
            imageword.image = [PublicClass getImageAccordName:model.imageName];
            [cell.contentView addSubview:imageword];
            [imageword release];
            
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setBackgroundView:[[UIView alloc] initWithFrame:CGRectZero]];
        }
        return cell;
        
    }else if (model.type ==  aboutDataModelTypeNULL)
    {
        UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"nil"];
        
        if (!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nil"] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setBackgroundView:[[UIView alloc] initWithFrame:CGRectZero]];
        return cell;
        
    }
    
    return nil;

}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    aboutDataModel  *model = [m_arrayData objectAtIndex:indexPath.row];
    
    if (model.type == aboutDataModelTypeImage)
    {
        return 52;
    }else if (model.type == aboutDataModelTypeNone)
    {
        return 40;
    }
    
    return m_tableView.frame.size.height;
}

/*
// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    DLOG(@"scrollViewWillBeginDragging:%@",scrollView);
}
// called on finger up if the user dragged. velocity is in points/second. targetContentOffset may be changed to adjust where the scroll view comes to rest. not called when pagingEnabled is YES
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
     DLOG(@"scrollViewWillEndDragging:%@",scrollView);
}
// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
     DLOG(@"scrollViewDidEndDragging:%@",scrollView);
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    DLOG(@"scrollViewWillBeginDecelerating:%@",scrollView);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    DLOG(@"scrollViewWillBeginDecelerating:%@",scrollView);
}*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    
    
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
    
}

- (BOOL)shouldAutorotate
{
    DLOG(@"shouldAutorotate");
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations
{
    return  UIInterfaceOrientationMaskLandscape;
}




-(void)dealloc
{
    [m_bgView release];
    m_bgView = nil;
    [m_tableView stopScrolling];
    [m_tableView release];
    m_tableView = nil;
    [m_arrayData release];
    m_arrayData = nil;
    [super dealloc];
}
@end
