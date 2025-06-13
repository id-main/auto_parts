//
//  CellHome.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 07/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
@interface CellHome:UITableViewCell<UITextViewDelegate> {
    
    Utile *utilitarx;
}

@property(nonatomic, strong) IBOutlet TTTAttributedLabel *TitluRand;
@property(nonatomic, strong) IBOutlet UILabel *GriRand;
@property(nonatomic, strong) IBOutlet TTTAttributedLabel *SubtitluRand;
@property(nonatomic, strong) IBOutlet UIButton *AlegeRand;
@property(nonatomic, strong) IBOutlet UIButton *fapoza;
@property(nonatomic, strong) IBOutlet UILabel *ALEGE; //BUTON MIC ROU
@property(nonatomic, strong) IBOutlet UIButton *CEREACUM; //BUTON MARE JOS
@property(nonatomic, strong) IBOutlet UIImageView *sageata; //poza imagine sageata
@property(nonatomic, strong) IBOutlet UITextView *texteditabil; //@"| Exemplu: Bară față roșie Renault Megane 2014"
@property(nonatomic, strong) IBOutlet UITextView *texteneeditabil; //@"| Exemplu: Bară față roșie Renault Megane 2014"
@property(nonatomic, strong) IBOutlet UIView *RANDSECUNDAR; //contine alegerile si sageata
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicheighttexteditabil; // different height cand text editabil se modifica
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicheightsybtitlurand; // continutul modificabil
-(void)loadObjectCell;
@end