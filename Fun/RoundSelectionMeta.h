//
//  CheckPointInfo.h
//  Fun
//
//  Created by carmazhao on 12-12-13.
//
//

#import <Foundation/Foundation.h>

@interface RoundSelectionMeta : NSObject{
}
@property(nonatomic , retain)NSMutableArray *  m_round_level_arr; //游戏的level集合
@property(nonatomic)unsigned char       m_game_size;                //游戏的规模
@property(nonatomic)unsigned char       m_game_num;         //游戏的关卡数

-(RoundSelectionMeta *)init;
@end
