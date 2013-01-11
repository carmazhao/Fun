//
//  LoadingView.h
//  Fun
//
//  Created by carmazhao on 12-12-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ViewData.h"

#define LOAD_ROUND_SELECTION_INFO 0
#define LOAD_GAME_ROUND_INFO      1


@interface LoadingView : CCLayer 
@property(nonatomic) NSInteger       m_load_type;
@property(nonatomic , retain)ViewData*         m_param;

+(id)sceneWithType:(NSInteger)type;
+(id)sceneWithType:(NSInteger)type:(id)param;

-(LoadingView*)initWithType:(NSInteger)type;
-(LoadingView*)initWithType:(NSInteger)type:(id)param;

-(void)load_resource;
@end
