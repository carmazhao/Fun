//
//  ScrollPageView.m
//  Fun
//
//  Created by carmazhao on 12-12-13.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScrollPageView.h"
#import "GameState.h"


@implementation ScrollPageView

@synthesize m_main_layer;
@synthesize m_num_of_pages;
@synthesize m_unit_width;
@synthesize m_pre_touch_pos;
@synthesize m_dir_flag;
@synthesize m_pre_layer_pos;
@synthesize m_dots_arr;
@synthesize m_lighted_dot;

+(ScrollPageView*)create_layer {
    
	ScrollPageView *layer = [ScrollPageView node];
	
	// return the scene
	return layer;
}

-(ScrollPageView *)init {
    if ((self = [super init])) {
        m_main_layer = [CCLayer node];
        m_main_layer.position = CGPointMake(0, 0);
        m_pre_layer_pos = m_main_layer.position;
        [self addChild:m_main_layer];
        
        m_dots_arr = [[NSMutableArray alloc]init];
        m_lighted_dot = [CCSprite spriteWithFile:@"pic/circle.png"];
        m_lighted_dot.scale = [GameState get_instance].m_scale;
        [self addChild:m_lighted_dot z:1];
        
        CGSize winsize = [[CCDirector sharedDirector]winSize];
        m_unit_width = winsize.width;
        m_num_of_pages = 0;
        
        m_dir_flag = MOVE_RIGHT;
        
        self.isTouchEnabled = YES;
    }
    return self;
}
-(void)onEnter{
    [super onEnter];
}

-(void)dealloc{
    [super dealloc];
}
-(void)add_page_view:(CCLayer *)page {
    CGPoint pos = CGPointMake(m_unit_width * m_num_of_pages, 0);
    page.position = pos;
    [m_main_layer addChild:page];
    m_num_of_pages++;
    
    //加一个点点
    CCSprite * dot = [CCSprite spriteWithFile:@"pic/circled.png"];
    dot.scale = [GameState get_instance].m_scale;
    [self addChild:dot z:0];
    [m_dots_arr addObject:dot];
    
    CGSize  win_size = [[CCDirector sharedDirector]winSize];
    //找到点点的开始位置
    NSInteger sum_size = DOT_INTER * [m_dots_arr count];
    CGPoint begin_pos = CGPointMake((win_size.width - sum_size)/2 + 10, 70);
    CCSprite * tmp_dot;
    for (NSInteger i = 0; i < [m_dots_arr count]; i++) {
        tmp_dot = [m_dots_arr objectAtIndex:i];
        tmp_dot.position = CGPointMake(begin_pos.x + i * DOT_INTER, begin_pos.y);
    }
    
    m_lighted_dot.position = begin_pos;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    m_pre_touch_pos = [[CCDirector sharedDirector]convertToGL:point];
}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint new_pos = [touch locationInView:[touch view]];
    new_pos = [[CCDirector sharedDirector]convertToGL:new_pos];
    
    NSInteger dx = new_pos.x - m_pre_touch_pos.x;
    if (dx <= 0) {
        m_dir_flag = MOVE_LEFT;
    }else{
        m_dir_flag = MOVE_RIGHT;
    }
    m_main_layer.position = CGPointMake(m_main_layer.position.x + dx, 0);
    m_pre_touch_pos = new_pos;
}
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSInteger   dis = ABS(m_pre_layer_pos.x - m_main_layer.position.x);
    NSInteger   count = dis/m_unit_width;
    CGPoint     target_pos;
    
    if (m_dir_flag == MOVE_LEFT) {
        target_pos = CGPointMake(-((count+1) * m_unit_width) + m_pre_layer_pos.x, 0);
    }else{
        target_pos = CGPointMake((count+1) * m_unit_width + m_pre_layer_pos.x, 0);
    }
    
    if (NO == [self check_bound:target_pos]) {
        return;
    }
    
    //改变小点点
    if (m_dir_flag == MOVE_LEFT) {
        m_lighted_dot.position = CGPointMake(m_lighted_dot.position.x + DOT_INTER , m_lighted_dot.position.y);
    }else{
        m_lighted_dot.position = CGPointMake(m_lighted_dot.position.x - DOT_INTER , m_lighted_dot.position.y);
    }
    
    CCMoveTo * move = [CCMoveTo actionWithDuration:0.5 position:target_pos];
    CCEaseOut * action = [CCEaseOut actionWithAction:move rate:4];
    CCCallFuncN * end_func = [CCCallFuncN actionWithTarget:self selector:@selector(ease_end)];
    CCSequence * sequence = [CCSequence actions:action , end_func , nil];
    [m_main_layer runAction:sequence];
    self.isTouchEnabled = NO;
    m_pre_layer_pos = target_pos;
}
-(void)ease_end{
    self.isTouchEnabled = YES;
}

-(BOOL)check_bound:(CGPoint)target{
    if (m_dir_flag == MOVE_LEFT) {
        if (target.x + m_unit_width * m_num_of_pages <= 0) {
            CCMoveTo * move = [CCMoveTo actionWithDuration:0.5 position:CGPointMake(target.x + m_unit_width, 0)];
            CCEaseOut * action = [CCEaseOut actionWithAction:move rate:4];
            CCCallFuncN * end_func = [CCCallFuncN actionWithTarget:self selector:@selector(ease_end)];
            CCSequence * sequence = [CCSequence actions:action , end_func , nil];
            [m_main_layer runAction:sequence];
            self.isTouchEnabled = NO;
            m_pre_layer_pos = CGPointMake(target.x + m_unit_width, 0);
            return NO;
        }
    }else{
        if (target.x > 0) {
            CCMoveTo * move = [CCMoveTo actionWithDuration:0.5 position:CGPointMake(0, 0)];
            CCEaseOut * action = [CCEaseOut actionWithAction:move rate:4];
            CCCallFuncN * end_func = [CCCallFuncN actionWithTarget:self selector:@selector(ease_end)];
            CCSequence * sequence = [CCSequence actions:action , end_func , nil];
            [m_main_layer runAction:sequence];
            self.isTouchEnabled = NO;
            m_pre_layer_pos = CGPointMake(0, 0);
            return NO;
        }
    }
   /* if (m_dir_flag == MOVE_LEFT) {
        //if the elements count is small
        CGSize      _win_size = [[CCDirector sharedDirector]winSize];
        //第一种情况
        NSInteger   _rest_width = m_num_of_pages*m_unit_width + m_main_layer.position.x;
        if (_rest_width < _win_size.width) {
            CGPoint     _target = CGPointMake(m_main_layer.position.x + (_win_size.width - _rest_width), m_main_layer.position.y);
            
            CCMoveTo * _move = [CCMoveTo actionWithDuration:0.5 position:_target];
            CCEaseOut * _action = [CCEaseOut actionWithAction:_move rate:4];
            [m_main_layer stopAllActions];
            [m_main_layer runAction:_action];
            return NO;
        }

    }else{
        if (m_main_layer.position.x + m_unit_width > 0) {
            CCMoveTo * move = [CCMoveTo actionWithDuration:0.5 position:CGPointMake(0, 0)];
            CCEaseOut * action = [CCEaseOut actionWithAction:move rate:4];
            CCCallFuncN * end_func = [CCCallFuncN actionWithTarget:self selector:@selector(ease_end)];
            CCSequence * sequence = [CCSequence actions:action , end_func , nil];
            [m_main_layer runAction:sequence];
            self.isTouchEnabled = NO;
            m_pre_layer_pos = CGPointMake(0, 0);
            return NO;
        }
    }*/
    return YES;
}
@end
