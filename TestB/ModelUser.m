//
//  ModelUser.m
//  TestB
//
//  Created by Alex on 15.10.15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "ModelUser.h"

@implementation ModelUser

- (id)initWithDictionary:(NSDictionary *)dictionaryFriends
{
    self = [super init];
    
    if (self)
    {
        self.firstName = [dictionaryFriends objectForKey:@"first_name"];
        self.lastName = [dictionaryFriends objectForKey:@"last_name"];
        
        NSString *urlStr = [dictionaryFriends objectForKey:@"photo_50"];
        if (urlStr)
        {
            self.urlImage = [NSURL URLWithString:urlStr];
        }
    }
    return self;
}

@end
