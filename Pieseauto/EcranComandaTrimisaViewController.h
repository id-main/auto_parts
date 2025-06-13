//
//  EcranComandaTrimisaViewController.h
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


@interface EcranComandaTrimisaViewController : UIViewController<UITabBarDelegate,UINavigationBarDelegate,UINavigationControllerDelegate> {
    Utile * utilitar;
}

@property (nonatomic,strong) IBOutlet UILabel *felicitari; //
@property (nonatomic,strong) IBOutlet UILabel *suporttehnic; //
@property (nonatomic,strong) IBOutlet UILabel *telefonafisat;
@property (nonatomic,strong) IBOutlet UILabel *orar;
@property (nonatomic,strong) IBOutlet UITabBar *barajos; //3 butoane ->adauga cerere, cererile mele  si cont
@end
