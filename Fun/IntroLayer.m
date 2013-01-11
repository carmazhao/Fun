//
//  IntroLayer.m
//  Fun
//
//  Created by carmazhao on 12-12-11.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "GameState.h"
#import "LoadingView.h"
#import "RoundSelectionView.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(void) onEnter
{
	[super onEnter];
    
    
    
/********************   先生成ui ***************/
	CCSprite * background = [CCSprite spriteWithFile:@"pic/startbg@2x.png"];
    CGSize size = [[CCDirector sharedDirector] winSize];
   
	background.position = ccp(size.width/2, size.height/2);
    background.scale = ([GameState get_instance]).m_scale;
    [self addChild:background];
    
    //生成按钮
    //开始
    CCSprite * start_btn_normal = [CCSprite spriteWithFile:@"pic/startbt.png"];
    start_btn_normal.scale = ([GameState get_instance]).m_scale;
    start_btn_normal.contentSize = CGSizeMake(start_btn_normal.contentSize.width*([GameState get_instance]).m_scale, start_btn_normal.contentSize.height*([GameState get_instance]).m_scale);
    CCSprite * start_btn_down = [CCSprite spriteWithFile:@"pic/startbt.png"];
    start_btn_down.scale = ([GameState get_instance]).m_scale;
    start_btn_down.contentSize = CGSizeMake(start_btn_down.contentSize.width*([GameState get_instance]).m_scale, start_btn_down.contentSize.height*([GameState get_instance]).m_scale);
    start_btn_down.color = ccYELLOW;

    
    CCMenuItemSprite * start_item = [CCMenuItemSprite itemWithNormalSprite:start_btn_normal selectedSprite:start_btn_down target:self selector:@selector(start_btn_down:)];
    
    //时间模式
    CCSprite * time_mode_btn_normal = [CCSprite spriteWithFile:@"pic/timebt.png"];
    time_mode_btn_normal.scale = ([GameState get_instance]).m_scale;
    time_mode_btn_normal.contentSize = CGSizeMake(time_mode_btn_normal.contentSize.width*([GameState get_instance]).m_scale, time_mode_btn_normal.contentSize.height*([GameState get_instance]).m_scale);
    CCSprite * time_mode_btn_down = [CCSprite spriteWithFile:@"pic/timebt.png"];
    time_mode_btn_down.scale = ([GameState get_instance]).m_scale;
    time_mode_btn_down.contentSize = CGSizeMake(time_mode_btn_down.contentSize.width*([GameState get_instance]).m_scale, time_mode_btn_down.contentSize.height*([GameState get_instance]).m_scale);

    time_mode_btn_down.color = ccYELLOW;
    
    CCMenuItemSprite * time_mode_item = [CCMenuItemSprite itemWithNormalSprite:time_mode_btn_normal selectedSprite:time_mode_btn_down target:self selector:@selector(time_btn_down:)];
    
    //更多游戏
    CCSprite * more_game_btn_normal = [CCSprite spriteWithFile:@"pic/morebt.png"];
    more_game_btn_normal.scale = ([GameState get_instance]).m_scale;
    more_game_btn_normal.contentSize = CGSizeMake(more_game_btn_normal.contentSize.width*([GameState get_instance]).m_scale, more_game_btn_normal.contentSize.height*([GameState get_instance]).m_scale);
    CCSprite * more_game_btn_down = [CCSprite spriteWithFile:@"pic/morebt.png"];
    more_game_btn_down.scale = ([GameState get_instance]).m_scale;
    more_game_btn_down.contentSize = CGSizeMake(more_game_btn_down.contentSize.width*([GameState get_instance]).m_scale, more_game_btn_down.contentSize.height*([GameState get_instance]).m_scale);
    more_game_btn_down.color = ccYELLOW;

    
    CCMenuItemSprite * more_game_item = [CCMenuItemSprite itemWithNormalSprite:more_game_btn_normal selectedSprite:more_game_btn_down target:self selector:@selector(more_btn_down:)];
    
    CCMenu * menu = [CCMenu menuWithItems:start_item , time_mode_item , more_game_item , nil];
    [menu alignItemsVerticallyWithPadding:5];
    menu.position = CGPointMake(size.width/2, size.height/2);
    
    [self addChild:menu];

    /*ScrollPageView * view = [ScrollPageView create_layer];
    view.position = CGPointMake(0, 0);
    [self addChild:view];
    
    
    CCSprite * sprite1 = [CCSprite spriteWithFile:@"pic/level效果图.png"];
    sprite1.scale = 0.5;
    CCSprite * sprite2 = [CCSprite spriteWithFile:@"pic/level效果图.png"];
    sprite2.scale = 0.5;
    CCSprite * sprite3 = [CCSprite spriteWithFile:@"pic/level效果图.png"];
    sprite3.scale = 0.5;
    
    [view set_page_width:sprite1.contentSize.width * sprite1.scale];
    [view add_page_view:sprite1];
    [view add_page_view:sprite2];
    [view add_page_view:sprite3];*/
}

-(void)dealloc {
    [super dealloc];
}


//各种按钮响应
-(void)start_btn_down:(id)sender{
    //[[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInL transitionWithDuration:0.5 scene:[LoadingView sceneWithViewClass:[RoundSelectionView class]:LOAD_ROUND_SELECTION_INFO]]];
    [[CCDirector sharedDirector] replaceScene:[LoadingView sceneWithType: LOAD_ROUND_SELECTION_INFO]];
}

-(void)time_btn_down:(id)sender{
    
}
-(void)more_btn_down:(id)sender{
    
}
@end
