//
//  JFLanchModel.m
//  chengyuwar
//
//  Created by ran on 13-12-23.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFLanchModel.h"

@implementation JFLanchModel

@synthesize question_db_xml_url;
@synthesize question_db_xml_ver;
@synthesize iwvs_server_ip;
@synthesize iwvs_server_port;
@synthesize notice;
@synthesize last_verion;
@synthesize last_verion_url;
@synthesize ios_share_app_url;
@synthesize scorewallType;
@synthesize exhibition_type;



-(void)dealloc
{
    self.question_db_xml_url = nil;
    self.iwvs_server_ip = nil;
    self.notice = nil;
    self.last_verion_url = nil;
    self.ios_share_app_url = nil;
    
    [super dealloc];
}
@end
