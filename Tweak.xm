#import <UIKit/UIKit.h>

%hook UIScreen
- (BOOL)_isCaptured { return NO; }
%end

%hook UIAlertController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    NSString *msg = [self.message lowercaseString];
    NSString *ttl = [self.title lowercaseString];
    if (msg && ([msg containsString:@"zone"] || [msg containsString:@"location"])) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (ttl && ([ttl containsString:@"zone"] || [ttl containsString:@"location"])) {
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

%hook SlotModel
- (BOOL)isInstant { return YES; }
%end

%hook UserStatusModel
- (BOOL)isVisitCompleted { return NO; }
%end
