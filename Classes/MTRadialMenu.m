//
//  MTRadialMenu
//
//  Created by Michael Timbrook on 1/13/14.
//  twitter: @7imbrook
//

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

#import <objc/runtime.h>
#import "MTRadialMenu.h"
#import "MTMenuItem.h"

CGPoint CGRectCenterPoint(CGRect rect) {
    return CGPointMake(rect.size.width / 2.0,
                       rect.size.height / 2.0);
}

CGAffineTransform CGAffineTransformOrientOnAngle(CGFloat angle, CGFloat radius){
    CGAffineTransform newTransform = CGAffineTransformRotate(CGAffineTransformIdentity, angle);
    newTransform = CGAffineTransformTranslate(newTransform, 0.0, -(radius >= 50 ? radius : 50));
    return newTransform;
}

@implementation MTRadialMenu
{
    CGFloat currentAngle;
    NSArray *menuItems;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        menuItems = @[];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)didMoveToSuperview
{
    // Add menu activation gesture
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    [self.superview addGestureRecognizer:longPress];
}

- (void)addMenuItem:(MTMenuItem *)item
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentAngle = _startingAngle ?: 10.0;
    });
    objc_setAssociatedObject(item, "display_angle", [NSNumber numberWithFloat:currentAngle], OBJC_ASSOCIATION_RETAIN);
    currentAngle += (_incrementAngle ?: 55.0);
    menuItems = [menuItems arrayByAddingObject:item];
}

- (void)showMenuAnimated:(BOOL)animated
{
    // Animate them
    CGAffineTransform start = CGAffineTransformMakeScale(0.0, 0.0);
    for (MTMenuItem *item in menuItems) {
        item.transform = CGAffineTransformIdentity;
        item.isSelected = NO;
        [item setNeedsDisplay];
        [item setFrame:({
            CGRect frame = CGRectZero;
            frame.origin = CGRectCenterPoint(self.frame);
            frame = CGRectInset(frame, -22.5, -37.5);
            frame;
        })];
        [self addSubview:item];
        item.transform = start;
    }

    // Animate self
    self.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));

    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        for (MTMenuItem *item in self.subviews) {
            if ([item isKindOfClass:[MTMenuItem class]]) {
                item.transform = CGAffineTransformOrientOnAngle(DEGREES_TO_RADIANS([objc_getAssociatedObject(item, "display_angle") floatValue]), _radius ?: 60.0);
            }
        }
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)hideMenuAnimated:(BOOL)animated completed:(void(^)(BOOL finished))competion
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.alpha = 1.0;
        self.transform = CGAffineTransformIdentity;
        competion(finished);
    }];
}

- (void)prepareMenuAtPoint:(CGPoint)point
{
    [self sendActionsForControlEvents:UIControlEventTouchDown];
    self.frame = CGRectMake(point.x, point.y, 0.0, 0.0);
    self.frame = CGRectInset(self.frame, -125, -125);
    [self setNeedsDisplayInRect:self.frame];
}

- (void)resetMenu
{
    self.frame = CGRectZero;
    for (UIView *sub in self.subviews) {
        [sub removeFromSuperview];
    }
}

- (void)notifyObserversOfSelection
{
    for (MTMenuItem *view in self.subviews) {
        if ([view isKindOfClass:[MTMenuItem class]]) {
            if (view.isSelected) {
                _selectedIdentifier = view.identifier;
                _location = self.center;
                [self sendActionsForControlEvents:UIControlEventTouchUpInside];
                break;
            }
        }
    }
}

- (void)handleTouch:(UIGestureRecognizer *)reg
{
    if (!CGAffineTransformIsIdentity(self.transform)) {
        return;
    }
    for (MTMenuItem *view in self.subviews) {
        if ([view isKindOfClass:[MTMenuItem class]]) {
            CGPoint touch = [reg locationInView:view];
            view.isSelected = [view.collisionPath containsPoint:touch];
            if (view.isSelected) {
                CGAffineTransform bigTrans = CGAffineTransformScale(CGAffineTransformOrientOnAngle(DEGREES_TO_RADIANS([objc_getAssociatedObject(view, "display_angle") floatValue]), _radius ?: 60.0), 1.5, 1.5);
                bigTrans = CGAffineTransformTranslate(bigTrans, 0.0, -13.0);
                if (CGAffineTransformEqualToTransform(bigTrans, view.transform)) {
                    continue;
                }
                [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    view.transform = bigTrans;
                } completion:nil];
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                    view.transform = CGAffineTransformOrientOnAngle(DEGREES_TO_RADIANS([objc_getAssociatedObject(view, "display_angle") floatValue]), _radius ?: 60.0);
                }];
            }
            [view setNeedsDisplay];
        }
    }
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)reg
{
    switch (reg.state) {
        case UIGestureRecognizerStateBegan:
            [self prepareMenuAtPoint:[reg locationInView:self.superview]];
            [self showMenuAnimated:YES];
            break;
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded: {
            [self notifyObserversOfSelection];
            [self hideMenuAnimated:YES completed:^(BOOL finished) {
                [self resetMenu];
            }];
        }
        case UIGestureRecognizerStateChanged:
            [self handleTouch:reg];
            break;
        default:
            break;
    }
}

@end
