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

@interface CommentTextView
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

    if ([arg2.absoluteString containsString:@"np.reddit.com"]) {
        %orig;

        return;
    }

    [self performSelector:@selector(presentSafariViewControllerWithURL:) withObject:arg2];
}

%end

%hook CommentsViewController

- (void)feedPostWebLinkViewDidTapLink:(FeedPostWebLinkView *)arg1 {
    %log;

    NSURL *url = arg1.post.linkURL;

    if ([url.absoluteString containsString:@"np.reddit.com"]) {
        %orig;

        return;
    }

    [self performSelector:@selector(presentSafariViewControllerWithURL:) withObject:url];
}

- (void)commentTextView:(CommentTextView *)arg1 didTapLinkURL:(NSURL *)arg2 {

    if ([arg2.absoluteString containsString:@"np.reddit.com"]) {
        %orig;

        return;
    }

    [self performSelector:@selector(presentSafariViewControllerWithURL:) withObject:arg2];
}

%end

