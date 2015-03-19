//
//  AboutViewController.m
//  running
//
//  Created by xiangyu on 3/19/15.
//  Copyright (c) 2015 MMClub. All rights reserved.
//

#import "AboutViewController.h"
#import "SNS.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)shareAppButtonClick:(UIButton *)sender {
    [SNS shareWithURLString:@"http://www.nupter.org" title:@"查询早跑App"];
}

- (IBAction)tucaoButtonClick:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms:13260715825"]];
}

- (IBAction)visitWebsiteButtonClick:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.nupter.org"]];
}

@end
