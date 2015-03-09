//
//  MainViewProvider.h
//  GrumpyGif
//
//  Created by Armando on 08/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "BaseProvider.h"

@interface MainViewProvider : BaseProvider
- (void)loadGifsFromCoreDataWithSuccess:(void(^)(NSArray *gifs))successBlock error:(void(^)(NSError *error))errorBlock;
@end
