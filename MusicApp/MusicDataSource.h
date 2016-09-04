//
//  MusicDataSource.h
//  MusicApp
//
//  Created by sujian on 16/9/4.
//  Copyright © 2016年 sujian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicItem : NSObject
@property (nonatomic, copy) NSString *musicName;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval playCurrentTime;
@property (nonatomic, assign) float progress;
@property (nonatomic, assign, getter=isPlaying) BOOL playing;
@end

@interface MusicDataSource : NSObject
@property (nonatomic, strong, readonly) NSArray *dataArray;

- (void)loadLocalMusicsWith:(void (^)())completed;
@end
