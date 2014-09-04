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
    
//    NSLog(@"%d", [self countOfSubstring:@" " atContents:bookfile]);
//    NSLog(@"%d", [self countOfSubstring:@"시장" atContents:bookfile]);
//    NSLog(@"%d", [self countOfSubstring:@"자본주의" atContents:bookfile]);
//    NSLog(@"%d", [self countOfSubstring:@"중상주의" atContents:bookfile]);
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

///// word count method
-(NSUInteger)countOfSubstring:(NSString*)substring atContents:(NSString*)contents{

    if(substring.length == 0 || contents.length == 0) return 0;
    
    NSUInteger words = 0;
    
    int lastcheck = contents.length - substring.length;
    int curcheck = 0;
    
    while (curcheck <= lastcheck){
        NSRange areaStr;
        areaStr.location = curcheck;
        areaStr.length = substring.length;
        
        if([[contents substringWithRange:areaStr] isEqualToString:substring]) words++;
        
        curcheck++;
    }
    
    return words;
}
- (IBAction)findLessAndMoreText:(id)sender {
    NSString *bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                             pathForResource:@"bookfile" ofType:@".txt"]  encoding:NSUTF8StringEncoding error:nil];
    
    NSString *urlString= @"http://125.209.194.123/wordlist.php";
    NSURL *url=[[NSURL alloc]initWithString:urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSError *err = nil;
    NSArray* wordArray = (NSArray*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves|| NSJSONReadingMutableContainers error:&err];
    
//    [self findLessAndManyWord:wordArray withContent:bookfile];
    [self findAsyncLessAndManyWord:wordArray withContent:bookfile];
    
}

-(void)findAsyncLessAndManyWord: (NSArray*)wordArray withContent:(NSString*)bookfile{
    double startTime = CACurrentMediaTime();
    NSMutableArray* wordsCount = [[NSMutableArray alloc] init];
    NSMutableArray* wordsArray = [[NSMutableArray alloc] init];
    
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //count해서 넣음
    for(int i = 0 ; i < wordArray.count; i++){
        dispatch_async(aQueue, ^{
            [wordsCount addObject:[NSNumber numberWithUnsignedInteger:[self countOfSubstring:wordArray[i] atContents:bookfile]]];
            [wordsArray addObject:wordArray[i]];
        });
    }
    
    dispatch_async(aQueue, ^{
        //비교해서 찾음
        NSString* alot;
        int moreCount = 0;
        NSString* less;
        int lessCount = 10000;
        
        for(int i = 0; i < wordsCount.count; i++){
            if([wordsCount[i] intValue] > moreCount){
                moreCount = [wordsCount[i] intValue];
                alot = wordsArray[i];
            }
            
            if([wordsCount[i] intValue] < lessCount){
                lessCount = [wordsCount[i] intValue];
                less = wordsArray[i];
            }
        }
        
        double endTime = CACurrentMediaTime();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"완료" message:[NSString stringWithFormat:@"적은 단어 %@: %d개\n 많은 단어 %@: %d개 \n 소요시간: %f", less, lessCount, alot, moreCount, endTime-startTime] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
        });
    });
    
    
//    NSLog(@"%d", wordsCount.count);
//    
//    //들어갔나 확인
//    for(int i = 0; i < wordsCount.count; i++){
//        NSLog(@"%d", [wordsCount[i] intValue]);
//    }
    
   }

-(void)findLessAndManyWord: (NSArray*)wordArray withContent:(NSString*)bookfile{
    double startTime = CACurrentMediaTime();
    NSString* alot;
    int moreCount = 0;
    NSString* less;
    int lessCount = 10000;
    
    for(int i = 0 ; i < wordArray.count; i++){
        int count = [self countOfSubstring:wordArray[i] atContents:bookfile];
        if(count > moreCount){
            moreCount = count;
            alot = wordArray[i];
        }
        if(count < lessCount){
            lessCount = count;
            less = wordArray[i];
        }
    }
    
    double endTime = CACurrentMediaTime();
    
    [[[UIAlertView alloc] initWithTitle:@"완료" message:[NSString stringWithFormat:@"적은 단어 %@: %d개\n 많은 단어 %@: %d개 \n 소요시간: %f", less, lessCount, alot, moreCount, endTime-startTime] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
}

@end
