//
//  TutorialHomeViewController.h
//  Pieseauto
//
//  Created by Ioan Ungureanu on 23/02/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
#import "CerereNouaViewController.h"

@interface TutorialHomeViewController : UIViewController<UITabBarDelegate> {
    Utile * utilitar;
    CerereNouaViewController *HOMEVIEW; //e principalul select
    
}
@property (nonatomic,strong) IBOutlet UIImageView *splashscreen;
@property (nonatomic,strong) IBOutlet UIButton *aminteles; //  Aminteles
@property (nonatomic,strong) IBOutlet UIButton *numaiafisa; // Numaiafisa
@property (nonatomic,strong) IBOutlet UIView *tutorialafisat; // Numaiafisa
@property (nonatomic,strong) IBOutlet UIView *viewgri; //un view care contine tutorialafisat

@property (nonatomic,strong) IBOutlet UITabBar *barajos; //3 butoane ->adauga cerere, cererile mele  si cont
@property (nonatomic, strong) IBOutlet TTTAttributedLabel *ceriofertatext;//textul cu 3 puncte...
@property (nonatomic,strong) IBOutlet UIButton *cereofertaacum; //  cere oferta acum
@property (nonatomic,strong) IBOutlet UILabel *aflamaimulte; //  cere oferta acum

@property (nonatomic,strong) IBOutlet UIView *continutbararosiesicursor;
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *bararosietext; //  text
@property (nonatomic,strong) IBOutlet UIView *cursorportocaliu; //un view cursor pulsating

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;// (scaleaza thumbs);

@end

