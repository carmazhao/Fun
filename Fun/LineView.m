//
//  LineView.m
//  Fun
//
//  Created by carmazhao on 12-12-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "LineView.h"


@implementation LineView
@synthesize m_lines_arr;
-(LineView*)init{
    if ((self = [super init])) {
        m_lines_arr = [[NSMutableArray alloc]init];
    }
    return  self;
}

-(void)draw{
    TraceLine * line;
    for (NSInteger i = 0; i < [m_lines_arr count]; i++) {
        line = [m_lines_arr objectAtIndex:i];
        glLineWidth(6);
        ccDrawLine(line.m_begin_pos, line.m_end_pos);
    }
}

-(void)add_line:(TraceLine *)line{
    [m_lines_arr addObject:line];
}

-(void)dealloc{
    [super dealloc];
    [m_lines_arr release];
}
@end
