//
//  GameView.m
//  Fun
//
//  Created by carmazhao on 12-12-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameTypeOneView.h"
#import "GameState.h"
#import "RoundData.h"
#import "GameBlock.h"
#import "TraceLine.h"
#import "ScoreCounter.h"
#import "RoundSelectionData.h"
#import "ConfirmWindow.h"
#import "LoadingView.h"
#import "ControlCreater.h"
#import "IntroLayer.h"
//for test
//#import "RoundSelectionView.h"

@implementation GameTypeOneView
@synthesize m_block_arr;
@synthesize m_begin_block;
@synthesize m_end_block;
@synthesize m_pre_point;
@synthesize m_line_view;
@synthesize m_time_label;

+(id)scene{
    CCScene * scene = [CCScene node];
    GameTypeOneView * layer = [[GameTypeOneView alloc]init];
    [scene addChild:layer];
    return scene;
}

-(GameTypeOneView * )init{
    if ((self = [super init])) {
        m_block_arr = [[NSMutableArray alloc]init];
        //m_heart_arr = [[NSMutableArray alloc]init];
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

-(void)onEnter {
    [super onEnter];
    
    //构造背景
    CGSize win_size = [[CCDirector sharedDirector]winSize];
    CCSprite * background = [CCSprite spriteWithFile:@"pic/gamebg1.png"];
    background.scale = [GameState get_instance].m_scale;
    background.position = CGPointMake(win_size.width/2, win_size.height/2);
    [self addChild:background];

    //显示时间的label
    m_time_label = [CCLabelAtlas labelWithString:@"00.00" charMapFile:@"fps_images-hd.png" itemWidth:24 itemHeight:60 startCharMap:'.'];
    m_time_label.position = CGPointMake(63, 384);
    m_time_label.scale = [GameState get_instance].m_scale;
    [self addChild:m_time_label];
    
    //构造黄色块
    if ([RoundData get_instance].m_type_one_meta == nil) {
        NSLog(@"TypeOneData is empty!");
        return;
    }
    //得到起始和终点坐标
    CGPoint begin_pos = [RoundData get_instance].m_type_one_meta.m_begin_pos;
    CGPoint end_pos = [RoundData get_instance].m_type_one_meta.m_end_pos;

    NSInteger size = [RoundData get_instance].m_type_one_meta.m_size;
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
    
    //构造上方的按钮们
    [self create_up_btns];
    [self create_hearts_and_timer];
    
    //构造划线的layer
    m_line_view = [[LineView alloc]init];
    m_line_view.isTouchEnabled = YES;
    [self addChild:m_line_view];
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
}

-(void)game_pass{
    //将计时器停住
    [self unscheduleAllSelectors];
    NSInteger level = [[ScoreCounter get_instance]get_game_score_level];
    NSInteger score = 0;
    switch (level) {
        case H_1_LIMIT:
        case H_1_SCORE:
            score = 3;
            break;
        case H_2_LIMIT:
        case H_2_SCORE: 
            score = 2;
            break;
        case H_3_LIMIT:
        case H_3_SCORE:
            score = 1;
            break;
        case H_4_LIMIT:
        case H_4_SCORE:
            score = 0;
            break;
        default:
            break;
    }
    
    ViewData * vd = [RoundData get_instance].m_cur_round;
    [[RoundSelectionData get_instance]change_data:vd :score];
    ConfirmWindow * cf_win = [ConfirmWindow create_confirm_window];
    [self addChild:cf_win];
}

-(void)go_next_game:(id)sender {
    ViewData * v_d = [[RoundData get_instance]get_next_game];
    //进入loading页面
    [[CCDirector sharedDirector]replaceScene:[LoadingView sceneWithType:LOAD_GAME_ROUND_INFO :v_d]];
    [[ScoreCounter get_instance]reset];
}

-(void)back_to_selection:(id)sender {
    [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInL transitionWithDuration:0.3 scene:[IntroLayer scene]]];
    [[ScoreCounter get_instance]reset];
}
@end
