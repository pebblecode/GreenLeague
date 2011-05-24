// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to University.m instead.

#import "_University.h"

@implementation UniversityID
@end

@implementation _University

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"University" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"University";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"University" inManagedObjectContext:moc_];
}

- (UniversityID*)objectID {
	return (UniversityID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"rankValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rank"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"rankLastYearValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rankLastYear"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic rank;



- (short)rankValue {
	NSNumber *result = [self rank];
	return [result shortValue];
}

- (void)setRankValue:(short)value_ {
	[self setRank:[NSNumber numberWithShort:value_]];
}

- (short)primitiveRankValue {
	NSNumber *result = [self primitiveRank];
	return [result shortValue];
}

- (void)setPrimitiveRankValue:(short)value_ {
	[self setPrimitiveRank:[NSNumber numberWithShort:value_]];
}





@dynamic awardClass;






@dynamic name;






@dynamic rankLastYear;



- (short)rankLastYearValue {
	NSNumber *result = [self rankLastYear];
	return [result shortValue];
}

- (void)setRankLastYearValue:(short)value_ {
	[self setRankLastYear:[NSNumber numberWithShort:value_]];
}

- (short)primitiveRankLastYearValue {
	NSNumber *result = [self primitiveRankLastYear];
	return [result shortValue];
}

- (void)setPrimitiveRankLastYearValue:(short)value_ {
	[self setPrimitiveRankLastYear:[NSNumber numberWithShort:value_]];
}





@dynamic totalScore;






@dynamic sortName;






@dynamic scores;

	
- (NSMutableSet*)scoresSet {
	[self willAccessValueForKey:@"scores"];
	NSMutableSet *result = [self mutableSetValueForKey:@"scores"];
	[self didAccessValueForKey:@"scores"];
	return result;
}
	





@end
