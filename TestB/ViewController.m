//
//  ViewController.m
//  TestB
//
//  Created by Alex on 15.10.15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "ViewController.h"
#import "ClientManager.h"
#import "ModelUser.h"
#import "UIImageView+AFNetworking.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *arrayFriends;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayFriends = [[NSMutableArray alloc]init];
    [self getFriends];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayFriends count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row == [self.arrayFriends count])
    {
        cell.textLabel.text = @"Загрузить еще...";
        cell.imageView.image = nil;
    }
    else
    {
        ModelUser *dictionary = [self.arrayFriends objectAtIndex:indexPath.row];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:dictionary.urlImage];
        
        __weak UITableViewCell *weakCell = cell;
        
        cell.imageView.image = nil;
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",dictionary.firstName, dictionary.lastName];
        [cell.imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            
            weakCell.imageView.image = image;
            [weakCell layoutSubviews];
            
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
            
        }];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row  == [self.arrayFriends count])
    {
        [self getFriends];
    }
}

#pragma mark api methods

- (void) getFriends
{
    [[ClientManager sharedManager]getFriendsWithOffset:[self.arrayFriends count] withCount:20 onSuccess:^(NSArray *arrayFriends) {
        
        [self.arrayFriends addObjectsFromArray:arrayFriends];
        
        NSMutableArray *arrayNewFriends = [NSMutableArray array];
        for (int i = (int)[self.arrayFriends count] - (int)[arrayFriends count]; i < [self.arrayFriends count]; i++)
        {
            [arrayNewFriends addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:arrayNewFriends withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
        
    } onFailure:^(NSError *error, NSInteger code) {
        
        NSLog(@"%@", [error localizedDescription]);
    }];
}

@end
