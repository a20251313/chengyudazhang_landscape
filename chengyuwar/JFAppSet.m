//
//  JFAppSet.m
//  chengyuwar
//
//  Created by ran on 13-12-10.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFAppSet.h"

static  JFAppSet  *appset = nil;

@implementation JFAppSet

@synthesize curreninterface;
@synthesize bgvolume;
@synthesize SoundEffect;
@synthesize exhibitiontype;
@synthesize scorewalltype;

+(NSString*)storePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"localJFAppSet"];
    
  //  NSError *error = nil;
   /* if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createFileAtPath:dataPath contents:nil attributes:nil:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    if (error)
    {
        DLOG(@"error:%@",error);
    }*/
    return dataPath;
}


+(void)storeShareInstance
{
    NSString  *strPath = [JFAppSet storePath];
    BOOL  bsuc =  [NSKeyedArchiver archiveRootObject:appset toFile:strPath];
    if (!bsuc)
    {
        DLOG(@"JFAppSet storeShareInstance strPath  fail:%@",strPath);
    }
}
+(id)shareInstance
{
    if (!appset)
    {
        appset = [[NSKeyedUnarchiver unarchiveObjectWithFile:[JFAppSet storePath]] retain];
        if (!appset)
        {
           appset = [[JFAppSet alloc] init];
        }
    }
    return appset;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        
        self.bgvolume = [aDecoder decodeFloatForKey:@"bgvolume"];
        self.SoundEffect = [aDecoder decodeFloatForKey:@"SoundEffect"];
        self.curreninterface = [aDecoder decodeIntForKey:@"curreninterface"];
        self.exhibitiontype = [aDecoder decodeIntForKey:@"exhibitiontype"];
        self.curreninterface =  UIInterfaceOrientationMaskLandscape;
        self.exhibitiontype = ad_exhibition_typeYouMi;
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeFloat:self.bgvolume forKey:@"bgvolume"];
    [aCoder encodeFloat:self.SoundEffect forKey:@"SoundEffect"];
    [aCoder encodeInt:self.curreninterface forKey:@"curreninterface"];
    [aCoder encodeInt:self.exhibitiontype forKey:@"exhibitiontype"];
    
}
-(id)init
{
    self = [super init];
    if (self)
    {
        
        self.curreninterface = UIInterfaceOrientationMaskLandscape;
        self.exhibitiontype = ad_exhibition_typeYouMi;
        self.bgvolume = 0.5;
        self.SoundEffect = 1.0;
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
}
@end
