//
//  ViewController.m
//  TableIndexViewOC
//
//  Created by GK on 2017/10/8.
//  Copyright © 2017年 GK. All rights reserved.
//

#import "ViewController.h"
#import "TableIndexView.h"

@interface ViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet TableIndexView *indexView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indexViewHeightConstraint;
@property (nonatomic,strong) NSDictionary *contactsDict;
@property (nonatomic,strong) NSArray *indexes;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.indexView.tableView = self.tableView;
    self.indexView.backgroundColor = [UIColor clearColor];
    self.indexView.indexs = self.indexes;
    [self.indexView setup];
    
    self.indexViewHeightConstraint.constant = (self.indexes.count - 1) * 5 + self.indexes.count * 15;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"plist"];
    self.contactsDict = [NSDictionary dictionaryWithContentsOfFile:path];
    [self.tableView reloadData];
}
- (NSArray *)indexes {
    if (!_indexes) {
        _indexes = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    }
    return _indexes;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.contactsDict.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.indexes[section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *contacts = self.contactsDict[self.indexes[section]];
    return contacts.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSArray *contacts = self.contactsDict[self.indexes[indexPath.section]];
    cell.textLabel.text = contacts[indexPath.row];
    return cell;
}
@end
