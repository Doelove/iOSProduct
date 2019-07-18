//
//  XSViderPlayerVC.m
//  iOSProject
//
//  Created by 软素 on 2019/6/26.
//  Copyright © 2019 软素. All rights reserved.
//

#import "XSViderPlayerVC.h"
#import <ZFPlayer/ZFPlayer.h>


@interface XSViderPlayerVC ()<SuperPlayerDelegate>

//@property(nonatomic,strong)ZFPlayerView *playerView;

@property(nonatomic,strong)SuperPlayerView *superPlayerView;

@end

@implementation XSViderPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBtn];
    _superPlayerView = [[SuperPlayerView alloc]init];
    _superPlayerView.delegate = self;
    _superPlayerView.fatherView = self.view;
    SuperPlayerModel *playerModel = [[SuperPlayerModel alloc]init];
    playerModel.videoURL = @"http://200024424.vod.myqcloud.com/200024424_709ae516bdf811e6ad39991f76a4df69.f20.mp4";
    [_superPlayerView playWithModel:playerModel];

}



@end
