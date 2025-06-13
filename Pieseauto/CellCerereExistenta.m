//
//  CellCerereExistenta.m
//  Piese auto
//
//  Created by Ioan Ungureanu on 26/04/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellCerereExistenta.h"
#import "AppDelegate.h"

@interface CellCerereExistenta ()

@end


@implementation CellCerereExistenta
@synthesize  TitluRand,DateMasina,Tipnoisausecond,ZonaLivrare,RandGri,sageataGri,sageataBlue,PozaCerere,PozaOferta,IconRand,Altrandalbastru,primulcell,bluecell,ofertacastigatoare,TitluOferta, TipOferta,PretOferta,HeadOferta,discutieuser,TitluMesaj,NumePersoanaMesaj,roundalbastru,pozauser,sageataGri2,expandcollapsecell,randgrenaanulata,numerandanulata,numartoate,detofer,topdetofer,LEFTPOZAOFERTA;
@synthesize randul1,titlurandul1,numeofertant,stelutacalificative,icontelefon,catecalificative,telefonuser,sageatablue,sageatablue2;//sageata blue
@synthesize dynamicheightTITLUCERERE,dynamicheightDATEMASINA,heighttitlurand,toppoza,heightHeadOferta,dynamictitluheight,dynamicDETOFERHEIGHT,sageataGri3;
-(void)viewWillAppear:(BOOL)animated {
   
    
}
-(void)loadObjectCell{
   NSLog(@"aici cell cerere existenta");
}
- (void)awakeFromNib
{
    
    // Initialization code
    NSLog(@"aici cell cerere existenta");
//    self.contentView.frame = self.bounds;
//    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}


@end