//
//  JFRoleModel.h
//  chengyuwar
//
//  Created by ran on 13-12-16.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    JFRoleModelTypebaijingjing = 21,
    JFRoleModelTypeshaheshang = 22,
    JFRoleModelTypezhuyuanshuai = 23,
    JFRoleModelTypesundashen = 24,
    JFRoleModelTypetangxiaozang = 25
    
}JFRoleModelType;
@interface JFRoleModel : NSObject<NSCoding>


@property(nonatomic,copy)NSString  *name;
@property(nonatomic,copy)NSString  *leftFaceImageName;
@property(nonatomic,copy)NSString  *rightFaceImageName;
@property(nonatomic,copy)NSString  *nameImageName;
@property(nonatomic,copy)NSString  *characterImageName;//性格
@property(nonatomic)int             unlockGold;
@property(nonatomic)BOOL            needUnlock;
@property(nonatomic,copy)NSString   *ownPhoto;
@property(nonatomic,copy)NSString   *ownPhotoGray;//((need unlock)
@property(nonatomic)JFRoleModelType  roleType;
@property(nonatomic)BOOL              needCheckView;   //just for view show check box



-(id)initWithType:(JFRoleModelType)type;

@end
