//
//  GameCenterManager.m
//  SDL2Test
//
//  Created by David Ludwig on 7/18/12.
//  Copyright (c) 2012 Funkitron, Inc. All rights reserved.
//

#import <GameKit/GameKit.h>

#import "GameCenterManager.h"

@implementation GameCenterManager

static GameCenterManager * _sharedManager = nil;

+ (GameCenterManager *) sharedManager {
	if ( ! _sharedManager) {
		_sharedManager = [[GameCenterManager alloc] init];
	}
	return _sharedManager;
}

- (void) authenticate {
	NSLog(@"INFO: Invoking Game Center Authentication.");
	GKLocalPlayer * localPlayer = [GKLocalPlayer localPlayer];
	[localPlayer authenticateWithCompletionHandler:^(NSError *error) {
		NSLog(@"INFO: %@, localPlayer.isAuthenticated=%s, error=%@",
			  NSStringFromSelector(_cmd),
			  (localPlayer.isAuthenticated ? "YES" : "NO"),
			  error);
	}];
}

- (void) showLeaderboardsInViewController:(UIViewController *)viewController {
	NSLog(@"INFO: Showing leaderboards in view controller 0x%x", (unsigned int)viewController);
	GKLeaderboardViewController * leaderboardVC = [[GKLeaderboardViewController alloc] init];
	leaderboardVC.leaderboardDelegate = self;
//	leaderboardVC.category = @"com.happyhydra.SDL2Test.Main";
	[viewController presentModalViewController:leaderboardVC animated:YES];
}

- (void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
	NSLog(@"INFO: Game Center Leaderboard view controller is done (%@).", NSStringFromSelector(_cmd));

	UIViewController * presentingViewController = nil;
	if ([viewController respondsToSelector:@selector(presentingViewController)]) {
		presentingViewController = viewController.presentingViewController;
	} else {
		presentingViewController = viewController.parentViewController;
	}
	if (presentingViewController) {
		[presentingViewController dismissModalViewControllerAnimated:YES];
	}
}

@end
