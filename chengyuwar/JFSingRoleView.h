//
//  JFSingRoleView.h
//  chengyuwar
//
//  Created by ran on 13-12-16.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFRoleModel.h"
#import "JFAudioPlayerManger.h"
@protocol JFSingRoleViewDelegate <NSObject>

-(void)textDidBegin:(UITextField*)textField;
-(void)textDidResign:(UITextField*)textField;
@end


@interface JFSingRoleView : UIView<UITextFieldDelegate>
{
    UIImageView     *m_characterView;
    UITextField     *m_textName;
    UIImageView     *m_ownphotoView;
    
    UIImageView     *m_imageLock;
    UIImageView     *m_rolenameView;
    
    id<JFSingRoleViewDelegate>  delegate;
    NSMutableArray  *m_arrayNickName;
}

@property(nonatomic,retain)JFRoleModel  *model;
@property(nonatomic,assign)id<JFSingRoleViewDelegate> delegate;
-(NSString*)getTextValue;


-(void)updateRoleViewWithModel:(JFRoleModel*)role needNickName:(BOOL)bNeed;
- (id)initWithFrame:(CGRect)frame  withRole:(JFRoleModel*)role;
-(void)flash;
@end
