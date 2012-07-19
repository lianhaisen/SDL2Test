//
//  GameCenterManager.m
//  SDL2Test
//
//  Created by David Ludwig on 7/18/12.
//  Copyright (c) 2012 Funkitron, Inc. All rights reserved.
//

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
	NSLog(@"authenticate");
}

@end
