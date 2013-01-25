//
//  SelectionPage.m
//  Fun
//
//  Created by carmazhao on 12-12-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectionPage.h"
#import "GameState.h"
#import "IntroLayer.h"
#import "LoadingView.h"
#import "GameTypeOneView.h"
#import "ViewData.h"
#import "ControlCreater.h"


@implementation SelectionPage
@synthesize m_meta;
@synthesize m_level_arr;
@synthesize m_touch_locked;
@synthesize m_page_num;

+(SelectionPage *)create_page:(RoundSelectionMeta *)meta:(NSInteger)page_num{
    SelectionPage * layer = [[[SelectionPage alloc]initWithMeta:meta:page_num]autorelease];
    return  layer;
}   

-(SelectionPage *)initWithMeta:(RoundSelectionMeta *)meta:(NSInteger)page_num{
    if ((self = [super initWithColor:ccc4(255, 0, 0, 255)])) {
        m_meta = [meta retain];
        m_level_arr = [[NSMutableArray alloc]init];
        self.isTouchEnabled = YES;
        m_touch_locked = NO;
        m_page_num = page_num;
    }
    return  self;
}

-(void)dealloc{
    [super dealloc];
    [m_meta release];
    [m_level_arr release];
}
-(void)onEnter {
    [super onEnter];
    CGSize winsize = [[CCDirector sharedDirector]winSize];
    //创建背景
    CCSprite *  background = [CCSprite spriteWithFile:@"pic/levelbg.png"];
    background.position = CGPointMake(winsize.width/2 , winsize.height/2);
    background.scale = [GameState get_instance].m_scale;
    [self addChild:background];
    
    //创建关卡size栏
    CCSprite * size_label;
    NSInteger size_val = m_meta.m_game_size;
    switch (size_val) {
        case 5:
            size_label = [CCSprite spriteWithFile:@"pic/5x5.png"];
            break;
        default:
            break;
    }
    if (size_label != nil) {
        size_label.scale = [GameState get_instance].m_scale;
        size_label.position = CGPointMake(77, 425);
        [self addChild:size_label];
    }
    
    //创建返回按钮
    CCMenu * menu = [[ControlCreater get_instance]create_simple_button:@"pic/backbt.png" :@"pic/backbt.png" :self :@selector(back_btn_down:)];
    menu.position = CGPointMake(96 , 120);
    [self addChild:menu];
    
    //创建各种关卡
    CCSprite * level_btn;
    CGPoint     base_pos = CGPointMake(67, 369);
    NSInteger  line_num = 0;
    NSInteger  colum_num = 0;
    for (NSInteger i = 0; i < m_meta.m_game_num; i++) {
        switch ([(NSNumber *)[m_meta.m_round_level_arr objectAtIndex:i] intValue]) {
            case 0:
                level_btn = [CCSprite spriteWithFile:@"pic/forbidden.png"];
                break;
            case 1:
                level_btn = [CCSprite spriteWithFile:@"pic/level0.png"];
                break;
            case 2:
                level_btn = [CCSprite spriteWithFile:@"pic/level1.png"];
                break;
            case 3:
                level_btn = [CCSprite spriteWithFile:@"pic/level2.png"];
                break;
            case 4:
                level_btn = [CCSprite spriteWithFile:@"pic/level3.png"];
                break;
            default:
                level_btn = [CCSprite spriteWithFile:@"pic/level0.png"];
                break;
        }
        level_btn.scale = [GameState get_instance].m_scale;
        level_btn.tag = [(NSNumber *)[m_meta.m_round_level_arr objectAtIndex:i] intValue];
        
       // level_btn.contentSize = CGSizeMake(level_btn.contentSize.width * [GameState get_instance].m_scale, level_btn.contentSize.height*[GameState get_instance].m_scale);
        line_num = i/5;
        colum_num = i%5;
        
        level_btn.position = CGPointMake(base_pos.x + colum_num * 45, base_pos.y - line_num*45);
        [self addChild:level_btn];
        [m_level_arr addObject:level_btn];
        level_btn = nil;
    }
}

-(void)back_btn_down:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInL transitionWithDuration:0.3 scene:[IntroLayer scene]]];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    m_touch_locked = YES;
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (m_touch_locked) {
        m_touch_locked = NO;
        return;
    }
    //边界检查
    NSInteger bound_x = self.parent.position.x + self.position.x;
    if (bound_x < 0 ||
        bound_x >= [[CCDirector sharedDirector]winSize].width) {
        return;
    }
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView:[touch view]];
    pos = [[CCDirector sharedDirector] convertToGL:pos];
    
    CCSprite * block;
    ViewData * v_d;
    for (NSInteger i = 0; i < [m_level_arr count]; i++) {
        block = [m_level_arr objectAtIndex:i];
        if (CGRectContainsPoint([block boundingBox], pos)) {
            //先检查本关卡开启了么
            if (block.tag == 0) {
                return;
            }
            v_d = [[ViewData alloc]init];
            v_d.m_game_index = i;
            v_d.m_page_num = m_page_num;
            NSLog(@"%d page number  " , m_page_num);
            //进入loading页面
            [[CCDirector sharedDirector]replaceScene:[LoadingView sceneWithType:LOAD_GAME_ROUND_INFO :v_d]];
            [v_d release];
            v_d = nil;
        }
    }
}
@end
