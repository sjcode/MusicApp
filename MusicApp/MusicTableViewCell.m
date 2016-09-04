//
//  MusicTableViewCell.m
//  MusicApp
//
//  Created by sujian on 16/9/4.
//  Copyright © 2016年 sujian. All rights reserved.
//

#import "MusicTableViewCell.h"
#import "MusicDataSource.h"
@interface MusicTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *totalTime;



@end
@implementation MusicTableViewCell


- (void)setCell:(MusicItem*)item{
    
    if (!item.isPlaying) {
        [self.playButton setImage:[UIImage imageNamed:@"icon_settings_play_n"] forState:UIControlStateNormal];
    }else{
        [self.playButton setImage:[UIImage imageNamed:@"icon_settings_play_r"] forState:UIControlStateNormal];
    }
    
    self.musicname.text = item.musicName;
    self.progressView.progress = item.progress;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"mm:ss"];
    
    NSDate *durationTime = [NSDate dateWithTimeIntervalSinceReferenceDate:item.duration];
    NSString *durationString = [formatter stringFromDate:durationTime];
    self.totalTime.text = durationString;
    
    NSDate *playtime = [NSDate dateWithTimeIntervalSinceReferenceDate:item.playCurrentTime];
    NSString *playtimestring = [formatter stringFromDate:playtime];
    self.currentTime.text = playtimestring;
}
@end
