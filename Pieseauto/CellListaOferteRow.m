//
//  CellListaOferteRow.m
//  Piese auto
//
//  Created by Ioan Ungureanu on 31/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CellListaOferteRow.h"
#import "AppDelegate.h"

@interface CellListaOferteRow ()

@end


@implementation CellListaOferteRow
@synthesize badgeRow,cercalbastru,cupaverde,dynamiccellLEFT,favoritagri,pozaRow,pretoferta,sageatablue,sageatagri,tipoferta,TitluRand,toppoza,toptitlurand,verdetop; //

-(void)viewWillAppear:(BOOL)animated {
}
-(void)loadObjectCell{
   NSLog(@"CellListaOferteRow");
  
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