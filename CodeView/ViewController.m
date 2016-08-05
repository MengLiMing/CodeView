//
//  ViewController.m
//  CodeView
//
//  Created by my on 16/5/18.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "ViewController.h"
#import "CodeView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addView];
}


- (void)addView {
    
    NSArray *arr = @[@"普通，下划线 分割线",
                     @"普通，下划线",
                     @"密码",
                     @"密码，分割线"];
    for (NSInteger i = 0; i < arr.count; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40 + 80 * i, self.view.frame.size.width, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = arr[i];
        [self.view addSubview:label];
        
        CodeView *v = [[CodeView alloc] initWithFrame:CGRectMake(0, 60 + 80 * i, self.view.frame.size.width - 10, 60)
                                                  num:6
                                            lineColor:[UIColor blackColor]
                                             textFont:50];
        
        switch (i) {
            case 0:
            {
                //下划线
                v.hasUnderLine = YES;
                //分割线
                v.hasSpaceLine = YES;
                //输入之后置空
                v.emptyEditEnd = YES;
                //输入风格
                v.codeType = CodeViewTypeCustom;
            }
                break;
            case 1:
            {
                //下划线
                v.hasUnderLine = YES;
                //分割线
                v.hasSpaceLine = NO;
                
                //输入风格
                v.codeType = CodeViewTypeCustom;
            }
                break;
            case 2:
            {
                //下划线
                v.hasUnderLine = NO;
                //分割线
                v.hasSpaceLine = NO;
                
                //输入风格
                v.codeType = CodeViewTypeSecret;
            }
                break;
            case 3:
            {
                //下划线
                v.hasUnderLine = NO;
                //分割线
                v.hasSpaceLine = YES;
                
                //输入风格
                v.codeType = CodeViewTypeSecret;
            }
                break;
            default:
                break;
        }

        
        v.EndEditBlcok = ^(NSString *str) {
            NSLog(@"%@",str);
        };
        [self.view addSubview:v];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
