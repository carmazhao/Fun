//
//  RoundData.h
//  Fun
//
//  Created by carmazhao on 12-12-22.
//
//

#import <Foundation/Foundation.h>
#import "TypeOneInfoMeta.h"
#import "TypeTwoInfoMeta.h"
#import "TypeThreeInfoMeta.h"
#import "ViewData.h"

#define TYPE_ONE_INFO_META 0
#define TYPE_TWO_INFO_META 1
#define TYPE_THREE_INFO_META 2

@interface RoundData : NSObject

@property(nonatomic)NSInteger                   m_type;
@property(nonatomic , retain)ViewData*          m_cur_round;//记录当前第几关

@property(nonatomic , retain)TypeOneInfoMeta *  m_type_one_meta;
@property(nonatomic , retain)TypeTwoInfoMeta *  m_type_two_meta;
@property(nonatomic , retain)TypeThreeInfoMeta *m_type_three_meta;


+(RoundData *)get_instance;
-(RoundData *)init;
-(NSInteger)load_round_data:(ViewData*)game_index;

-(ViewData *)get_next_game;

@end
