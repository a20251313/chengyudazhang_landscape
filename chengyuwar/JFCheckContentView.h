//
//  JFcheckContentView.h
//  chengyuwar
//
//  Created by ran on 13-12-13.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFSinglecheckView.h"
#import "MCProgressBarView.h"


typedef enum
{
    JFidiomContentTypeNeedUnlock,
    JFidiomContentTypeNeedloadMore,
    JFidiomContentTypeUnlockedAll,
}JFIdiomContentType;

@protocol JFCheckContentViewDelegate <NSObject,JFSinglecheckViewDelegate>

-(void)scrollViewDidProgress:(CGFloat)fprogress;
-(void)scrollViewDidBeginProgress:(CGFloat)fprogress;

@end

@interface JFCheckContentView : UIView<UIScrollViewDelegate,JFSinglecheckViewDelegate>
{
    UIScrollView    *m_scorllView;
    NSMutableArray  *m_arrayData;
    id<JFCheckContentViewDelegate>  delegate;
    
    int             m_totlapages;
    JFIdiomContentType  m_icontentType;
    
    MCProgressBarView   *m_progressView;
    UILabel             *m_labelContent;
    
}
@property(nonatomic,assign)id<JFCheckContentViewDelegate>  delegate;
@property(nonatomic)JFIdiomContentType  contentType;

- (id)initWithFrame:(CGRect)frame  withdataArray:(NSMutableArray*)arrayData withType:(JFIdiomContentType)type;
-(void)loadwithArrayData:(NSMutableArray*)data  withType:(JFIdiomContentType)type;

-(void)setProgress:(CGFloat)fprogress;
-(void)addViewWithContentType:(JFIdiomContentType)type;


-(void)setContentOffsetMax:(id)Thread;


-(void)scrollToIndexInTotal:(int)index;
@end
