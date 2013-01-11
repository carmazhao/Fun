//
//  RoundInfoMeta.h
//  Fun
//
//  Created by carmazhao on 12-12-22.
//
//

#import <Foundation/Foundation.h>

@interface TypeOneInfoMeta : NSObject
@property(nonatomic)NSInteger   m_size;
@property(nonatomic)CGPoint     m_begin_pos;
@property(nonatomic)CGPoint     m_end_pos;

-(TypeOneInfoMeta *)init;
@end
