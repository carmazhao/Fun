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
#import "ControlCreater.h"
#import "ScoreCounter.h"
#import "GamePoint.h"

@implementation GameTypeBombView
@synthesize m_begin_block;
@synthesize m_block_arr;
@synthesize m_end_block;
@synthesize m_active_block_arr;
@synthesize m_time_label;
@synthesize m_line_view;
@synthesize m_pre_block;

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
    //测试
    [GameState get_instance].m_ratio = 5.0/((float)size);
    NSMutableArray * bomb_arr = [RoundData get_instance].m_type_bomb_meta.m_bomb_arr;
    for (NSInteger i = 0; i < size; i++) {
        for (NSInteger j = 0; j < size; j++) {
            block = [GameBlock block];
            [block create_sprite:@"pic/graymask.png"];
            [block set_sprite_pos:CGPointMake(base_pos.x + j*57*[GameState get_instance].m_ratio, base_pos.y + i*57*[GameState get_instance].m_ratio)];
            block.m_passed = NO;
            block.m_coor = CGPointMake(j, i);
            
            [self addChild:block.m_sprite];
            block.m_sprite.scale = [GameState get_instance].m_scale * [GameState get_instance].m_ratio;
            
            
            //记录开始位置
            if (j == begin_pos.x && i == begin_pos.y) {
                m_begin_block = [block retain];
            }
            //记录结束位置
            if (j == end_pos.x && i == end_pos.y) {
                m_end_block = [block retain];
            }
            
            //检查是否在有雷
            for (NSInteger k = 0; k < [bomb_arr count]; k++) {
                GamePoint * gp = [bomb_arr objectAtIndex:k];
                if (gp.m_x == i && gp.m_y == j) {
                    block.m_value = HAS_BOMB;
                    break;
                }else{
                    //搜索周围的雷
                    if ((j == gp.m_x + 1 ||
                         j == gp.m_x - 1 ||
                         j == gp.m_x) &&
                        (i == gp.m_y + 1 ||
                         i == gp.m_y - 1 ||
                         i == gp.m_y)) {
                            block.m_value++;
                    }
                }
            }
            
            [m_block_arr addObject:block];
            block = nil;
        }
    }
    //开始坐标和结束坐标标记
    CCSprite * begin_circle = [CCSprite spriteWithFile:@"pic/green.png"];
    begin_circle.position = CGPointMake(base_pos.x + begin_pos.x*57*[GameState get_instance].m_ratio, base_pos.y + begin_pos.y*57*[GameState get_instance].m_ratio);
    begin_circle.scale = [GameState get_instance].m_scale*[GameState get_instance].m_ratio;
    [self addChild:begin_circle];
    
    CCSprite * end_circle = [CCSprite spriteWithFile:@"pic/greencircle.png"];
    end_circle.position = CGPointMake(base_pos.x + end_pos.x*57*[GameState get_instance].m_ratio, base_pos.y + end_pos.y*57*[GameState get_instance].m_ratio);
    end_circle.scale = [GameState get_instance].m_scale*[GameState get_instance].m_ratio;
    [self addChild:end_circle];
    
    //test
    for (NSInteger m = 0; m < [m_block_arr count]; m++) {
        GameBlock * blocktmp = [m_block_arr objectAtIndex:m];
        if (blocktmp.m_value ==  -1) {
            continue;
        }
        NSString * val_str = [NSString stringWithFormat:@"pic/%d.png" , blocktmp.m_value];
        CCSprite * tmp = [CCSprite spriteWithFile:val_str];
        tmp.position = CGPointMake(base_pos.x + blocktmp.m_coor.x*57*[GameState get_instance].m_ratio, base_pos.y + blocktmp.m_coor.y*57*[GameState get_instance].m_ratio);
        [self addChild:tmp];
    }
    //构造划线的layer
    m_line_view = [[LineView alloc]init];
    m_line_view.isTouchEnabled = YES;
    [m_line_view set_base_pos:BASE_X:BASE_Y];
    [self addChild:m_line_view];
    //构造上方的按钮们
    [self create_up_btns];
    [self create_hearts_and_timer];
}

-(void)create_hearts_and_timer{
    //构造心
    CCSprite * heart_1 = [CCSprite spriteWithFile:@"pic/heart3.png"];
    heart_1.scale = [GameState get_instance].m_scale;
    heart_1.position = CGPointMake(HEART_POS_BASE_X , HEART_POS_BASE_Y);
    heart_1.tag = 1;
    [self addChild:heart_1];
    
    CCSprite * heart_2 = [CCSprite spriteWithFile:@"pic/heart3.png"];
    heart_2.scale = [GameState get_instance].m_scale;
    heart_2.position = CGPointMake(HEART_POS_BASE_X + HEART_INTER*1 , HEART_POS_BASE_Y);
    heart_2.tag = 2;
    [self addChild:heart_2];
    
    CCSprite * heart_3 = [CCSprite spriteWithFile:@"pic/heart3.png"];
    heart_3.scale = [GameState get_instance].m_scale;
    heart_3.position = CGPointMake(HEART_POS_BASE_X + HEART_INTER*2 , HEART_POS_BASE_Y);
    heart_3.tag = 3;
    [self addChild:heart_3];
    
    //启动定时器
    [self schedule:@selector(updateHeartData:) interval:1];
}

-(void)create_up_btns{
    //创建reset按钮
    CCMenu * reset_menu = [[ControlCreater get_instance]create_simple_button:@"pic/resetbt.png" :@"pic/resetbt.png" :self :@selector(game_reset:)];
    reset_menu.position = CGPointMake(240, 450);
    [self addChild:reset_menu];
    
    //创建menu按钮
    CCMenu * menu_menu = [[ControlCreater get_instance]create_simple_button:@"pic/menubt.png" :@"pic/menubt.png" :self :@selector(menu_btn_down:)];
    menu_menu.position = CGPointMake(50, 450);
    [self addChild:menu_menu];
    
}
-(void)game_reset:(id)sender{
    [[ScoreCounter get_instance]reset];
    //停止计时
    [self unschedule:@selector(updateHeartData:)];
    
    //删除心
    CCSprite * tmp_heart;
    tmp_heart = (CCSprite*)[self getChildByTag:1];
    [self removeChild:tmp_heart cleanup:YES];
    tmp_heart = nil;
    
    tmp_heart = (CCSprite*)[self getChildByTag:2];
    [self removeChild:tmp_heart cleanup:YES];
    tmp_heart = nil;
    
    tmp_heart = (CCSprite*)[self getChildByTag:3];
    [self removeChild:tmp_heart cleanup:YES];
    tmp_heart = nil;
    
    //清零label
    [m_time_label setString:@"00.00"];
    [self create_hearts_and_timer];
}
-(void)updateHeartData:(ccTime)delta{
    [[ScoreCounter get_instance] update];
    NSInteger   change = [[ScoreCounter get_instance] ready_to_change];
    [m_time_label setString:[[ScoreCounter get_instance] get_time_string]];
    if (change == -1) {
        return;
    }
    //NSLog(@"偶了");
    NSInteger   tag_of_child = 0;
    NSString    *path;
    CGPoint     pos;
    switch (change) {
            //与第一个心相关
        case CHANGE_TO_2:
            tag_of_child = 1;
            path = @"pic/heart2.png";
            pos = CGPointMake(HEART_POS_BASE_X , HEART_POS_BASE_Y);
            break;
        case CHANGE_TO_3:
            tag_of_child = 1;
            path = @"pic/heart1.png";
            pos = CGPointMake(HEART_POS_BASE_X , HEART_POS_BASE_Y);
            break;
            //与第二颗心相关
        case CHANGE_TO_4:
            tag_of_child = 2;
            path = @"pic/heart2.png";
            pos = CGPointMake(HEART_POS_BASE_X + HEART_INTER*1 , HEART_POS_BASE_Y);
            break;
        case CHANGE_TO_5:
            tag_of_child = 2;
            path = @"pic/heart1.png";
            pos = CGPointMake(HEART_POS_BASE_X + HEART_INTER*1 , HEART_POS_BASE_Y);
            break;
            //与第三颗心相关
        case CHANGE_TO_6:
            tag_of_child = 3;
            path = @"pic/heart2.png";
            pos = CGPointMake(HEART_POS_BASE_X + HEART_INTER*2 , HEART_POS_BASE_Y);
            break;
        case CHANGE_TO_7:
            tag_of_child = 3;
            path = @"pic/heart1.png";
            pos = CGPointMake(HEART_POS_BASE_X + HEART_INTER*2 , HEART_POS_BASE_Y);
            break;
        default:
            return;
            break;
    }
    
    CCSprite * tmp_heart;
    tmp_heart = (CCSprite*)[self getChildByTag:tag_of_child];
    [self removeChild:tmp_heart cleanup:YES];
    tmp_heart = nil;
    tmp_heart = [CCSprite spriteWithFile:path];
    tmp_heart.tag = tag_of_child;
    tmp_heart.position = pos;
    tmp_heart.scale = [GameState get_instance].m_scale;
    [self addChild:tmp_heart];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView:[touch view]];
    pos = [[CCDirector sharedDirector]convertToGL:pos];
    
    //清空永远也不用划线的最后一格
    m_end_block.m_passed = NO;
    //从第一个格子开始的话
    if (CGRectContainsPoint([m_begin_block.m_sprite boundingBox], pos)) {
        m_begin_block.m_passed = YES;
        m_pre_block = m_begin_block;
        [m_line_view delete_lines_begin_by:0 :0];
    }
    
    //如果不是从第一个格子开始的
    for (NSInteger i = 0; i < [m_block_arr count]; i++) {
        GameBlock * tmp_block = [m_block_arr objectAtIndex:i];
        if (CGRectContainsPoint([tmp_block.m_sprite boundingBox], pos)) {
            if (tmp_block.m_passed == NO) {
                break;
            }
            [m_line_view delete_lines_begin_by:tmp_block.m_coor.x :tmp_block.m_coor.y];
            m_pre_block = tmp_block;
        }
    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView:[touch view]];
    pos = [[CCDirector sharedDirector]convertToGL:pos];
    
    TraceLine * line = [[TraceLine alloc]init];
    
    if (CGRectContainsPoint([m_end_block.m_sprite boundingBox], pos)&&
        m_end_block.m_passed != YES) {
        NSLog(@"here");
        m_end_block.m_passed = YES;
        if ((m_pre_block.m_coor.x == m_end_block.m_coor.x &&
             ABS(m_pre_block.m_coor.y - m_end_block.m_coor.y)==1)||
            (m_pre_block.m_coor.y == m_end_block.m_coor.y&&
             ABS(m_pre_block.m_coor.x - m_end_block.m_coor.x)==1)) {
            [self game_pass];
        }
    }
    
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
            if ((m_pre_block.m_coor.x == tmp.m_coor.x &&
                 ABS(m_pre_block.m_coor.y - tmp.m_coor.y)==1)||
                (m_pre_block.m_coor.y == tmp.m_coor.y&&
                 ABS(m_pre_block.m_coor.x - tmp.m_coor.x)==1)) {
                    tmp.m_passed = YES;
                    //计算一根线
                    line.m_begin_pos = m_pre_block;
                    line.m_end_pos = tmp;
                    [m_line_view.m_lines_arr addObject:line];
                    m_pre_block = tmp;
                }
        }
    }
    [line release];
}
-(void)game_pass{
    //将计时器停住
    [self unscheduleAllSelectors];
    NSInteger level = [[ScoreCounter get_instance]get_game_score_level];
    NSInteger score = 0;
    switch (level) {
        case H_1_LIMIT:
        case H_1_SCORE:
            score = 4;
            break;
        case H_2_LIMIT:
        case H_2_SCORE:
            score = 3;
            break;
        case H_3_LIMIT:
        case H_3_SCORE:
            score =2;
            break;
        case H_4_LIMIT:
        case H_4_SCORE:
            score = 1;
            break;
        default:
            break;
    }
    NSLog(@"pass!!");
}
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
}

@end
