//
//  CarSprite.m
//  sem_math
//
//  Created by SangChan on 2014. 10. 23..
//  Copyright 2014년 sangchan. All rights reserved.
//

#import "CarSprite.h"
#import "CCAnimation.h"


@implementation CarSprite

- (id)initWithPosition:(CGPoint)newPosition
{
    self = [super initWithImageNamed:@"image_car_1.png"];
    if (!self) return(nil);
    self.position = newPosition;
    self.anchorPoint = ccp(0.0,1.0);
    
    expressionLabel = [CCLabelTTF labelWithString:@"1 + 1" fontName:@"Arial" fontSize:24];
    expressionLabel.anchorPoint = ccp(0.5,-1.0);
    expressionLabel.position = ccp(self.contentSize.width/2-10,-6);
    [self addChild:expressionLabel];
    [self setExpression:@"+" withAugend:arc4random_uniform(10) withAddend:arc4random_uniform(10)];
    [self startMove];
    return self;
}

- (void)setExpression:(NSString *)arithmetic withAugend:(int)augend withAddend:(int)addend
{
    [expressionLabel setString:[NSString stringWithFormat:@"%d %@ %d",augend,arithmetic,addend]];
    if ([arithmetic isEqualToString:@"+"]) {
        rightAnswer = augend + addend;
    }
}

- (void)startMove
{
    CCActionMoveBy *actionBy = [CCActionMoveBy actionWithDuration:6 position:ccp([CCDirector sharedDirector].viewSize.width+180,0)];
    CCActionCallFunc *callFunc = [CCActionCallFunc actionWithTarget:self selector:@selector(onCarMoveEnded)];
    [self runAction:[CCActionSequence actions:actionBy,callFunc,nil]];

    NSArray *moveAniFrames = [NSArray arrayWithObjects:[CCSpriteFrame frameWithImageNamed:@"image_car_1.png"],[CCSpriteFrame frameWithImageNamed:@"image_car_2.png"], nil];
    CCAnimation *moveAnimation = [CCAnimation animationWithSpriteFrames:moveAniFrames delay:0.3f];
    CCActionAnimate *animationAction = [CCActionAnimate actionWithAnimation:moveAnimation];
    CCActionRepeatForever *repeatingAnimation = [CCActionRepeatForever actionWithAction:animationAction];
    [self runAction:repeatingAnimation];
}

- (BOOL)compareInput:(int)input
{
    return (input == rightAnswer);
}

#pragma clang diagnostic ignored "-Wundeclared-selector"

- (void)onCarMoveEnded
{
    [self.parent performSelector:@selector(onCarMoveEndedWithNoAnswer)];
    NSLog(@"onCarMoveEnded");
}

- (void)onGetRightOrWrongAnswer
{
    [self.parent performSelector:@selector(onCarMoveEndedWithAnswer)];
    NSLog(@"onGetRightOrWrongAnswer");
}
@end
