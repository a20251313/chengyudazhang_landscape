//
//  playAudio.h
//  chengyuwar
//
//  Created by ran on 14-1-7.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>

#import <AudioToolbox/AudioToolbox.h>

#import <AudioToolbox/AudioFile.h>

#define NUM_BUFFERS 3



@interface playAudio : NSObject{
    
    //播放音频文件ID
    AudioFileID audioFile;
    
    //音频流描述对象
    AudioStreamBasicDescription dataFormat;
    
    //音频队列
    AudioQueueRef queue;
    
    SInt64 packetIndex;
    
    UInt32 numPacketsToRead;
    
    UInt32 bufferByteSize;
    
    AudioStreamPacketDescription *packetDescs;
    
    AudioQueueBufferRef buffers[NUM_BUFFERS];
    
}



//定义队列为实例属性
@property AudioQueueRef queue;

//播放方法定义
-(id)initWithAudio:(NSString *) path;

//定义缓存数据读取方法
-(void) audioQueueOutputWithQueue:(AudioQueueRef)audioQueue

                      queueBuffer:(AudioQueueBufferRef)audioQueueBuffer;

-(UInt32)readPacketsIntoBuffer:(AudioQueueBufferRef)buffer;





@end
