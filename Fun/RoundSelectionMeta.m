//
//  CheckPointInfo.m
//  Fun
//
//  Created by carmazhao on 12-12-13.
//
//

#import "RoundSelectionMeta.h"

@implementation RoundSelectionMeta
@synthesize m_round_level_arr;
@synthesize m_game_num;
@synthesize m_game_size;

-(RoundSelectionMeta *)init{
    if ((self = [super init])) {
        m_round_level_arr = [[NSMutableArray alloc]init];
        m_game_size = 0;
        m_game_num = 0;
    }
    return self;
}
@end
