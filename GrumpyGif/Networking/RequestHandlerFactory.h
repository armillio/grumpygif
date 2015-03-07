//
//  RequestHandler.h
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestHandler.h"

@interface RequestHandlerFactory : NSObject
+ (id<RequestHandler>)requestHandler;
@end
