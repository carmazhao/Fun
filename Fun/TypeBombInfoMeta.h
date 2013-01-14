//
//  TypeBombInfoMeta.h
//  Fun
//
//  Created by carmazhao on 13-1-13.
//
//

#import <Foundation/Foundation.h>

@interface TypeBombInfoMeta : NSObject
@property(nonatomic)NSInteger   m_size;
@property(nonatomic)CGPoint     m_begin_pos;
@property(nonatomic)CGPoint     m_end_pos;
@property(nonatomic , retain)NSMutableArray*  m_bomb_arr;   //存储bomb的位置

-(TypeBombInfoMeta *)init;

@end
