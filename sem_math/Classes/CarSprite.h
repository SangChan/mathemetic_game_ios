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
}

- (id)initWithPosition:(CGPoint)newPosition;
- (BOOL)compareInput:(int)input;
@end
