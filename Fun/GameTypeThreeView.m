//
//  GameTypeThreeView.m
//  Fun
//
//  Created by carmazhao on 13-1-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameTypeThreeView.h"
#import "GameState.h"
#import "RoundData.h"
#import "GamePoint.h"
#import "ScoreCounter.h"


@implementation GameTypeThreeView
@synthesize m_block_arr;
@synthesize m_begin_block;
@synthesize m_end_block;
@synthesize m_pre_point;
@synthesize m_line_view;
@synthesize m_score_label;

+(id)scene{
    CCScene * scene = [CCScene node];
    GameTypeThreeView * layer = [[GameTypeThreeView alloc]init];
    [scene addChild:layer];
    return scene;
}

-(GameTypeThreeView * )init{
    if ((self = [super init])) {
        m_block_arr = [[NSMutableArray alloc]init];
        self.isTouchEnabled = YES;
    }
    return self;
}

-(void)dealloc{
    [super dealloc];
    [m_block_arr release];
    [m_begin_block release];
    [m_end_block release];
    [m_line_view release];
    //[m_heart_arr release];
}

-(void)onEnter{
    [super onEnter];
    //构造背景
    CGSize win_size = [[CCDirector sharedDirector]winSize];
    CCSprite * background = [CCSprite spriteWithFile:@"pic/gamebg3.png"];
    background.scale = [GameState get_instance].m_scale;
    background.position = CGPointMake(win_size.width/2, win_size.height/2);
    [self addChild:background];
    
    //显示分数的label
    m_score_label = [CCLabelAtlas labelWithString:@"0" charMapFile:@"fps_images-hd.png" itemWidth:24 itemHeight:60 startCharMap:'.'];
    m_score_label.position = CGPointMake(90, 382);
    m_score_label.scale = [GameState get_instance].m_scale;
    [self addChild:m_score_label];

    
    //构造块
    if ([RoundData get_instance].m_type_three_meta == nil) {
        NSLog(@"TypeOneData is empty!");
        return;
    }
    
    //得到起始和终点坐标
    CGPoint begin_pos = [RoundData get_instance].m_type_three_meta.m_begin_pos;
    CGPoint end_pos = [RoundData get_instance].m_type_three_meta.m_end_pos;
    
    NSInteger size = [RoundData get_instance].m_type_three_meta.m_size;
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
                //   NSLog(@"begin %d %d" , j , i);
                m_begin_block = [block retain];
            }
            //记录结束位置
            if (j == end_pos.x && i == end_pos.y) {
                //    NSLog(@"begin %d %d" , j , i);
                m_end_block = [block retain];
            }
            block = nil;
        }
    }

    // 写上数字
    NSMutableArray * s_block_arr = [RoundData get_instance].m_type_three_meta.m_signed_block_arr;
    NSInteger value = 0;
    CCSprite * sp;
    NSString * pic_path;
    
    for (NSInteger k = 0; k < [s_block_arr count]; k++) {
        value = ((GamePoint*)[s_block_arr objectAtIndex:k]).m_value;
        pic_path = [NSString stringWithFormat:@"pic/big%d.png" , value];
        sp = [CCSprite spriteWithFile:pic_path];
        sp.position = CGPointMake(base_pos.x + ((GamePoint*)[s_block_arr objectAtIndex:k]).m_x*57, base_pos.y + ((GamePoint*)[s_block_arr objectAtIndex:k]).m_y*57);
        sp.scale = [GameState get_instance].m_scale;
        //标记已经生成的快
        GameBlock * tmp_block;
        for (NSInteger m = 0; m < [m_block_arr count]; m++) {
            tmp_block = [m_block_arr objectAtIndex:m];
            if (tmp_block.m_coor.x == ((GamePoint*)[s_block_arr objectAtIndex:k]).m_x&&
                tmp_block.m_coor.y == ((GamePoint*)[s_block_arr objectAtIndex:k]).m_y) {
                tmp_block.m_value = value;
            }
        }
        [self addChild:sp];
    }
    
    //开始坐标和结束坐标标记
    CCSprite * begin_circle = [CCSprite spriteWithFile:@"pic/green.png"];
    begin_circle.position = CGPointMake(base_pos.x + begin_pos.x*57, base_pos.y + begin_pos.y*57);
    begin_circle.scale = [GameState get_instance].m_scale;
    [self addChild:begin_circle];
    
    CCSprite * end_circle = [CCSprite spriteWithFile:@"pic/greencircle.png"];
    end_circle.position = CGPointMake(base_pos.x + end_pos.x*57, base_pos.y + end_pos.y*57);
    end_circle.scale = [GameState get_instance].m_scale;
    [self addChild:end_circle];
    
    //构造划线的layer
    m_line_view = [[LineView alloc]init];
    m_line_view.isTouchEnabled = YES;
    [self addChild:m_line_view];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView:[touch view]];
    pos = [[CCDirector sharedDirector]convertToGL:pos];
    
    if (CGRectContainsPoint([m_begin_block.m_sprite boundingBox], pos)) {
        m_begin_block.m_passed = YES;
        m_pre_point = m_begin_block.m_coor;
    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView:[touch view]];
    pos = [[CCDirector sharedDirector]convertToGL:pos];
    
    TraceLine * line = [[TraceLine alloc]init];
    if (m_begin_block.m_passed == YES) {
        for (NSInteger i = 0; i < [m_block_arr count]; i++) {
            //  NSLog(@"%d" , (int)i);
            GameBlock * tmp = [m_block_arr objectAtIndex:i];
            if (tmp.m_passed == YES) {
                continue;
            }
            //检查是否落入方格内
            if (!CGRectContainsPoint([tmp.m_sprite boundingBox], pos)) {
                continue;
            }
            if ((m_pre_point.x == tmp.m_coor.x &&
                 ABS(m_pre_point.y - tmp.m_coor.y)==1)||
                (m_pre_point.y == tmp.m_coor.y&&
                 ABS(m_pre_point.x - tmp.m_coor.x)==1)) {
                    
                    tmp.m_passed = YES;
                    [[ScoreCounter get_instance]add_score:tmp.m_value];
                    [m_score_label setString:[[ScoreCounter get_instance]get_score_string]];
                    //计算一根线
                    line.m_begin_pos = CGPointMake(BASE_X + m_pre_point.x*57, BASE_Y + m_pre_point.y*57);
                    line.m_end_pos = CGPointMake(BASE_X + tmp.m_coor.x*57, BASE_Y + tmp.m_coor.y*57);
                    [m_line_view.m_lines_arr addObject:line];
                    m_pre_point = tmp.m_coor;
                }
        }
    }
    [line release];
    if (CGRectContainsPoint([m_end_block.m_sprite boundingBox], pos)&&
        m_end_block.m_passed == YES) {
        for (NSInteger i = 0; i < [m_block_arr count]; i++) {
            GameBlock * tmp = [m_block_arr objectAtIndex:i];
            if (!tmp.m_passed) {
                return;
            }
        }
        [self game_pass];
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (NSInteger i = 0; i < [m_block_arr count]; i++) {
        GameBlock * tmp = [m_block_arr objectAtIndex:i];
        tmp.m_passed = NO;
    }
    //清空线
    [m_line_view.m_lines_arr removeAllObjects];
    //清空分数
    [[ScoreCounter get_instance]reset];
    [m_score_label setString:@"0"];
}

-(void)game_pass{
    
}

@end
