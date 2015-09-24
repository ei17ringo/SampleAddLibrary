//
//  ViewController.m
//  SampleAddLibrary
//
//  Created by Eriko Ichinohe on 2015/02/03.
//  Copyright (c) 2015年 Eriko Ichinohe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //MapViewオブジェクトを生成
    MKMapView *mapView = [[MKMapView alloc] init];
    
    mapView.delegate = self;
    
    //大きさ、位置を決定
    mapView.frame = CGRectMake(0,20,320,460);
    
    //表示位置を設定
    CLLocationCoordinate2D co;
    
    //アヤラの位置を設定
    co.latitude = 10.317347;        //緯度
    co.longitude = 123.905759;      //経度
    
    [mapView setCenterCoordinate:co];
    
    //縮尺を設定
    MKCoordinateRegion cr = mapView.region;
    
    cr.span.latitudeDelta = 0.05;   //数字を小さくすると、詳細な地図になる
    cr.span.longitudeDelta = 0.05;
    
    cr.center = co;
    
    [mapView setRegion:cr];
    
    //地図の表示種類設定
    mapView.mapType = MKMapTypeStandard;
    
    //現在地を表示
    mapView.showsUserLocation = YES;
    
    //ピンを立てる
    //アヤラ
    //    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    //    pin.coordinate = CLLocationCoordinate2DMake(co.latitude, co.longitude);
    //    pin.title = @"アヤラ";
    //    pin.subtitle = @"biggest Shopping Mall in Cebu.";
    //
    
    JPSThumbnail *thumbnail = [[JPSThumbnail alloc] init];
    thumbnail.image = [UIImage imageNamed:@"ayara.jpg"];
    thumbnail.title = @"アヤラ";
    thumbnail.subtitle = @"biggest Shopping Mall in Cebu.";
    thumbnail.coordinate = CLLocationCoordinate2DMake(co.latitude, co.longitude);
    
    [mapView addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:thumbnail]];
    
    //表示するためにViewに追加
    [self.view addSubview:mapView];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
