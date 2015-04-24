//
//  JFExchangeView.h
//  chengyuwar
//
//  Created by ran on 14-1-9.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFExchangeNet.h"
#import "JFAlertView.h"

@interface JFExchangeView : UIView<UITextFieldDelegate,JFExchangeNetDelegate>
{
    
    UITextField         *m_textWord;
    JFExchangeNet       *m_exchangeNet;
   // id<JFShareWordViewDelegate> delegate;
}
//@property(nonatomic,assign)id<JFShareWordViewDelegate> delegate;

-(void)show;

@end