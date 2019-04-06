//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

#ifndef AppConstants_h
#define AppConstants_h


#endif /* AppConstants_h */
#ifdef DEBUG
#define DEEP_LOG(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else

#define DEEP_LOG(...)

#endif

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

//--Use main screen to check screen height and width
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

//--Defining Length According to size of different Devices
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONEX (([[UIScreen mainScreen] bounds].size.height-812)?NO:YES)

//--Defining SYSTEM VERSION
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//--Defining Fonts
#define FONT_REGULAR(A) [UIFont fontWithName:@"Roboto-Regular" size:A]
#define FONT_REGULAR_REGULAR [UIFont fontWithName:@"Roboto-Regular" size:13]
#define FONT_REGULAR_SMALL [UIFont fontWithName:@"Roboto-Regular" size:11.5]
#define FONT_REGULAR_LARGE [UIFont fontWithName:@"Roboto-Regular" size:15]

#define FONT_BOLD(A) [UIFont fontWithName:@"Roboto-Bold" size:A]
#define FONT_BOLD_REGULAR [UIFont fontWithName:@"Roboto-Bold" size:13]
#define FONT_BOLD_SMALL [UIFont fontWithName:@"Roboto-Bold" size:11.5]
#define FONT_BOLD_LARGE [UIFont fontWithName:@"Roboto-Bold" size:15]

#define FONT_LIGHT(A) [UIFont fontWithName:@"Roboto-Light" size:A]
#define FONT_LIGHT_REGULAR [UIFont fontWithName:@"Roboto-Light" size:13]
#define FONT_LIGHT_SMALL [UIFont fontWithName:@"Roboto-Light" size:11.5]
#define FONT_LIGHT_LARGE [UIFont fontWithName:@"Roboto-Light" size:15]

#define FONT_ITALIC(A) [UIFont fontWithName:@"Roboto-Italic" size:A]
#define FONT_ITALIC_REGULAR [UIFont fontWithName:@"Roboto-Italic" size:13]
#define FONT_ITALIC_SMALL [UIFont fontWithName:@"Roboto-Italic" size:11.5]
#define FONT_ITALIC_LARGE [UIFont fontWithName:@"Roboto-Italic" size:15]

#define FONT_MEDIUM(A) [UIFont fontWithName:@"Roboto-Medium" size:A]
#define FONT_MEDIUM_REGULAR [UIFont fontWithName:@"Roboto-Medium" size:13]
#define FONT_MEDIUM_SMALL [UIFont fontWithName:@"Roboto-Medium" size:11.5]
#define FONT_MEDIUM_LARGE [UIFont fontWithName:@"Roboto-Medium" size:15]

#define DEFAULT_TIMEOUT_INTERVAL 120


#define DEVICE_ID                                           [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]

