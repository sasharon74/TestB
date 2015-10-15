//
//  ClientManager.h
//  TestB
//
//  Created by Alex on 15.10.15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClientManager : NSObject

+ (ClientManager *) sharedManager;

- (void)getFriendsWithOffset:(NSInteger) offset withCount:(NSInteger)count onSuccess:(void(^)(NSArray * arrayFriends)) success onFailure:(void(^)(NSError *error, NSInteger code)) failure;

@end
