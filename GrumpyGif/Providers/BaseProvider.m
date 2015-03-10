//
//  BaseProvider.m
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "BaseProvider.h"
#import "CoreDataStack.h"

NSString *const kModelName = @"GrumpyGif";

@interface BaseProvider()
@property (strong,nonatomic) CoreDataStack *coreDataStack;
@end

@implementation BaseProvider
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.coreDataStack = [[CoreDataStack alloc] initWithModelName:kModelName];
        self.managedObjectContext = self.coreDataStack.managedObjectContext;
    }
    return self;
}
- (id<RequestHandler>)requestHandler{
    if (_requestHandler == nil) {
        _requestHandler = [RequestHandlerFactory requestHandler];
        //_requestHandler.baseDomain = @"http://api.giphy.com";
        //_requestHandler.baseParameters = @{@"api_key":@"dc6zaTOxFJmzC"};
    }
    return _requestHandler;
}
@end
