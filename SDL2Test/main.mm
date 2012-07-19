//
//  main.mm
//  SDL2Test
//
//  Created by David Ludwig on 7/6/12.
//  Copyright (c) 2012 Funkitron, Inc. All rights reserved.
//

#include <stdio.h>
#include <iostream>
#include <sstream>
#import <UIKit/UIKit.h>

#include <boost/format.hpp>

#include <SDL.h>

#import "GameCenterManager.h"
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

std::string ConvertSDLWindowEventIDToString(Uint8 eventID) {
	switch (eventID) {
		case SDL_WINDOWEVENT_NONE: return "SDL_WINDOWEVENT_NONE";
		case SDL_WINDOWEVENT_SHOWN: return "SDL_WINDOWEVENT_SHOWN";
		case SDL_WINDOWEVENT_HIDDEN: return "SDL_WINDOWEVENT_HIDDEN";
		case SDL_WINDOWEVENT_EXPOSED: return "SDL_WINDOWEVENT_EXPOSED";
		case SDL_WINDOWEVENT_MOVED: return "SDL_WINDOWEVENT_MOVED";
		case SDL_WINDOWEVENT_RESIZED: return "SDL_WINDOWEVENT_RESIZED";
		case SDL_WINDOWEVENT_SIZE_CHANGED: return "SDL_WINDOWEVENT_SIZE_CHANGED";
		case SDL_WINDOWEVENT_MINIMIZED: return "SDL_WINDOWEVENT_MINIMIZED";
		case SDL_WINDOWEVENT_MAXIMIZED: return "SDL_WINDOWEVENT_MAXIMIZED";
		case SDL_WINDOWEVENT_RESTORED: return "SDL_WINDOWEVENT_RESTORED";
		case SDL_WINDOWEVENT_ENTER: return "SDL_WINDOWEVENT_ENTER";
		case SDL_WINDOWEVENT_LEAVE: return "SDL_WINDOWEVENT_LEAVE";
		case SDL_WINDOWEVENT_FOCUS_GAINED: return "SDL_WINDOWEVENT_FOCUS_GAINED";
		case SDL_WINDOWEVENT_FOCUS_LOST: return "SDL_WINDOWEVENT_FOCUS_LOST";
		case SDL_WINDOWEVENT_CLOSE: return "SDL_WINDOWEVENT_CLOSE";
		default:
			return (boost::format("<unknown SDL window event id: 0x%x") % eventID).str();
	}
}

std::string ConvertSDLEventTypeToString(Uint32 type) {
	switch (type) {
		case SDL_QUIT: return "SDL_QUIT";
		case SDL_WINDOWEVENT: return "SDL_WINDOWEVENT";
		case SDL_SYSWMEVENT: return "SDL_SYSWMEVENT";
		case SDL_KEYDOWN: return "SDL_KEYDOWN";
		case SDL_KEYUP: return "SDL_KEYUP";
		case SDL_TEXTEDITING: return "SDL_TEXTEDITING";
		case SDL_TEXTINPUT: return "SDL_TEXTINPUT";
		case SDL_MOUSEMOTION: return "SDL_MOUSEMOTION";
		case SDL_MOUSEBUTTONDOWN: return "SDL_MOUSEBUTTONDOWN";
		case SDL_MOUSEBUTTONUP: return "SDL_MOUSEBUTTONUP";
		case SDL_MOUSEWHEEL: return "SDL_MOUSEWHEEL";
		case SDL_INPUTMOTION: return "SDL_INPUTMOTION";
		case SDL_INPUTBUTTONDOWN: return "SDL_INPUTBUTTONDOWN";
		case SDL_INPUTBUTTONUP: return "SDL_INPUTBUTTONUP";
		case SDL_INPUTWHEEL: return "SDL_INPUTWHEEL";
		case SDL_INPUTPROXIMITYIN: return "SDL_INPUTPROXIMITYIN";
		case SDL_INPUTPROXIMITYOUT: return "SDL_INPUTPROXIMITYOUT";
		case SDL_JOYAXISMOTION: return "SDL_JOYAXISMOTION";
		case SDL_JOYBALLMOTION: return "SDL_JOYBALLMOTION";
		case SDL_JOYHATMOTION: return "SDL_JOYHATMOTION";
		case SDL_JOYBUTTONDOWN: return "SDL_JOYBUTTONDOWN";
		case SDL_JOYBUTTONUP: return "SDL_JOYBUTTONUP";
		case SDL_FINGERDOWN: return "SDL_FINGERDOWN";
		case SDL_FINGERUP: return "SDL_FINGERUP";
		case SDL_FINGERMOTION: return "SDL_FINGERMOTION";
		case SDL_TOUCHBUTTONDOWN: return "SDL_TOUCHBUTTONDOWN";
		case SDL_TOUCHBUTTONUP: return "SDL_TOUCHBUTTONUP";
		case SDL_DOLLARGESTURE: return "SDL_DOLLARGESTURE";
		case SDL_DOLLARRECORD: return "SDL_DOLLARRECORD";
		case SDL_MULTIGESTURE: return "SDL_MULTIGESTURE";
		case SDL_CLIPBOARDUPDATE: return "SDL_CLIPBOARDUPDATE";
		case SDL_DROPFILE: return "SDL_DROPFILE";
		case SDL_USEREVENT: return "SDL_USEREVENT";
		default:
		{
			return (boost::format("<unknown SDL event type: 0x%x>") % type).str();
		}
	}
}

std::string ConvertSDLMouseStateToString(Uint8 flags) {
	std::stringstream ss;
	Uint8 decodedFlags = 0;
	
	if (flags & SDL_BUTTON_LMASK) { ss << "SDL_BUTTON_LMASK | "; decodedFlags |= SDL_BUTTON_LMASK; }
	if (flags & SDL_BUTTON_MMASK) { ss << "SDL_BUTTON_MMASK | "; decodedFlags |= SDL_BUTTON_MMASK; }
	if (flags & SDL_BUTTON_RMASK) { ss << "SDL_BUTTON_RMASK | "; decodedFlags |= SDL_BUTTON_RMASK; }
	if (flags & SDL_BUTTON_X1MASK) { ss << "SDL_BUTTON_X1MASK | "; decodedFlags |= SDL_BUTTON_X1MASK; }
	if (flags & SDL_BUTTON_X2MASK) { ss << "SDL_BUTTON_X2MASK | "; decodedFlags |= SDL_BUTTON_X2MASK; }
	
	if (flags != decodedFlags) {
		ss << "... | ";
	}
	
	std::string result = ss.str();
	if ( ! result.empty()) {
		result = result.substr(0, result.size() - 3);
	}
	
	return result;
}

std::string ConvertSDLMouseButtonToString(Uint8 button) {
	switch (button) {
		case SDL_BUTTON_LEFT: return "SDL_BUTTON_LEFT";
		case SDL_BUTTON_MIDDLE: return "SDL_BUTTON_MIDDLE";
		case SDL_BUTTON_RIGHT: return "SDL_BUTTON_RIGHT";
		case SDL_BUTTON_X1: return "SDL_BUTTON_X1";
		case SDL_BUTTON_X2: return "SDL_BUTTON_X2";
		default:
			return (boost::format("<unknown SDL button: 0x%x>") % button).str();
	}
}

struct ExtraInfoOnSDLEvent {
	ExtraInfoOnSDLEvent(const SDL_Event & event) : event(event) {}
	const SDL_Event & event;
};

std::ostream & operator<<(std::ostream & stream, const ExtraInfoOnSDLEvent & e) {
	switch (e.event.type) {
		case SDL_FINGERDOWN:
		case SDL_FINGERMOTION:
		case SDL_FINGERUP:
			stream
				<< "windowID=" << e.event.tfinger.windowID << ", "
				<< "touchId=" << e.event.tfinger.touchId << ", "
				<< "fingerId=" << e.event.tfinger.fingerId << ", "
				<< "state=(" << ConvertSDLMouseStateToString(e.event.tfinger.state) << "), "
				<< "x=" << e.event.tfinger.x << ", "
				<< "y=" << e.event.tfinger.y << ", "
				<< "dx=" << e.event.tfinger.dx << ", "
				<< "dy=" << e.event.tfinger.dy << ", "
				<< "pressure=" << e.event.tfinger.pressure << " ";
			break;
		case SDL_MOUSEBUTTONDOWN:
		case SDL_MOUSEBUTTONUP:
			stream
				<< "windowID=" << e.event.motion.windowID << ", "
				<< "button=" << ConvertSDLMouseButtonToString(e.event.button.button) << ", "
				<< "state=(" << ConvertSDLMouseStateToString(e.event.button.state) << "), "
				<< "x=" << e.event.button.x << ", "
				<< "y=" << e.event.button.y << " ";
			break;
		case SDL_MOUSEMOTION:
			stream
				<< "windowID=" << e.event.motion.windowID << ", "
				<< "state=(" << ConvertSDLMouseStateToString(e.event.motion.state) << "), "
				<< "x=" << e.event.motion.x << ", "
				<< "y=" << e.event.motion.y << ", "
				<< "xrel=" << e.event.motion.xrel << ", "
				<< "yrel=" << e.event.motion.yrel << " ";
			break;
		case SDL_WINDOWEVENT:
			stream
				<< "windowID=" << e.event.window.windowID << ", "
				<< "event=" << ConvertSDLWindowEventIDToString(e.event.window.event) << ", "
				<< "data1=" << e.event.window.data1 << ", "
				<< "data2=" << e.event.window.data2 << " ";
			break;
		default:
			stream << "... ";
	}
	
	return stream;
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
	
	printf("INFO: The main SDL Window has been created (via SDL_CreateWindow).  (address = 0x%x)\n",
		   (unsigned int)mainWindow);
	
#pragma mark - GL Context Creation
	// Creating a GL context (via SDL_GL_CreateContext) and updating its window
	// (via SDL_GL_SwapWindow) is needed to get events working in an iOS-based
	// SDL app (as of this writing on July 15, 2012).  This isn't to say there
	// aren't other ways of getting events working in an SDL + iOS based app,
	// however the combination of these two calls does work.  Not including
	// these calls, and only attempting to poll for events (via SDL_PollEvent)
	// does not work for most event types.  Window events get received, but not
	// touch events.
	
	printf("INFO: Creating GL context (via SDL_GL_CreateContext) for main window.\n");
	SDL_GLContext mainGLContext = SDL_GL_CreateContext(mainWindow);
	if ( ! mainGLContext) {
		printf("ERROR: Unable to create a GL context (via SDL_GL_CreateContext), error = \"%s\".\n",
			   SDL_GetError());
		return 1;
	}
	printf("INFO: A GL context has been created for the main window (via SDL_GL_CreateContext).  (address = 0x%x)\n",
		   (unsigned int)mainGLContext);
	
#pragma mark - Main Loop
	// Sit in an endless loop, getting + logging events, drawing stuff, etc.
	printf("INFO: Entering main loop.\n");
	unsigned long long loopCount = 0;
	while (true) {
		// Update the loop count.  This is always done once when the main loop
		// iterates.
		++loopCount;
		
		// Retrieve all events in SDL's event queue, logging information about
		// them.
		SDL_Event event;
		while (SDL_PollEvent(&event)) {
			std::cout << "INFO: " << ConvertSDLEventTypeToString(event.type) <<
				" received, loop count=" << loopCount <<
				", " << ExtraInfoOnSDLEvent(event) << "\n";
			
			if (event.type == SDL_MOUSEBUTTONDOWN &&
				event.button.x >= 0 && event.button.x <= 100 &&
				event.button.y >= 0 && event.button.y <= 100)
			{
				std::cout << "INFO: Authenticating With Game Center.\n";
				[[GameCenterManager sharedManager] authenticate];
			}
		}
		
		// This seems to be a necessary component of getting an iOS-based SDL
		// app to process touch events.
		SDL_GL_SwapWindow(mainWindow);
		
		// Wait a bit, just in case the OS needs time to process things.
		SDL_Delay(1);
	}
	
	return 0;
}
