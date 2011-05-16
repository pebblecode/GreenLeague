//
//  DataKey.m
//  GreenLeague
//
//  Created by Tak Tran on 16/05/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DataKey.h"
#import "Data.h"
#import "MetaData.h"

#define kKeyField 0
#define kKeyValueField 1


@implementation DataKey
@dynamic value;
@dynamic key;
@dynamic data;
@dynamic metaData;

static NSString *kDataKeyEntityName = @"DataKey";

#pragma mark -
#pragma mark === Class methods ===
#pragma mark


+ (NSString *)entityName {
	return [NSString stringWithString:kDataKeyEntityName];
}

// Returns an array of DataKey objects from an array of 
// keys as strings.
// If a key is not found, then the nil object is stored in the array
+ (NSArray *)dataKeyArrayFromKeyStringArray:(NSArray *)keyStringArray managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    NSArray *dateKeyArray = [[NSArray alloc] init];
    for (int i = 0; i < [keyStringArray count]; i++) {
        NSString *keyStr = [keyStringArray objectAtIndex:i];
        
        // Find string in DataKey table
		NSEntityDescription *entity = [NSEntityDescription entityForName:[DataKey entityName] inManagedObjectContext: managedObjectContext];
        
        
    }
}

+ (void)addDataKeyToDBWithManagedContext:(NSManagedObjectContext *)managedObjectContext fromRowArray:(NSArray *)rowArray {
    
	DataKey *dataKey;
	
	if ([rowArray count] > kKeyValueField) {
		NSString *key = [rowArray objectAtIndex:kKeyField];
        NSString *value = [rowArray objectAtIndex:kKeyValueField];
        
		if ((key.length > 0) && (value.length > 0)) {
			dataKey = (DataKey *)[NSEntityDescription insertNewObjectForEntityForName:[DataKey entityName] inManagedObjectContext:managedObjectContext];
			[dataKey setKey:key];
			[dataKey setValue:value];
			
			NSError *error;					
			if(![managedObjectContext save:&error]) {
				//This is a serious error saying the record  
				//could not be saved. Advise the user to  
				//try again or restart the application.   
				NSLog(@"Error in saving the record: %@", error);
			}		
			
		} // Else, do nothing - shouldn't have an empty row
	}    
    
}

@end
