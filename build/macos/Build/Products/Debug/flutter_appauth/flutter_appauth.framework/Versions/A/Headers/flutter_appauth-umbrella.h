#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FlutterAppauthPlugin.h"

FOUNDATION_EXPORT double flutter_appauthVersionNumber;
FOUNDATION_EXPORT const unsigned char flutter_appauthVersionString[];

