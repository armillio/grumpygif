//
//  RequestHandler.m
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "RequestHandlerFactory.h"

@implementation RequestHandlerFactory
+(id<RequestHandler>)requestHandler{
    return [[RequestHandlerFactory alloc] init];
}
@end
