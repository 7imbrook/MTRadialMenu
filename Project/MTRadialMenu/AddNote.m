//
//  AddNote.m
//  AccessLecture
//
//  Created by Michael on 1/15/14.
//
//

#import "AddNote.h"

@implementation AddNote

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* fillColorNormal = [UIColor colorWithRed: 0 green: 0.657 blue: 0.219 alpha: 1];
    UIColor* fillColorSelected = [UIColor colorWithRed: 0 green: 0.429 blue: 0.143 alpha: 1];
    UIColor* fillColor3 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    //// Oval Drawing
    self.collisionPath = [UIBezierPath bezierPath];
    [self.collisionPath moveToPoint: CGPointMake(23.6, 73.5)];
    [self.collisionPath addCurveToPoint: CGPointMake(41.72, 36.93) controlPoint1: CGPointMake(28.95, 73.51) controlPoint2: CGPointMake(40.07, 40.76)];
    [self.collisionPath addCurveToPoint: CGPointMake(37.25, 6.22) controlPoint1: CGPointMake(45, 29.3) controlPoint2: CGPointMake(45.4, 13.86)];
    [self.collisionPath addCurveToPoint: CGPointMake(7.75, 6.22) controlPoint1: CGPointMake(29.11, -1.41) controlPoint2: CGPointMake(15.89, -1.41)];
    [self.collisionPath addCurveToPoint: CGPointMake(3.28, 36.93) controlPoint1: CGPointMake(-0.4, 13.86) controlPoint2: CGPointMake(0, 29.3)];
    [self.collisionPath addCurveToPoint: CGPointMake(23.6, 73.5) controlPoint1: CGPointMake(4.92, 40.73) controlPoint2: CGPointMake(18.27, 73.49)];
    [self.collisionPath closePath];
    [(self.isSelected ? fillColorSelected : fillColorNormal) setFill];
    [self.collisionPath fill];
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(10.5, 11.5, 24, 24) byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii: CGSizeMake(15, 15)];
    [roundedRectanglePath closePath];
    [fillColor3 setStroke];
    roundedRectanglePath.lineWidth = 3;
    [roundedRectanglePath stroke];
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(22.5, 17.5)];
    [bezierPath addLineToPoint: CGPointMake(22.5, 29.5)];
    [bezierPath addLineToPoint: CGPointMake(22.5, 17.5)];
    [bezierPath closePath];
    [fillColor3 setStroke];
    bezierPath.lineWidth = 2;
    [bezierPath stroke];
    
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(16.5, 23.5)];
    [bezier2Path addLineToPoint: CGPointMake(28.5, 23.5)];
    [bezier2Path addLineToPoint: CGPointMake(16.5, 23.5)];
    [bezier2Path closePath];
    [fillColor3 setStroke];
    bezier2Path.lineWidth = 2;
    [bezier2Path stroke];

}


@end
