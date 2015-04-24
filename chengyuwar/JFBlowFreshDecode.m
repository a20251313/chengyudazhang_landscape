//
//  JFBlowFreshDecode.m
//  chengyuwar
//
//  Created by ran on 14-1-14.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFBlowFreshDecode.h"
#import "popobf.h"

#define BLOWFRESHPWD        @"3b145d00529bd3f9c488843b84b06fe7"

@implementation JFBlowFreshDecode

+(NSData*)getDataAccordFilePath:(NSString*)strPath
{
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:strPath])
    {
        DLOG(@"getDataAccordFilePath file is not exist :%@",strPath);
        return nil;
    }
    NSError *error = nil;
    
    NSData *data = [NSData dataWithContentsOfFile:strPath options:NSDataReadingMappedIfSafe error:&error];

    
    int size = data.length;
    int d = size % 8;
    if (d != 0)
    {
        size = ((data.length/8)+1) * 8;
    }
    
    unsigned char *buf = (unsigned char *)malloc(sizeof(unsigned char) * size);
    memset(buf, 0, sizeof(unsigned char) * size);
    [data getBytes:buf length:sizeof(unsigned char) * size];
    
    char *pwd = (char*)[BLOWFRESHPWD UTF8String];
    popo_bf_set_key((unsigned char *)pwd, [BLOWFRESHPWD length]);
   
   // popo_bf_encrypt(buf, size);
    popo_bf_decrypt(buf, data.length);
    NSData *imgData1 = [NSData dataWithBytes:buf length:size];
    if (error)
    {
        DLOG(@"getDataAccordFilePath error:%@",error);
    }

    free(buf);
    buf = NULL;
    return imgData1;
    
}
@end
