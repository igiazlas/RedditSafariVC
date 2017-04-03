#import <UIKit/UIKit.h>
@import SafariServices;

@interface Post
{
    NSURL *_linkURL;
}

@property(copy, nonatomic) NSURL *linkURL;

@end

@interface FeedPostWebLinkView
{
    Post *_post;
}

@property(retain, nonatomic) Post *post;

@end

@interface FeedPostTextView
@end

@interface FeedPostSelfTextView
@end

@interface CommentTextView
@end

@interface AttributedLabel
@end

%hook UIViewController

%new
- (void)presentSafariViewControllerWithURL:(NSURL *)url {
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];

    safariVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    safariVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    safariVC.modalPresentationCapturesStatusBarAppearance = YES;

    [self presentViewController:safariVC animated:YES completion:nil];
}

%end

%hook MainFeedViewController

- (void)feedPostTextView:(FeedPostTextView *)arg1 didTapLinkURL:(NSURL *)arg2 {

    NSString *usrStr = [arg2.absoluteString lowercaseString];

    if ([usrStr containsString:@"np.reddit.com"] ||
        [usrStr hasPrefix:@"/r/"] ||
        [usrStr hasPrefix:@"r/"]
    ) {
        %orig;

        return;
    }

    [self performSelector:@selector(presentSafariViewControllerWithURL:) withObject:arg2];
}

%end

%hook SubredditFeedViewController

- (void)feedPostTextView:(FeedPostTextView *)arg1 didTapLinkURL:(NSURL *)arg2 {

    NSString *usrStr = [arg2.absoluteString lowercaseString];

    if ([usrStr containsString:@"np.reddit.com"] ||
        [usrStr hasPrefix:@"/r/"] ||
        [usrStr hasPrefix:@"r/"]
    ) {
        %orig;

        return;
    }

    [self performSelector:@selector(presentSafariViewControllerWithURL:) withObject:arg2];
}

%end

%hook CommentsViewController

- (void)feedPostWebLinkViewDidTapLink:(FeedPostWebLinkView *)arg1 {

    NSURL *url = arg1.post.linkURL;
    NSString *usrStr = [url.absoluteString lowercaseString];

    if ([usrStr containsString:@"np.reddit.com"] ||
        [usrStr hasPrefix:@"/r/"] ||
        [usrStr hasPrefix:@"r/"]
    ) {
        %orig;

        return;
    }

    [self performSelector:@selector(presentSafariViewControllerWithURL:) withObject:url];
}

- (void)feedPostSelfTextView:(FeedPostSelfTextView *)arg1 didTapLinkURL:(NSURL *)arg2 {
    NSString *usrStr = [arg2.absoluteString lowercaseString];

    if ([usrStr containsString:@"np.reddit.com"] ||
        [usrStr hasPrefix:@"/r/"] ||
        [usrStr hasPrefix:@"r/"]
    ) {
        %orig;

        return;
    }

    [self performSelector:@selector(presentSafariViewControllerWithURL:) withObject:arg2];
}

- (void)feedPostTextView:(FeedPostTextView *)arg1 didTapLinkURL:(NSURL *)arg2 {
    NSString *usrStr = [arg2.absoluteString lowercaseString];

    if ([usrStr containsString:@"np.reddit.com"] ||
        [usrStr hasPrefix:@"/r/"] ||
        [usrStr hasPrefix:@"r/"]
    ) {
        %orig;

        return;
    }

    [self performSelector:@selector(presentSafariViewControllerWithURL:) withObject:arg2];
}

- (void)commentTextView:(CommentTextView *)arg1 didTapLinkURL:(NSURL *)arg2 {

    NSString *usrStr = [arg2.absoluteString lowercaseString];

    if ([usrStr containsString:@"np.reddit.com"] ||
        [usrStr hasPrefix:@"/r/"] ||
        [usrStr hasPrefix:@"r/"]
    ) {
        %orig;

        return;
    }

    [self performSelector:@selector(presentSafariViewControllerWithURL:) withObject:arg2];
}

%end

%hook MessageRepliesViewController

- (void)attributedLabel:(AttributedLabel *)arg1 didSelectLinkWithURL:(NSURL *)arg2 {
    NSString *usrStr = [arg2.absoluteString lowercaseString];

    if ([usrStr containsString:@"np.reddit.com"] ||
        [usrStr hasPrefix:@"/r/"] ||
        [usrStr hasPrefix:@"r/"]
    ) {
        %orig;

        return;
    }

    [self performSelector:@selector(presentSafariViewControllerWithURL:) withObject:arg2];
}

%end


