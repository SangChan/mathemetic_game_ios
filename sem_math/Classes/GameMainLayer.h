//
//  GameMainLayer.h
//  sem_math
//
//  Created by SangChan on 2014. 10. 23..
//  Copyright 2014년 sangchan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class CarSprite;

@interface GameMainLayer : CCNode {
    CarSprite *carSprite;
    CCLabelTTF *answerLabel;
    int comboCount;
}

- (void)setAnswerLabelString:(NSString *)string;
- (NSString *)getAnswerLabelString;
- (void)compareInputAndAnswer;

@end
