//
//  JFRankModel.m
//  chengyuwar
//
//  Created by ran on 13-12-14.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFRankModel.h"

@implementation JFRankModel

@synthesize nickName;
@synthesize rankIndex;
@synthesize userRankScore;
@synthesize conWinNumber;

-(void)dealloc
{
    self.nickName = nil;
    [super dealloc];
}
@end
