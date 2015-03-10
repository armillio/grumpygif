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
-(NSManagedObjectContext *)managedObjectContext{
    if(_managedObjectContext == nil){
        _managedObjectContext = self.coreDataStack.managedObjectContext;
    }
    return _managedObjectContext;
}
-(CoreDataStack *)coreDataStack{
    if(_coreDataStack == nil){
        _coreDataStack = [[CoreDataStack alloc] initWithModelName:kModelName];
    }
    return _coreDataStack;
}
- (id<RequestHandler>)requestHandler{
    if (_requestHandler == nil) {
        _requestHandler = [RequestHandlerFactory requestHandler];
    }
    return _requestHandler;
}

@end
