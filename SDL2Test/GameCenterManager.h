//
//  GameCenterManager.h
//  SDL2Test
//
//  Created by David Ludwig on 7/18/12.
//  Copyright (c) 2012 Funkitron, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GameCenterManager : NSObject <GKLeaderboardViewControllerDelegate>
+ (GameCenterManager *) sharedManager;
- (void) authenticate;
- (void) showLeaderboardsInViewController:(UIViewController *)viewController;

// GKLeaderboardViewControllerDelegate methods
- (void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController;
@end
