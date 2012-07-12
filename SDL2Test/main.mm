//
//  main.m
//  SDL2Test
//
//  Created by David Ludwig on 7/6/12.
//  Copyright (c) 2012 Funkitron, Inc. All rights reserved.
//

#include <stdio.h>
#include <iostream>
#include <sstream>
#import <UIKit/UIKit.h>

#include <SDL.h>

//#import "AppDelegate.h"


static const char * ConvertPixelFormatToCString(Uint32 pixelFormat) {
	switch (pixelFormat) {
		case SDL_PIXELFORMAT_UNKNOWN: return "SDL_PIXELFORMAT_UNKNOWN";
		case SDL_PIXELFORMAT_INDEX1LSB: return "SDL_PIXELFORMAT_INDEX1LSB";
		case SDL_PIXELFORMAT_INDEX1MSB: return "SDL_PIXELFORMAT_INDEX1MSB";
		case SDL_PIXELFORMAT_INDEX4LSB: return "SDL_PIXELFORMAT_INDEX4LSB";
		case SDL_PIXELFORMAT_INDEX4MSB: return "SDL_PIXELFORMAT_INDEX4MSB";
		case SDL_PIXELFORMAT_INDEX8: return "SDL_PIXELFORMAT_INDEX8";
		case SDL_PIXELFORMAT_RGB332: return "SDL_PIXELFORMAT_RGB332";
		case SDL_PIXELFORMAT_RGB444: return "SDL_PIXELFORMAT_RGB444";
		case SDL_PIXELFORMAT_RGB555: return "SDL_PIXELFORMAT_RGB555";
		case SDL_PIXELFORMAT_BGR555: return "SDL_PIXELFORMAT_BGR555";
		case SDL_PIXELFORMAT_ARGB4444: return "SDL_PIXELFORMAT_ARGB4444";
		case SDL_PIXELFORMAT_RGBA4444: return "SDL_PIXELFORMAT_RGBA4444";
		case SDL_PIXELFORMAT_ABGR4444: return "SDL_PIXELFORMAT_ABGR4444";
		case SDL_PIXELFORMAT_BGRA4444: return "SDL_PIXELFORMAT_BGRA4444";
		case SDL_PIXELFORMAT_ARGB1555: return "SDL_PIXELFORMAT_ARGB1555";
		case SDL_PIXELFORMAT_RGBA5551: return "SDL_PIXELFORMAT_RGBA5551";
		case SDL_PIXELFORMAT_ABGR1555: return "SDL_PIXELFORMAT_ABGR1555";
		case SDL_PIXELFORMAT_BGRA5551: return "SDL_PIXELFORMAT_BGRA5551";
		case SDL_PIXELFORMAT_RGB565: return "SDL_PIXELFORMAT_RGB565";
		case SDL_PIXELFORMAT_BGR565: return "SDL_PIXELFORMAT_BGR565";
		case SDL_PIXELFORMAT_RGB24: return "SDL_PIXELFORMAT_RGB24";
		case SDL_PIXELFORMAT_BGR24: return "SDL_PIXELFORMAT_BGR24";
		case SDL_PIXELFORMAT_RGB888: return "SDL_PIXELFORMAT_RGB888";
		case SDL_PIXELFORMAT_RGBX8888: return "SDL_PIXELFORMAT_RGBX8888";
		case SDL_PIXELFORMAT_BGR888: return "SDL_PIXELFORMAT_BGR888";
		case SDL_PIXELFORMAT_BGRX8888: return "SDL_PIXELFORMAT_BGRX8888";
		case SDL_PIXELFORMAT_ARGB8888: return "SDL_PIXELFORMAT_ARGB8888";
		case SDL_PIXELFORMAT_RGBA8888: return "SDL_PIXELFORMAT_RGBA8888";
		case SDL_PIXELFORMAT_ABGR8888: return "SDL_PIXELFORMAT_ABGR8888";
		case SDL_PIXELFORMAT_BGRA8888: return "SDL_PIXELFORMAT_BGRA8888";
		case SDL_PIXELFORMAT_ARGB2101010: return "SDL_PIXELFORMAT_ARGB2101010";
		case SDL_PIXELFORMAT_YV12: return "SDL_PIXELFORMAT_YV12";
		case SDL_PIXELFORMAT_IYUV: return "SDL_PIXELFORMAT_IYUV";
		case SDL_PIXELFORMAT_YUY2: return "SDL_PIXELFORMAT_YUY2";
		case SDL_PIXELFORMAT_UYVY: return "SDL_PIXELFORMAT_UYVY";
		case SDL_PIXELFORMAT_YVYU: return "SDL_PIXELFORMAT_YVYU";
	}
	return "<undefined>";
}

std::string ConvertSDLWindowFlagsToString(Uint32 flags) {
	std::stringstream ss;
	Uint32 decodedFlags = 0;
	
	if (flags & SDL_WINDOW_FULLSCREEN) { ss << "SDL_WINDOW_FULLSCREEN | "; decodedFlags |= SDL_WINDOW_FULLSCREEN; }
	if (flags & SDL_WINDOW_OPENGL) { ss << "SDL_WINDOW_OPENGL | "; decodedFlags |= SDL_WINDOW_OPENGL; }
	if (flags & SDL_WINDOW_SHOWN) { ss << "SDL_WINDOW_SHOWN | "; decodedFlags |= SDL_WINDOW_SHOWN; }
	if (flags & SDL_WINDOW_HIDDEN) { ss << "SDL_WINDOW_HIDDEN | "; decodedFlags |= SDL_WINDOW_HIDDEN; }
	if (flags & SDL_WINDOW_BORDERLESS) { ss << "SDL_WINDOW_BORDERLESS | "; decodedFlags |= SDL_WINDOW_BORDERLESS; }
	if (flags & SDL_WINDOW_RESIZABLE) { ss << "SDL_WINDOW_RESIZABLE | "; decodedFlags |= SDL_WINDOW_RESIZABLE; }
	if (flags & SDL_WINDOW_MINIMIZED) { ss << "SDL_WINDOW_MINIMIZED | "; decodedFlags |= SDL_WINDOW_MINIMIZED; }
	if (flags & SDL_WINDOW_MAXIMIZED) { ss << "SDL_WINDOW_MAXIMIZED | "; decodedFlags |= SDL_WINDOW_MAXIMIZED; }
	if (flags & SDL_WINDOW_INPUT_GRABBED) { ss << "SDL_WINDOW_INPUT_GRABBED | "; decodedFlags |= SDL_WINDOW_INPUT_GRABBED; }
	if (flags & SDL_WINDOW_INPUT_FOCUS) { ss << "SDL_WINDOW_INPUT_FOCUS | "; decodedFlags |= SDL_WINDOW_INPUT_FOCUS; }
	if (flags & SDL_WINDOW_MOUSE_FOCUS) { ss << "SDL_WINDOW_MOUSE_FOCUS | "; decodedFlags |= SDL_WINDOW_MOUSE_FOCUS; }
	if (flags & SDL_WINDOW_FOREIGN) { ss << "SDL_WINDOW_FOREIGN | "; decodedFlags |= SDL_WINDOW_FOREIGN; }
	
	if (flags != decodedFlags) {
		ss << "... | ";
	}
	
	std::string result = ss.str();
	if ( ! result.empty()) {
		result = result.substr(0, result.size() - 3);
	}
	
	return result;
}

int main(int argc, char *argv[])
{
	// When cycling through display modes, one will be chosen as the one to
	// initialize a window with.  A copy of its SDL_DisplayMode struct will
	// be made.
	SDL_DisplayMode chosenDisplayMode;
	memset(&chosenDisplayMode, 0, sizeof(chosenDisplayMode));
	bool wasDisplayModeChosen = false;
	const int videoDisplayIndexToChoose = 0;
	const int displayModeIndexToChoose = -1;	// If -1, the mode will be chosen by SDL_GetCurrentDisplayMode.

#pragma mark - Initialize SDL
	// Try initializing SDL.  Init as much as possible, to keep our options
	// open (for this test program).
	//
	// NOTE: As of Jul 6, 2012: Haptic support causes SDL_Init to fail.
	Uint32 sdlInitFlags = SDL_INIT_EVERYTHING;
	if (SDL_Init(sdlInitFlags) != 0) {
		printf("WARNING: SDL_Init(SDL_INIT_EVERYTHING) failed with error, \"%s\".\n",
				SDL_GetError());
		printf("INFO: An attempt will be made to initialize SDL without haptic support.\n");
		sdlInitFlags = SDL_INIT_EVERYTHING & (~SDL_INIT_HAPTIC);
		if (SDL_Init(sdlInitFlags) != 0) {
			printf("ERROR: SDL_Init(<SDL_INIT_EVERYTHING minus SDL_INIT_HAPTIC>) failed with error, \"%s\".\n",
					SDL_GetError());
			printf("INFO: The app will now terminate.\n");
			return 1;
		} else {
			printf("INFO: SDL_Init(<SDL_INIT_EVERYTHING minus SDL_INIT_HAPTIC>) was successful!\n");
		}
	} else {
		printf("INFO: SDL_Init(SDL_INIT_EVERYTHING) was successful!\n");
	}
	
#pragma mark - Video Mode Reporting
	// Display information on the currently available video displays:
	printf("INFO: Retrieving information on the available video display(s):\n");

	// Get the number of video displays, then display information on each of
	// them.
	const int numVideoDisplays = SDL_GetNumVideoDisplays();
	if (numVideoDisplays < 1) {
		printf("WARNING: Unable to retrieve the number of video displays (via SDL_GetNumVideoDisplays), error = \"%s\".\n",
				SDL_GetError());
	} else {
		printf("INFO: Number of video displays (via SDL_GetNumVideoDisplays): %d\n", numVideoDisplays);

		for (int videoDisplayIndex = 0; videoDisplayIndex < numVideoDisplays; ++videoDisplayIndex) {
			SDL_DisplayMode displayMode;
			
			// Display information on each of the display's video modes:
			int numDisplayModes = SDL_GetNumDisplayModes(videoDisplayIndex);
			if (numDisplayModes < 1) {
				printf("WARNING: Unable to retrieve the number of display modes for video display %d (via SDL_GetNumDisplayModes), error = \"%s\".\n",
						videoDisplayIndex, SDL_GetError());
			} else {
				printf("INFO: Number of display modes for video display %d (via SDL_GetNumDisplayModes): %d\n",
						videoDisplayIndex, numDisplayModes);
			
				for (int displayModeIndex = 0; displayModeIndex < numDisplayModes; ++displayModeIndex) {
					if (SDL_GetDisplayMode(videoDisplayIndex, displayModeIndex, &displayMode) != 0) {
						printf("WARNING: Unable to get information on display mode #%d for video display #%d (via SDL_GetDisplayMode), error = \"%s\".\n",
								displayModeIndex, videoDisplayIndex, SDL_GetError());
					} else {
						printf("INFO: Video Display #%d, Display Mode #%d: format=%s, w=%d, h=%d, refresh_rate=%d\n",
								videoDisplayIndex, displayModeIndex,
								ConvertPixelFormatToCString(displayMode.format),
								displayMode.w, displayMode.h, displayMode.refresh_rate);
						
						if (videoDisplayIndex == videoDisplayIndexToChoose &&
							displayModeIndexToChoose == displayModeIndex)
						{
							chosenDisplayMode = displayMode;
							wasDisplayModeChosen = true;
						}
					}
				}
			}

			// Display information on the display's current video mode:
			if (SDL_GetCurrentDisplayMode(videoDisplayIndex, &displayMode) != 0) {
				printf("WARNING: Unable to get information on video display #%d (via SDL_GetCurrentDisplayMode); error = \"%s\".\n",
						videoDisplayIndex, SDL_GetError());
			} else {
				printf("INFO: Current Mode for Video Display #%d (via SDL_GetCurrentDisplayMode): format=%s, w=%d, h=%d, refresh_rate=%d\n",
						videoDisplayIndex,
						ConvertPixelFormatToCString(displayMode.format),
						displayMode.w, displayMode.h, displayMode.refresh_rate);
						
				if (videoDisplayIndex == videoDisplayIndexToChoose &&
					displayModeIndexToChoose == -1)
				{
					chosenDisplayMode = displayMode;
					wasDisplayModeChosen = true;
				}
			}
		}
	}
	
	// Display information on the currently available SDL video driver(s):
	printf("INFO: Retrieving information on the available video driver(s):\n");
	
	// Get the number of video drivers, then display information on each of them:
	const int numVideoDrivers = SDL_GetNumVideoDrivers();
	if (numVideoDrivers < 1) {
		printf("WARNING: Unable to retrieve the number of video drivers (via SDL_GetNumVideoDrivers), error = \"%s\".\n",
				SDL_GetError());
	} else {
		printf("INFO: Number of video drivers (via SDL_GetNumVideoDrivers): %d\n", numVideoDrivers);
		
		// Display information on each of SDL's video drivers:
		for (int videoDriverIndex = 0; videoDriverIndex < numVideoDrivers; ++videoDriverIndex) {
			const char * videoDriver = SDL_GetVideoDriver(videoDriverIndex);
			if ( ! videoDriver) {
				printf("WARNING: Unable to get information on video driver #%d (via SDL_GetVideoDriver), no error information is available.\n",
						videoDriverIndex);
			} else {
				printf("INFO: Video driver #%d is \"%s\".\n",
						videoDriverIndex, videoDriver);
			}
		}
	}
	
	// Display information on the current video driver:
	const char * currentVideoDriver = SDL_GetCurrentVideoDriver();
	if ( ! currentVideoDriver) {
		printf("WARNING: Unable to get information the current video driver (via SDL_GetCurrentVideoDriver), no error information is available.\n");
	} else {
		printf("INFO: The current video driver (via SDL_GetCurrentVideoDriver) is, \"%s\".\n",
				currentVideoDriver);
	}
	
#pragma mark - Window Creation
	// Make sure a display mode was chosen.  If not, exit.
	if ( ! wasDisplayModeChosen) {
		if (displayModeIndexToChoose == -1) {
			printf("ERROR: Unable to create a window as a display mode was not found (at video driver index=%d and display mode index=current.\n",
				   videoDisplayIndexToChoose);
		} else {
			printf("ERROR: Unable to create a window as a display mode was not found (at video driver index=%d and display mode index=%d.\n",
				   videoDisplayIndexToChoose, displayModeIndexToChoose);
		}
		return 1;
	}
	
	// Create a new SDL window with OpenGL support.
	const Uint32 windowFlags = SDL_WINDOW_FULLSCREEN | SDL_WINDOW_SHOWN | SDL_WINDOW_OPENGL;
	const char * windowTitle = "SDL2Test Window";
	const int windowX = 0;
	const int windowY = 0;
	std::string stringifiedWindowFlags = ConvertSDLWindowFlagsToString(windowFlags);
	printf("INFO: Creating the main SDL Window (via SDL_CreateWindow) with: title=\"%s\", x=%d, y=%d, w=%d, h=%d, flags=(%s)\n",
		   windowTitle, windowX, windowY, chosenDisplayMode.w,
		   chosenDisplayMode.h,
		   stringifiedWindowFlags.c_str());
	SDL_Window * mainWindow = SDL_CreateWindow(windowTitle,
											   0, 0,
											   chosenDisplayMode.w, chosenDisplayMode.h,
											   windowFlags);
	if ( ! mainWindow) {
		printf("ERROR: Unable to create the main SDL window (via SDL_CreateWindow), error = \"%s\".\n",
			   SDL_GetError());
		return 1;
	}
	
	printf("INFO: The main SDL Window has been created.  (address = 0x%x)\n",
		   (unsigned int)mainWindow);
	
	return 0;
}
