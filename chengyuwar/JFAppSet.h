//
//  JFAppSet.h
//  chengyuwar
//
//  Created by ran on 13-12-10.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "AdCommonDef.h"

@interface JFAppSet : NSObject<NSCoding>

@property(nonatomic)UIInterfaceOrientationMask  curreninterface;
@property(nonatomic)CGFloat             SoundEffect;
@property(nonatomic)CGFloat             bgvolume;
@property(nonatomic)ad_exhibition_type  exhibitiontype;
@property(nonatomic)ad_score_wall_type  scorewalltype;
+(id)shareInstance;
+(void)storeShareInstance;
@end
