#import <UIKit/UIKit.h>

// 1. Allow Screenshots
%hook UIScreen
- (BOOL)_isCaptured { return NO; }
%end

// 2. Force All Buttons to be Enabled (Allows clicking "Confirm" even if outside zone)
%hook UIButton
- (void)setEnabled:(BOOL)enabled {
    %orig(YES); 
}
%end

// 3. Enable Instant Track
%hook SlotModel
- (BOOL)isInstant { return YES; }
- (void)setIsInstant:(BOOL)arg1 { %orig(YES); }
%end

// 4. Bypass Visit Completed Restriction
%hook UserStatusModel
- (BOOL)isVisitCompleted { return NO; }
- (void)setIsVisitCompleted:(BOOL)arg1 { %orig(NO); }
%end
