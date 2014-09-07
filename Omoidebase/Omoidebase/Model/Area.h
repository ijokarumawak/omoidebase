//
//  Area.h
//  Omoidebase


#import <CouchbaseLite/CouchbaseLite.h>
#import "Document.h"

#define AREA_VIEW  @"areas"
#define AREA_TYPE @"place"

@interface Area : Document

/**
 * 画像
 */
@property NSString* image;

+ (CBLQuery *)findAreas:(NSError **)outError;

@end
