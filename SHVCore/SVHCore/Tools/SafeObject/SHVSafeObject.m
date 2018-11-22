//
//  SafeObject.m
//  Acquirer
//
//  Created by chinaPnr on 13-10-24.
//  Copyright (c) 2013年 chinaPnr. All rights reserved.
//

#import "SHVSafeObject.h"

// 类型识别（将NSNull类型转化成nil、number类型转成string）
NSString *NOEESafeString(id value) {
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        return [value description];
    }
    return nil;
}

// 过滤NSNull
id  NOEESafeValue(id value) {
    if ([value isKindOfClass:[NSNull class]]){
        return nil;
    }
    return value;
}

@implementation NSArray(SHVSafeObject)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if(self.count == 0) {
        //printf("\n--- array have no objects ---\n");
        return (nil);
    }
    if(index > MAX(self.count - 1, 0)) {
        //printf("\n--- index:%li out of array range ---\n", (long)index);
        return (nil);
    }
    return ([self objectAtIndex:index]);
}

- (NSUInteger)safeIndexOfObject:(id)object{
    if (object) {
        NSUInteger index = [self indexOfObject:object];
        if (index>self.count -1) {
            return 0;
        }
        return index;
    }
    return 0;
}

@end

//-----------------------------------------------------
//-----------------------------------------------------

@implementation NSMutableArray(SHVSafeObject)

- (void)safeAddObject:(id)anObject
{
    if(!anObject) {
        NSLog(@"--- addObject:object must not nil ---");
        return;
    }
    [self addObject:anObject];
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index
{
    if(index > MAX(self.count - 1, 0)) {
        NSLog(@"--- insertObject:atIndex: out of array range ---");
        return;
    }
    if(!anObject) {
        NSLog(@"--- insertObject:atIndex: object must not nil ---");
        return;
    }
    [self insertObject:anObject atIndex:index];
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index
{
    if(index > MAX(self.count - 1, 0)) {
        NSLog(@"--- removeObjectAtIndex: out of array range ---");
        return;
    }
    [self removeObjectAtIndex:index];
}

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if(index > MAX(self.count - 1, 0)) {
        NSLog(@"--- replaceObjectAtIndex:atIndex: out of array range ---");
        return;
    }
    if(!anObject) {
        NSLog(@"--- replaceObjectAtIndex:atIndex: object must not nil ---");
        return;
    }
    [self replaceObjectAtIndex:index withObject:anObject];
}

@end


#define checkNull(__X__) (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]

@implementation NSDictionary(SHVSafeObject)

- (NSString *)stringObjectForKey:(id <NSCopying>)key {
    id ob = [self objectForKey:key];
    if(ob == [NSNull null] || ob == nil) {
        return (@"");
    }
    if([ob isKindOfClass:[NSString class]]) {
        return (ob);
    }
    return ([NSString stringWithFormat:@"%@", ob]);
}

- (id)safeJsonObjectForKey:(id <NSCopying>)key {
    id ob = [self objectForKey:key];
    if(ob == [NSNull null]) {
        return (nil);
    }
    if ([ob isKindOfClass:[NSNumber class]]) {
        return [(NSNumber*)ob stringValue];
    }
    return (ob);
}

@end


@implementation NSMutableDictionary(SHVSafeObject)

- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if(!aKey || !anObject) {
        NSLog(@"--- setObject:forKey: key must not nil");
    } else {
        [self setObject:anObject forKey:aKey];
    }
}

@end

