//
//  JFAlertUpdateView.h
//  chengyuwar
//
//  Created by ran on 13-12-17.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCProgressBarView.h"
#import "JFAlertUpdateView.h"
#import "JFDownZipManger.h"

@protocol JFAlertUpdateViewDelegate <NSObject>
-(void)downLoadUpdateInfoSuc:(id)thread;
-(void)clickCancelUpdateAction:(id)sender;
@end

@interface JFAlertUpdateView : UIView<JFDownZipMangerDelegate>
{
    BOOL        m_bIsWillRemove;
    UIImageView *_backgroundImageView;
    UILabel     *_contentLabel;
    
    UIButton    *_backButton;
    UIView      *_overlayView;
    MCProgressBarView   *_progressView;
    
    id<JFAlertUpdateViewDelegate>   delegate;
    JFDownZipManger *m_downZip;
}

@property(nonatomic,assign)id<JFAlertUpdateViewDelegate>   delegate;

-(void)loadDownZipArray:(NSMutableArray*)array;

-(void)setProgress:(CGFloat)fprogress;
- (void)show;
@end
