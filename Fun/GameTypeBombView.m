//
//  GameTypeBombView.m
//  Fun
//
//  Created by carmazhao on 13-1-13.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameTypeBombView.h"
#import "GameState.h"
#import "RoundData.h"

@implementation GameTypeBombView
@synthesize m_begin_block;
@synthesize m_block_arr;
@synthesize m_end_block;
@synthesize m_active_block_arr;
@synthesize m_time_label;

+(id)scene{
    CCScene * scene = [CCScene node];
    GameTypeBombView * layer = [[GameTypeBombView alloc]init];
    [scene addChild:layer];
    return scene;
}

-(GameTypeBombView * )init{
    if ((self = [super init])) {
        m_block_arr = [[NSMutableArray alloc]init];
        m_active_block_arr = [[NSMutableArray alloc]init];
        self.isTouchEnabled = YES;
    }
    return self;
}

-(void)dealloc{
    [super dealloc];
    [m_block_arr release];
    [m_active_block_arr release];
    [m_begin_block release];
    [m_end_block release];
}

-(void)onEnter {
    [super onEnter];
    //构造背景
    CGSize win_size = [[CCDirector sharedDirector]winSize];
    CCSprite * background = [CCSprite spriteWithFile:@"pic/gamebg4.png"];
    background.scale = [GameState get_instance].m_scale;
    background.position = CGPointMake(win_size.width/2, win_size.height/2);
    [self addChild:background];
    
    //得到起始和终点坐标
    CGPoint begin_pos = [RoundData get_instance].m_type_bomb_meta.m_begin_pos;
    CGPoint end_pos = [RoundData get_instance].m_type_bomb_meta.m_end_pos;
    
    NSInteger size = [RoundData get_instance].m_type_bomb_meta.m_size;
    CGPoint  base_pos = CGPointMake(BASE_X , BASE_Y);
    GameBlock * block;
    for (NSInteger i = 0; i < size; i++) {
        for (NSInteger j = 0; j < size; j++) {
            block = [GameBlock block];
            [block create_sprite:@"pic/yellowmask.png"];
            [block set_sprite_pos:CGPointMake(base_pos.x + j*57, base_pos.y + i*57)];
            block.m_passed = NO;
            block.m_coor = CGPointMake(j, i);
            
            [self addChild:block.m_sprite];
            [m_block_arr addObject:block];
            
            //记录开始位置
            if (j == begin_pos.x && i == begin_pos.y) {
                   NSLog(@"begin %d %d" , j , i);
                m_begin_block = [block retain];
            }
            //记录结束位置
            if (j == end_pos.x && i == end_pos.y) {
                    NSLog(@"begin %d %d" , j , i);
                m_end_block = [block retain];
            }
            block = nil;
        }
    }
    //  NSLog(@"%d" ,(int)[m_block_arr count]);
    //开始坐标和结束坐标标记
    CCSprite * begin_circle = [CCSprite spriteWithFile:@"pic/green.png"];
    begin_circle.position = CGPointMake(base_pos.x + begin_pos.x*57, base_pos.y + begin_pos.y*57);
    begin_circle.scale = [GameState get_instance].m_scale;
    [self addChild:begin_circle];
    
    CCSprite * end_circle = [CCSprite spriteWithFile:@"pic/greencircle.png"];
    end_circle.position = CGPointMake(base_pos.x + end_pos.x*57, base_pos.y + end_pos.y*57);
    end_circle.scale = [GameState get_instance].m_scale;
    [self addChild:end_circle];

    
}

@end
