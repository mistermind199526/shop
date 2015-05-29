//
//  BSItemsViewController.m
//  test
//
//  Created by Binasystems on 5/5/15.
//  Copyright (c) 2015 Binasystems. All rights reserved.
//

#import "BSItemsViewController.h"
#import "BSTableViewCell.h"
#import "BSCartViewController.h"
#import "BSStoreModel.h"
#import "BSItemModel.h"

@interface BSItemsViewController () <BSTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) BSStoreModel *storeModel;

@end

@implementation BSItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Produse";

    [self.tableView registerNib:[UINib nibWithNibName:@"BSTableViewCell" bundle:nil] forCellReuseIdentifier:@"id"];
//    self.tableView.backgroundColor = [UIColor redColor];
    
    NSArray *arr = self.tabBarController.viewControllers;
    UIViewController *vc = arr[1];
    if ([vc isKindOfClass:UINavigationController.class]) {
        NSArray *arr2 = ((UINavigationController *)vc).viewControllers;
        UIViewController *c = arr2.firstObject;
        if ([c isKindOfClass:BSCartViewController.class]) {
            self.delegate = (BSCartViewController *)c;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 126;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.storeModel.itemsArray.count;
}
//crearea celulelor dupa array
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSTableViewCell *cell = (BSTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"id"];
    cell.delegate = self;
    
//    BSItemModel *item = (BSItemModel *)self.storeModel.itemsArray[indexPath.row];
    cell.ItemImageView.image = [UIImage imageNamed:@"VvAySQ3mugI.jpg"];

    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

 - (void)tableViewCellDidTapBuyButton:(BSTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if ([self.delegate respondsToSelector:@selector(viewController:didPickItem:)]) {
        [self.delegate viewController:self didPickItem:self.storeModel.itemsArray[indexPath.row]];
    }
}

- (BSStoreModel *)storeModel
{
    if (!_storeModel) {
        _storeModel = [BSStoreModel new];
    }
    return _storeModel;
}

@end
