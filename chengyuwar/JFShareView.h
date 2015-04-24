//
//  JFShareView.h
//  chengyuwar
//
//  Created by ran on 13-12-25.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum
{
    JFShareModelTypeSina,
    JFShareModelTypeTencent,
    JFShareModelTypeWeiXin,
    JFShareModelTypePengyouquan
}JFShareModelType;
@interface JFShareModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString   *imageName;
@property(nonatomic)JFShareModelType   type;
@end


@protocol JFShareViewDelegate <NSObject>

-(void)shareWithType:(JFShareModelType)type;

@end
@interface JFShareView : UIView
{
    NSMutableArray  *m_arrayData;
    int              m_ileaveCount;
    id<JFShareViewDelegate> delegate;
}
@property(nonatomic,assign)id<JFShareViewDelegate>  delegate;



- (id)initWithLeaveCount:(int)count;
-(void)show;
@end



