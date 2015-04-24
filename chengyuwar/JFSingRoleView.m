//
//  JFSingRoleView.m
//  chengyuwar
//
//  Created by ran on 13-12-16.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFSingRoleView.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"
@implementation JFSingRoleView
@synthesize delegate;
@synthesize model;


- (id)initWithFrame:(CGRect)frame  withRole:(JFRoleModel*)role
{
    self = [super initWithFrame:frame];
    self.model = role;
    if (self)
    {
        // Initialization code
    }
    return self;
}

-(void)updateRoleViewWithModel:(JFRoleModel*)role needNickName:(BOOL)bNeed
{
    
    if ([role isKindOfClass:[NSNull class]])
    {
        return;
    }
    self.model = role;
    CGFloat    fXpoint = 5;
    CGFloat    fYpoint = 40;
    if (!m_ownphotoView)
    {
        m_ownphotoView = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint,fYpoint, 130, 130)];
        [self addSubview:m_ownphotoView];
        m_ownphotoView.userInteractionEnabled = YES;
    }
    
    if (self.model.needUnlock)
    {
        m_ownphotoView.image = [PublicClass getImageAccordName:self.model.ownPhotoGray];
    
        if (!m_imageLock)
        {
            m_imageLock = [[UIImageView alloc] initWithFrame:CGRectMake((m_ownphotoView.frame.size.width-38)/2, (m_ownphotoView.frame.size.height-48)/2, 38, 48)];
            [m_ownphotoView addSubview:m_imageLock];
             m_imageLock.image = [PublicClass getImageAccordName:@"createrole_lockicon.png"];
        }
    }else
    {
     
         m_ownphotoView.image = [PublicClass getImageAccordName:self.model.ownPhoto];
         [m_imageLock removeFromSuperview];
    }
    
    
    fXpoint += 130+10;
    fYpoint -= 20;
    if (!m_rolenameView)
    {
        m_rolenameView = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, 62, 22)];
        [self addSubview:m_rolenameView];
    }
    m_rolenameView.image = [PublicClass getImageAccordName:self.model.nameImageName];
    
    
    fXpoint += 2;
    fYpoint += 22+10;
    UIImageView *viewIntroduce = (UIImageView *)[self viewWithTag:1000];
    if (!viewIntroduce)
    {
        viewIntroduce = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, 40, 17)];
        viewIntroduce.image = [PublicClass getImageAccordName:@"createrole_introduceword.png"];
        [self addSubview:viewIntroduce];
        viewIntroduce.tag = 1000;
        [viewIntroduce release];
    }
   
    fYpoint += 22+10;
    if (!m_characterView)
    {
        m_characterView = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint+20, fYpoint, 146, 36)];
        [self addSubview:m_characterView];
    }
    m_characterView.image = [PublicClass getImageAccordName:self.model.characterImageName];
    
    
    fYpoint += 35+10;
    UIView  *nickBg = [self viewWithTag:1001];
    
    if (!nickBg && bNeed)
    {
        nickBg =    [[UIView alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, self.frame.size.width-fXpoint, 24)];
        [self addSubview:nickBg];
        nickBg.userInteractionEnabled = YES;
        UIImageView  *imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, 40, 17)];
        imageIcon.image = [PublicClass getImageAccordName:@"createrole_nickname_titile.png"];
        [nickBg addSubview:imageIcon];
        
        UIImageView  *imagenamebg = [[UIImageView alloc] initWithFrame:CGRectMake(40+20, 0, 98, 24)];
        imagenamebg.image = [PublicClass getImageAccordName:@"createrole_name_bg.png"];
        [nickBg addSubview:imagenamebg];
        
        imagenamebg.userInteractionEnabled = YES;
        m_textName = [[UITextField alloc] initWithFrame:CGRectMake(3, 3, imagenamebg.frame.size.width-4, 20)];
        [m_textName setText:model.name];
        [m_textName setFont:[UIFont systemFontOfSize:12]];
        [m_textName setDelegate:self];
        [m_textName setBorderStyle:UITextBorderStyleNone];
        [m_textName setTextColor:[UIColor whiteColor]];
        [m_textName setPlaceholder:@"请输入昵称"];
        [imagenamebg addSubview:m_textName];
        
        UIButton  *btndice = [[UIButton alloc] initWithFrame:CGRectMake(98+40+20, -3, 15+10, 16+10)];
        [btndice setImage:[PublicClass getImageAccordName:@"createrole_dice.png"] forState:UIControlStateNormal];
        [btndice setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [btndice addTarget:self action:@selector(clickChangeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [nickBg addSubview:btndice];
        
        [btndice release];
        [imagenamebg release];
        [imageIcon release];
        [nickBg release];
        //createrole_nickname_titile
    }
 
    UIImageView  *imageCheckview = (UIImageView*)[m_ownphotoView viewWithTag:2000];
    if (self.model.needCheckView)
    {
        //31 34 createrole_check
        if (!imageCheckview)
        {
            imageCheckview = [[UIImageView alloc] initWithFrame:CGRectMake((m_ownphotoView.frame.size.width-31)/2, (m_ownphotoView.frame.size.height-34)/2, 31, 34)];
            imageCheckview.image = [PublicClass getImageAccordName:@"createrole_check.png"];
            [m_ownphotoView addSubview:imageCheckview];
            [imageCheckview release];
        }
        
    }else
    {
        [imageCheckview removeFromSuperview];
    }
    
    
}


-(void)dealloc
{
    [m_ownphotoView release];
    m_ownphotoView = nil;
    [m_textName release];
    m_textName = nil;
    [m_characterView release];
    m_characterView = nil;
    [m_imageLock release];
    m_imageLock = nil;
    [m_rolenameView release];
    m_rolenameView = nil;
    [m_arrayNickName release];
    m_arrayNickName = nil;
    self.model = nil;
    [super dealloc];
}
-(void)clickChangeBtn:(id)sender
{
    
    [m_textName setTextColor:[UIColor whiteColor]];

    if (!m_arrayNickName)
    {
        m_arrayNickName = [[NSMutableArray alloc] init];
        NSString  *strPath = [[NSBundle mainBundle] pathForResource:@"nickname" ofType:@"txt"];
        NSError  *error = nil;
        NSString  *strContent = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:&error];
        if (error)
        {
            DLOG(@"strPath read error:%@ error:%@",strPath,error);
        }else
        {
            NSArray  *array = [strContent componentsSeparatedByString:@","];
            [m_arrayNickName addObjectsFromArray:array];
           // DLOG(@"get array nick name:%@",array);
        }
        
    }
    

    static int i = 0;
    srandom(time(NULL)+i);
    i++;
    int index = random()%[m_arrayNickName count];
    [m_textName setText:[m_arrayNickName objectAtIndex:index]];
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    DLOG(@"clickChangeBtn:%@",sender);
}



#pragma mark uitextfielddelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (delegate && [delegate respondsToSelector:@selector(textDidBegin:)])
    {
        [delegate textDidBegin:textField];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
   
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(NSString*)getTextValue
{
    return m_textName.text;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (range.length == 1)
    {
        return YES;
    }
    
    
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([toBeString length] > 8)
    {
        return NO;
    }
    
    [textField setTextColor:[UIColor whiteColor]];
    
    return YES;
}


-(void)flash
{

    [m_textName setAlpha:0];
    [m_textName setText:@"请输入昵称"];
    [m_textName setTextColor:[UIColor whiteColor]];
    
    [UIView beginAnimations:@"flash screen" context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationRepeatCount:2];
    //  [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    //    [UIView setAnimationDelegate:self];
    [m_textName setAlpha:1];
    [m_textName setText:@"请输入昵称"];
    [m_textName setTextColor:[UIColor redColor]];

    [UIView commitAnimations];
}

//- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (delegate && [delegate respondsToSelector:@selector(textDidResign:)])
    {
        [delegate textDidResign:textField];
    }
    [textField resignFirstResponder];
    return YES;
}/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
