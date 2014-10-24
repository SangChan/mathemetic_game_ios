//
//  LevelGuageSprite.m
//  sem_math
//
//  Created by SangChan on 2014. 10. 24..
//  Copyright 2014년 sangchan. All rights reserved.
//

#import "LevelGuageSprite.h"


@implementation LevelGuageSprite

- (id)initWithLevelCount:(int)levelCount
{
    self = [super initWithImageNamed:@"image_levelguage_bg.png"];
    if (!self) return nil;
    self.anchorPoint = ccp(0,1.0);
    self.position = ccp(510,[CCDirector sharedDirector].viewSize.height - 170);
    [self drawLevelItemsUsingLevelCount:levelCount];
    return self;
}

#define LEVEL_GUAGE_MAX 10
- (void)drawLevelItemsUsingLevelCount:(int)levelCount
{
    const int height_const_value = self.contentSize.height + 10;
    const int width_const_value = self.contentSize.width/2;
    for (int i = 0; i < levelCount; i++) {
        NSString *imageSrc, *efcImageSrc;
        if (i == 0) {
            imageSrc = @"image_levelguage_below.png";
            efcImageSrc = @"image_levelguage_below_efc.png";
        } else if (i == LEVEL_GUAGE_MAX) {
            imageSrc = @"image_levelguage_top.png";
            efcImageSrc = @"image_levelguage_top_efc.png";
        } else {
            imageSrc = @"image_levelguage_center.png";
            efcImageSrc = @"image_levelguage_center_efc.png";
        }
        CCSprite *image_levelGuage = [CCSprite spriteWithImageNamed:imageSrc];
        image_levelGuage.position = ccp(width_const_value,height_const_value - (14 * (LEVEL_GUAGE_MAX - i)));
        image_levelGuage.anchorPoint = ccp(0.5,1.0);
        [self addChild:image_levelGuage];
    }
}


@end
