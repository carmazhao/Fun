//
//  TypeBombInfoMeta.m
//  Fun
//
//  Created by carmazhao on 13-1-13.
//
//

#import "TypeBombInfoMeta.h"

@implementation TypeBombInfoMeta
@synthesize m_begin_pos;
@synthesize m_end_pos;
@synthesize m_size;
@synthesize m_bomb_arr;

-(TypeBombInfoMeta *)init {
    if ((self = [super init])) {
        m_size = 0;
        m_bomb_arr = [[NSMutableArray alloc]init];
    }
    return  self;
}

-(void)dealloc {
    [super dealloc];
    [m_bomb_arr release];
}
@end
