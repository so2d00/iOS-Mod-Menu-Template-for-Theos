#import <UIKit/UIKit.h>

// 1. Enable Screenshots
%hook UIScreen
- (BOOL)_isCaptured { return NO; }
%end

// 2. Reservation Status Logic (Based on Android s5.js)
%hook ReservationStatus
- (BOOL)isVisitCompleted { return NO; }
- (BOOL)canReserve { return YES; }
%end

// 3. Slot Logic - Force Instant Track (Getter Only)
%hook Slot
- (BOOL)isInstant { return YES; }
%end

// 4. Permit Logic
%hook Permit
- (BOOL)isActive { return YES; }
- (BOOL)isExpired { return NO; }
%end

// 5. Hide Alerts & Error Messages
%hook UIAlertController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    NSString *msg = [self.message lowercaseString];
    if (msg && ([msg containsString:@"zone"] || [msg containsString:@"location"] || [msg containsString:@"completed"])) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
%end

// 6. Force "Confirm" Buttons
%hook UIButton
- (void)layoutSubviews {
    %orig;
    if (!self.enabled) {
        [self setEnabled:YES];
        [self setUserInteractionEnabled:YES];
    }
}
%end
