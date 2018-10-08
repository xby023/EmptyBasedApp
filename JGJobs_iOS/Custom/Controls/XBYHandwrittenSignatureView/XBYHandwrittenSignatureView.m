//
//  XBYHandwrittenSignatureView.m
//  手写签名
//
//  Created by 许必杨 on 2018/2/28.
//  Copyright © 2018年 许必杨. All rights reserved.
//

#import "XBYHandwrittenSignatureView.h"

@interface XBYHandwrittenSignatureView()

@property (nonatomic ,strong) NSMutableArray *allLinesOfPoints;

@end


@implementation XBYHandwrittenSignatureView

//懒加载
- (NSMutableArray *)allLinesOfPoints{
    if (!_allLinesOfPoints) {
        _allLinesOfPoints = [NSMutableArray array];
    }
    return _allLinesOfPoints;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.write = YES;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSMutableArray *line = [NSMutableArray array];
    [line addObject:[NSValue valueWithCGPoint:point]];
    [self.allLinesOfPoints addObject:line];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSMutableArray *line = [self.allLinesOfPoints lastObject];
    [line addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesEnded:touches withEvent:event];
}

- (void)drawRect:(CGRect)rect {
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //设置节点样式
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    //设置线头
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    //设置线宽
    CGContextSetLineWidth(ctx, 3);
    
    for (NSInteger index = 0; index < self.allLinesOfPoints.count; index ++) {
        NSArray *line = self.allLinesOfPoints[index];
        for (NSInteger i = 0;i < line.count; i ++) {
            CGPoint point = [line[i] CGPointValue];
            if (i == 0) {
               CGContextMoveToPoint(ctx, point.x, point.y);
            }else{
                CGContextAddLineToPoint(ctx, point.x, point.y);
            }
        }
    }
    
    [[UIColor blackColor] set];
    CGContextStrokePath(ctx);
    
}


/**
 回退一步
 */
- (void)backToOneStep{
    [self.allLinesOfPoints removeLastObject];
    [self setNeedsDisplay];
}


/**
 重新写
 */
- (void)rewriteSignature{
    [self.allLinesOfPoints removeAllObjects];
    [self setNeedsDisplay];
}

//获取图片
- (UIImage *)getImage{
    // 开启一个指定尺寸的上下文
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    // 从当前上下文获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

/**
 保存未片
 */
- (void)saveImage{
    // 开启一个指定尺寸的上下文
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.layer renderInContext:ctx];
    
    // 从当前上下文获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //存到相册
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);
    
    //关闭上文，
    UIGraphicsEndImageContext();
    
}

// 这是保存图片到相册回调函数的固定写法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        // 设置弹窗，表示保存错误
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"图片保存失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:sure];
        [[self viewController] presentViewController:alert animated:YES completion:nil];
    }else {
        // 设置弹窗，表示保存成功
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"图片保存成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:sure];
        [[self viewController] presentViewController:alert animated:YES completion:nil];
    }
}

//获取View所在的Viewcontroller方法
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
