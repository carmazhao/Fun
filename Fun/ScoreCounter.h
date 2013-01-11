//
//  ScoreCounter.h
//  Fun
//
//  Created by carmazhao on 12-12-31.
//
//

#import <Foundation/Foundation.h>

#define LIMIT_1     2
#define LIMIT_2     4
#define LIMIT_3     6
#define LIMIT_4     8
#define LIMIT_5     10
#define LIMIT_6     12

#define STATE_1         0
#define STATE_2         1
#define STATE_3         2
#define STATE_4         3
#define STATE_5         4
#define STATE_6         5
#define STATE_7         6

#define CHANGE_TO_2         1
#define CHANGE_TO_3         2
#define CHANGE_TO_4         3
#define CHANGE_TO_5         4
#define CHANGE_TO_6         5
#define CHANGE_TO_7         6

//关于游戏评分
#define H_1_LIMIT 5
#define H_2_LIMIT 10
#define H_3_LIMIT 15
#define H_4_LIMIT 20

#define H_1_SCORE 3
#define H_2_SCORE 2
#define H_3_SCORE 1
#define H_4_SCORE 0

@interface ScoreCounter : NSObject
@property(nonatomic)NSInteger       m_time_passed;  //自从游戏开始过了多久
@property(nonatomic)NSInteger       m_cur_state;    //当前处于分数哪个状态
@property(nonatomic)NSInteger       m_score;        //第三种玩法的分数

+(ScoreCounter*)get_instance;
-(void)update;
-(NSInteger)ready_to_change;
-(NSString *)get_time_string;
-(void)add_score:(NSInteger)added_score;
-(NSString *)get_score_string;

-(NSInteger)get_game_score_level;

-(void)reset;
@end
