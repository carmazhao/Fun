//
//  GameState.m
//  Fun
//
//  Created by carmazhao on 12-12-11.
//
//

#import "GameState.h"

static GameState * m_inst;

@implementation GameState
@synthesize m_scale;

+(GameState *)get_instance {
    if (m_inst == nil) {
        m_inst = [[GameState alloc]init];
    }
    return m_inst;
}

-(GameState*)init {
    if ((self =[super init])) {
        m_scale = 1;
    }
    return  self;
}
@end
