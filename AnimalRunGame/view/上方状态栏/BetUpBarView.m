//
//  BetUpBarView.m
//  Horse
//
//  Created by 叶颖欣 on 14/6/1.
//  Copyright © 2016年 叶颖欣. All rights reserved.
//

#import "BetUpBarView.h"
#import "BetGameModel.h"

@interface BetUpBarView()
{
    BetGameModel * _betGameModel;
    UIView * _maskView;
    UIView * _backgroundView;
    UIImageView * _moneyBackgroundImgView;
    UILabel * _totalMoneyLabel;
    UIButton * _exitBtn;
    UIButton * _addMoneyBtn;
    UIButton * _showWinnerHistoryBtn;
}
@end

@implementation BetUpBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initData];
        [self initView];
    }
    return self;
}

-(void)initData
{
    _betGameModel = [BetGameModel getInstance];
}


-(void)initView
{
    [self addBackgroundView];
    [self addMoneyBackground];
    //[self addExitBtn];
    [self addShowWinnerHistoryBtn];
    [self addMoneyBtn];
    
}

// 设置背景
-(void)addBackgroundView
{
    _backgroundView = [[UIView alloc]initWithFrame:self.bounds];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.4;
    [self addSubview:_backgroundView];
}

// 设置左边金钱图标
-(void)addMoneyBackground
{
    _moneyBackgroundImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 186.5, 28.5)];
    [_moneyBackgroundImgView setImage:[UIImage imageNamed:@"bet_money_background.png"]];
    [self addSubview:_moneyBackgroundImgView];
}

// 设置右边回到大厅按钮
-(void)addExitBtn
{
    _exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _exitBtn.frame = CGRectMake(self.bounds.size.width-85, 0, 73, 27.5);
    [_exitBtn setImage:[UIImage imageNamed:@"bet_exitBtn.png"] forState:UIControlStateNormal];
    [_exitBtn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_exitBtn];
}

-(void)exitBtnClick
{
    
}

// 是否显示历史按钮
-(void)addShowWinnerHistoryBtn{
    _showWinnerHistoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _showWinnerHistoryBtn.frame = CGRectMake(self.bounds.size.width-85, 1, 74, 27);
    _showWinnerHistoryBtn.backgroundColor = [UIColor colorWithRed:24/255.0 green:174/255.0 blue:176/255.0 alpha:1.0];
    _showWinnerHistoryBtn.layer.borderWidth = 1.0;
    _showWinnerHistoryBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [_showWinnerHistoryBtn.layer setMasksToBounds:YES];
    [_showWinnerHistoryBtn.layer setCornerRadius:12.0]; //设置矩形四个圆角半径
    [_showWinnerHistoryBtn.layer setBorderColor:[UIColor blackColor].CGColor];
    [_showWinnerHistoryBtn setTitle:@"历史参考" forState:UIControlStateNormal];
    [_showWinnerHistoryBtn.titleLabel setFont:[UIFont fontWithName:@"HiraKakuProN-W6" size:12]];
    [_showWinnerHistoryBtn addTarget:self action:@selector(showWinnerHistoryBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_showWinnerHistoryBtn addTarget:self action:@selector(showWinnerHistoryBtnClickDone) forControlEvents:UIControlEventTouchDown];
    [self addSubview:_showWinnerHistoryBtn];
}

-(void)showWinnerHistoryBtnClick{
    if (_betGameModel.isShowWinnerHistory == false) {
        _betGameModel.isShowWinnerHistory = true;
        [_showWinnerHistoryBtn setTitle:@"参考个锤子" forState:UIControlStateNormal];
    } else {
        _betGameModel.isShowWinnerHistory = false;
        [_showWinnerHistoryBtn setTitle:@"历史参考" forState:UIControlStateNormal];
    }
    _showWinnerHistoryBtn.backgroundColor = [UIColor colorWithRed:24/255.0 green:174/255.0 blue:176/255.0 alpha:1.0];
    [[NSNotificationCenter defaultCenter] postNotificationName:_betGameModel.EVENT_SHOW_WINNER_HISTORY object:nil];
}

-(void)showWinnerHistoryBtnClickDone{
    _showWinnerHistoryBtn.backgroundColor = [UIColor grayColor];
}

// 增加金钱按钮
-(void)addMoneyBtn
{
    _addMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addMoneyBtn.frame = CGRectMake(self.bounds.size.width-170, 1, 80, 27);
    _addMoneyBtn.backgroundColor = [UIColor colorWithRed:24/255.0 green:174/255.0 blue:176/255.0 alpha:1.0];
    _addMoneyBtn.layer.borderWidth = 1.0;
    _addMoneyBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [_addMoneyBtn.layer setMasksToBounds:YES];
    [_addMoneyBtn.layer setCornerRadius:12.0]; //设置矩形四个圆角半径
    [_addMoneyBtn.layer setBorderColor:[UIColor blackColor].CGColor];
    [_addMoneyBtn setTitle:@"不就是氪金嘛" forState:UIControlStateNormal];
    [_addMoneyBtn.titleLabel setFont:[UIFont fontWithName:@"HiraKakuProN-W6" size:12]];
    [_addMoneyBtn addTarget:self action:@selector(addMoneyClick) forControlEvents:UIControlEventTouchUpInside];
    [_addMoneyBtn addTarget:self action:@selector(addMoneyClickDone) forControlEvents:UIControlEventTouchDown];
    [self addSubview:_addMoneyBtn];
    
}

-(void)addMoneyClick
{
    //printf("add money click!");
    _betGameModel.myTotalMoney += 648;
    [_totalMoneyLabel setText:[NSString stringWithFormat:@"%i", _betGameModel.myTotalMoney]];
    _addMoneyBtn.backgroundColor = [UIColor colorWithRed:24/255.0 green:174/255.0 blue:176/255.0 alpha:1.0];

}

-(void)addMoneyClickDone
{
    //printf("add money click done!");
    _addMoneyBtn.backgroundColor = [UIColor grayColor];
   
}


// 设置金钱
-(void)setTotalMoney:(int)money
{
    if(!_totalMoneyLabel)
    {
        _totalMoneyLabel = [[UILabel alloc]init];
        _totalMoneyLabel.frame = CGRectMake(45, 5, 120, 20);
        _totalMoneyLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:14];
        _totalMoneyLabel.textColor = [UIColor yellowColor];
        _totalMoneyLabel.textAlignment = NSTextAlignmentLeft;
        _totalMoneyLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_totalMoneyLabel];
    }

    [_totalMoneyLabel setText:[NSString stringWithFormat:@"%i",money]];
}

//金钱不够
-(void)moneyNoEnough
{
    _totalMoneyLabel.alpha = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationRepeatCount:4];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    _totalMoneyLabel.alpha = 1;
    
    [UIView commitAnimations];
}

//更新自己现在的总金额
-(void)updataMyTotalMoney
{
    [_totalMoneyLabel setText:[NSString stringWithFormat:@"%i",_betGameModel.myTotalMoney]];
}


//设置是否可用
-(void)setEnable:(Boolean)enable
{
    if(enable == YES)       //可用
    {
        if(_maskView)
        {
            [_maskView removeFromSuperview];
            _maskView = nil;
        }
    }
    else                    //不可用
    {
        if(!_maskView)
        {
            _maskView = [[UIView alloc]initWithFrame:self.bounds];
            _maskView.backgroundColor = [UIColor blackColor];
            _maskView.alpha = 0.5;
            [self addSubview:_maskView];
        }
        
    }
}

- (void)dealloc
{
    //
    _maskView = nil;
    _backgroundView = nil;
    _moneyBackgroundImgView = nil;
    _totalMoneyLabel = nil;
    _exitBtn = nil;
    _addMoneyBtn = nil;
    NSLog(@"-----BetUpBarView---dealloc");
}

@end
