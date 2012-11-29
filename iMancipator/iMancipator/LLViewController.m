//
//  LLViewController.m
//  iMancipator
//
//  Created by Mason on 11/14/12.
//  Copyright (c) 2012 A-Team. All rights reserved.
//

#import "LLViewController.h"
#import "LLTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface LLViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation LLViewController {
    NSArray* data;
    NSArray* selected;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    data = @[
      @{
          @"image" : @"http://upload.wikimedia.org/wikipedia/commons/thumb/8/86/Joseph_Smith,_Jr._portrait_owned_by_Joseph_Smith_III.jpg/230px-Joseph_Smith,_Jr._portrait_owned_by_Joseph_Smith_III.jpg",
          @"name"  : @"Joe Smith",
          @"activity"  : @"Running",
          @"distance"  : @"400 meters"
      },
      @{
          @"image" : @"http://3.bp.blogspot.com/-1RCu99L03jQ/TjbNaa5Iu9I/AAAAAAAACU4/4oqTEbGmdFA/s1600/jane+doe.jpg",
          @"name"  : @"Jane Doe",
          @"activity"  : @"Frisbee Golf",
          @"distance"  : @"0.6 Miles"
      },
      @{
          @"image" : @"http://www.anarchistecouronne.com/2100science/2220physicists/images/paul_dirac3.jpg",
          @"name"  : @"Jean Paul Dirac",
          @"activity"  : @"Tennis",
          @"distance"  : @"1 Mile"
       },
       @{
          @"image" : @"http://a3.ec-images.myspacecdn.com/profile01/129/54b4bc9e460346c09b69d0753e35ef22/t.jpg",
          @"name"  : @"Barbara Thurston",
          @"activity"  : @"Laser Tag",
          @"distance"  : @"2.4 Miles"
       },
       @{
          @"image" : @"http://www.hollywoodinterrupted.com/wp-content/uploads/2010/04/carrey-banner.jpg",
          @"name"  : @"Crazy Jim McGee",
          @"activity"  : @"Chasing people around with a stick",
          @"distance"  : @"7 Miles"
        },
    ];
    
    [self relocate];    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.found) {
        [self performSelector:@selector(relocate) withObject:self afterDelay:0.5f];
    }
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    NSLog(@"will region change");
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"region change");
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView {
    NSLog(@"start loading");
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    NSLog(@"finished loading");
}

- (void) relocate {
    MKUserLocation *userLocation = self.map.userLocation;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (userLocation.location.coordinate, 1000, 1000);
    [self.map setRegion:region animated:!self.found];
    
    if (self.found) {
        MKPointAnnotation* point;
        point = [[MKPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude + 0.001, userLocation.location.coordinate.longitude + 0.005);
        [self.map addAnnotation:point];

        point = [[MKPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude - 0.0001, userLocation.location.coordinate.longitude + 0.001);
        [self.map addAnnotation:point];
        
        point = [[MKPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude + 0.001, userLocation.location.coordinate.longitude);
        [self.map addAnnotation:point];
        
        point = [[MKPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude - 0.003, userLocation.location.coordinate.longitude - 0.003);
        [self.map addAnnotation:point];
        
        point = [[MKPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude + 0.0005, userLocation.location.coordinate.longitude + 0.002);
        [self.map addAnnotation:point];
    } else {
        
    }

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"mapAnnotation"];
    
    if (pin) {
        [pin prepareForReuse];
    } else {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"mapAnnotation"];
    }
    
//    pin.canShowCallout = YES;
//    pin.animatesDrop = YES;
    pin.pinColor = [annotation isKindOfClass:[MKUserLocation class]] ? MKPinAnnotationColorGreen : MKPinAnnotationColorPurple;
    
    UILabel* label = [[UILabel alloc] init];
    label.text = @"hi there";
    pin.leftCalloutAccessoryView = label;
    
    
    return pin;
}


- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView {
    NSLog(@"will loc");
}
- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView {
    NSLog(@"did stop loc");
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    NSLog(@"did update u");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Activity Cell"];
    if (!cell) {
        cell = [[LLTableViewCell alloc] init];
    }
    cell.name.text = [[data objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.activity.text = [[data objectAtIndex:indexPath.row] objectForKey:@"activity"];
    cell.distance.text = [[data objectAtIndex:indexPath.row] objectForKey:@"distance"];
    CALayer* layer = cell.image.layer;
    [layer setBorderWidth:1.0f];
    [layer setBorderColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.2f].CGColor];
    dispatch_async(dispatch_get_main_queue(), ^{
        cell.image.image = [UIImage imageWithData:
                            [NSData dataWithContentsOfURL:
                             [NSURL URLWithString:[[data objectAtIndex:indexPath.row] objectForKey:@"image"]]]];        
    });
    return cell;
}


@end
