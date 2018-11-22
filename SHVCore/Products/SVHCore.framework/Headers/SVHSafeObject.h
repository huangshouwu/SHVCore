//
//  SafeObject.h
//  Acquirer
//
//  Created by chinaPnr on 13-10-24.
//  Copyright (c) 2013年 chinaPnr. All rights reserved.
//

#import <Foundation/Foundation.h>

//-----------------------------------------------------
//-----------------------------------------------------

// 类型识别（将NSNull类型转化成nil、number类型转成string）
NSString *NOEESafeString(id value);

// 过滤NSNull
id  NOEESafeValue(id value);

@interface NSArray(SVHSafeObject)

//NSArray objectAtIndex:的安全方法，避免数组越界造成的崩溃
- (id)safeObjectAtIndex:(NSUInteger)index;

- (NSUInteger)safeIndexOfObject:(id)object;

@end

//-----------------------------------------------------
//-----------------------------------------------------

@interface NSMutableArray(SVHSafeObject)

//NSMutableArray addObject:的安全方法，避免anObject为nil时造成的崩溃
- (void)safeAddObject:(id)anObject;

//NSMutableArray insertObject:atIndex:的安全方法，避免index越界以及anObject为nil时造成的崩溃
- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index;

//NSMutableArray removeObjectAtIndex:的安全方法，避免数组越界造成的崩溃
- (void)safeRemoveObjectAtIndex:(NSUInteger)index;

//NSMutableArray replaceObjectAtIndex:withObject:的安全方法，避免index越界以及anObject为nil时造成的崩溃
- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end

//-----------------------------------------------------
//-----------------------------------------------------

@interface NSDictionary(SVHSafeObject)

//空值返回@""
- (NSString *)stringObjectForKey:(id <NSCopying>)key;

//空值返回nil
- (id)safeJsonObjectForKey:(id <NSCopying>)key;

@end

//-----------------------------------------------------
//-----------------------------------------------------

@interface NSMutableDictionary(SVHSafeObject)

//NSMutableDictionary setObject:forKey:的安全方法，避免anObject或aKey为nil时造成的崩溃
- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end

//-----------------------------------------------------
//-----------------------------------------------------
