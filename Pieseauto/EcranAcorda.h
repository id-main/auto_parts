//
//  EcranAcorda.h
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
#import "HCSStarRatingView.h"

@interface EcranAcorda: UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate> {
    Utile * utilitar;
}

@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) NSDictionary *CALIFICATIV; //  titluriCAMPURI

@property (nonatomic,strong) NSString *CE_TIP_E;
@property (nonatomic,assign) double rating1;
@property (nonatomic,assign) double rating2;
@property (nonatomic,assign) double rating3;
@property (nonatomic,assign) double rating4;
@property (nonatomic,assign) int tipuldecalificativdeacordat; //0=nimic 1 = positive 2=neutru 3=negativ
@property (nonatomic,strong) NSString *comentariuAcorda;
@property (nonatomic,strong) HCSStarRatingView *mystars;


@end
