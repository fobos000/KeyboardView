#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (extended)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property(nonatomic,readonly) CGFloat screenX;
@property(nonatomic,readonly) CGFloat screenY;
@property(nonatomic,readonly) CGFloat screenViewX;
@property(nonatomic,readonly) CGFloat screenViewY;
@property(nonatomic,readonly) CGRect screenFrame;
/*
@property(nonatomic,readonly) CGFloat orientationWidth;
@property(nonatomic,readonly) CGFloat orientationHeight;
*/
- (UIScrollView*)findFirstScrollView;

- (UIView*)firstViewOfClass:(Class)cls;

- (UIView*)firstParentOfClass:(Class)cls;

- (UIView*)findChildWithDescendant:(UIView*)descendant;

/**
 * Removes all subviews.
 */
- (void)removeSubviews;

/**
 * WARNING: This depends on undocumented APIs and may be fragile.  For testing only.
 */
//- (void)simulateTapAtPoint:(CGPoint)location;

- (CGPoint)offsetFromView:(UIView*)otherView;

-(void)resizeWidthToFitSubviews;

-(void) addCornerRadius:(float)cornerRadius;
-(void) addBorderWidth:(CGFloat) width color:(UIColor*) color;
-(void) addGradientBackgroundWithTopColor:(UIColor*)topColor andBottomColor:(UIColor*)bottomColor;

// fill the view in its superview, and activate the autoresize mask so, the view will change is size if its superview bounds change
-(void) fillSuperviewAndEnableAutoresizeMask;

// fill the view in its superview, and activate the autoresize mask so, the view will change is size if its superview width bounds change
-(void) fillSuperviewAndEnableAutoresizeMaskWidth;

-(void) fillSuperviewAndEnableAutoresizeMaskNoTop;

/**
 *  Search for all layout constaints of specific type on view
 *
 *  @param attribute Layout attribute type to search constraint for
 *
 *  @return Array of all matched NSLayoutConstraint objects
 */
-(NSArray *) constraintsForAttribute:(NSLayoutAttribute)attribute;

/**
 *  Get first layout constaints of specific type on view
 *
 *  @param attribute  Layout attribute type to search constraint for
 *
 *  @return First matched constraint
 */
-(NSLayoutConstraint *) firstConstraintForAttribute:(NSLayoutAttribute)attribute;

@end
