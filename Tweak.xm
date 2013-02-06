/*

Written by Max Katzmann (2013)


*/

#import <UIKit/UIKit.h>


@interface SBAwayView : UIView

@end

@interface SBAwayController

- (void)unlockWithSound:(BOOL)arg1;

@end

@interface SBAwayController (SwipeUpRecognizer)

- (void)SULhandleLockSwipe:(UISwipeGestureRecognizer *)gesture;

@end

%hook SBAwayController

//hooking in lock
-(void)lock {
    
    //NEVER FORGET ORIG!
    %orig;


    //getting the _awayView of the SBAwayController
    SBAwayView *lockAwayView = MSHookIvar<id>(self, "_awayView");

    UISwipeGestureRecognizer *oneFingerSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SULhandleLockSwipe:)];
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionUp];

    //add the GestureRecognizer
    [lockAwayView addGestureRecognizer:oneFingerSwipeUp];

}

//###################### GESTURE RECOGNIZER ######################

%new
//what happens if the user swipes
- (void)SULhandleLockSwipe:(UISwipeGestureRecognizer *)gesture {
    [self unlockWithSound:YES];
}


%end