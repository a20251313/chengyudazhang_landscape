//
//  JFLevelModel.h
//  chengyuwar
//
//  Created by ran on 14-1-10.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
     JFLevelModelTypebuyi,
     JFLevelModelTypexiucai,
     JFLevelModelTypejuren,
     JFLevelModelTypejinshi,
     JFLevelModelTypetahua,
     JFLevelModelTypebangyan,
     JFLevelModelTypezhuangyuan,
     JFLevelModelTypechenxiang,
     JFLevelModelTypeshangshu,
     JFLevelModelTypehuangdi,

}JFLevelModelType;
@interface JFLevelModel : NSObject


@property(nonatomic,copy)NSString   *levelName;
@property(nonatomic,copy)NSString   *levelDescription;
@property(nonatomic)JFLevelModelType levelType;
+(id)levelModelWithType:(JFLevelModelType)type;
@end
