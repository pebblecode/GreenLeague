// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Score.m instead.

#import "_Score.h"

@implementation ScoreID
@end

@implementation _Score

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Score" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Score";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Score" inManagedObjectContext:moc_];
}

- (ScoreID*)objectID {
	return (ScoreID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic value;






@dynamic key;

	

@dynamic university;

	





@end
