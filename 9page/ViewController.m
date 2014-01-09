//
//  ViewController.m
//  9page
//
//  Created by SDT-1 on 2014. 1. 9..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "Model.h"
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UITextField *productNameField;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}
- (IBAction)addNewProduct:(id)sender
{
    // 모델에게 제품 추가하도록
    Model *model = [Model sharedModel];
    NSString *productName = self.productNameField.text;
    [model addProduct:productName];
    
    // 뷰에 반영
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([model numberOfProducts]-1) inSection:0];
    NSArray *newRow = [NSArray arrayWithObject:indexPath];
    [self.table insertRowsAtIndexPaths:newRow withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // 텍스트 필드 정리
    [self.productNameField setText:@""];
    [self.productNameField resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 모델에게 제품 삭제
    [[Model sharedModel]removeProductAt:indexPath.row];
    // 뷰에 반영
    NSArray *rowForDelete = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:rowForDelete withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[Model sharedModel] numberOfProducts];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID"];
    
    Model *model = [Model sharedModel];
    cell.textLabel.text = [model productAt:indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
