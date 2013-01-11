//
//  RoundSelectionView.m
//  Fun
//
//  Created by carmazhao on 12-12-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoundSelectionView.h"
#import "RoundSelectionData.h"
#import "ScrollPageView.h"
#import "SelectionPage.h"
#import "GameState.h"


@implementation RoundSelectionView

+(id)scene{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	RoundSelectionView *layer = [RoundSelectionView node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(RoundSelectionView * )init{
    if ((self = [super init])) {
        self.isTouchEnabled = YES;
    }
    return  self;
}
-(void)dealloc{
    [super dealloc];
}

-(void)onEnter {
    [super onEnter];
    ScrollPageView * scroll_view = [ScrollPageView create_layer];
    scroll_view.position = CGPointMake(0, 0);
    [self addChild:scroll_view];
    //利用数据构造选关页面
    NSMutableArray * meta_arr = [RoundSelectionData get_instance].m_game_arr;
    SelectionPage * page = nil;
    for (NSInteger i = 0; i < [meta_arr count]; i++) {
        page = [SelectionPage create_page:[meta_arr objectAtIndex:i]:i];
        [scroll_view add_page_view:page];
    }
}
@end
