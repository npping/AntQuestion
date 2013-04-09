//
//  PlaceModalView.m
//  
//
//  Created by ning pingping on 13-4-8.
//  Copyright (c) 2013年 thinkSky. All rights reserved.
//

#import "PlaceModalView.h"

@implementation PlaceModalView
{
    int m_endPoint[2];
    int m_startPosition[5];
    int m_directions[5];
    
    Ant *m_ant[5];
    
    int m_stepCount;
    NSTimer *m_timer;
}

- (id)initWithOriginPoint:(CGPoint)point
{
    CGRect rt = CGRectMake(point.x,point.y, D_len + 20, 10);
    self = [self initWithFrame:rt];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor grayColor]];
        
        int start[5] = {3 * D_scale - D_antSize / 2, 7 * D_scale  - D_antSize / 2, 11 * D_scale  - D_antSize / 2, 17 * D_scale  - D_antSize / 2, 23 * D_scale  - D_antSize / 2};
        int end[2] = {0 - D_antSize / 2, 27 * D_scale  - D_antSize / 2};
                
        for (int i = 0; i < 2; ++i) {
            m_endPoint[i] = end[i];
        }
        
        UIColor *color[5] = {
            [UIColor redColor],
            [UIColor greenColor],
            [UIColor blueColor],
            [UIColor orangeColor],
            [UIColor blackColor]
        };
        
        for (int i = 0; i < 5; ++i) {
            
            m_startPosition[i] = start[i];
            
            m_ant[i] = [[Ant alloc] initWithFrame:CGRectMake(m_startPosition[i] - D_antSize / 2, (10 / D_antSize ) / 2, D_antSize, D_antSize)];
            m_ant[i].position = m_startPosition[i];
            m_ant[i].speed = D_speed;
            [m_ant[i] setBackgroundColor:color[i]];
            [self addSubview:m_ant[i]];
        }
        
        m_stepCount = 0;
        
    }
    return self;
}

- (void)dealloc
{
    for (int i = 0; i < 5; ++i) {
        [m_ant[i] release];
        m_ant[i] = nil;
    }
    if (m_timer) {
        [m_timer invalidate];
        [m_timer release];
        m_timer = nil;
    }
    [super dealloc];
}

- (void)initAntWithDirections:(AntDirectionArrow[5])directions
{
    for (int i = 0; i < 5; ++i) {
        [m_ant[i] setDirection:directions[i]];
        m_directions[i] = (int)directions[i];
    }
}

- (void)start
{
    if (!m_timer) {
        m_timer = [[NSTimer timerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil repeats:YES] retain];
        [[NSRunLoop currentRunLoop] addTimer:m_timer forMode:NSDefaultRunLoopMode];
    }
    
}

- (void)update
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 5; ++i) {
        if (m_ant[i].isOut) {
            [m_ant[i] setHidden:YES];
            continue;
        }
        [array addObject:m_ant[i]];
    }
    
    if ([array count] == 0) {
        [m_timer invalidate];
        [m_timer release];
        m_timer = nil;
        NSLog(@"OverTest Tag[%d]... step[%d] directions[%d, %d, %d, %d, %d]", self.tag, m_stepCount, m_directions[0], m_directions[1], m_directions[2], m_directions[3], m_directions[4]);
        
    } else {
        m_stepCount += 1;
        
        int cout = 5;
        if (cout > 1) {
            for (int i = 0; i < cout; ++i) {
                Ant *iAnt = m_ant[i];
                
                for (int j = i + 1; j < cout; ++j) {
                    Ant *jAnt = m_ant[j];
                    if (iAnt.position  == jAnt.position) {
                        AntDirectionArrow newIDirect = (iAnt.direction == AntDirectionArrow_Left ? AntDirectionArrow_Right : AntDirectionArrow_Left);
                        AntDirectionArrow newJDirect = (jAnt.direction == AntDirectionArrow_Left ? AntDirectionArrow_Right : AntDirectionArrow_Left);
                        
                        if (!iAnt.hasChangeDirection) {
                            iAnt.direction = newIDirect;
                            iAnt.hasChangeDirection = YES;
                        }
                        
                        if (!jAnt.hasChangeDirection) {
                            jAnt.direction = newJDirect;
                            jAnt.hasChangeDirection = YES;
                        }
                    }
                }
            }
        }
    }
    
    for (int i = 0; i < 5; ++i) {
        Ant *ant = m_ant[i];
        if (ant.isOut) {
            continue;
        }
        
        [ant step];
        if (ant.position == m_endPoint[0] || ant.position == m_endPoint[1]) {
            ant.isOut = YES;
        }
    }
}

@end
