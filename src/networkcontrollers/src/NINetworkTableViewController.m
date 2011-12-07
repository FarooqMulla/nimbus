//
// Copyright 2011 Jeff Verkoeyen
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "NINetworkTableViewController.h"

#import "NimbusCore+Additions.h"

@interface NINetworkTableViewController()
@property (nonatomic, readwrite, assign) UIActivityIndicatorViewStyle activityIndicatorStyle;
@property (nonatomic, readwrite, assign) UITableViewStyle tableViewStyle;
@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NINetworkTableViewController

@synthesize activityIndicatorStyle = _activityIndicatorStyle;
@synthesize tableViewStyle = _tableViewStyle;
@synthesize activityIndicator = _activityIndicator;
@synthesize tableView = _tableView;
@synthesize clearsSelectionOnViewWillAppear = _clearsSelectionOnViewWillAppear;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  NI_RELEASE_SAFELY(_tableView);
  NI_RELEASE_SAFELY(_activityIndicator);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithTableViewStyle:(UITableViewStyle)tableViewStyle activityIndicatorStyle:(UIActivityIndicatorViewStyle)activityIndicatorStyle {
  if ((self = [super initWithNibName:nil bundle:nil])) {
    self.activityIndicatorStyle = activityIndicatorStyle;
    self.tableViewStyle = tableViewStyle;
    self.clearsSelectionOnViewWillAppear = YES;
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  return [self initWithTableViewStyle:UITableViewStylePlain
               activityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
  [super loadView];

  self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds
                                                 style:self.tableViewStyle] autorelease];
  self.tableView.autoresizingMask = UIViewAutoresizingFlexibleAllDimensions;
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.view addSubview:self.tableView];

  self.activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorStyle] autorelease];
  self.activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleAllMargins;
  [self.activityIndicator sizeToFit];
  [self.activityIndicator centerWithin:self.view];
  [self.view addSubview:self.activityIndicator];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
  self.tableView = nil;

  [super viewDidUnload];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  if (self.clearsSelectionOnViewWillAppear) {
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow
                                  animated:animated];
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 0;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Methods


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setIsLoading:(BOOL)isLoading {
  self.tableView.hidden = isLoading;

  if (isLoading) {
    [self.activityIndicator startAnimating];

  } else {
    [self.activityIndicator stopAnimating];
  }
}

@end
