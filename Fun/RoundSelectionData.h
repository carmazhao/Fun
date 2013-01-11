//
//  AlertCheckPoint.h
//  Fun
//
//  Created by carmazhao on 12-12-13.
//
//

#import <Foundation/Foundation.h>
#import "ViewData.h"

@interface RoundSelectionData : NSObject{
}
@property(nonatomic , retain)NSMutableArray *  m_game_arr;  //装载游戏信息
@property(nonatomic)BOOL        m_round_info_loaded;
@property(nonatomic , retain)NSMutableData *   m_data;

+(RoundSelectionData *)get_instance;
-(RoundSelectionData *)init;

-(void)load_round_selection_info;

-(void)change_data:(ViewData *)view_data:(NSInteger)value;
@end
