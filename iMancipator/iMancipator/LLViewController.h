//
//  LLViewController.h
//  iMancipator
//
//  Created by Mason on 11/14/12.
//  Copyright (c) 2012 A-Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LLViewController : UIViewController<MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL found;

@end
