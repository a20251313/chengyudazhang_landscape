//
//  JFShareWordView.h
//  chengyuwar
//
//  Created by ran on 13-12-27.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol JFShareWordViewDelegate <NSObject>
-(void)shareWithMsg:(NSString*)strMsg  image:(UIImage*)image;
@end

@interface JFShareWordView : UIView<UITextFieldDelegate>
{
    
    UIImageView                     *m_imageScreen;
    UITextField                     *m_textWord;
    id<JFShareWordViewDelegate>     delegate;
}
@property(nonatomic,assign)id<JFShareWordViewDelegate> delegate;


-(void)updateMsg:(NSString*)strMsg  UIImage:(UIImage*)image;
-(void)show;

@end
