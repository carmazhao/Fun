//
//  RoundInfoMeta.m
//  Fun
//
//  Created by carmazhao on 12-12-22.
//
//

#import "TypeOneInfoMeta.h"

@implementation TypeOneInfoMeta
@synthesize m_begin_pos;
@synthesize m_end_pos;
@synthesize m_size;

-(TypeOneInfoMeta *)init {
    if ((self = [super init])) {
        m_size = 0;
    }
    return  self;
}

-(void)dealloc {
    [super dealloc];
}
@end
