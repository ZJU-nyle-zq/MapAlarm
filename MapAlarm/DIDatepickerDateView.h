

#import <UIKit/UIKit.h>


extern const CGFloat kDIDatepickerItemWidth;
extern const CGFloat kDIDatepickerSelectionLineWidth;


@interface DIDatepickerDateView : UIControl

// data
@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) BOOL isSelected;

// methods
- (void)setItemSelectionColor:(UIColor *)itemSelectionColor;

@end
