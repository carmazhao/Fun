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

-(LineView *)init;
-(void)add_line:(TraceLine * )line;
@end
