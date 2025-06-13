//
//  CellProfil.m
//  Piese auto
//
//  Created by Ioan Ungureanu on 31/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CellProfil.h"
#import "AppDelegate.h"

@interface CellProfil ()

@end


@implementation CellProfil
@synthesize  HeaderTabel,NUMEPROFIL,score,stars_class,dynamiccellnumeprofil;
@synthesize  Row1,sellericon,sellerlabel,score_percent,verdepozitiv,dynamiccellLEFT,dynamiccellLEFT2,dynamiccellLEFT3,dynamiccellLEFT4,iconpozitivnegativ;
@synthesize  Row2,telefonicon,telefon;
@synthesize  Row3,siglafirma,numefirma,reprezinta,sageatablue;
@synthesize  Row4,membrudindata,ultimadataonline,localizarea,nranunturipublicate,sageatablue2;
@synthesize  Row5,calificative,calificativedetaliate,ultimulan,intotal;
@synthesize  Row6,iconpozitive,descrierepozitive,nrpean,total;
@synthesize  Row7,descriereRandCal,nrrating,stelutarosie;
@synthesize  Row8,SEGCNTRL;
@synthesize  Row12,iconcalificativprimit,comentariu,dela,numecomentator,stelutaverde,scorcomentator,dynamiccellcomentariuheight,nusuntcalificative;
@synthesize  Row13,iconmaimult,vezimaimult;
-(void)viewWillAppear:(BOOL)animated {
}
-(void)loadObjectCell{
   NSLog(@"CellListaNotificari");

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)awakeFromNib
{
    
 // Initialization code
    self.contentView.frame = self.bounds;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
}
-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}

@end