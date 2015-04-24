//
//  JFSinglecheckView.h
//  chengyuwar
//
//  Created by ran on 13-12-13.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFIdiomModel.h"

@protocol JFSinglecheckViewDelegate <NSObject>

-(void)chooseIdiomModel:(JFIdiomModel*)model;

@end


@interface JFSinglecheckView : UIImageView
{
    id<JFSinglecheckViewDelegate>  delegtae;
}

@property(nonatomic,retain)JFIdiomModel  *model;
@property(nonatomic,assign)id<JFSinglecheckViewDelegate>  delegate;
-(void)updateViewWithDatamodel:(JFIdiomModel*)tempmodel;
@end
