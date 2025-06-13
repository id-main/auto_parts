//
//  PagedImageScrollView.m
//  Test
//
//  Created by jianpx on 7/11/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import "PagedImageScrollView.h"
#import "AppDelegate.h"

@interface PagedImageScrollView() <UIScrollViewDelegate>
@property (nonatomic) BOOL pageControlIsChangingPage;
@property (nonatomic) BOOL final;
@end

@implementation PagedImageScrollView
@synthesize  imaginile,final,dotImage,currentDotImage;


#define PAGECONTROL_DOT_WIDTH 50
#define PAGECONTROL_HEIGHT 100
#define VIEW_FOR_ZOOM_TAG (1)


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        final=NO;
        self.backgroundColor =[UIColor blackColor];
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.pageControl = [[UIPageControl alloc] init];
        [self setDefaults];
        [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        self.scrollView.delegate = self;
        self.dotImage        = [UIImage imageNamed:@"Dot_grey_outline_72x72"];
     
        //self.currentDotImage = [UIImage imageNamed:@"Dot_white_outline_72x72"];
        self.currentDotImage = [UIImage imageNamed:@"Dot_grey_outline_72x72"];
     }
    return self;
}

//-(void) updateDots
//{
//    for (int i = 0; i < [self.subviews count]; i++)
//    {
//        UIImageView * dot = [self imageViewForSubview:  [self.subviews objectAtIndex: i]];
//        if (i == self.pageControl.currentPage) dot.image = self.currentDotImage;
//        else dot.image = self.dotImage  ;
//    }
//}

-(void)updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        dot.frame = CGRectMake(dot.frame.origin.x, dot.frame.origin.y, 40, 40);
        if (i == self.pageControl.currentPage)
            dot.image = currentDotImage;
        else
            dot.image =dotImage;
    }
}



- (void)setPageControlPos:(enum PageControlPosition)pageControlPos
{
    CGFloat width = PAGECONTROL_DOT_WIDTH * self.pageControl.numberOfPages;
    _pageControlPos = pageControlPos;
    if (pageControlPos == PageControlPositionRightCorner)
    {
        self.pageControl.frame = CGRectMake(self.scrollView.frame.size.width - width, self.scrollView.frame.size.height - PAGECONTROL_HEIGHT  , width, PAGECONTROL_HEIGHT);
    }else if (pageControlPos == PageControlPositionCenterBottom)
    {
        self.pageControl.frame = CGRectMake((self.scrollView.frame.size.width - width) / 2, self.scrollView.frame.size.height - PAGECONTROL_HEIGHT , width, PAGECONTROL_HEIGHT);
    }else if (pageControlPos == PageControlPositionLeftCorner)
    {
        self.pageControl.frame = CGRectMake(0, self.scrollView.frame.size.height - PAGECONTROL_HEIGHT , width, PAGECONTROL_HEIGHT);
    }
}

- (void)setDefaults
{
//    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
//    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];

   ///  self.pageControl.currentPageIndicatorTintColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"Dot_white_outline_72x72"]];
  ///   self.pageControl.pageIndicatorTintColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"Dot_grey_outline_72x72"]];
   
    self.pageControl.hidesForSinglePage = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.pageControlPos = PageControlPositionRightCorner;
}
//
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
//    
//    NSInteger curentpage =self.pageControl.currentPage;
//    UIView *cautare =[[UIView alloc]init];
//    NSLog(@"curentpage %ld", (long)curentpage);
//   // for(int i=0; i< scrollView.subviews)
//   // return [scrollView viewWithTag:curentpage -1];
//    for(int i=0; i< scrollView.subviews.count;i++) {
//     UIView *cauta = [scrollView.subviews objectAtIndex:i];
//        if (cauta.tag ==VIEW_FOR_ZOOM_TAG) {
//            cautare =cauta;
//            break;
//        }
//    }
//    
//    return cautare;
//}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollView viewWithTag:VIEW_FOR_ZOOM_TAG];
}

- (void)setScrollViewContents: (NSArray *)images
{
    //remove original subviews first.
    imaginile = [[NSArray alloc]init];
    imaginile = images;
    for (UIView *subview in [self.scrollView subviews]) {
        [subview removeFromSuperview];
    }
    if (images.count <= 0) {
        self.pageControl.numberOfPages = 0;
        return;
    }
    CGRect innerScrollFrame =  self.scrollView.bounds;
    NSLog(@"inner %f %f", innerScrollFrame.size.width,innerScrollFrame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    for (NSInteger i = 0; i < images.count; i++) {
        id  ceva =images[i];
        if ([ceva isKindOfClass:[UIImage class]]) {
        UIImage *mypic= images[i];
        UIImageView *imageForZooming = [[UIImageView alloc] init];
//            if(mypic.size.height > mypic.size.width) {
//                innerScrollFrame = CGRectMake(0, 0, self.scrollView.frame.size.height,self.scrollView.frame.size.width);
//            }
        imageForZooming.tag = VIEW_FOR_ZOOM_TAG;
        UIScrollView *pageScrollView = [[UIScrollView alloc] initWithFrame:innerScrollFrame];
        pageScrollView.delegate = self;
        imageForZooming.contentMode =UIViewContentModeScaleAspectFit;
        imageForZooming.clipsToBounds=YES;
        imageForZooming.image=mypic;
        imageForZooming.frame =CGRectMake(0, 0, innerScrollFrame.size.width,innerScrollFrame.size.height);
// maybe sunday!           if(mypic.size.height > mypic.size.width) {
//               imageForZooming.frame =CGRectMake(0, 0, innerScrollFrame.size.height,innerScrollFrame.size.width);
//                 pageScrollView.contentSize =CGSizeMake( innerScrollFrame.size.height,innerScrollFrame.size.width);
//            } else {
//
//                pageScrollView.contentSize =CGSizeMake( innerScrollFrame.size.width,innerScrollFrame.size.height);
//            }
        pageScrollView.contentSize =  imageForZooming.bounds.size;
        pageScrollView.minimumZoomScale = 1.0f;
        pageScrollView.maximumZoomScale = 8.0f;
        pageScrollView.zoomScale = 1.0f;
      
       
        pageScrollView.showsHorizontalScrollIndicator = NO;
        pageScrollView.showsVerticalScrollIndicator = NO;
        pageScrollView.bouncesZoom=NO;
        [pageScrollView addSubview:imageForZooming];
        [self.scrollView addSubview:pageScrollView];
         if (i <  images.count -1) {
            innerScrollFrame.origin.x += innerScrollFrame.size.width;
        }
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(innerScrollFrame.origin.x +
                                            innerScrollFrame.size.width, self.scrollView.bounds.size.height);
    NSLog(@"images.count %lu", (unsigned long)images.count);
    self.pageControl.numberOfPages = images.count;
    //call pagecontrolpos setter.
    self.pageControlPos = self.pageControlPos;
// old code... //  self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * images.count, self.scrollView.frame.size.height);
//    for (int i = 0; i < images.count; i++) {
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
//        imageView.contentMode =UIViewContentModeScaleAspectFit;
//        [imageView setImage:images[i]];
//      //  imageView.tag = i;
//        UIScrollView *pageScrollView = [[UIScrollView alloc] initWithFrame:innerScrollFrame];
//        imageView.tag=VIEW_FOR_ZOOM_TAG;
//        pageScrollView.minimumZoomScale = 1.0f;
//        pageScrollView.maximumZoomScale = 2.0f;
//        pageScrollView.zoomScale = 1.0f;
//        pageScrollView.contentSize = imageView.bounds.size;
//        pageScrollView.delegate = self;
//        pageScrollView.showsHorizontalScrollIndicator = NO;
//        pageScrollView.showsVerticalScrollIndicator = NO;
//        [pageScrollView addSubview:imageView];
//        [self.scrollView addSubview:pageScrollView];
//        if (i < imaginile.count-1) {
//            innerScrollFrame.origin.x += innerScrollFrame.size.width;
//        }
//   
//    }
//  //  self.scrollView.contentSize = CGSizeMake(innerScrollFrame.origin.x +                                           innerScrollFrame.size.width, self.scrollView.frame.size.height);
//     self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * images.count, self.scrollView.frame.size.height);
  
}
- (BOOL)shouldAutorotate {
    return NO;
}
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)changePage:(UIPageControl *)sender
{
    
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    self.pageControlIsChangingPage = YES;
    [self updateDots];
   }

#pragma scrollviewdelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.pageControlIsChangingPage) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    //switch page at 50% across
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
   
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //little trick
//    if(final ==YES && self.pageControl.currentPage == imaginile.count-1) {
//        UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
//        [nav popViewControllerAnimated:YES];
//    }
//    self.pageControlIsChangingPage = NO;
//    NSLog(@"self.pageControl.currentPage %li %lu",(long)self.pageControl.currentPage,(unsigned long)imaginile.count);
    if(self.pageControl.currentPage == imaginile.count-1 ) {
     //   self.pageControl.currentPage =0;
     //   final =YES;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.pageControlIsChangingPage = NO;
}

@end
