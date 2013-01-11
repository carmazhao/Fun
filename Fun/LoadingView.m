//
//  LoadingView.m
//  Fun
//
//  Created by carmazhao on 12-12-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoadingView.h"
#import "RoundSelectionData.h"
#import "RoundData.h"
#import "RoundSelectionView.h"
#import "GameTypeOneView.h"
#import "GameTypeTwoView.h"
#import "GameTypeThreeView.h"


@implementation LoadingView
@synthesize m_load_type;
@synthesize m_param;


//为了load关卡整体
+(id)sceneWithType:(NSInteger)type {
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LoadingView *layer = [[[LoadingView alloc]initWithType:type]autorelease];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
+(id)sceneWithType:(NSInteger)type :(ViewData*)param{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LoadingView *layer = [[[LoadingView alloc]initWithType:type :param]autorelease];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(LoadingView *)initWithType:(NSInteger)type{
    if ((self = [super init])) {
        m_load_type = type;
    }
    return  self;
}
-(LoadingView *)initWithType:(NSInteger)type:(ViewData*)param{
    if ((self = [super init])) {
        m_load_type = type;
        m_param = param;
    }
    return  self;
}


-(void)dealloc{
    [super dealloc];
}

-(void)onEnter{
    [super onEnter];
    CGSize winSize = [[CCDirector sharedDirector]winSize];
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"loading....."  fontName:@"Marker Felt"  fontSize:21];
    label.position = ccp(winSize.width/2,winSize.height/2);
    [self addChild:label];
    //在页面显示出来之后再读取
    [self scheduleOnce:@selector(load_resource) delay:0];
}
-(void)load_resource{
     NSInteger g_type = 0;
    
    switch (m_load_type) {
        case LOAD_ROUND_SELECTION_INFO:
            if (![RoundSelectionData get_instance].m_round_info_loaded) {
                [[RoundSelectionData get_instance]load_round_selection_info];
            }
            [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInR transitionWithDuration:0.5 scene:[RoundSelectionView scene]]];
            break;
        case LOAD_GAME_ROUND_INFO:
            g_type = [[RoundData get_instance] load_round_data:m_param];
            switch (g_type) {
                case TYPE_ONE_INFO_META:
                    [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInR transitionWithDuration:0.5 scene:[GameTypeOneView scene]]];
                    break;
                case TYPE_TWO_INFO_META:
                    [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInR transitionWithDuration:0.5 scene:[GameTypeTwoView scene]]];
                    break;
                case TYPE_THREE_INFO_META:
                    [[CCDirector sharedDirector]replaceScene:[CCTransitionMoveInR transitionWithDuration:0.5 scene:[GameTypeThreeView scene]]];
                    break;
                default:
                    break;
            }
            
            break;
        default:
            break;
    }
}
@end
