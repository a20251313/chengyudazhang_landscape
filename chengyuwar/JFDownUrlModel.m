//
//  JFDownUrlModel.m
//  chengyuwar
//
//  Created by ran on 13-12-23.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFDownUrlModel.h"

@implementation JFDownUrlModel
@synthesize urlString;
@synthesize urlType;
@synthesize md5String;
@synthesize packageSize;
@synthesize index;

-(void)dealloc
{
    self.urlString = nil;
    self.md5String = nil;
    [super dealloc];
}

@end
