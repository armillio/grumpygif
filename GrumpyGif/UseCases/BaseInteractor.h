//
//  BaseInteractor.h
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface BaseInteractor : NSObject
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end
