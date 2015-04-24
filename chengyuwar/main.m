//
//  main.m
//  chengyuwar
//
//  Created by ran on 13-12-10.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JFAppDelegate.h"


int main(int argc, char * argv[])
{
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([JFAppDelegate class]));
    [pool release];
    return retVal;
}



