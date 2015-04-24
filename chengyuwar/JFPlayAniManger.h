//
//  JFPlayAniManger.h
//  chengyuwar
//
//  Created by ran on 14-1-6.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CABasicAnimation+someAniForProp.h"
typedef enum
{
    JFGoldImageTypeAdd,
    JFGoldImageTypeDelete
}JFGoldImageType;
@interface JFPlayAniManger : NSObject



+(void)addGoldWithAni:(int)goldNumber;
+(void)deleteGoldWithAni:(int)goldNumber;
@end
