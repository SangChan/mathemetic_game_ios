//
//  CarSprite.h
//  sem_math
//
//  Created by SangChan on 2014. 10. 23..
//  Copyright 2014년 sangchan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CarSprite : CCSprite {
    CCLabelTTF *expressionLabel;
    int rightAnswer;
    CCSprite *image_o;
    CCSprite *image_x;
}

- (id)initWithPosition:(CGPoint)newPosition;
- (BOOL)compareInput:(int)input;
- (void)showRightAnswer;
- (void)showWrongAnswer;
@end
