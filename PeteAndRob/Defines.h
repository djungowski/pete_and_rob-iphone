//
//  Defines.h
//  
//
//  Created by Elmar Kretzer on 25.11.11
//  Copyright 2010 symentis. All rights reserved.
//

// this file is globally included from the pre compile header .pch file

#ifndef PAR_definitions_h

#define PAR_definitions_h

#define UIColor(r,g,b) [UIColor \
colorWithRed:(float)r/255.0 \
green:(float)g/255.0 \
blue:(float)b/255.0 alpha:1.0] 

#define UIImage(named) [UIImage imageNamed:named]

#define WARNING YES

#define HEIGHT_ROW_VIDEO 65

#define DURATION_URL_REQUEST_TIMEOUT 20

// UIFonts
#define FONT_DEFAULT(s) [UIFont fontWithName:@"Futura-CondensedMedium" size:s]
#define FONT_BOLD(s)    [UIFont fontWithName:@"Futura-CondensedExtraBold" size:s]
// font sizes
#define FONTSIZE_SMALL   17
#define FONTSIZE_DEFAULT 21

#define NUMBER_RSS_ITEMS 25

#define UICOLOR_TINT [UIColor colorWithRed:0.675 green:0.757 blue:0.694 alpha:1]

#define HTTP_METHOD_POST @"POST"
#define HTTP_METHOD_PUT @"PUT"
#define HTTP_METHOD_GET @"GET"
#define HTTP_METHOD_DELETE @"DELETE"

#define URL_VIDEOS @"http://www.peteandrob.com/rss/videos.php"
#define URL_WALLPAPERS @"http://www.peteandrob.com/rss/wallpapers.php"

#define NSSTRING_FACEBOOK @"http://www.facebook.com/share.php?u="
#define NSSTRING_TWITTER @"http://twitter.com/share?url="
#define NSSTRING_GOOGLE @"https://m.google.com/app/plus/x/?v=compose&content="


#endif