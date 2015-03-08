//
//  ImageEntity.h
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ImageEntity : NSManagedObject

@property (nonatomic, retain) NSString * imageId;
@property (nonatomic, retain) NSString * imageRated;
@property (nonatomic, retain) NSString * imageSource;
@property (nonatomic, retain) NSString * imageUrl;

@end
