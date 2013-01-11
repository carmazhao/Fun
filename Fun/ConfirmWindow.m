//
//  ConfirmWindow.m
//  Fun
//
//  Created by carmazhao on 13-1-10.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "ConfirmWindow.h"
#import "GameState.h"
#import "ControlCreater.h"


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
    CCMenu * next_menu = [[ControlCreater get_instance]create_simple_button:@"Icon-Small-50.png" :@"Icon-Small-50.png" :[self parent] :@selector(go_next_game:)];
    next_menu.position = CGPointMake(win_size.width/2, win_size.height/2);
    [self addChild:next_menu];
    
    //返回
    CCMenu * back_menu = [[ControlCreater get_instance]create_simple_button:@"Icon-Small-50.png" :@"Icon-Small-50.png" :[self parent] :@selector(back_to_selection:)];
    back_menu.position = CGPointMake(win_size.width/2+50, win_size.height/2);
    [self addChild:back_menu];
}
@end
