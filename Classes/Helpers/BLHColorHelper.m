//
//  BLHColorHelper.m
//  yssy
//
//  Created by Rurui Ye on 1/31/14.
//  Copyright (c) 2014 Rurui Ye. All rights reserved.
//

#import "BLHColorHelper.h"

@implementation UIColor(BLHColorHelper)
+(UIColor*)getColorForLable:(NSString *)label
{
    const char *inputUTF8 = [label UTF8String];
    int value = 0;
    for (int i = 0; i < label.length; i++)
    {
        value += inputUTF8[i];
    }
    value = value % 26;
    switch (value) {
        case 0:
            return [UIColor steelBlueColor];
        case 1:
            return [UIColor warmGrayColor];
        case 2:
            return [UIColor tealColor];
        case 3:
            return [UIColor robinEggColor];
        case 4:
            return [UIColor pastelBlueColor];
        case 5:
            return [UIColor indigoColor];
        case 6:
            return [UIColor blueberryColor];
        case 7:
            return [UIColor emeraldColor];
        case 8:
            return [UIColor maroonColor];
        case 9:
            return [UIColor oliveDrabColor];
        case 10:
            return [UIColor limeColor];
        case 11:
            return [UIColor salmonColor];
        case 12:
            return [UIColor grapefruitColor];
        case 13:
            return [UIColor coralColor];
        case 14:
            return [UIColor tomatoColor];
        case 15:
            return [UIColor pastelPurpleColor];
        case 16:
            return [UIColor fuschiaColor];
        case 17:
            return [UIColor bananaColor];
        case 18:
            return [UIColor chiliPowderColor];
        case 19:
            return [UIColor eggplantColor];
        case 20:
            return [UIColor indianRedColor];
        case 21:
            return [UIColor watermelonColor];
        case 22:
            return [UIColor lavenderColor];
        case 23:
            return [UIColor goldenrodColor];
        case 24:
            return [UIColor lavenderColor];
        case 25:
            return [UIColor denimColor];
        default:
            return [UIColor infoBlueColor];
    }
}
@end
