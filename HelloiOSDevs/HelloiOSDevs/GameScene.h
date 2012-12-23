//
//  GameScene.h
//  HelloiOSDevs
//
//  Created by Gibson Tang on 22/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"

@interface GameScene : CCLayer
{
    CCMenu *bugs;
    CCLabelTTF *lblScore;
    int score;
    CGSize size;
    int maxBugs;
}

// returns a CCScene that contains the GameScene as the only child
+(CCScene *) scene;

@end
