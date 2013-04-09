//
//  PlaceModalView.h
//  
//
//  Created by ning pingping on 13-4-8.
//  Copyright (c) 2013年 thinkSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ant.h"

#define D_scale (6)

#define D_len (27 * D_scale)

#define D_antSize (1 * D_scale)

#define D_speed (1 * D_scale)

@interface PlaceModalView : UIView

- (id)initWithOriginPoint:(CGPoint)point;

- (void)initAntWithDirections:(AntDirectionArrow[5])directions;

- (void)start;


@end
