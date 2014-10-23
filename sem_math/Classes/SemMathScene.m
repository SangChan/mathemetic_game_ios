//
//  SemMathScene.m
//  sem_math
//
//  Created by SangChan on 2014. 10. 6..
//  Copyright 2014년 sangchan. All rights reserved.
//

#import "SemMathScene.h"
#import "IntroScene.h"
#import "BGLayer.h"
#import "GameMainLayer.h"
#import "InputLayer.h"

@implementation SemMathScene

+(SemMathScene *)scene
{
    return [[self alloc]init];
}

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self)
        return(nil);
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor darkGrayColor]];
    [self addChild:background];
    
    BGLayer *statusLayer = [BGLayer node];
    [self addChild:statusLayer];
    
    GameMainLayer *gameMainLayer = [GameMainLayer node];
    [self addChild:gameMainLayer];
    
    InputLayer *inputLayer = [InputLayer node];
    [self addChild:inputLayer];
    
    return self;
}

@end
