//
//  MusicTableViewCell.h
//  MusicApp
//
//  Created by sujian on 16/9/4.
//  Copyright © 2016年 sujian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIButton *playButton;
@property (nonatomic, weak) IBOutlet UILabel *musicname;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;

- (void)setCell:(id)item;
@end
