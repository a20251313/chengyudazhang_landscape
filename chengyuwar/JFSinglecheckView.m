//
//  JFSinglecheckView.m
//  chengyuwar
//
//  Created by ran on 13-12-13.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFSinglecheckView.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"
@implementation JFSinglecheckView
@synthesize model;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled  = YES;
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSelf:)];
        [self addGestureRecognizer:tap];
        [tap release];
        // Initialization code
    }
    return self;
}

-(void)clickSelf:(id)sender
{
    if (delegate  && [delegate respondsToSelector:@selector(chooseIdiomModel:)])
    {
        [delegate chooseIdiomModel:self.model];
    }
    DLOG(@"clickSelf:%@",sender);
    
}
-(void)updateViewWithDatamodel:(JFIdiomModel*)tempmodel
{
    
    static UIImage *imageanswer = nil;
    
    if (!imageanswer)
    {
        imageanswer = [[UIImage imageNamed:@"check_single_answered_bg.png"] retain];

    }
    
    static UIImage  *imageNeedUnlock = nil;
    if (!imageNeedUnlock)
    {
        imageNeedUnlock = [[UIImage imageNamed:@"check_single_unanswered_bg.png"] retain];
    }
    
    
    self.model = tempmodel;
    UIImageView  *view = (UIImageView*)[self viewWithTag:1000];
    UIImageView  *imageview = (UIImageView*)[self viewWithTag:1003];
    if (model.isUnlocked)
    {
        self.image = imageanswer;
        if (!view)
        {

            view = [[UtilitiesFunction getImagewithNumber:[self.model.idiomlevelString intValue] type:JFPicNumberTypeLevelNumber] retain];
            [self addSubview:view];
            view.userInteractionEnabled = YES;
            view.tag = 1000;
            //view.center = self.center;
            [view setFrame:CGRectMake((self.frame.size.width-view.frame.size.width)/2, (self.frame.size.height-view.frame.size.height)/2, view.frame.size.width, view.frame.size.height)];
           
            [view release];
        }
        
        if (!imageview)
        {
            imageview = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-50)/2, (self.frame.size.height-50)/2, 50, 50)];
            imageview.userInteractionEnabled = YES;
            imageview.tag = 1003;
            imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"check_role%d.png",(([model.idiomlevelString intValue]-1)/120)%5+1]];
            [self insertSubview:imageview atIndex:0];
            [imageview release];
        }
        
        [view setHidden:NO];
    }else
    {
        self.image = imageNeedUnlock;
        [view setHidden:YES];
    }
    

    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)dealloc
{
    self.model = nil;
    [super dealloc];
}

@end
