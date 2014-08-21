//
//  DetailViewController.m
//  week6
//
//  Created by 김민주 on 2014. 8. 21..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController
{
    NSStream* Astream;
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    //8000port로 접속하기!
    NSString* ip = @"127.0.0.1";
    CFReadStreamRef readStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)ip, 8000, &readStream, nil);
    NSInputStream *inputStream = (__bridge_transfer NSInputStream *)readStream;
    [inputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
}

-(void)stream:(NSStream*)stream handleEvent:(NSStreamEvent)eventCode{
    Astream = stream;
    switch (eventCode) {
        case NSStreamEventOpenCompleted:
            NSLog(@"Server Connected");
            break;
        case NSStreamEventHasBytesAvailable:{
            _imgData = [NSMutableData alloc];
            uint8_t buf[1024];
            NSInteger len = 0;
            len = [(NSInputStream*)stream read:buf maxLength:8];
            NSInteger readLen = atoi((const char*)buf);
            NSLog(@"%d", readLen);
            NSInteger curLen = 0;

            if(len <= 0){
            }else{
                while (curLen < readLen) {
                    len = [(NSInputStream*)stream read:buf maxLength:1024];
                    NSLog(@"curLen: %d, len: %d", curLen, len);
                    [_imgData appendBytes:buf length:len];
                    curLen += len;
                }
                
                if(curLen == readLen){
                    buf[len] = '\0';
                    curLen = 0;
                    UIImage* img = [UIImage imageWithData:_imgData];
                    _img.image = img;
                }
                
                
            }

            
        };
            break;
            default:
            break;
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [Astream close];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
