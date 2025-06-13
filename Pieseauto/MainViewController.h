//
//  MainViewController.h
//  Pieseauto
//
//  Created by Ioan Ungureanu on 23/02/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorialHomeViewController.h"
#import "SelectieLimbaVC.h"
#import "utile.h"
#import "MBProgressHUD.h"

@interface MainViewController : UIViewController {
    TutorialHomeViewController *tutorial;
    SelectieLimbaVC *selectielimba;
    Utile *utilitarx;
    
}
@property (nonatomic,strong) IBOutlet UIView *splashscreen;
@property (nonatomic,assign) BOOL FIRSTIME;
-(void)aluatdate;


@end

