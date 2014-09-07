//
//  Area.h
//  Omoidebase


#import <CouchbaseLite/CouchbaseLite.h>
#import "Document.h"

#define USER_VIEW  @"users"
#define USER_TYPE @"profile"

@interface User : Document

/**
 * 場所
 */
@property (copy) NSArray *places;

+ (User *)findUser:(NSString *)code error:(NSError **)outError;

@end
