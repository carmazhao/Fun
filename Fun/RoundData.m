//
//  RoundData.m
//  Fun
//
//  Created by carmazhao on 12-12-22.
//
//

#import "RoundData.h"
#import "GamePoint.h"
#import "ViewData.h"
#import "RoundSelectionData.h"
#import "RoundSelectionMeta.h"

static RoundData * m_inst;
@implementation RoundData
@synthesize     m_type;
@synthesize     m_type_one_meta;
@synthesize     m_type_two_meta;
@synthesize     m_type_three_meta;
@synthesize     m_type_bomb_meta;
@synthesize     m_cur_round;

+(RoundData *)get_instance {
    if (m_inst == nil) {
        m_inst = [[RoundData alloc]init];
    }
    return  m_inst;
}

-(RoundData *)init{
    if ((self = [super init])) {
        m_type = 0;
    }
    return  self;
}
-(void)dealloc{
    if (m_type_one_meta != nil) {
        [m_type_one_meta release];
        m_type_one_meta = nil;
    }
    if (m_type_two_meta != nil) {
        [m_type_two_meta release];
        m_type_two_meta = nil;
    }
    if (m_type_three_meta != nil) {
        [m_type_three_meta release];
        m_type_three_meta = nil;
    }
    [m_cur_round release];
    [super dealloc];
}

/*
 每次加载之前先把各种类的关卡元数据清零
 然后根据不同的需求new出来
 */
-(NSInteger)load_round_data:(ViewData*)game_index {
    m_cur_round = [game_index retain];
    if (m_type_one_meta != nil) {
        [m_type_one_meta release];
        m_type_one_meta = nil;
    }
    if (m_type_two_meta != nil) {
        [m_type_two_meta release];
        m_type_two_meta = nil;
    }
    if (m_type_three_meta != nil) {
        [m_type_two_meta release];
        m_type_two_meta = nil;
    }
    if (m_type_bomb_meta != nil) {
        [m_type_bomb_meta release];
        m_type_bomb_meta = nil;
    }
    NSString * str_index = [NSString stringWithFormat:@"ini/%d_%d" , game_index.m_page_num , game_index.m_game_index];
    NSString* path = [[NSBundle mainBundle]pathForResource:str_index ofType:@""];
    
    NSData* data;
    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        data = [NSData dataWithContentsOfFile:path];
    }else{
        return -1;
    }
    
    //开始读取
    //每次读取的指针位置
    NSInteger       begin_index = 0;
    //读取size
    unsigned char   game_size = 0;
    [data getBytes:&game_size range:NSMakeRange(begin_index, sizeof(game_size))];
    begin_index += sizeof(game_size);
    
    //读取游戏种类
    unsigned char   game_type = 0;
    [data getBytes:&game_type range:NSMakeRange(begin_index, sizeof(game_type))];
    begin_index += sizeof(game_type);
    
    m_type = game_type;
    //获取x
    unsigned char bx = 0;
    unsigned char by = 0;
    unsigned char ex = 0;
    unsigned char ey = 0;
    
    
    switch (m_type) {
        case TYPE_ONE_INFO_META:
            m_type_one_meta = [[TypeOneInfoMeta alloc]init];
            m_type_one_meta.m_size = game_size;
            //获取x
            [data getBytes:&bx range:NSMakeRange(begin_index, sizeof(bx))];
            begin_index += sizeof(bx);
        
            //获取y
            [data getBytes:&by range:NSMakeRange(begin_index, sizeof(by))];
            begin_index += sizeof(by);
            
            m_type_one_meta.m_begin_pos = CGPointMake(bx, by);
            
            //获取x
            [data getBytes:&ex range:NSMakeRange(begin_index, sizeof(ex))];
            begin_index += sizeof(ex);

            //获取y
            [data getBytes:&ey range:NSMakeRange(begin_index, sizeof(ey))];
            begin_index += sizeof(ey);

            m_type_one_meta.m_end_pos = CGPointMake(ex, ey);
            break;
        case TYPE_TWO_INFO_META:
            m_type_two_meta = [[TypeTwoInfoMeta alloc]init];
            m_type_two_meta.m_size = game_size;
            //获取x
            [data getBytes:&bx range:NSMakeRange(begin_index, sizeof(bx))];
            begin_index += sizeof(bx);
            
            //获取y
            [data getBytes:&by range:NSMakeRange(begin_index, sizeof(by))];
            begin_index += sizeof(by);
            
            m_type_two_meta.m_begin_pos = CGPointMake(bx, by);
            
            //获取x
            [data getBytes:&ex range:NSMakeRange(begin_index, sizeof(ex))];
            begin_index += sizeof(ex);
            
            //获取y
            [data getBytes:&ey range:NSMakeRange(begin_index, sizeof(ey))];
            begin_index += sizeof(ey);
            
            m_type_two_meta.m_end_pos = CGPointMake(ex, ey);
            
            unsigned char num_of_empty = 0;
            unsigned char empty_x = 0;
            unsigned char empty_y = 0;
            //开始获取空格子数据
            [data getBytes:&num_of_empty range:NSMakeRange(begin_index, sizeof(num_of_empty))];
            begin_index += sizeof(num_of_empty);
            
            
            NSInteger sum = num_of_empty;
           // NSLog(@"%d" , (int)sum);
            GamePoint *  gp = nil;
            //读取空格子
            for (NSInteger i = 0; i < sum; i++) {
                [data getBytes:&empty_x range:NSMakeRange(begin_index, sizeof(empty_x))];
                begin_index += sizeof(empty_x);
                [data getBytes:&empty_y range:NSMakeRange(begin_index, sizeof(empty_y))];
                begin_index += sizeof(empty_y);
                gp = [[GamePoint alloc]init];
                gp.m_x = empty_x;
                gp.m_y = empty_y;
                //NSLog(@"%d , %d" , (int)gp.m_x , (int)gp.m_y);
                [m_type_two_meta.m_empty_block_arr addObject:gp];
                [gp release];
                gp = nil;
            }
            break;
        case TYPE_THREE_INFO_META:
            m_type_three_meta = [[TypeThreeInfoMeta alloc]init];
            m_type_three_meta.m_size = game_size;
            //获取x
            [data getBytes:&bx range:NSMakeRange(begin_index, sizeof(bx))];
            begin_index += sizeof(bx);
            
            //获取y
            [data getBytes:&by range:NSMakeRange(begin_index, sizeof(by))];
            begin_index += sizeof(by);
            
            m_type_three_meta.m_begin_pos = CGPointMake(bx, by);
            
            //获取x
            [data getBytes:&ex range:NSMakeRange(begin_index, sizeof(ex))];
            begin_index += sizeof(ex);
            
            //获取y
            [data getBytes:&ey range:NSMakeRange(begin_index, sizeof(ey))];
            begin_index += sizeof(ey);
            
            m_type_three_meta.m_end_pos = CGPointMake(ex, ey);
            
            unsigned char num_of_signed = 0;
            unsigned char s_x = 0;
            unsigned char s_y = 0;
            char          s_value = 0;
            
            [data getBytes:&num_of_signed range:NSMakeRange(begin_index, sizeof(num_of_signed))];
            begin_index += sizeof(num_of_signed);
            
            GamePoint * gp_3 = nil;
            for (NSInteger i = 0; i < num_of_signed;i++) {
                [data getBytes:&s_x range:NSMakeRange(begin_index, sizeof(s_x))];
                begin_index += sizeof(s_x);
                [data getBytes:&s_y range:NSMakeRange(begin_index, sizeof(s_y))];
                begin_index += sizeof(s_y);
                [data getBytes:&s_value range:NSMakeRange(begin_index, sizeof(s_value))];
                begin_index += sizeof(s_value);
                
                gp_3 = [[GamePoint alloc]init];
                gp_3.m_x = s_x;
                gp_3.m_y = s_y;
                gp_3.m_value = s_value;
              //  NSLog(@"%d",gp_3.m_value);
                [m_type_three_meta.m_signed_block_arr addObject:gp_3];
                [gp_3 release];
                gp_3 = nil;
            }
            break;
        case TYPE_BOMB_INFO_META:
            m_type_bomb_meta = [[TypeBombInfoMeta alloc]init];
            m_type_bomb_meta.m_size = game_size;
            //获取x
            [data getBytes:&bx range:NSMakeRange(begin_index, sizeof(bx))];
            begin_index += sizeof(bx);
            
            //获取y
            [data getBytes:&by range:NSMakeRange(begin_index, sizeof(by))];
            begin_index += sizeof(by);
            
            m_type_bomb_meta.m_begin_pos = CGPointMake(bx, by);
            
            //获取x
            [data getBytes:&ex range:NSMakeRange(begin_index, sizeof(ex))];
            begin_index += sizeof(ex);
            
            //获取y
            [data getBytes:&ey range:NSMakeRange(begin_index, sizeof(ey))];
            begin_index += sizeof(ey);
            
            m_type_bomb_meta.m_end_pos = CGPointMake(ex, ey);
            
            unsigned char num_of_bomb = 0;
            unsigned char b_x = 0;
            unsigned char b_y = 0;
            
            [data getBytes:&num_of_bomb range:NSMakeRange(begin_index, sizeof(num_of_bomb))];
            begin_index += sizeof(num_of_bomb);
            
            GamePoint * gp_b = nil;
            for (NSInteger i = 0; i < num_of_bomb;i++) {
                [data getBytes:&b_x range:NSMakeRange(begin_index, sizeof(b_x))];
                begin_index += sizeof(b_x);
                [data getBytes:&b_y range:NSMakeRange(begin_index, sizeof(b_y))];
                begin_index += sizeof(b_y);
                
                gp_b = [[GamePoint alloc]init];
                gp_b.m_x = b_x;
                gp_b.m_y = b_y;
                //  NSLog(@"%d",gp_3.m_value);
                [m_type_bomb_meta.m_bomb_arr addObject:gp_b];
                [gp_b release];
                gp_b = nil;
            }

            break;
        default:
            break;
    }
    return m_type;
}

-(ViewData *)get_next_game {
    ViewData * vd = [[ViewData alloc]init];
    RoundSelectionMeta* cur_page = [[RoundSelectionData get_instance].m_game_arr objectAtIndex:m_cur_round.m_page_num];
    if ([cur_page.m_round_level_arr count]-1 <= m_cur_round.m_game_index) {
        vd.m_page_num = m_cur_round.m_page_num+1;
        vd.m_game_index = 0;
    }else{
        vd.m_page_num = m_cur_round.m_page_num;
        vd.m_game_index = m_cur_round.m_game_index+1;
    }
    return vd;
}
@end
