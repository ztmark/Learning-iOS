//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Mark on 16/1/6.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect {
    CGRect bounds = self.bounds;

    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;

    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;

    UIBezierPath *path = [[UIBezierPath alloc] init];

    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    }

    path.lineWidth = 10;

    [[UIColor lightGrayColor] setStroke];

    [path stroke];

    // set shadow
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3);
    
    UIImage *logo = [UIImage imageNamed:@"logo.png"];
    [logo drawInRect:bounds];

    CGContextRestoreGState(currentContext);


    CGContextSaveGState(currentContext);
    [path addClip];

    CGFloat location[2] = {0.0, 1.0};
    CGFloat components[8] = { 1.0, 1.0, 0.0, 1.0,
                            1.0, 0.0, 1.0, 1.0};
    CGPoint startPoint = CGPointMake(100, 350);
    CGPoint endPoint = CGPointMake(100, 50);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, location, 2);


    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(currentContext);

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}


@end
