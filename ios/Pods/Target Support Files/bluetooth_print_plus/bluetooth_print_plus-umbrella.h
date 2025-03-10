#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BluetoothPrintPlusPlugin.h"
#import "ConnecterManager.h"
#import "CpclCommandPlugin.h"
#import "EscCommandPlugin.h"
#import "TscCommandPlugin.h"

FOUNDATION_EXPORT double bluetooth_print_plusVersionNumber;
FOUNDATION_EXPORT const unsigned char bluetooth_print_plusVersionString[];

