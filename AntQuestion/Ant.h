//
//  Ant.h
//  
//
//  Created by ning pingping on 13-4-8.
//  Copyright (c) 2013年 thinkSky. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *	蚂蚁的爬行方向
 */
typedef enum
{
	AntDirectionArrow_Left = 0, /**< 向左爬行 */
	AntDirectionArrow_Right = 1 /**< 向右爬行 */
}AntDirectionArrow;


/*
 *	蚂蚁视图类
 */
@interface Ant : UIView


/*
 *	蚂蚁当前的位置
 */
@property (nonatomic, assign)int  position;

/*
 *	蚂蚁当前的爬行方向
 */
@property (nonatomic, assign)AntDirectionArrow direction;

/*
 *	蚂蚁的爬行速度
 */
@property (nonatomic, assign)int speed;

/*
 *	蚂蚁是否已经走出有效区域
 */
@property (nonatomic, assign)BOOL isOut;

/*
 *	在step之后的判断中，是否已经进行了碰头方向的改变
 */
@property (nonatomic, assign)BOOL hasChangeDirection;


/*
 *	步进一次
 */
- (void)step;


@end
