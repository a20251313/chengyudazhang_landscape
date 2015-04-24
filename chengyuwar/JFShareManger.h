//
//  JFShareManger.h
//  chengyuwar
//
//  Created by ran on 13-12-25.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFShareView.h"
#import "JFShareWordView.h"
#import "JFLocalPlayer.h"
//#import <Frontia/Frontia.h>

@interface JFShareManger : NSObject<JFShareViewDelegate,JFShareWordViewDelegate>


@property(nonatomic,copy)NSString       *shareMsg;
@property(nonatomic,retain)UIImage      *shareImage;
@property(nonatomic)JFShareModelType    type;



+(void)shareWithMsg:(NSString*)msg image:(UIImage*)image;
@end
