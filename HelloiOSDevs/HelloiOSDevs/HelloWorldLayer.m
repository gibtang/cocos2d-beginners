//
//  HelloWorldLayer.m
//  HelloiOSDevs
//
//  Created by Gibson Tang on 21/12/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		// create and initialize a Label
        AppDelegate* obj = ((AppDelegate*)[UIApplication sharedApplication].delegate);
        NSString *str = [obj getHeader];
        label = [CCLabelTTF labelWithString:str fontName:@"Marker Felt" fontSize:48];
        //label.anchorPoint = ccp(0,0);//this sets the origin point to be at the bottom left
        
        UIView *myView = (UIView*) [[CCDirector sharedDirector] openGLView];//get the view
        textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 180, 250, 40)];
        [myView addSubview:textField];
        [[[[CCDirector sharedDirector]openGLView] window]addSubview:myView];
        
        [textField setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:1.0]];
        //[textField becomeFirstResponder];
        [textField setDelegate:self];
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
        
        CCMenuItem *menuItem = [CCMenuItemImage itemFromNormalImage:@"start1.png"
                                                  selectedImage:@"start2.png"
                                                         target:self
                                                           selector:@selector(startGame:)];

        CCMenu *menu = [CCMenu menuWithItems:menuItem, nil];
        menu.position = ccp( size.width /2 , size.height/2 + 140);
        [self addChild:menu];
	}
	return self;
}

- (void)startGame:(id) sender {
    NSLog(@"Starting");
    if ([textField.text length] == 0)
    {
        UIAlertView* alert_view = [[[UIAlertView alloc] initWithTitle:@"Error"                                                              message:@"Please enter a name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        [alert_view show];
    }
    else
    {
        [textField removeFromSuperview];
        [[CCDirector sharedDirector] replaceScene:[GameScene node]];
    }
}

- (void)textFieldDidEndEditing:(UITextField*)text_field {
    if (text_field == textField) {
        [text_field endEditing:YES];
        // here is where you should do something with the data they entered
        NSString *result = textField.text;
        [label setString:result];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField*)text_field {
    //Stop the editing
    [text_field resignFirstResponder];
    return YES;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
