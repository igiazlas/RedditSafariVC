#import <Foundation/Foundation.h>

@interface RDLinkHandler : NSObject

- (BOOL)shouldIgnoreURL:(NSURL *)url;
- (void)presentSafariFrom:(UIViewController *)sender withURL:(NSURL *)url;

@end
