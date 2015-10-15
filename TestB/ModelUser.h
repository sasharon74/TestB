//
//  ModelUser.h
//  TestB
//
//  Created by Alex on 15.10.15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelUser : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSURL *urlImage;

- (id)initWithDictionary:(NSDictionary *)dictionaryFriends;

@end
