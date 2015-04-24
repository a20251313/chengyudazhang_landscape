//
//  JFAboutViewController.h
//  chengyuwar
//
//  Created by ran on 13-12-13.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAAutoTableView.h"

extern  NSString   *const   BNRShowSetView;
typedef enum
{
    aboutDataModelTypeNone,
    aboutDataModelTypeImage,
    aboutDataModelTypeNULL,
}aboutDataModelType;

@interface aboutDataModel : NSObject

@property(nonatomic,copy)NSString  *title;
@property(nonatomic,retain)UIFont  *textfont;
@property(nonatomic,retain)UIColor *textColor;
@property(nonatomic,retain)NSString  *imageName;
@property(nonatomic)aboutDataModelType  type;
+(aboutDataModel*)aboutmodelwithtitle:(NSString*)strTitle color:(UIColor*)temptextColor textfont:(UIFont*)usefont;
+(aboutDataModel*)aboutmodelwithImageName:(NSString*)strImageName;
@end


@interface JFAboutViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray              *m_arrayData;
    DAAutoTableView             *m_tableView;
    UIView                      *m_bgView;
}
@end
