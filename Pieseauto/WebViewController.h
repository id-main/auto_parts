//
//  WebViewController.h
//  Pieseauto
//
//  Created by Ioan Ungureanu on 29/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DataMasterProcessor.h"
#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"


@interface WebViewController: UIViewController<UIWebViewDelegate> {
    Utile * utilitar;
    UIWebView* mWebView;
}
@property (nonatomic, retain) IBOutlet UIWebView* mWebView;
@property (nonatomic,strong) NSString *urlPiesesimilare;
@property (nonatomic, assign) BOOL dinhelp;

@end
