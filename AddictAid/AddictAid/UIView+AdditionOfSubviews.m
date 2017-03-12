//
//  UIView+AdditionOfSubviews.m
//  AddictAid
//
//  Created by Justin Rowe on 3/11/17.
//  Copyright © 2017 Justin Rowe. All rights reserved.
//

#import "UIView+AdditionOfSubviews.h"

@implementation UIView (AdditionOfSubviews)

- (void)addSubviews:(NSArray *)views
{
    for (UIView *view in views) {
        if ([view isKindOfClass:[UIView class]]) {
            [self addSubview:view];
        }
    }
}

@end
