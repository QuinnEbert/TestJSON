//
//  TestJSONViewController.h
//  TestJSON
//
//  Created by Quinn Ebert on 3/19/14.
//  Copyright (c) 2014 Quinn Ebert. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HOST_URL @"http://url.to/path_to/my_JSON.php"

@interface TestJSONViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *rootItems;
    int rootItemsCount;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic,retain) NSMutableArray *rootItems;
@property (nonatomic) int rootItemsCount;

@end
