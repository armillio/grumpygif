//
//  BaseProvider.m
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "BaseProvider.h"
#import "CoreDataStack.h"

@interface BaseProvider()
@property (strong,nonatomic) CoreDataStack *coreDataStack;
@end
@implementation BaseProvider
-(NSManagedObjectContext *)managedObjectContext{
    if(_managedObjectContext == nil){
        _managedObjectContext = [CoreDataStack sharedInstance].managedObjectContext;
    }
    return _managedObjectContext;
}
- (id<RequestHandler>)requestHandler{
    if (_requestHandler == nil) {
        _requestHandler = [RequestHandlerFactory requestHandler];
    }
    return _requestHandler;
}
@end
