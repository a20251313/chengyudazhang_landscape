//
//  JFCreateRoleView.h
//  chengyuwar
//
//  Created by ran on 13-12-16.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFSingRoleView.h"
#import "JFAlertView.h"
typedef enum
{
    JFCreateRoleViewTypeCreate,
    JFCreateRoleViewTypeModify
}JFCreateRoleViewType;

@protocol JFCreateRoleViewDelegate <NSObject>
-(void)userHasCreateRole:(id)Thread;
@optional
-(void)userCancelCreateRole:(id)Thread;
@end

@interface JFCreateRoleView : UIView<UIScrollViewDelegate,JFSingRoleViewDelegate,JFAlertViewDeledate>
{
    JFCreateRoleViewType   m_itype;
    UIScrollView           *m_scrollView;
    NSMutableArray         *m_arrayData;
    UIButton               *m_btnCreate;
    NSMutableArray         *m_arrayViews;
    
    int                     m_ipage;
    id<JFCreateRoleViewDelegate>    delegate;
}
@property(nonatomic,assign)id<JFCreateRoleViewDelegate>    delegate;

-(void)show;
- (id)initWithType:(JFCreateRoleViewType)type;
@end
