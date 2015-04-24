//
//  JFPhaseXmlData.m
//  chengyuwar
//
//  Created by ran on 13-12-26.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFPhaseXmlData.h"
#import "GDataXMLNode.h"
#import "JFIdiomModel.h"
#import "JFDownUrlModel.h"
#import "UtilitiesFunction.h"
#import "JFBlowFreshDecode.h"
@implementation JFPhaseXmlData


+(NSMutableArray*)getAllIdiomFromDownloadFiles
{
    
    NSMutableArray  *arrayAll = [NSMutableArray array];
    NSMutableArray  *arrZip = [JFPhaseXmlData phaseUrlInfoAccordPath:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME] xmlType:JFPhaseXmlDataTypeNormalXml rootPath:nil];
    for (JFDownUrlModel *model in arrZip)
    {
        NSMutableArray  *arrayTemp = [JFPhaseXmlData phaseUrlInfoAccordPath:[[UtilitiesFunction getNormalQustionZip:model.md5String] stringByAppendingPathComponent:DOWNDEScription] xmlType:JFPhaseXmlDataTypeNormalIdiom rootPath:[UtilitiesFunction getNormalQustionZip:model.md5String]];
        [arrayAll addObjectsFromArray:arrayTemp];
    }

    DLOG(@"getAllIdiomCountFromDownloadFiles:%d",[arrayAll count]);
    return arrayAll;
}


+(int)getAllIdiomCountFromDownloadFiles
{
    NSMutableArray  *arrZip = [JFPhaseXmlData phaseUrlInfoAccordPath:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME] xmlType:JFPhaseXmlDataTypeNormalXml rootPath:nil];
    int count = 0;
    for (JFDownUrlModel *model in arrZip)
    {
        count += [JFPhaseXmlData getIdidomcountAccordPath:[[UtilitiesFunction getNormalQustionZip:model.md5String] stringByAppendingPathComponent:DOWNDEScription]];
    }
    
    DLOG(@"getAllIdiomCountFromDownloadFiles:%d",count);
    return count;
}
+(BOOL)checkArrayZip:(NSMutableArray*)inputArray  outArray:(NSMutableArray*)outArray
{
    BOOL    bRight = YES;
    
    for (int i = 0; i < [inputArray count]; i++)
    {
        JFDownUrlModel  *model = [inputArray objectAtIndex:i];
        NSString    *filePath = nil;
        switch (model.urlType)
        {
            case JFDownUrlModelTypeNormalQustion:
                filePath = [UtilitiesFunction getNormalQustionZip:model.md5String];
                break;
            case JFDownUrlModelTypeRaceQustion:
                filePath = [UtilitiesFunction getRaceQustionZip:model.md5String];
                break;
                
            default:
                break;
        }
        
        
        if (filePath == nil)
        {
            [outArray addObject:model];
            bRight  = bRight && NO;
            DLOG(@"checkArrayZip addone because no file");
            continue;
        }
        
        filePath = [filePath stringByAppendingString:@".zip"];
        NSString    *md5String = [UtilitiesFunction file_md5:filePath];
        if (![md5String isEqualToString:model.md5String])
        {
            
            switch (model.urlType)
            {
                case JFDownUrlModelTypeNormalQustion:
                    [UtilitiesFunction deleteNormalQustionZip:model.md5String];
                    break;
                case JFDownUrlModelTypeRaceQustion:
                    [UtilitiesFunction deleteRaceQustionZip:model.md5String];
                    break;
                    
                default:
                    break;
            }
            [outArray addObject:model];
             DLOG(@"md5 check fail,mismatch   md5String:%@,model.md5String:%@",md5String,model.md5String);
            bRight  = bRight && NO;
            
        }else
        {
            bRight  = bRight && YES;
           DLOG(@"md5 check suc");
        }
    }
    return !bRight;
}
+(int)phaseXml:(NSString*)strPath xmlType:(JFPhaseXmlDataType)xmlType
{

    //NSData  *data = [JFBlowFreshDecode getDataAccordFilePath:strPath];
    int     version = -1;
    NSError *error = nil;
    GDataXMLDocument  *doc = [[GDataXMLDocument alloc] initWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:&error];
    if (doc)
    {
        switch (xmlType)
        {
            case JFPhaseXmlDataTypeNormalXml:
            {
                GDataXMLElement  *rootele = [doc rootElement];
                NSString    *dbversion = [[[rootele elementsForName:@"db_ver"] objectAtIndex:0] stringValue];
                version = [dbversion intValue];
            }
                break;
            default:
                break;
        }
    }
    
    [doc release];
    doc = nil;
    
    
    return version;
}
+(CGFloat)phaseXmlZipSize:(NSString*)strPath xmlType:(JFPhaseXmlDataType)xmlType
{
    
    CGFloat     size = 0;
    GDataXMLDocument  *doc = [[GDataXMLDocument alloc] initWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:NULL];
    if (doc)
    {
        switch (xmlType)
        {
            case JFPhaseXmlDataTypeNormalXml:
            {
                GDataXMLElement  *rootele = [doc rootElement];
                NSArray *nextele = [rootele elementsForName:@"package"];
                
                
                for (GDataXMLElement *ele in nextele)
                {
                    CGFloat tempsize = [[[[ele elementsForName:@"pagszie"] objectAtIndex:0] stringValue] floatValue];
                    size += tempsize;
                }
              
            }
                break;
            default:
                break;
        }
    }
    
    [doc release];
    doc = nil;
    
    
    return size;
}



+(int)getIdidomcountAccordPath:(NSString*)strPath
{
    //  DLOG(@"data:%@",[NSString stringWithUTF8String:[data bytes]]);
    GDataXMLDocument  *doc = nil;
    NSData  *data = [JFBlowFreshDecode getDataAccordFilePath:strPath];
    doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:NULL];
    int count = 0;
    if (doc)
    {
        GDataXMLElement  *rootele = [doc rootElement];
        // NSArray *array = [rootele elementsForName:@"package"];
        GDataXMLElement *question = [[rootele elementsForName:@"question"] objectAtIndex:0];
        NSArray *array = [question elementsForName:@"p"];
        count = [array count];
        
        if (count || array == nil)
        {
            array = [rootele elementsForName:@"p"];
        }
        count = [array count];
    }
    
    [doc release];
    doc = nil;
    
    //  DLOG(@"phaseUrlInfoAccordPath:%@",arrayData);
    return count;
}

+(NSMutableArray*)phaseUrlInfoAccordPath:(NSString*)strPath    xmlType:(JFPhaseXmlDataType)xmlType rootPath:(NSString*)rootPath
{
  
    NSData  *data = nil;
  //  DLOG(@"data:%@",[NSString stringWithUTF8String:[data bytes]]);
    GDataXMLDocument  *doc = nil;
    if (xmlType == JFPhaseXmlDataTypeNormalXml)
    {
        doc = [[GDataXMLDocument alloc] initWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:NULL];
    }else
    {
         data = [JFBlowFreshDecode getDataAccordFilePath:strPath];
         doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:NULL];
    }
    
    
    
    
    NSMutableArray  *arrayData = [NSMutableArray array];
    if (doc)
    {
        switch (xmlType)
        {
            case JFPhaseXmlDataTypeNormalXml:
            {
                GDataXMLElement  *rootele = [doc rootElement];
                NSArray *array = [rootele elementsForName:@"package"];
                
                for (GDataXMLElement *xmlData in array)
                {
                    JFDownUrlModel  *downLoadModel = [[JFDownUrlModel alloc] init];
                    downLoadModel.urlType = JFDownUrlModelTypeNormalQustion;
                    downLoadModel.urlString = [[[xmlData elementsForName:@"link"] objectAtIndex:0] stringValue];
                    downLoadModel.md5String = [[[xmlData elementsForName:@"md5"] objectAtIndex:0] stringValue];
                    downLoadModel.packageSize = [[[[xmlData elementsForName:@"pagszie"] objectAtIndex:0] stringValue] floatValue];
                    downLoadModel.index = [[[[xmlData elementsForName:@"idx"] objectAtIndex:0] stringValue] intValue];
                    [arrayData addObject:downLoadModel];
                    [downLoadModel release];
                }
                
            }
                break;
                
            case JFPhaseXmlDataTypeNormalIdiom:
            {
                GDataXMLElement  *rootele = [doc rootElement];
               // NSArray *array = [rootele elementsForName:@"package"];
                
                int  packageIndex = [[[[rootele elementsForName:@"package_idx"] objectAtIndex:0] stringValue] intValue];
                
                GDataXMLElement *question = [[rootele elementsForName:@"question"] objectAtIndex:0];
                NSArray *array = [question elementsForName:@"p"];
                
                if (![array count] || !array)
                {
                    array = [rootele elementsForName:@"p"];
                    if (![array count])
                    {
                        strPath = [strPath stringByAppendingString:@"123"];
                        [data writeToFile:strPath atomically:YES];
                        DLOG(@"phaseUrlInfoAccordPath array is nil:package_idx:%d \nrootele:%@",packageIndex,rootele);
                    }
                 
                }
                for (GDataXMLElement *xmlData in array)
                {
                    JFIdiomModel    *model = [[JFIdiomModel alloc] init];
                    NSString    *lastPath = [[[xmlData elementsForName:@"idiom_guess_pic"] objectAtIndex:0] stringValue];
                    lastPath = [rootPath stringByAppendingPathComponent:lastPath];
                    model.packageIndex = packageIndex;
                    model.index = [[[[xmlData elementsForName:@"idx"] objectAtIndex:0] stringValue] intValue];
                    model.hardType = [[[[xmlData elementsForName:@"level"] objectAtIndex:0] stringValue] intValue];
                    model.idiomOptionstr = [[[xmlData elementsForName:@"option_str"] objectAtIndex:0] stringValue];
                    model.idiomOptionstr = [model.idiomOptionstr stringByReplacingOccurrencesOfString:@"、" withString:@""];
                    model.idiomOptionstr = [model.idiomOptionstr stringByReplacingOccurrencesOfString:@"," withString:@""];model.idiomOptionstr = [model.idiomOptionstr stringByReplacingOccurrencesOfString:@"，" withString:@""];
                    
                    GDataXMLElement *secondEle = [[xmlData elementsForName:@"answer"] objectAtIndex:0];
                    model.idiomAnswer = [[[secondEle elementsForName:@"idiom"] objectAtIndex:0] stringValue];
                    model.idiomExplain = [[[secondEle elementsForName:@"explain"] objectAtIndex:0] stringValue];
                    model.idiomFrom = [[[secondEle elementsForName:@"from"] objectAtIndex:0] stringValue];
                    
                   // model.idiomImageName = [NSString stringWithFormat:@""];
                    model.idiomImageName = lastPath;
                    [arrayData addObject:model];
                    [model release];
                }
                
            }
                break;
            default:
                break;
        }
        
        
    }
    
    [doc release];
    doc = nil;
    
  //  DLOG(@"phaseUrlInfoAccordPath:%@",arrayData);
    return arrayData;
}
@end
