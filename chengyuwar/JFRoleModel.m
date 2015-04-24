//
//  JFRoleModel.m
//  chengyuwar
//
//  Created by ran on 13-12-16.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFRoleModel.h"
#import "JFSQLManger.h"
@implementation JFRoleModel
@synthesize roleType;
@synthesize name;
@synthesize nameImageName;
@synthesize characterImageName;
@synthesize ownPhoto;
@synthesize ownPhotoGray;
@synthesize unlockGold;
@synthesize needUnlock;
@synthesize needCheckView;          //just for view show check box
@synthesize leftFaceImageName;
@synthesize rightFaceImageName;



-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.roleType = [aDecoder decodeIntForKey:@"roleType"];
        self.needCheckView = [aDecoder decodeBoolForKey:@"needCheckView"];
        self.needUnlock =   [aDecoder decodeBoolForKey:@"needUnlock"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.nameImageName = [aDecoder decodeObjectForKey:@"nameImageName"];
        self.characterImageName = [aDecoder decodeObjectForKey:@"characterImageName"];
        self.ownPhoto = [aDecoder decodeObjectForKey:@"ownPhoto"];
        self.ownPhotoGray = [aDecoder decodeObjectForKey:@"ownPhotoGray"];
        self.leftFaceImageName = [aDecoder decodeObjectForKey:@"leftFaceImageName"];
        self.rightFaceImageName = [aDecoder decodeObjectForKey:@"rightFaceImageName"];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:self.nameImageName forKey:@"nameImageName"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.characterImageName forKey:@"characterImageName"];
    [aCoder encodeObject:self.ownPhoto forKey:@"ownPhoto"];
    [aCoder encodeObject:self.ownPhotoGray forKey:@"ownPhotoGray"];
    [aCoder encodeObject:self.leftFaceImageName forKey:@"leftFaceImageName"];
    [aCoder encodeObject:self.rightFaceImageName forKey:@"rightFaceImageName"];
    [aCoder encodeInt:self.roleType forKey:@"roleType"];
    [aCoder encodeBool:self.needCheckView forKey:@"needCheckView"];
    [aCoder encodeBool:self.needUnlock forKey:@"needUnlock"];
}



-(id)initWithType:(JFRoleModelType)type
{
    self = [super init];
    if (self)
    {
        self.roleType = type;
    
        switch (type)
        {
            case JFRoleModelTypebaijingjing:
                self.name = @"白晶晶";
                self.nameImageName = @"createrole_baijingjing_word.png";
                self.characterImageName = @"createrole_baijingjing_description.png";
                self.ownPhoto = @"createrole_baijingjingimage.png";
                self.ownPhotoGray = nil;
                self.leftFaceImageName = @"baijingjing_faceleft.png";
                self.rightFaceImageName = @"baijingjing_faceright.png";
                break;
            case JFRoleModelTypeshaheshang:
                self.name = @"沙和尚";
                self.nameImageName = @"createrole_shaheshang_word.png";
                self.characterImageName = @"createrole_shaheshang_description.png";
                self.ownPhoto = @"createrole_shaheshangimage.png";
                self.ownPhotoGray = nil;
                self.leftFaceImageName = @"shanheshang_faceleft.png";
                self.rightFaceImageName = @"shanheshang_faceright.png";
                break;
            case JFRoleModelTypezhuyuanshuai:
                self.name = @"猪元帅";
                self.nameImageName = @"createrole_zhuyuanshuai_word.png";
                self.characterImageName = @"createrole_zhuyuanshuai_description.png";
                self.ownPhoto = @"createrole_zhuyuanshuaiimage.png";
                self.ownPhotoGray = nil;
                self.leftFaceImageName = @"zhuyuanshuai_faceleft.png";
                self.rightFaceImageName = @"zhuyuanshuai_faceright.png";
                break;
            case JFRoleModelTypesundashen:
                self.name = @"孙大圣";
                self.nameImageName = @"createrole_sundashen_word.png";
                self.characterImageName = @"createrole_sundashen_description.png";
                self.ownPhoto = @"createrole_sundashenimage.png";
                self.ownPhotoGray = @"createrole_sundashenimagegray.png";
                self.leftFaceImageName = @"sundashen_faceleft.png";
                self.rightFaceImageName = @"sundashen_faceright.png";
                self.unlockGold = 1000;
                self.needUnlock = ![JFSQLManger roleIsUnlock:self.roleType];
                break;
            case JFRoleModelTypetangxiaozang:
                self.name = @"唐小藏";
                self.nameImageName = @"createrole_tangxiaozang_word.png";
                self.characterImageName = @"createrole_tangxiaozang_description.png";
                self.ownPhoto = @"createrole_tangxiaozangimage.png";
                self.ownPhotoGray = @"createrole_tangxiaozangimagegray.png";
                self.leftFaceImageName = @"tangxiaozang_faceleft.png";
                self.rightFaceImageName = @"tangxiaozang_faceright.png";
                self.unlockGold = 3000;
                self.needUnlock = ![JFSQLManger roleIsUnlock:self.roleType];;
                break;
                
            default:
                break;
        }
        
    }
    return self;
}

-(void)dealloc
{
    self.nameImageName = nil;
    self.name = nil;
    self.characterImageName = nil;
    self.ownPhoto = nil;
    self.ownPhotoGray = nil;
    self.leftFaceImageName = nil;
    self.rightFaceImageName = nil;
    [super dealloc];
}
@end
