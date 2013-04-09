//
//  Ant.m
//  
//
//  Created by ning pingping on 13-4-8.
//  Copyright (c) 2013年 thinkSky. All rights reserved.
//

#import "Ant.h"

@implementation Ant

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.isOut = NO;
        self.hasChangeDirection = NO;
    }
    return self;
}

- (void)step
{
    if (self.direction == AntDirectionArrow_Left) {//向左移动
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setFrame:(CGRect){self.frame.origin.x - self.speed, self.frame.origin.y, self.frame.size}];
        });

        self.position -= self.speed;
    } else if (self.direction == AntDirectionArrow_Right) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setFrame:(CGRect){self.frame.origin.x + self.speed, self.frame.origin.y, self.frame.size}];
        });
        self.position += self.speed;
    }
    self.hasChangeDirection = NO;
}


@end
