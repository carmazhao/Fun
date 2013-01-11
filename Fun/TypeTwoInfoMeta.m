//
//  TypeTwoInfoMeta.m
//  Fun
//
//  Created by carmazhao on 12-12-27.
//
//

#import "TypeTwoInfoMeta.h"
#import "GamePoint.h"

@implementation TypeTwoInfoMeta
@synthesize m_begin_pos;
@synthesize m_end_pos;
@synthesize m_size;
@synthesize m_empty_block_arr;

-(TypeTwoInfoMeta *)init {
    if ((self = [super init])) {
        m_size = 0;
        m_empty_block_arr = [[NSMutableArray alloc]init];
    }
    return  self;
}

-(void)dealloc {
    [super dealloc];
    [m_empty_block_arr release];
}
@end
