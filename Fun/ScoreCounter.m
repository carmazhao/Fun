//
//  ScoreCounter.m
//  Fun
//
//  Created by carmazhao on 12-12-31.
//
//

#import "ScoreCounter.h"

static ScoreCounter * m_inst;
@implementation ScoreCounter
@synthesize m_time_passed;
@synthesize m_cur_state;
@synthesize m_score;

+(ScoreCounter *)get_instance{
    if (m_inst == nil) {
        m_inst = [[ScoreCounter alloc]init];
    }
    return m_inst;
}

-(ScoreCounter *)init {
    if ((self = [super init])) {
        m_time_passed = 0;
        m_score = 0;
        m_cur_state = STATE_1;
    }
    return self;
}

-(void)update{
    m_time_passed++;
}

-(NSInteger)ready_to_change{
    if (m_time_passed >= LIMIT_1&&
        m_cur_state == STATE_1) {
        m_cur_state = STATE_2;
        return CHANGE_TO_2;
    }
    
    if (m_time_passed >= LIMIT_2&&
        m_cur_state == STATE_2) {
        m_cur_state = STATE_3;
        return CHANGE_TO_3;
    }
    
    if (m_time_passed >= LIMIT_3&&
        m_cur_state == STATE_3) {
        m_cur_state = STATE_4;
        return CHANGE_TO_4;
    }
    
    if (m_time_passed >= LIMIT_4&&
        m_cur_state == STATE_4) {
        m_cur_state = STATE_5;
        return CHANGE_TO_5;
    }
    
    if (m_time_passed >= LIMIT_5&&
        m_cur_state == STATE_5) {
        m_cur_state = STATE_6;
        return CHANGE_TO_6;
    }
    
    if (m_time_passed >= LIMIT_6&&
        m_cur_state == STATE_6) {
        m_cur_state = STATE_7;
        return CHANGE_TO_7;
    }

    return -1;
}
-(NSString *)get_time_string{
    NSString * str;
    NSInteger sec = m_time_passed%60;
    NSInteger min = m_time_passed/60;
    str = [NSString stringWithFormat:@"%02i.%02i" , min , sec];
    return  str;
}

-(void)add_score:(NSInteger)added_score{
    m_score += added_score;
}
-(NSString *)get_score_string{
    NSString * str = [NSString stringWithFormat:@"%d" , m_score];
    return  str;
}

-(NSInteger)get_game_score_level {
    // 如果是以时间计算
    if (m_time_passed != 0) {
        if (m_time_passed <= H_1_LIMIT) {
            return H_1_LIMIT;
        }
        if (m_time_passed <= H_2_LIMIT) {
            return H_2_LIMIT;
        }
        if (m_time_passed <= H_3_LIMIT) {
            return H_3_LIMIT;
        }
        return H_4_LIMIT;
    }
    if(m_score != 0) {
        if(m_score >= H_1_SCORE) {
            return H_1_SCORE;
        }
        if(m_score >= H_2_SCORE) {
            return H_2_SCORE;
        }
        if (m_score >= H_3_SCORE) {
            return H_3_SCORE;
        }
        return H_4_SCORE;
    }
    return -1;
}
-(void)reset{
    m_time_passed = 0;
    m_cur_state = STATE_1;
    m_score = 0;
}
@end
