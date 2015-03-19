//
//  FirstViewController.m
//  running
//
//  Created by xiangyu on 3/19/15.
//  Copyright (c) 2015 MMClub. All rights reserved.
//

#import "FirstViewController.h"
#import "RunningTableCell.h"

@interface FirstViewController ()

@property NSArray *timesArray;
@property NSArray *dateArray;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _timesArray = @[@"", @"hu"];
    _dateArray = @[@"", @"hu"];
    [_tableView registerClass: [RunningTableCell class] forCellReuseIdentifier:@"RunningTableCell"];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [_timesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    
    cell.textLabel.text = [_dateArray objectAtIndex:indexPath.row];
    return cell;
    
    
//    RunningTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RunningTableCell" forIndexPath:indexPath];
//
//    
//    
//    if (cell == nil)
//    {
//        
//        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"RunningTableCell" owner:self options:nil];
//        cell = (RunningTableCell *)[nibArray objectAtIndex:0];
//    }
//    
//    [self configureCell:cell forRowAtIndexPath:indexPath];
//
//    return cell;
}

- (void)configureCell:(RunningTableCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.dateLabel.text = [self.dateArray objectAtIndex:indexPath.row];
    cell.timeLabel.text = [self.timesArray objectAtIndex:indexPath.row];
}




@end
