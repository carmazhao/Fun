//
//  LineView.m
//  Fun
//
//  Created by carmazhao on 12-12-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "LineView.h"
#import "GameState.h"


@implementation LineView
@synthesize m_lines_arr;
@synthesize m_base_pos;

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
        CGPoint begin_pos = CGPointMake(m_base_pos.x + line.m_begin_pos.m_coor.x*57*[GameState get_instance].m_ratio, m_base_pos.y + line.m_begin_pos.m_coor.y*57*[GameState get_instance].m_ratio);
        CGPoint end_pos = CGPointMake(m_base_pos.x + line.m_end_pos.m_coor.x*57*[GameState get_instance].m_ratio, m_base_pos.y + line.m_end_pos.m_coor.y*57*[GameState get_instance].m_ratio);
        ccDrawLine(begin_pos, end_pos);
    }
}

-(void)add_line:(TraceLine *)line{
    [m_lines_arr addObject:line];
}

-(void)set_base_pos:(NSInteger)x :(NSInteger)y{
    m_base_pos.x = x;
    m_base_pos.y = y;
}

-(void)delete_lines_begin_by:(NSInteger)x:(NSInteger)y{
    for (NSInteger i = 0; i < [m_lines_arr count]; i++) {
        TraceLine * line = [m_lines_arr objectAtIndex:i];
        if (line.m_begin_pos.m_coor.x == x &&
            line.m_begin_pos.m_coor.y == y) {
            
            //把所有去掉的节点制成未pass
            for (NSInteger j = i; j < [m_lines_arr count]; j++) {
                TraceLine * tmp = [m_lines_arr objectAtIndex:j];
              //  tmp.m_begin_pos.m_passed = NO;
                tmp.m_end_pos.m_passed = NO;
            }
            [m_lines_arr removeObjectsInRange:NSMakeRange(i, [m_lines_arr count] - i)];
        }
    }
}
-(void)dealloc{
    [m_lines_arr release];
    [super dealloc];
}
@end
