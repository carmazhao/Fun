//
//  LineView.h
//  Fun
//
//  Created by carmazhao on 12-12-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TraceLine.h"

@interface LineView : CCLayer {
}
@property(nonatomic , retain)NSMutableArray * m_lines_arr;
@property(nonatomic)CGPoint m_base_pos;

-(LineView *)init;
-(void)add_line:(TraceLine * )line;
-(void)set_base_pos:(NSInteger)x :(NSInteger)y;
-(void)delete_lines_begin_by:(NSInteger)x:(NSInteger)y;
@end
