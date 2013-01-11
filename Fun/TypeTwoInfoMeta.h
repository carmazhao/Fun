//
//  TypeTwoInfoMeta.h
//  Fun
//
//  Created by carmazhao on 12-12-27.
//
//

#import <Foundation/Foundation.h>

@interface TypeTwoInfoMeta : NSObject
@property(nonatomic)NSInteger   m_size;
@property(nonatomic)CGPoint     m_begin_pos;
@property(nonatomic)CGPoint     m_end_pos;
@property(nonatomic , retain)NSMutableArray*  m_empty_block_arr;

-(TypeTwoInfoMeta *)init;
@end
