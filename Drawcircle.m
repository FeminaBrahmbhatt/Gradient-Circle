//
//  Drawcircle.m
//  Running
//
//  Created by Femina Rajesh Brahmbhatt on 17/05/17.
//  Copyright © 2017 Femina Rajesh Brahmbhatt. All rights reserved.
//

#import "Drawcircle.h"

@implementation Drawcircle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //CGFloat arcStartAngle = M_PI;
    //CGFloat arcEndAngle = 2 * M_PI;
    
    CGPoint startPoint = CGPointMake(0,0);
    CGPoint endPoint = CGPointMake(0,360);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat colors[] =
    {
        0.0, 1.0, 0.8, 0.6,   //RGBA values (so red to green in this case)
        0.0, 0.0, 0.0, 0.0
    };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
    //Where the 2 is for the number of color components. You can have more colors throughout //your gradient by adding to the colors[] array, and changing the components value.
    
    CGColorSpaceRelease(colorSpace);
    
    //Now for the arc part...
    
    CGMutablePathRef arc = CGPathCreateMutable();
    
    //Here, the CGPoint self.arcCenter is the point around which the arc is placed, so maybe the
    //middle of your view. self.radius is the distance between this center point and the arc.
    CGPathAddArc(arc, NULL, self.frame.size.width/2, self.frame.size.width/2, (self.frame.size.width/2)-1,self.frame.size.width/2, 2*M_PI, YES);
    
    
    //This essentially draws along the path in an arc shape
    CGPathRef strokedArc = CGPathCreateCopyByStrokingPath(arc, NULL, 1.5f,
                                                          kCGLineCapButt, kCGLineJoinMiter, 10);
    
    CGContextSaveGState(context);
    
    CGContextAddPath(context, strokedArc);
    CGContextClip(context);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
