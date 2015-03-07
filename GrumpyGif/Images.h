//
//  Images.h
//  GrumpyGif
//
//  Created by Armando on 07/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Images : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * rated;
@property (nonatomic, retain) NSString * id;

@end
