//
//  ImageEntity.h
//  GrumpyGif
//
//  Created by Armando on 13/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ImageEntity : NSManagedObject

@property (nonatomic, retain) NSString * imageCaption;
@property (nonatomic, retain) NSString * imageId;
@property (nonatomic, retain) NSDate * imageImportDate;
@property (nonatomic, retain) NSString * imageOriginalUrl;
@property (nonatomic, retain) NSString * imageRating;
@property (nonatomic, retain) NSString * imageSource;
@property (nonatomic, retain) NSString * imageUrl;

@end
