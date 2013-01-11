//
//  ControlCreater.h
//  Fun
//
//  Created by carmazhao on 13-1-11.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ControlCreater : NSObject

+(ControlCreater *)get_instance;
-(CCMenu *)create_simple_button:(NSString *)normal_path:(NSString *)down_path:(id)target:(SEL)selector;
@end
