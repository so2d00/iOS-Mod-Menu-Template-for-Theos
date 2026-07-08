#import <UIKit/UIKit.h>

// 1. Enable Screenshots
%hook UIScreen
- (BOOL)_isCaptured { return NO; }
%end

// 2. Hide Location/Zone Alerts and Force Interaction
%hook UIViewController
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        UIAlertController *alert = (UIAlertController *)viewControllerToPresent;
        NSString *message = [alert.message lowercaseString];
        NSString *title = [alert.title lowercaseString];
        
        // Block alerts containing these keywords
        if ([message containsString:@"zone"] || [message containsString:@"location"] || 
            [title containsString:@"zone"] || [title containsString:@"location"]) {
            return; // Do not show the alert
        }
    }
    %orig;
}
%end

// 3. Force "Confirm Slots" Button to be Enabled
%hook UIButton
- (void)setEnabled:(BOOL)enabled {
    // If the button is likely the confirmation button, force it to stay enabled
    %orig(YES);
}
%end

// 4. Enable Instant Track
%hook SlotModel
- (BOOL)isInstant { return YES; }
- (void)setIsInstant:(BOOL)arg1 { %orig(YES); }
%end

// 5. Bypass Visit Completed Restriction
%hook UserStatusModel
- (BOOL)isVisitCompleted { return NO; }
- (void)setIsVisitCompleted:(BOOL)arg1 { %orig(NO); }
%end
