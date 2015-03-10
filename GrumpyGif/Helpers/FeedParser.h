//
//  FeedParser.h
//  GrumpyGif
//
//  Created by Armando on 10/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedParser : NSObject
-(NSArray *) parseDataToJson:(NSData *)data;
@end
