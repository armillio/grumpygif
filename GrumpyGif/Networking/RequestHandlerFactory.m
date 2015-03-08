//
//  RequestHandler.m
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "RequestHandlerFactory.h"
#import "GifCatcher.h"

@implementation RequestHandlerFactory
+(id<RequestHandler>)requestHandler{
    return [[GifCatcher alloc] init];
}
@end
