//
//  GameCenterManager.h
//  SDL2Test
//
//  Created by David Ludwig on 7/18/12.
//  Copyright (c) 2012 Funkitron, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameCenterManager : NSObject
+ (GameCenterManager *) sharedManager;
- (void) authenticate;
- (void) showLeaderboardsInViewController:(UIViewController *)viewController;
@end
