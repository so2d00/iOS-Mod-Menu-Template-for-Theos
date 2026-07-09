#import <UIKit/UIKit.h>

%hook UIScreen
- (BOOL)_isCaptured { return NO; }
%end

%hook ReservationStatus
- (BOOL)isVisitCompleted { return NO; }
- (BOOL)canReserve { return YES; }
%end

%hook Slot
- (BOOL)isInstant { return YES; }
- (void)setIsInstant:(BOOL)arg1 { %orig(YES); }
%end

%hook Permit
- (BOOL)isActive { return YES; }
- (BOOL)isExpired { return NO; }
%end

%hook UIAlertController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    NSString *msg = [self.message lowercaseString];
    if (msg && ([msg containsString:@"zone"] || [msg containsString:@"location"] || [msg containsString:@"completed"])) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
%end

%hook UIButton
- (void)layoutSubviews {
    %orig;
    if (!self.enabled) {
        [self setEnabled:YES];
        [self setUserInteractionEnabled:YES];
    }
}
%end
