//
//  SPImageView.m
//  SPDevelopTools
//
//  Created by 宋璞 on 2021/1/13.
//

#import "SPImageView.h"
#include <mach/mach_time.h>

#define LABEL_TAG 1

static const CGRect imageRect = {{0, 0}, {100, 100}};
static const CGPoint imagePoint = {0, 0};

@implementation SPImageView

@synthesize image;

- (void)awakeFromNib
{
    [super awakeFromNib];
    if (self.image) {
        self.image = [UIImage imageNamed:@""];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (CGRectEqualToRect(rect, imageRect)) {
        uint64_t start = mach_absolute_time();
        [image drawAtPoint:imagePoint];
        uint64_t drawtime = mach_absolute_time() - start;
        
        NSString *text = [NSString stringWithFormat:@"%lld", drawtime];
        UILabel *label = (UILabel *)[self viewWithTag:LABEL_TAG];
        label.text = text;
    }
}


@end
