//
//  AppDelegate.h
//  HelloiOSDevs
//
//  Created by Gibson Tang on 21/12/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameScene.h"

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    NSString *header;
}

@property (nonatomic, retain) UIWindow *window;
-(void) setHeader:(NSString *) myHeader;
-(NSString *) getHeader;
@end
