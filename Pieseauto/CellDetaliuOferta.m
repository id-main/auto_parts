//
//  CellDetaliuOferta.m
//  Piese auto
//
//  Created by Ioan Ungureanu on 04/05/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CellDetaliuOferta.h"
#import "AppDelegate.h"



@interface CellDetaliuOferta ()

@end


@implementation CellDetaliuOferta
@synthesize pozaRow,TitluRand,badgeRow,tipoferta,pretoferta,dynamiccellLEFT,cupaverde,verdetop,toptitlurand,toppoza,fundalmesaj,elpozaalbastra,eupozagri,sageatablue,stelutacalificative,icontelefon,catecalificative,telefonuser,bifablue,salveazalapreferate,acceptaoferta,expandcollapsecell,textmesaj,ultimulrand,randul1,titlurandul1,numeofertant,randul2,titlurandul2,continutmesaj,titlurandulextra,dynamictableheightJ,heighttitlurand; //
@synthesize  COMPUNE,compunetextmesaj,fapoza,TRIMITE,trimitetextmesaj,sageatatrimite,pozamesajdejatrimis,dynamicTEXTVIEWHEIGHT,dynamicCOMPUNEROWHEIGHT,dynamicLINIEGRIHEIGHT,salvatabifablue;
@synthesize bluecell; //icons
@synthesize Altrandalbastru; //cell cu icon in stanga
@synthesize sageataBlue;
@synthesize IconRand;
@synthesize sageataGri3;

-(void)viewWillAppear:(BOOL)animated {
}
-(void)loadObjectCell{
   NSLog(@"CellDetaliuOferta");
  
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
   
    self.contentView.frame = self.bounds;

    
}
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
//    [compunetextmesaj resignFirstResponder];
//    return YES;
//    
//}


//INCHIDE LA DONE...
//-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    if([text isEqualToString:@"\n"]) {
//   AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//   del.TEXTMESAJTEMPORAR = compunetextmesaj.text;
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}




-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}

@end