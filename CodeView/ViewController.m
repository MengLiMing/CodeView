//
//  ViewController.m
//  CodeView
//
//  Created by my on 16/5/18.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "ViewController.h"
#import "CodeView.h"
#import "UIView+Category.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    CodeView *v = [[CodeView alloc] initWithFrame:CGRectMake(0, 0, 200, 80)
                                              num:4
                                         lineWith:30
                                        lineColor:[UIColor redColor]
                                        textColor:[UIColor redColor]
                                         textFont:50];
    v.center = self.view.center;
    v.layer.borderWidth = 1;
    v.layer.borderColor = [UIColor redColor].CGColor;
    [v tapHandle:^{
        [v beginEdit];
    }];
    v.EndEditBlcok = ^(NSString *str) {
        NSLog(@"%@",str);
    };
    [self.view addSubview:v];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
