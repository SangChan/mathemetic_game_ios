//
//  MyCocos2DClass.m
//  sem_math
//
//  Created by SangChan on 2014. 10. 6..
//  Copyright 2014년 sangchan. All rights reserved.
//

#import "StatusLayer.h"


@implementation StatusLayer

+ (StatusLayer *)node
{
    return [[self alloc]init];
}
- (id)init
{
    
    if (self = [super init]) {
        self.position = ccp(0.0, 0.0);
        CCNodeColor *nodeColorYellow = [CCNodeColor nodeWithColor:[CCColor yellowColor]];
        [nodeColorYellow setPosition:ccp(0, [CCDirector sharedDirector].viewSize.height-50.0)];
        [nodeColorYellow setContentSize:CGSizeMake([CCDirector sharedDirector].viewSize.width, 50.0)];
        [self addChild:nodeColorYellow];
    }
    return self;
}

@end
