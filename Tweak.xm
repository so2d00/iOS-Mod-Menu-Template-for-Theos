#import <UIKit/UIKit.h>

// 1. Enable Screenshots
%hook UIScreen
- (BOOL)_isCaptured { return NO; }
%end

// 2. Automatically Dismiss "Outside Zone" Alerts
%hook UIAlertController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    NSString *msg = [self.message lowercaseString];
    NSString *ttl = [self.title lowercaseString];
    
    // If the alert is about the zone or location, close it immediately
    if (msg && ([msg containsString:@"zone"] || [msg containsString:@"location"])) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (ttl && ([ttl containsString:@"zone"] || [ttl containsString:@"location"])) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
%end

// 3. Force "Confirm" Button to be Clickable
%hook UIButton
- (void)layoutSubviews {
    %orig;
    // We only force buttons that are currently disabled
    if (!self.enabled) {
        [self setEnabled:YES];
        [self setUserInteractionEnabled:YES];
    }
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
