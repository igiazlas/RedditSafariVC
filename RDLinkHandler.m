#import <objc/runtime.h>

#import "RDSafariViewController.h"
#import "RDLinkHandler.h"

@interface Theme

@property(readonly, nonatomic) UIColor *navBarColor;
@property(readonly, nonatomic) UIColor *buttonColor;

@end

@interface ThemeGuidance

@property(retain, nonatomic) Theme *currentTheme;

+ (id)currentGuidance;

@end

@interface DeeplinkFactory : NSObject

+ (id)viewControllerForDeeplinkURL:(id)arg1;
+ (_Bool)isExternalURL:(id)arg1;

@end

@implementation RDLinkHandler

+ (BOOL)shouldIgnoreURL:(NSURL *)url {
    BOOL isExternalURL = [objc_getClass("DeeplinkFactory") isExternalURL:url];

    if (isExternalURL) {
        return NO;
    }

    NSString *suggestedVCName = NSStringFromClass([[objc_getClass("DeeplinkFactory") viewControllerForDeeplinkURL:url] class]);

    if ([suggestedVCName isEqualToString:@"WebViewController"]) {
        return NO;
    }

    return YES;
}

- (BOOL)readerModeOn {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    return [userDefaults boolForKey:@"safari_reader_mode"];
}

- (void)presentSafariFrom:(UIViewController *)sender withURL:(NSURL *)url {
    RDSafariViewController *safariVC = [[RDSafariViewController alloc] initWithURL:url entersReaderIfAvailable:[self readerModeOn]];

    ThemeGuidance *themeGuidance = [objc_getClass("ThemeGuidance") currentGuidance];

    safariVC.preferredBarTintColor = themeGuidance.currentTheme.navBarColor;
    safariVC.preferredControlTintColor = themeGuidance.currentTheme.buttonColor;

    [sender presentViewController:safariVC animated:YES completion:nil];
}

@end
