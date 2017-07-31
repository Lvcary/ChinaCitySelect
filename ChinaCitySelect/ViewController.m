//
//  ViewController.m
//  ChinaCitySelect
//
//  Created by 刘康蕤 on 2017/7/31.
//  Copyright © 2017年 lkr. All rights reserved.
//

#import "ViewController.h"
#import "ChinaCitySelectView.h"
#define SCRWidth [UIScreen mainScreen].bounds.size.width
#define SCRHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@property (nonatomic, strong)ChinaCitySelectView * citySelectView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.citySelectView];
}

- (ChinaCitySelectView *)citySelectView {

    if (!_citySelectView) {
        _citySelectView = [[ChinaCitySelectView alloc] initWithFrame:CGRectMake(0, SCRHeight - 180, SCRWidth, 180)];
        _citySelectView.backgroundColor = [UIColor orangeColor];
    }
    return _citySelectView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
