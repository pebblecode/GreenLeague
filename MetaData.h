//
//  MetaData.h
//  GreenLeague
//
//  Created by Tak Tran on 16/05/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class University;

@interface MetaData : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) University * university;
@property (nonatomic, retain) NSManagedObject * key;


@end
