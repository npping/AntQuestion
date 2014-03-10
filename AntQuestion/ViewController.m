//
//  ViewController.m
//  AntQuestion
//
//  Created by ning pingping on 13-4-9.
//
//

#import "ViewController.h"
#import "PlaceModalView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    int gap = 10;
    NSMutableArray *places = [NSMutableArray array];
    
    for (int i = 0; i < 32; ++i)
    {
        int s = i;
        AntDirectionArrow a[5] = {s>>0 & 0X1, s>>1 & 0X1, s>>2 & 0X1, s>>3 & 0X1, s>>4 & 0X1};
        
        PlaceModalView *v = [[PlaceModalView alloc] initWithOriginPoint:(CGPoint){60, gap}];
        [v initAntWithDirections:a];
        [self.view addSubview:v];
        [v setTag:i];
        [places addObject:v];
        [v release];
        
        gap += 10;
    }
    
    [places makeObjectsPerformSelector:@selector(start)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
