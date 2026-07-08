#import <UIKit/UIKit.h>

// 1. Allow Screenshots
%hook UIScreen
- (BOOL)_isCaptured { return NO; }
%end

// 2. Hide "Outside Zone" Alerts
%hook UIAlertController
- (void)viewWillAppear:(BOOL)animated {
    %orig;
    NSString *msg = [self.message lowercaseString];
    NSString *ttl = [self.title lowercaseString];
    
    // If the alert mentions location or zone, dismiss it immediately
    if ([msg containsString:@"zone"] || [msg containsString:@"location"] || 
        [ttl containsString:@"zone"] || [ttl containsString:@"location"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
%end

// 3. Force "Confirm Slots" Button to be active
%hook UIButton
- (void)layoutSubviews {
    %orig;
    // Force buttons to stay enabled so you can click them
    if (!self.enabled) {
        [self setEnabled:YES];
    }
}
%end

// 4. Enable Instant Track
%hook SlotModel
- (BOOL)isInstant { return YES; }
- (void)setIsInstant:(BOOL)arg1 { %orig(YES); }
%end

// 5. Bypass Visit Completed
%hook UserStatusModel
- (BOOL)isVisitCompleted { return NO; }
- (void)setIsVisitCompleted:(BOOL)arg1 { %orig(NO); }
%end
