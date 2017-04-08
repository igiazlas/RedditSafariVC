#import <objc/runtime.h>

#import <UIKit/UIKit.h>
@import SafariServices;

#import "RDLinkHandler.h"

@interface Theme

@property(readonly, nonatomic) UIColor *navBarColor;
@property(readonly, nonatomic) UIColor *buttonColor;

@end

@interface ThemeGuidance

@property(retain, nonatomic) Theme *currentTheme;

+ (id)currentGuidance;

@end

@implementation RDLinkHandler

- (BOOL)shouldIgnoreURL:(NSURL *)url {
    NSString *urlSchemeStr = [url.scheme lowercaseString];
    NSString *urlStr = [url.absoluteString lowercaseString];

    return !([urlSchemeStr isEqualToString:@"http"] || [urlSchemeStr isEqualToString:@"https"]) || [urlStr containsString:@"np.reddit.com"];
}

- (BOOL)readerModeOn {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    return [userDefaults boolForKey:@"safari_reader_mode"];
}

- (void)presentSafariFrom:(UIViewController *)sender withURL:(NSURL *)url {
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url entersReaderIfAvailable:[self readerModeOn]];

    safariVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    safariVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    safariVC.modalPresentationCapturesStatusBarAppearance = YES;

    ThemeGuidance *themeGuidance = [objc_getClass("ThemeGuidance") currentGuidance];

    safariVC.preferredBarTintColor = themeGuidance.currentTheme.navBarColor;
    safariVC.preferredControlTintColor = themeGuidance.currentTheme.buttonColor;

    if (sender.navigationController != nil) {
        [sender.navigationController presentViewController:safariVC animated:YES completion:nil];
    } else {
        [sender presentViewController:safariVC animated:YES completion:nil];
    }

}

@end
