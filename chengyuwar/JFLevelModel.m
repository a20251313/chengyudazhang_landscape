//
//  JFLevelModel.m
//  chengyuwar
//
//  Created by ran on 14-1-10.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFLevelModel.h"

@implementation JFLevelModel
@synthesize levelDescription;
@synthesize levelName;
@synthesize levelType;

+(id)levelModelWithType:(JFLevelModelType)type
{
    JFLevelModel *model = [[JFLevelModel alloc] init];
    if (model)
    {
        NSString    *strName = nil;
        NSString    *strDescription = nil;
        
        switch (type)
        {
            case JFLevelModelTypebuyi:
                strName = @"布衣";
                strDescription = @"30分以下";
                break;
            case JFLevelModelTypexiucai:
                strName = @"秀才";
                strDescription = @"30（含）~90分";
                break;
            case JFLevelModelTypejuren:
                strName = @"举人";
                strDescription = @"90（含）~180分";
                break;
            case JFLevelModelTypejinshi:
                strName = @"进士";
                strDescription = @"180（含）~360分";
                break;
            case JFLevelModelTypetahua:
                strName = @"探花";
                strDescription = @"360（含）~600分";
                break;
            case JFLevelModelTypebangyan:
                strName = @"榜眼";
                strDescription = @"600（含）~900分";
                break;
            case JFLevelModelTypezhuangyuan:
                strName = @"状元";
                strDescription = @"900（含）~1500分";
                break;
            case JFLevelModelTypeshangshu:
                strName = @"尚书";
                strDescription = @"1500（含）~3000分";
                break;
            case JFLevelModelTypechenxiang:
                strName = @"丞相";
                strDescription = @"3000（含）~6000分";
                break;
            case JFLevelModelTypehuangdi:
                strName = @"皇帝";
                strDescription = @"6000（含）分以上";
                break;
            default:
                break;
        }
        model.levelName = strName;
        model.levelDescription = strDescription;
        
    }
    return [model autorelease];
}
-(void)dealloc
{
    self.levelDescription = nil;
    self.levelName = nil;
    [super dealloc];
}

@end
