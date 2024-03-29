//
//  AppDelegate.m
//  ColorPaletteMaker
//
//  Created by Hemanta Sapkota on 16/05/2014.
//  Copyright (c) 2014 com.laex. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

/*
 NSColor: Instantiate from Web-like Hex RRGGBB string
 Original Source: <http://cocoa.karelia.com/Foundation_Categories/NSColor__Instantiat.m>
 (See copyright notice at <http://cocoa.karelia.com>)
 */
+ (NSColor *) colorFromHexRGB:(NSString *) inColorString
{
	NSColor *result = nil;
	unsigned int colorCode = 0;
	unsigned char redByte, greenByte, blueByte;
	
	if (nil != inColorString)
	{
        if ([inColorString characterAtIndex:0] == '#')
            inColorString = [inColorString substringFromIndex:1];
        
		NSScanner *scanner = [NSScanner scannerWithString:inColorString];
		(void) [scanner scanHexInt:&colorCode];	// ignore error
	}
	redByte		= (unsigned char) (colorCode >> 16);
	greenByte	= (unsigned char) (colorCode >> 8);
	blueByte	= (unsigned char) (colorCode);	// masks off high bits
	result = [NSColor
              colorWithCalibratedRed:		(float)redByte	/ 0xff
              green:	(float)greenByte/ 0xff
              blue:	(float)blueByte	/ 0xff
              alpha:1.0];
	return result;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"flat_ui_colors" ofType:@"plist"];
    NSMutableDictionary *colors = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSColorList *list = [[NSColorList alloc] initWithName:@"FlatUI"];
    
    [colors enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [list setColor:[AppDelegate colorFromHexRGB:obj] forKey:key];
    }];
    
   [list writeToFile:nil];
    
}

@end