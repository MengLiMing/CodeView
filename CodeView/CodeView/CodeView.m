//
//  CodeView.m
//  BaseProject
//
//  Created by my on 16/3/24.
//  Copyright © 2016年 base. All rights reserved.
//

#import "CodeView.h"

@interface CodeView ()
{
    NSMutableArray *textArray;
    
    //线的条数
    NSInteger lineNum;
    CGFloat lineWidth;
    UIColor *linecolor;
    UIColor *textcolor;
    CGFloat fontSize;
    
}
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray *lineArr;
@end

@implementation CodeView

- (instancetype)initWithFrame:(CGRect)frame
                          num:(NSInteger)num
                     lineWith:(CGFloat)width
                    lineColor:(UIColor *)lColor
                    textColor:(UIColor *)tColor
                     textFont:(CGFloat)font {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        textArray = [NSMutableArray arrayWithCapacity:num];
        
        lineNum = num;
        lineWidth = width;
        linecolor = lColor;
        textcolor = tColor;
        fontSize = font;
        
        [self addLine];
        [self addNotification];
    }
    
    return self;
}

#pragma mark - 添加通知
- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSInteger length = _textField.text.length;
        if (length == lineNum && self.EndEditBlcok) {
            [_textField resignFirstResponder];
            self.EndEditBlcok(_textField.text);
        }
        if (length > lineNum) {
            [_textField resignFirstResponder];
            _textField.text = [_textField.text substringToIndex:lineNum];
        }
        
        //改变数组，存储需要画的字符
        //通过判断textfield的长度和数组中的长度比较，选择删除还是添加
        if (length<=lineNum) {
            if (length > textArray.count) {
                [textArray addObject:[_textField.text substringWithRange:NSMakeRange(length - 1, 1)]];
            } else {
                [textArray removeLastObject];
            }
            //标记为需要重绘
            [self setNeedsDisplay];
        }
                
        //判断底部的view隐藏还是显示
        for (NSInteger i = 0; i < lineNum; i ++) {
            CAShapeLayer *obj = [_lineArr objectAtIndex:i];
            if (i < _textField.text.length) {
                obj.hidden = YES;
            } else {
                obj.hidden = NO;
            }
        }
    }];
}

//键盘弹出
- (void)beginEdit {
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.hidden = YES;
        [self addSubview:_textField];
    }
    [self.textField becomeFirstResponder];}

- (void)endEdit {
    [self.textField resignFirstResponder];
}

- (void)addLine {
   //创建下标线
    CGFloat line_sep = (self.frame.size.width - lineNum * lineWidth)/(lineNum + 1);
    for (NSInteger i = 0; i < lineNum; i ++) {
        CAShapeLayer *line = [CAShapeLayer layer];
        line.fillColor = linecolor.CGColor;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(line_sep * (i + 1) + i * lineWidth, self.frame.size.height - 10, lineWidth, 3)];
        line.path = path.CGPath;
        line.hidden = NO;
        [self.layer addSublayer:line];
        [self.lineArr addObject:line];
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)lineArr{
    if (_lineArr == nil) {
        _lineArr = [NSMutableArray array];
    }
    return _lineArr;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    // Drawing code
    //画字
    CGFloat line_sep = (self.frame.size.width - lineNum * lineWidth)/(lineNum + 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIFont  *font = [UIFont boldSystemFontOfSize:fontSize];
    for (NSInteger i = 0; i < textArray.count; i ++) {
        [textArray[i] drawInRect:CGRectMake(line_sep * (i + 1) + i * lineWidth, self.frame.size.height - (fontSize + 15), lineWidth,  fontSize + 5) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:textcolor}];
    }
    CGContextDrawPath(context, kCGPathFill);
}


@end
