//
//  HorseStageViewCtrl.m
//  Horse
//
//  Created by 叶颖欣 on 14/5/23.
//  Copyright © 2016年 叶颖欣. All rights reserved.
//

#import "HorseStageViewCtrl.h"
#import "BetGameViewCtrl.h"
#import "GuideView.h"

@interface HorseStageViewCtrl ()
{
    //游戏主页面
    BetGameViewCtrl * _betGameViewCtl;
    
    //启动的页面
    //GuideView * _guideView;
}
@end

@implementation HorseStageViewCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 启动页图片直接是default-568h.png  自动进入
    
//
//    _guideView = [[GuideView alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:_guideView];
//
//    //delay后进入游戏主页面
//    [self performSelector:@selector(showGameView) withObject:nil afterDelay:1.0f];
    
    // 直接跳转到游戏主画面
    [self showGameView];
}


-(void)showGameView
{
//    [_guideView removeFromSuperview];
//    _guideView = nil;
    
    //从启动页切换到游戏主界面
    _betGameViewCtl = [[BetGameViewCtrl alloc]init];
    _betGameViewCtl.view.frame = self.view.bounds;
    [self.view addSubview:_betGameViewCtl.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    //
}

@end
