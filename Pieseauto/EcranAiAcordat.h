//
//  EcranAiAcordat.h
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


@interface EcranAiAcordat : UIViewController<UITabBarDelegate,UINavigationBarDelegate,UINavigationControllerDelegate> {
    Utile * utilitar;
}

@property (nonatomic,strong) IBOutlet UILabel *felicitari; //
@property (nonatomic,strong) IBOutlet UILabel *aiincadeacordat; //
@property (nonatomic,strong) IBOutlet UITabBar *barajos; //3 butoane ->adauga cerere, cererile mele  si cont
@property (nonatomic,strong) IBOutlet UIImageView *sageatablue;
@property (nonatomic,assign) int catemaiare;
-(void)mergiHome;
@end
