#import <UIKit/UIKit.h>

// 1. Enable Screenshots
%hook UIScreen
- (BOOL)_isCaptured { return NO; }
%end

// 2. Hide "Outside Zone" Alerts
%hook UIAlertController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    NSString *msg = [self.message lowercaseString];
    NSString *ttl = [self.title lowercaseString];
    
    // Check if alert is related to location or zone
    if (msg && ([msg containsString:@"zone"] || [msg containsString:@"location"])) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (ttl && ([ttl containsString:@"zone"] || [ttl containsString:@"location"])) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
%end

// 3. Force "Confirm" Buttons to be Clickable
%hook UIButton
- (BOOL)isEnabled { return YES; }
- (void)setEnabled:(BOOL)enabled { %orig(YES); }
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
