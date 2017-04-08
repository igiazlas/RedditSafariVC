#import <UIKit/UIKit.h>

#import "RDLinkHandler.h"

@interface Post

@property(copy, nonatomic) NSURL *linkURL;

@end

@interface FeedPostWebLinkView

@property(retain, nonatomic) Post *post;

@end

@interface FeedViewController : UIViewController
@end

@interface CommentsViewController : UIViewController
@end

@interface MessageRepliesViewController : UIViewController
@end

@interface FeedPostTextView
@end

@interface FeedPostSelfTextView
@end

@interface CommentTextView
@end

@interface AttributedLabel
@end

%hook FeedViewController

- (void)feedPostTextView:(FeedPostTextView *)arg1 didTapLinkURL:(NSURL *)arg2 {
    RDLinkHandler *linkHandler = [[RDLinkHandler alloc] init];

    if ([linkHandler shouldIgnoreURL:arg2]) { %orig; return; }

    [linkHandler presentSafariFrom:self withURL:arg2];
}

%end

%hook CommentsViewController

- (void)feedPostWebLinkViewDidTapLink:(FeedPostWebLinkView *)arg1 {
    NSURL *url = arg1.post.linkURL;

    RDLinkHandler *linkHandler = [[RDLinkHandler alloc] init];

    if ([linkHandler shouldIgnoreURL:url]) { %orig; return; }

    [linkHandler presentSafariFrom:self withURL:url];
}

- (void)feedPostSelfTextView:(FeedPostSelfTextView *)arg1 didTapLinkURL:(NSURL *)arg2 {
    RDLinkHandler *linkHandler = [[RDLinkHandler alloc] init];

    if ([linkHandler shouldIgnoreURL:arg2]) { %orig; return; }

    [linkHandler presentSafariFrom:self withURL:arg2];
}

- (void)feedPostTextView:(FeedPostTextView *)arg1 didTapLinkURL:(NSURL *)arg2 {
    RDLinkHandler *linkHandler = [[RDLinkHandler alloc] init];

    if ([linkHandler shouldIgnoreURL:arg2]) { %orig; return; }

    [linkHandler presentSafariFrom:self withURL:arg2];
}

- (void)commentTextView:(CommentTextView *)arg1 didTapLinkURL:(NSURL *)arg2 {
    RDLinkHandler *linkHandler = [[RDLinkHandler alloc] init];

    if ([linkHandler shouldIgnoreURL:arg2]) { %orig; return; }

    [linkHandler presentSafariFrom:self withURL:arg2];
}

%end

%hook MessageRepliesViewController

- (void)attributedLabel:(AttributedLabel *)arg1 didSelectLinkWithURL:(NSURL *)arg2 {
    RDLinkHandler *linkHandler = [[RDLinkHandler alloc] init];

    if ([linkHandler shouldIgnoreURL:arg2]) { %orig; return; }

    [linkHandler presentSafariFrom:self withURL:arg2];
}

%end


