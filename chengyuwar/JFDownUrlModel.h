//
//  JFDownUrlModel.h
//  chengyuwar
//
//  Created by ran on 13-12-23.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    JFDownUrlModelTypeNormalQustion,
    JFDownUrlModelTypeRaceQustion
}JFDownUrlModelType;

@interface JFDownUrlModel : NSObject

@property(nonatomic)JFDownUrlModelType  urlType;
@property(nonatomic,retain)NSString *urlString;
@property(nonatomic,copy)NSString   *md5String;
@property(nonatomic)float packageSize;
@property(nonatomic)int   index;
@end
