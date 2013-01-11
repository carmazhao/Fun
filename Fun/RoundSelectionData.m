//
//  AlertCheckPoint.m
//  Fun
//
//  Created by carmazhao on 12-12-13.
//
//

#import "RoundSelectionData.h"
#import "RoundSelectionMeta.h"

static RoundSelectionData * m_inst;
@implementation RoundSelectionData
@synthesize m_game_arr;
@synthesize m_round_info_loaded;
@synthesize m_data;

+(RoundSelectionData *)get_instance {
    if (m_inst == nil) {
        m_inst = [[RoundSelectionData alloc]init];
    }
    return m_inst;
}

-(RoundSelectionData *)init {
    if ((self = [super init])) {
        m_game_arr = [[NSMutableArray alloc]init];
        m_round_info_loaded = NO;
    }
    return self;
}
-(void)dealloc {
    [super dealloc];
    [m_game_arr release];
}


-(void)load_round_selection_info{
    NSString  *     path = [[NSBundle mainBundle]pathForResource:@"ini/game_ini" ofType:@""];
    m_data = [NSMutableData dataWithContentsOfFile:path];
    RoundSelectionMeta  *meta_data = [[RoundSelectionMeta alloc]init];
    
    //开始读取
    //每次读取的指针位置
    NSInteger       begin_index = 0;
    //有多少种关卡页面
    unsigned char       num_of_page = 0;
    [m_data getBytes:&num_of_page length:sizeof(num_of_page)];
    begin_index += sizeof(num_of_page);

    //每种关卡的size
    unsigned char       size_of_type = 0;
    //每种的关卡个数
    unsigned char       num_of_every_type = 0;
    //每个关的完成程度
    unsigned char       degree_of_game = 0;
    for (NSInteger i = 0; i < num_of_page; i++) {
        //清空meta
        [meta_data release];
        meta_data = nil;
        meta_data = [[RoundSelectionMeta alloc]init];
        
        //获取每种游戏的size
        [m_data getBytes:&size_of_type range:NSMakeRange(begin_index, sizeof(size_of_type))];
        begin_index += sizeof(size_of_type);
        meta_data.m_game_size = size_of_type;
        
        //获取每个type中有多少个游戏
        [m_data getBytes:&num_of_every_type range:NSMakeRange(begin_index, sizeof(num_of_every_type))];
        begin_index += sizeof(num_of_every_type);
        meta_data.m_game_num = num_of_every_type;
      
        for (NSInteger j = 0; j < num_of_every_type; j++) {
            [m_data getBytes:&degree_of_game range:NSMakeRange(begin_index, sizeof(degree_of_game))];
            begin_index += sizeof(degree_of_game);
            
            //把data放到meta中
            NSNumber * tmp = [NSNumber numberWithUnsignedChar:degree_of_game];
            [meta_data.m_round_level_arr addObject:tmp];
        }
        [m_game_arr addObject:meta_data];
    }
   /* for (NSInteger i = 0; i < [meta_data.m_check_point_arr count]; i++) {
        NSInteger m = [(NSNumber*)[meta_data.m_round_level_arr objectAtIndex: i] intValue];
        NSLog(@"%d" , (int)m);
    }*/
    [meta_data release];
    meta_data = nil;
    m_round_info_loaded = YES;
}

-(void)change_data:(ViewData *)view_data :(NSInteger)value {
    NSInteger page_num = view_data.m_page_num;
    NSInteger game_num = view_data.m_game_index;
    //NSLog(@"%d , %d" , page_num , game_num);
    NSNumber * game_value = [NSNumber numberWithInteger:value];
    [((RoundSelectionMeta*)[m_game_arr objectAtIndex:page_num]).m_round_level_arr replaceObjectAtIndex:game_num withObject:game_value];
}

@end
