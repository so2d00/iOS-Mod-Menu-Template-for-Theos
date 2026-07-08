#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

// 1. Enable Instant Track and Bypass Eligibility
%hook RawdahViewModel
- (BOOL)isInstantTrackAllowed {
    return YES;
}
- (BOOL)isInstantEligible {
    return YES;
}
%end

// 2. Bypass "Visit Completed" Popup/Status
%hook RawdahBookingStatus
- (BOOL)isVisitCompleted {
    return NO;
}
%end

// 3. Enable Confirm Slot / Confirm Visit Button
%hook RawdahTicketViewModel
- (BOOL)canConfirmVisit {
    return YES;
}
%end

// 4. Disable Screenshot Protection (Allow Screenshots)
%hook UIScreen
- (BOOL)isCaptured {
    return NO;
}
%end

%hook UITextField
- (void)setSecureTextEntry:(BOOL)secure {
    %orig(NO);
}
%end

// 5. Bypass Location/Madinah Zone Restriction (Spoofing Location to Al-Masjid An-Nabawi)
%hook CLLocationManager
- (CLLocation *)location {
    CLLocationCoordinate2D madinahCoordinate = CLLocationCoordinate2DMake(24.4672, 39.6112);
    CLLocation *fakeLocation = [[CLLocation alloc] initWithCoordinate:madinahCoordinate
                                                             altitude:0
                                                   horizontalAccuracy:5
                                                     verticalAccuracy:5
                                                            timestamp:[NSDate date]];
    return fakeLocation;
}
%end

%hook RawdahLocationValidator
- (BOOL)isUserInsideMadinahZone {
    return YES;
}
- (BOOL)isUserInsideMasjidZone {
    return YES;
}
%end
