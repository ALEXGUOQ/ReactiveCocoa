//
//  RACReduceSpec.m
//  ReactiveCocoa
//
//  Created by Dave Lee on 4/7/14.
//  Copyright (c) 2014 GitHub, Inc. All rights reserved.
//

#import "RACReduce.h"

SpecBegin(RACReduce)

it(@"should invoke the block with the given arguments", ^{
	__block NSString *stringArg;
	__block NSNumber *numberArg;
	id (^block)(NSString *, NSNumber *) = ^ id (NSString *string, NSNumber *number) {
		stringArg = string;
		numberArg = number;
		return nil;
	};

	RACReduce(block)(RACTuplePack(@"hi", @1));
	expect(stringArg).to.equal(@"hi");
	expect(numberArg).to.equal(@1);
});

it(@"should return the result of the block invocation", ^{
	NSString * (^block)(NSString *) = ^(NSString *string) {
		return string.uppercaseString;
	};

	NSString *result = RACReduce(block)(RACTuplePack(@"hi"));
	expect(result).to.equal(@"HI");
});

it(@"should return the BOOL result of the block invocation", ^{
	BOOL (^block)(NSString *) = ^ BOOL (NSString *string) {
		return string.length == 0;
	};

	BOOL result = RACReduce(block)(RACTuplePack(@"hi"));
	expect(result).to.equal(NO);
});

it(@"should pass RACTupleNils as nil", ^{
	__block id arg;
	id (^block)(id) = ^ id (id obj) {
		arg = obj;
		return nil;
	};

	RACReduce(block)(RACTuplePack(nil));
	expect(arg).to.beNil();
});

SpecEnd