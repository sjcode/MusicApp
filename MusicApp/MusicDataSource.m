//
//  MusicDataSource.m
//  MusicApp
//
//  Created by sujian on 16/9/4.
//  Copyright © 2016年 sujian. All rights reserved.
//

#import "MusicDataSource.h"
@import AVFoundation;
#import "NSString+stringByDecodingURLFormat.h"

@implementation MusicItem

@end

@interface MusicDataSource()
@property (nonatomic, strong, readwrite) NSArray *dataArray;
@end

@implementation MusicDataSource

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadLocalMusicsWith:(void (^)())completed{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSArray *fileList = [[NSBundle mainBundle]URLsForResourcesWithExtension:@"mp3" subdirectory:@"/"];
        NSLog(@"%@",fileList);
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (NSURL *url in fileList) {
            MusicItem *music = [[MusicItem alloc]init];
            music.musicName = [[[url.absoluteString lastPathComponent]stringByDecodingURLFormat]stringByDeletingPathExtension];
            music.url = url;
            NSError *error;
            AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
            music.duration = player.duration;
            [array addObject:music];
        }
        self.dataArray = array;
        dispatch_async(dispatch_get_main_queue(), ^{
            completed();
        });
    });
}

@end
