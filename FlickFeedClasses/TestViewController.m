//
//  TestViewController.m
//  
//
//  Created by Amro Munajjed on 12/20/13.

//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController
@synthesize responseData , imgT;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"viewdidload");
    self.responseData = [NSMutableData data];

//    NSURLRequest *request = [NSURLRequest requestWithURL:
//                             [NSURL URLWithString:@"http://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=84f9cf09bcdb6d792b986bf4399e8cc9&per_page=10&format=json&nojsoncallback=1&auth_token=72157638855819046-eea91007b5002ed5&api_sig=177e7c0011d80c816a057c71c271ab3d"]];
//    [[NSURLConnection alloc] initWithRequest:request delegate:self];

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
  //  NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    // show all values
    for(id key in res) {
        
        id value = [res objectForKey:key];
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        
        NSLog(@"key: %@", keyAsString);
        NSLog(@"value: %@", valueAsString);
    }
    
    
    NSMutableArray *photoURLs = [[NSMutableArray alloc]init];
 
    NSArray *photos = [[res objectForKey:@"photos"] objectForKey:@"photo"];
    
    for (NSDictionary *photo in photos) {
        // 3.a Get title for e/ photo
//NSString *title = [photo objectForKey:@"title"];
       // [photoNames addObject:(title.length > 0 ? title : @"Untitled")];
        // 3.b Construct URL for e/ photo.
        NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
       // NSLog((@"%@", photoURLString));
        [photoURLs addObject:[NSURL URLWithString:photoURLString]];
    }
    
    
   // NSDictionary *DataDict = photosArray[@"photo"];
    // NSArray *photosArray1 = photosArray[@"photo"];
  //  NSDictionary *DataDict = [photosArray objectAtIndex:3];
  //  NSString * trst = @"fasdf";
    // NSArray *DataDict = photosArray[3][@"photo"];
//    
//    NSString * farm = photosArray[0][@"farm"];
//    NSString * _id = photosArray[0][@"id"];
//    NSString * owner = photosArray[0][@"owner"];
//    NSString * secret = photosArray[0][@"secret"];
//    NSString * server = photosArray[0][@"server"];
//    NSString *photoUrl = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@.jpg" ,farm , server, _id , secret ];
//    NSLog(@"%@" , photoUrl);
    
   // NSURL * imageURL = [NSURL URLWithString:[photoURLs objectAtIndex:0]];
    NSData * imageData = [NSData dataWithContentsOfURL:[photoURLs objectAtIndex:0]];
    UIImage * image = [UIImage imageWithData:imageData];
    
    [imgT setImage:image];
    
//    // extract specific value...
//    NSArray *results = [res objectForKey:@"results"];
//    
//    for (NSDictionary *result in results) {
//        NSString *icon = [result objectForKey:@"icon"];
//        NSLog(@"icon: %@", icon);
//    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
