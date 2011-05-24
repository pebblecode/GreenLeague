// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ScoreKey.m instead.

#import "_ScoreKey.h"

@implementation ScoreKeyID
@end

@implementation _ScoreKey

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ScoreKey" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ScoreKey";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ScoreKey" inManagedObjectContext:moc_];
}

- (ScoreKeyID*)objectID {
	return (ScoreKeyID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"maxScoreValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"maxScore"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic maxScore;



- (short)maxScoreValue {
	NSNumber *result = [self maxScore];
	return [result shortValue];
}

- (void)setMaxScoreValue:(short)value_ {
	[self setMaxScore:[NSNumber numberWithShort:value_]];
}

- (short)primitiveMaxScoreValue {
	NSNumber *result = [self primitiveMaxScore];
	return [result shortValue];
}

- (void)setPrimitiveMaxScoreValue:(short)value_ {
	[self setPrimitiveMaxScore:[NSNumber numberWithShort:value_]];
}





@dynamic shortName;






@dynamic text;






@dynamic key;






@dynamic score;

	
- (NSMutableSet*)scoreSet {
	[self willAccessValueForKey:@"score"];
	NSMutableSet *result = [self mutableSetValueForKey:@"score"];
	[self didAccessValueForKey:@"score"];
	return result;
}
	





@end
