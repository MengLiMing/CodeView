//
//  CodeView.h
//  BaseProject
//
//  Created by my on 16/3/24.
//  Copyright © 2016年 base. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeView : UIView

//输入完成回调
@property (nonatomic,copy) void(^EndEditBlcok)(NSString *text);

- (instancetype)initWithFrame:(CGRect)frame
                          num:(NSInteger)num
                     lineWith:(CGFloat)width
                    lineColor:(UIColor *)lColor
                    textColor:(UIColor *)tColor
                     textFont:(CGFloat)font;

- (void)beginEdit;
- (void)endEdit;

@end
