//
//  GameView.h
//  Fun
//
//  Created by carmazhao on 12-12-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameBlock.h"
#import "LineView.h"
#import "ViewData.h"

#define BASE_X 50
#define BASE_Y 100


#define HEART_POS_BASE_X    230
#define HEART_POS_BASE_Y    390
#define HEART_INTER         26

@interface GameTypeOneView : CCLayer {
}
@property(nonatomic , retain)NSMutableArray * m_block_arr;
@property(nonatomic , retain)GameBlock *      m_begin_block;
@property(nonatomic , retain)GameBlock *      m_end_block;
@property(nonatomic , retain)GameBlock *      m_pre_block;//记录前一个滑到的点的横纵编号
@property(nonatomic , retain)LineView *       m_line_view;
@property(nonatomic , retain)CCLabelAtlas*    m_time_label;//用于显示时间的label

+(id)scene;
-(GameTypeOneView *)init;
-(void)create_up_btns;
-(void)create_hearts_and_timer;
-(void)game_pass;
-(void)game_reset:(id)sender;
@end
