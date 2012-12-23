//
//  HelloWorldLayer.h
//  HelloiOSDevs
//
//  Created by Gibson Tang on 21/12/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "GameScene.h"
#import "AppDelegate.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <UITextFieldDelegate>
{
    UITextField *textField;
    CCLabelTTF *label;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
