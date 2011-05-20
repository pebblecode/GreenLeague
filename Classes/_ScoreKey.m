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
	

	return keyPaths;
}




@dynamic key;






@dynamic text;






@dynamic score;

	
- (NSMutableSet*)scoreSet {
	[self willAccessValueForKey:@"score"];
	NSMutableSet *result = [self mutableSetValueForKey:@"score"];
	[self didAccessValueForKey:@"score"];
	return result;
}
	





@end
