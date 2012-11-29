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
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.found) {
        [self performSelector:@selector(relocate) withObject:self afterDelay:0.1f];
    } else {
        [self relocate];
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
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (userLocation.location.coordinate, 3000, 3000);
    [self.map setRegion:region animated:!self.found];
    
    if (self.found) {
        NSLog(@"xx");
        [data enumerateObjectsUsingBlock:^(NSDictionary* person, NSUInteger idx, BOOL *stop) {
            MKPointAnnotation* point = [[MKPointAnnotation alloc] init];
            point.title = [person objectForKey:@"name"];
            point.subtitle = [person objectForKey:@"activity"];
            float n = arc4random_uniform(100) % 2 == 0 ? 1 : -1;
            float m = arc4random_uniform(100) % 3 == 0 ? 0.003f : 0.001f;
            float o = arc4random_uniform(100) % 5 == 0 ? -0.003f : 0.002f;
            
            float rdx1 = (idx * m + o) * n;
            
            n = arc4random_uniform(100) % 2 == 0 ? 1 : -1;
            m = arc4random_uniform(100) % 3 == 0 ? 0.003f : 0.001f;
            o = arc4random_uniform(100) % 5 == 0 ? -0.003f : 0.002f;
            float rdx2 = (idx * m + o) * n;

            point.coordinate = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude - rdx1, userLocation.location.coordinate.longitude + rdx2);
            [self.map addAnnotation:point];
        }];
    }

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"mapAnnotation"];
    
    if (pin) {
        [pin prepareForReuse];
    } else {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"mapAnnotation"];
    }
    
    pin.canShowCallout = YES;
    pin.animatesDrop = YES;
    pin.pinColor = [annotation isKindOfClass:[MKUserLocation class]] ? MKPinAnnotationColorGreen : MKPinAnnotationColorPurple;    
    
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
    [cell.spinner startAnimating];
    dispatch_async(dispatch_get_main_queue(), ^{
        cell.image.image = [UIImage imageWithData:
                            [NSData dataWithContentsOfURL:
                             [NSURL URLWithString:[[data objectAtIndex:indexPath.row] objectForKey:@"image"]]]];        
        [cell.spinner stopAnimating];
    });
    return cell;
}


@end
