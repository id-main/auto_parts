//
//  WebViewController.m
//  Pieseauto
//
//  Created by Ioan Ungureanu on 29/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import "utile.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "WebViewController.h"
#import "CellMasinileMeleRow.h"
#import "TutorialHomeViewController.h"
#import <CoreText/CoreText.h>
#import "choseLoginview.h"
#import "ContulMeuViewController.h"
#import "DataMasterProcessor.h"
#import "ListaMasiniUserViewController.h"
#import "CerereNouaViewController.h"
#import "butoncustomback.h"

@interface WebViewController(){
 
}
@end

@implementation WebViewController
@synthesize  mWebView,urlPiesesimilare,dinhelp;

-(butoncustomback *) backbtncustom {
    butoncustomback *backcustombutton =[butoncustomback  buttonWithType:UIButtonTypeCustom];
    [backcustombutton setFrame:CGRectMake(0.0f, 14.0f, 80.0f, 25.0f)];
    [backcustombutton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    UIImage *image3 = [UIImage imageNamed:@"Back-96.png"];
    UIImageView *btnimg= [[UIImageView alloc]init];
    CGRect frameimg = CGRectMake(-15, 2, 16, 16);
    btnimg.frame = frameimg;
    btnimg.image = image3;
    btnimg.contentMode =UIViewContentModeScaleAspectFit;
    [backcustombutton addSubview:btnimg];
    UILabel *titlubuton =[[UILabel alloc]init];
    titlubuton.textColor =[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1];
    titlubuton.font =[UIFont systemFontOfSize:16];
      [titlubuton setFrame:CGRectMake(4.0f,2.0f, 60.0f, 20.0f)];
    titlubuton.textAlignment = NSTextAlignmentLeft;
    titlubuton.text=@"Înapoi";
    [backcustombutton addSubview:titlubuton];
    [backcustombutton setShowsTouchWhenHighlighted:NO];
    [backcustombutton bringSubviewToFront:btnimg];
    return backcustombutton;
}
-(void)perfecttimeforback{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)viewWillAppear:(BOOL)animated {
    [self addhud];
    NSLog(@"felicitari");
    self.urlPiesesimilare = urlPiesesimilare;
    [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
    
    self.navigationController.navigationItem.hidesBackButton = YES;
    //clean other left
    for(UIButton *view in  self.navigationController.navigationBar.subviews) {
        if([view isKindOfClass:[butoncustomback class]]){
            [view removeFromSuperview];
        }
    }
    //add new left
    UIButton *ceva = [self backbtncustom];
    [ceva addTarget:self action:@selector(perfecttimeforback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *inapoibtn =[[UIBarButtonItem alloc] initWithCustomView:ceva];
    self.navigationItem.leftBarButtonItem = inapoibtn;
//    if(dinhelp ==YES) {
//        dinhelp=NO;
//        NSURL *url = [NSURL URLWithString:urlPiesesimilare];
//        NSError* error;
//        NSString *content = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
//        NSLog(@"caz help %@",content);
//        NSString *str2 = [content stringByReplacingOccurrencesOfString:@"{font-family:Roboto-Regular;font-size:22px;}" withString:@"{font-family: 'Helvetica Neue', 'Lucida Grande';font-size:18px;}"];
//        //{font-family:Roboto-Regular;font-size:22px;}
//        [self.mWebView loadHTMLString:str2 baseURL:nil];
//    //[self.mWebView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('os_ios')[0].style.fontFamily =\"-apple-system\",\"HelveticaNeue\""];
// 
//    } else {
//        dinhelp=NO;
//    }
//

    /*
     "url_similar_products" = "http://dev5.activesoft.ro/~csaba/4tilance/piese-auto-aston-martin/db9/";
    */
   
    
    
    
}
-(void)addhud{
    [MBProgressHUD showHUDAddedTo:self.navigationController.visibleViewController.view animated:YES];
}
-(void)removehud{
    [MBProgressHUD hideAllHUDsForView:self.navigationController.visibleViewController.view animated:YES];
}


-(void)mergiBack {
 //intotdeauna la ecranul principal pentru ca aici ajunge numai dupa ce a facut cerere completa
    TutorialHomeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialHomeVC"];
    [self.navigationController pushViewController:vc animated:NO ];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dinhelp =dinhelp;

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
       [self.navigationController setNavigationBarHidden:NO]; self.navigationItem.leftBarButtonItem=nil;
        self.mWebView.delegate = self;
      ///  self.mWebView.scalesPageToFit = YES;
        NSURL* url = [NSURL URLWithString:self.urlPiesesimilare];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        [self.mWebView loadRequest:request];
   
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated {
   
  
    //urlPiesesimilare
    
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
   
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
       [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self removehud];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
   
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self removehud];

}

-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}



@end


