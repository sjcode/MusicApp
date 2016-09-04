//
//  MusicTableViewController.m
//  MusicApp
//
//  Created by sujian on 16/9/4.
//  Copyright © 2016年 sujian. All rights reserved.
//

#import "MusicTableViewController.h"
#import "MusicTableViewCell.h"
@import AVFoundation;
#import "MusicDataSource.h"

@interface MusicTableViewController ()<AVAudioPlayerDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSTimer *progresstimer;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) MusicDataSource *dataSource;
@property (nonatomic, assign) NSInteger selectedOfMusic;
@end

@implementation MusicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Music Table";
    self.dataSource = [[MusicDataSource alloc]init];
    [self.dataSource loadLocalMusicsWith:^{
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.dataArray.count ?: 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"musicCell" forIndexPath:indexPath];
    
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor colorWithRed:0.804 green:0.933 blue:1.000 alpha:1.000];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    [cell setCell:self.dataSource.dataArray[indexPath.row]];
                                           
    [cell.playButton addTarget:self action:@selector(onPlay:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)onPlay:(UIButton*)sender{
    if (self.player && self.player.isPlaying) {
        [self.player stop];
    }
    
    if (self.progresstimer) {
        [self.progresstimer invalidate];
    }
    
    self.player = nil;
    self.progresstimer = nil;
    
    for (MusicItem *item in self.dataSource.dataArray) {
        item.playing = NO;
        item.progress = 0;
    }
    
    CGPoint point = [sender.superview convertPoint:sender.center toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    self.selectedOfMusic = indexPath.row;
    MusicItem *item = self.dataSource.dataArray[indexPath.row];
    item.playing = YES;
    NSError *error;
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:item.url error:&error];
    self.player.delegate = self;
    __weak typeof(MusicTableViewController) *weakSelf = self;
    
    self.progresstimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:weakSelf selector:@selector(tick:) userInfo:item repeats:YES];
    
    [self.player prepareToPlay];
    [self.player play];
    [self.progresstimer fire];
    [self.tableView reloadData];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self.progresstimer invalidate];
    self.progresstimer = nil;
    MusicItem *item = self.dataSource.dataArray[self.selectedOfMusic];
    item.playing = NO;
    item.progress = 0;
    [self.tableView reloadData];
}

- (void)tick:(NSTimer*)timer{
    MusicItem *musicitem = timer.userInfo;
    NSTimeInterval progress = self.player.currentTime / self.player.duration;
    musicitem.progress = progress;
    musicitem.playCurrentTime = self.player.currentTime;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectedOfMusic inSection:0];
    MusicTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [cell.progressView setProgress:progress animated:YES];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"mm:ss"];
    NSDate *playtime = [NSDate dateWithTimeIntervalSinceReferenceDate:self.player.currentTime];
    NSString *playtimestring = [formatter stringFromDate:playtime];
    cell.currentTime.text = playtimestring;
}

@end
