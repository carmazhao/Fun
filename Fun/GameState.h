//
//  GameState.h
//  Fun
//
//  Created by carmazhao on 12-12-11.
//
//

#import <Foundation/Foundation.h>

@interface GameState : NSObject {
}
@property(nonatomic)float      m_scale;
@property(nonatomic)float      m_ratio;

+(GameState *)get_instance;

-(GameState*)init;
@end
