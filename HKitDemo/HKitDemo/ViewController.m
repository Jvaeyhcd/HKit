//
//  ViewController.m
//  HKitDemo
//
//  Created by 超讯研发部 on 2019/8/30.
//  Copyright © 2019 Jvaeyhcd. All rights reserved.
//

#import "ViewController.h"
#import "HKit.h"

@interface ViewController ()

/**
 购买数量输入框
 */
@property (nonatomic, strong) UITextField *buyCountTF;

/**
 立即购买按钮
 */
@property (nonatomic, strong) UIButton *buyBtn;

/**
 剩余票数量
 */
@property (nonatomic, strong) UILabel *ticketCountLbl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *tipsLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 60, SCREEN_WIDTH, 20)];
    tipsLbl.textColor = [UIColor colorWithHexString:@"0x999999"];
    tipsLbl.textAlignment = NSTextAlignmentCenter;
    tipsLbl.font = [UIFont systemFontOfSize:12];
    tipsLbl.text = @"当前剩余票数";
    [self.view addSubview:tipsLbl];
    
    self.ticketCountLbl.frame = CGRectMake(0, CGRectGetMaxY(tipsLbl.frame) + 8, SCREEN_WIDTH, 30);
    [self.view addSubview:self.ticketCountLbl];
    
    self.buyCountTF.frame = CGRectMake(16, CGRectGetMaxY(self.ticketCountLbl.frame) + 60, SCREEN_WIDTH - 60 - 3 * 16, 40);
    [self.buyCountTF becomeFirstResponder];
    [self.view addSubview:self.buyCountTF];
    
    self.buyBtn.frame = CGRectMake(CGRectGetMaxX(self.buyCountTF.frame) + 16, CGRectGetMinY(self.buyCountTF.frame), 60, 40);
    [self.view addSubview:self.buyBtn];
}

/**
 点击购买
 */
- (void)clickBuy {
    
}

#pragma mark - lazy load

- (UITextField *)buyCountTF {
    if (!_buyCountTF) {
        _buyCountTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _buyCountTF.textAlignment = NSTextAlignmentLeft;
        _buyCountTF.font = [UIFont systemFontOfSize:14];
        _buyCountTF.placeholder = @"请输入购票数量";
        _buyCountTF.backgroundColor = [UIColor colorWithHexString:@"0xf4f5f6"];
        _buyCountTF.clipsToBounds = YES;
        _buyCountTF.layer.borderColor = [UIColor colorWithHexString:@"0xf4f5f6"].CGColor;
        _buyCountTF.layer.borderWidth = 1;
        _buyCountTF.layer.cornerRadius = 4;
        _buyCountTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        _buyCountTF.leftViewMode = UITextFieldViewModeAlways;
        _buyCountTF.textColor = [UIColor blackColor];
        _buyCountTF.clearsOnBeginEditing = YES;
        _buyCountTF.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _buyCountTF;
}

- (UILabel *)ticketCountLbl {
    if (!_ticketCountLbl) {
        _ticketCountLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _ticketCountLbl.textAlignment = NSTextAlignmentCenter;
        _ticketCountLbl.font = [UIFont systemFontOfSize:24];
        _ticketCountLbl.text = @"100";
    }
    return _ticketCountLbl;
}

- (UIButton *)buyBtn {
    if (!_buyBtn) {
        _buyBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buyBtn.layer.cornerRadius = 4;
        _buyBtn.clipsToBounds = YES;
        [_buyBtn addTarget:self action:@selector(clickBuy) forControlEvents:UIControlEventTouchUpInside];
        _buyBtn.backgroundColor = [UIColor colorWithHexString:@"0x649FEF"];
        [_buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    }
    return _buyBtn;
}

@end
