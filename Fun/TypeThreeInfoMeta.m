//
//  TypeThreeInfoMeta.m
//  Fun
//
//  Created by carmazhao on 13-1-4.
//
//

#import "TypeThreeInfoMeta.h"

@implementation TypeThreeInfoMeta
@synthesize m_begin_pos;
@synthesize m_end_pos;
@synthesize m_size;
@synthesize m_signed_block_arr;

-(TypeThreeInfoMeta *)init {
    if ((self = [super init])) {
        m_size = 0;
        m_signed_block_arr = [[NSMutableArray alloc]init];
    }
    return  self;
}

-(void)dealloc {
    [super dealloc];
    [m_signed_block_arr release];
}
@end
