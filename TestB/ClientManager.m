//
//  ClientManager.m
//  TestB
//
//  Created by Alex on 15.10.15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "ClientManager.h"
#import "AFNetworking.h"
#import "ModelUser.h"

const NSString *idUser = @"11438266";

@interface ClientManager ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestOperationManager;

@end

@implementation ClientManager

+ (ClientManager *) sharedManager
{
    static ClientManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[ClientManager alloc]init];
        
    });
    
    return manager;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"https://api.vk.com/method/"]];
        
    }
    return self;
}

- (void)getFriendsWithOffset:(NSInteger) offset withCount:(NSInteger)count onSuccess:(void(^)(NSArray * arrayFriends)) success onFailure:(void(^)(NSError *error, NSInteger code)) failure
{
    NSDictionary *dictionaryParametrs = [NSDictionary dictionaryWithObjectsAndKeys:idUser, @"user_id", @"name", @"order", @(count), @"count", @(offset), @"offset", @"photo_50", @"fields", @"nom", @"name_case", nil];
    
    [self.requestOperationManager GET:@"friends.get" parameters:dictionaryParametrs success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *friendsArray = [responseObject objectForKey:@"response"];
        
        NSMutableArray *arrayObject = [NSMutableArray array];
        for (NSDictionary *dict in friendsArray)
        {
            ModelUser *user = [[ModelUser alloc]initWithDictionary:dict];
            [arrayObject addObject:user];
        }
        
        if (success)
        {
            success(arrayObject);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
       
        NSLog(@"Error: %@", error);
        
    }];
}

@end
