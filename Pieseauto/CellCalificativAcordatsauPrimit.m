//
//  CellCalificativAcordatsauPrimit.m
//  Piese auto
//
//  Created by Ioan Ungureanu on 07/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellCalificativAcordatsauPrimit.h"
#import "AppDelegate.h"


@interface CellCalificativAcordatsauPrimit ()

@end


@implementation CellCalificativAcordatsauPrimit
@synthesize titluROW,sageatagri,dynamictableheightJ;
@synthesize pozacerere,iconuser,iconcalificativ,titlucalificativ,textcalificativ,detaliucomentariu,dynamictleftpoza,dynamictableheightJ2;

-(void)viewWillAppear:(BOOL)animated {
}
-(void)loadObjectCell{
  // NSLog(@"aici cell choose 4");
  
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)awakeFromNib
{
    
    // Initialization code
//NSLog(@"aici cell choose 4");
    self.contentView.frame = self.bounds;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
 
  
}
-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}

@end