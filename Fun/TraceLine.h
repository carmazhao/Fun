//
//  TraceLine.h
//  Fun
//
//  Created by carmazhao on 12-12-23.
//
//

#import <Foundation/Foundation.h>
#import "GameBlock.h"

@interface TraceLine : NSObject
@property(nonatomic , retain)GameBlock * m_begin_pos;
@property(nonatomic , retain)GameBlock * m_end_pos;

@end
