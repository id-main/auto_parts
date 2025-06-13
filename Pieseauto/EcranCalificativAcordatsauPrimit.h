//
//  EcranCalificativAcordatsauPrimit.h
//  Pieseauto
//
//  Created by Ioan Ungureanu on 24/02/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DataMasterProcessor.h"
#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"


@interface EcranCalificativAcordatsauPrimit : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource> {
    Utile * utilitar;
}
@property (nonatomic,strong) IBOutlet UIButton *Continua;
@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) NSDictionary *CALIFICATIV; //  titluriCAMPURI
@property (nonatomic,strong) IBOutlet UIImageView *sageatablue; //
@property (nonatomic,strong) NSString *CE_TIP_E;


@end
