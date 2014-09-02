//
//  ViewController.m
//  week9
//
//  Created by nhn on 2014. 9. 2..
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _progressBar.progress = 0 ;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstBtnClick:(id)sender {
//    mission1
    UIColor *originColor = [sender backgroundColor];
    CGRect originFrame = [sender frame];
    NSString *originTitle = [sender titleLabel].text;
    float originAlpha = [sender alpha];
    
    [UIView animateWithDuration:2.0 animations:^{
        
        [sender setBackgroundColor:[UIColor yellowColor]];
        [sender setFrame: CGRectMake(100, 300, 200, 100)];
        [sender setTitle:@"bookfile LOAD" forState:UIControlStateNormal];
        [sender setAlpha:0.35];
        
    } completion:^(BOOL finished){
        [sender setBackgroundColor: originColor];
        [sender setFrame:originFrame];
        [sender setTitle:originTitle forState:UIControlStateNormal];
        [sender setAlpha:originAlpha];
    }];
    
//    mission2
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(aQueue, ^{
        [self workingProgress];
    });
}

-(void)workingProgress {
    NSString *bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                             pathForResource:@"bookfile" ofType:@".txt"]  encoding:NSUTF8StringEncoding error:nil];
    int length = bookfile.length;
    int spaceCount = 0;
    float progress = 0;
    unichar aChar;
    
    for (int nLoop=0; nLoop<length; nLoop++) {
        aChar = [bookfile characterAtIndex:nLoop];
        if (aChar==' ') spaceCount++;
        progress = (float)nLoop / (float)length;
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_sync(mainQ, ^{
            _progressBar.progress = progress;
        });
        
    }
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [[[UIAlertView alloc] initWithTitle:@"완료" message:[NSString stringWithFormat:@"찾았다 %d개",spaceCount] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    });
    
}

@end
