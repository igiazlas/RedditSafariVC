#import <UIKit/UIKit.h>
@import SafariServices;

#import "RDLinkHandler.h"

@implementation RDLinkHandler

- (BOOL)shouldIgnoreURL:(NSURL *)url {
    NSString *urlStr = [url.absoluteString lowercaseString];

    return [urlStr containsString:@"np.reddit.com"] ||
        [urlStr hasPrefix:@"/r/"] ||
        [urlStr hasPrefix:@"r/"] ||
        [urlStr hasPrefix:@"/u/"] ||
        [urlStr hasPrefix:@"u/"];
}

- (void)presentSafariFrom:(UIViewController *)sender withURL:(NSURL *)url {
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];

    safariVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    safariVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    safariVC.modalPresentationCapturesStatusBarAppearance = YES;

    [sender presentViewController:safariVC animated:YES completion:nil];
}

@end
