//
//  GamePoint.m
//  Fun
//
//  Created by carmazhao on 12-12-27.
//
//

#import "GamePoint.h"

@implementation GamePoint
@synthesize m_x;
@synthesize m_y;
@synthesize m_value;

-(GamePoint *)init{
    if ((self = [super init])) {
        m_x = 0;
        m_y = 0;
        m_value = 0;
    }
    return self;
}

@end
