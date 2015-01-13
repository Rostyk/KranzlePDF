//
//  PDFRenderer.h
//  KranzlePDF
//
//  Created by Ross on 1/13/15.
//  Copyright (c) 2015 Ross. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFRenderer : NSObject

+ (instancetype)sharedRenderer;

- (void)insertName:(NSString*)name;
@end
