//
//  FirstViewController.m
//  running
//
//  Created by xiangyu on 3/19/15.
//  Copyright (c) 2015 MMClub. All rights reserved.
//

#import "FirstViewController.h"
#import "RunningTableCell.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "Constraint.h"
#import "Response.h"
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
    _timesArray = @[@"跑步日期"];
    _dateArray = @[@"时间"];
    
    UINib *nib = [UINib nibWithNibName:@"RunningTableCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"RunningTableCell"];
    [self loadChacheData];

    [self refreshNewData];

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
    
    
    static NSString *simpleTableIdentifier = @"RunningTableCell";
    
    RunningTableCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
   
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    
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

#pragma mark - Network

-(void)refreshNewData{
    
//name:张娟
//SchoolID:B13040505
//version:1
//device:ios
    
    
    NSString *name = @"张娟";
    NSString *schoolId = @"B13040505";
    NSString *version = @"1.0";
    NSString *device = @"ios";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
    
    [SVProgressHUD show];
    
    NSDictionary *parameters = @{@"name": name,
                                 @"SchoolID": schoolId,
                                 @"version": version,
                                 @"device": device};
    [manager POST:kBaseUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        Response *response = [Response responseWithJSONDictionary:responseObject];
        if (response.error == 0){
            NSLog(@"%@", response.rundataArray);
            [SVProgressHUD showSuccessWithStatus:@"获取数据成功"];
            
           
            
            NSMutableArray *dateArray = [[NSMutableArray alloc] initWithObjects: @"跑步日期", nil];
            NSMutableArray *timeArray = [[NSMutableArray alloc] initWithObjects: @"时间", nil];

            for (NSArray *arr in response.rundataArray){
                [dateArray addObject:[arr firstObject]];
                [timeArray addObject:[arr lastObject]];
                
            }
            
            _dateArray = dateArray;
            _timesArray = timeArray;
            [self.tableView reloadData];
            [self cacheArray];
            

        }else {
            [SVProgressHUD showErrorWithStatus:response.message];

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"获取失败"];
    }];
}


-(void)loadChacheData{

    
    _timesArray = [[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"timeArray"]] copy];
    _dateArray = [[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"dateArray"]] copy];
    if (_timesArray){
        [_tableView reloadData];
    }else {
        _timesArray = @[@"跑步日期"];
        _dateArray = @[@"时间"];
    }
    
    
}

-(void)cacheArray{
    [[NSUserDefaults standardUserDefaults] setObject:_timesArray forKey:@"timeArray"];
    [[NSUserDefaults standardUserDefaults] setObject:_dateArray forKey:@"dateArray"];

}




@end
