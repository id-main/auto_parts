//
//  EcranCerereTrimisaViewController.h
//  Pieseauto
//
//  Created by Ioan Ungureanu on 28/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DataMasterProcessor.h"
#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"


@interface EcranCerereTrimisaViewController : UIViewController<UITabBarDelegate> {
    Utile * utilitar;
}
@property (nonatomic,strong) NSDictionary *titlurilables; //  titluriCAMPURI
@property (nonatomic,strong) IBOutlet UILabel *catemagazine; //
@property (nonatomic,strong) IBOutlet UILabel *setarinotificarioferte;
@property (nonatomic,strong) IBOutlet UILabel *pretpiesesimilare;
@property (nonatomic,strong) IBOutlet UITabBar *barajos; //3 butoane ->adauga cerere, cererile mele  si cont
@property (nonatomic,strong) NSString *urlPiesesimilare;
@end
