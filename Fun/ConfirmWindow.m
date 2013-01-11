//
//  ConfirmWindow.m
//  Fun
//
//  Created by carmazhao on 13-1-10.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "ConfirmWindow.h"
#import "GameState.h"


@implementation ConfirmWindow
+(ConfirmWindow *)create_confirm_window{
    ConfirmWindow * layer = [[[ConfirmWindow alloc]init]autorelease];
    return layer;
}

-(ConfirmWindow *)init {
    if (self = [super init]) {
    }
    return self;
}

-(void)onEnter {
    [super onEnter];
    //背景
    CCSprite * background = [CCSprite spriteWithFile:@"pic/startbg@2x.png"];
    background.scale = 0.3;
    CGSize win_size = [[CCDirector sharedDirector]winSize];
    background.position = CGPointMake(win_size.width/2, win_size.height/2);
    [self addChild:background];
    
    //下一关
    CCSprite * next_btn_normal = [CCSprite spriteWithFile:@"Icon-Small-50.png"];
    next_btn_normal.scale = ([GameState get_instance]).m_scale;
    next_btn_normal.contentSize = CGSizeMake(next_btn_normal.contentSize.width * [GameState get_instance].m_scale, next_btn_normal.contentSize.height*[GameState get_instance].m_scale);
    
    CCSprite * next_btn_down = [CCSprite spriteWithFile:@"Icon-Small-50.png"];
    next_btn_down.scale = ([GameState get_instance]).m_scale;
    next_btn_down.contentSize = CGSizeMake(next_btn_down.contentSize.width * [GameState get_instance].m_scale, next_btn_down.contentSize.height*[GameState get_instance].m_scale);
    next_btn_down.color = ccYELLOW;
    
    CCMenuItemSprite * next_btn_item = [CCMenuItemSprite itemWithNormalSprite:next_btn_normal selectedSprite:next_btn_down target: [self parent] selector:@selector(go_next_game:)];
    
    CCMenu * next_menu = [CCMenu menuWithItems:next_btn_item , nil];
    next_menu.position = CGPointMake(win_size.width/2, win_size.height/2);
    [self addChild:next_menu];
}
@end
