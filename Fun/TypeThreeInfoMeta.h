//
//  TypeThreeInfoMeta.h
//  Fun
//
//  Created by carmazhao on 13-1-4.
//
//

#import <Foundation/Foundation.h>

@interface TypeThreeInfoMeta : NSObject
@property(nonatomic)NSInteger   m_size;
@property(nonatomic)CGPoint     m_begin_pos;
@property(nonatomic)CGPoint     m_end_pos;
@property(nonatomic , retain)NSMutableArray*  m_signed_block_arr;

-(TypeThreeInfoMeta *)init;
@end
