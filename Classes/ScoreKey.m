//
//  ScoreKey.m
//  GreenLeague
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
//

#import "ScoreKey.h"
#import "Score.h"
#import "NSString+Helper.h"

#define kKeyField 0
#define kKeyShortValueField 1
#define kKeyValueField 2
#define kMaxScoreField 3

@implementation ScoreKey

static NSString *kScoreKeyEntityName = @"ScoreKey";


#pragma mark -
#pragma mark === Class methods ===
#pragma mark


+ (NSString *)entityName {
	return [NSString stringWithString:kScoreKeyEntityName];
}

// Returns an array of ScoreKey objects from an array of 
// keys as strings.
// If a key is not found, then the nil object is stored in the array
+ (NSArray *)scoreKeyArrayFromKeyStringArray:(NSArray *)keyStringArray managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    NSMutableArray *scoreKeyArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [keyStringArray count]; i++) {
        NSString *keyStr = [keyStringArray objectAtIndex:i];
        
        // Find string in ScoreKey table
		NSEntityDescription *entity = [NSEntityDescription entityForName:[ScoreKey entityName] inManagedObjectContext: managedObjectContext];
        
        //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == \"%@\"", keyStr]; // This doesn't work for some reason
        NSString *predicateString = [NSString stringWithFormat:@"key == \"%@\"", keyStr];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
        //NSLog(@"predicate = '%@', keyStr = '%@'", predicate, keyStr);
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		[request setEntity:entity]; 
        [request setPredicate:predicate];        
        
		// Fetch the records and handle an error
		NSError *error;
		NSMutableArray *scoreKeys = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
		if (!scoreKeys) {
			// Handle the error.
			// This is a serious error and should advise the user to restart the application
			NSLog(@"scoreKeys error: %@", error);
		}
        [request release];
        
        if ([scoreKeys count] > 0) {
            [scoreKeyArray addObject:[scoreKeys objectAtIndex:0]]; // Just add the first match - should only be one
        } else {
            NSLog(@"Score key '%@' not found, adding null to array at index: %d.", keyStr, i);
            [scoreKeyArray addObject:[NSNull null]];
        }
    }
    
    return [scoreKeyArray autorelease];
}

+ (void)addScoreKeyToDBWithManagedContext:(NSManagedObjectContext *)managedObjectContext fromRowArray:(NSArray *)rowArray {
    
	ScoreKey *scoreKey;
	
	if ([rowArray count] >= kKeyValueField) {
		NSString *key = [rowArray objectAtIndex:kKeyField];
        NSString *scoreText = [rowArray objectAtIndex:kKeyValueField];
        NSString *scoreShortText = [rowArray objectAtIndex:kKeyShortValueField];
        NSNumber *maxScore = nil;
        if (rowArray.count > kMaxScoreField) {
            NSString *maxScoreString = [rowArray objectAtIndex:kMaxScoreField];
            maxScore = [maxScoreString numberFromString];
        }
        
        
		if ((key.length > 0) && (scoreText.length > 0)) {
			scoreKey = (ScoreKey *)[NSEntityDescription insertNewObjectForEntityForName:[ScoreKey entityName] inManagedObjectContext:managedObjectContext];
			[scoreKey setKey:key];
			[scoreKey setText:scoreText];
            [scoreKey setShortName:scoreShortText];
            if (maxScore) {
                [scoreKey setMaxScore:maxScore];
            }
            
			//NSLog(@"Saving the record: %@", scoreKey);
			
            NSError *error;					
			if(![managedObjectContext save:&error]) {
				//This is a serious error saying the record  
				//could not be saved. Advise the user to  
				//try again or restart the application.   
				NSLog(@"Error in saving the record: %@", error);
			}		
			
		} // Else, do nothing - shouldn't have an empty row
        else {
            NSLog(@"Couldn't save: %@:%@", key, scoreText);
        }
	}    
    
}


@end
