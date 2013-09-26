//
//  LoadingCollection_VC.m
//  Architexture
//
//  Created by Enric Vergara Carreras on 20/09/13.
//
//

//---Imports:--
#import "LoadingCollection_VC.h"
//--------------

@interface LoadingCollection_VC ()

@end

@implementation LoadingCollection_VC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([[AppDelegate mainAppDelegate].m_sCollectionToLoad isEqualToString:COLLECTION_BARCELONA])
    {
        _m_Label_Loading.text = @"Loading Barcelona Collection...";
    }
    else if ([[AppDelegate mainAppDelegate].m_sCollectionToLoad isEqualToString:COLLECTION_MATERIALS])
    {
        _m_Label_Loading.text = @"Loading Materials Collection...";
    }
    else if ([[AppDelegate mainAppDelegate].m_sCollectionToLoad isEqualToString:COLLECTION_PARIS])
    {
        _m_Label_Loading.text = @"Loading Paris Collection...";
    }
    else if ([[AppDelegate mainAppDelegate].m_sCollectionToLoad isEqualToString:SP_COLLECTION_DALI])
    {
        _m_Label_Loading.text = @"Loading Dalí Collection...";
    }
    else if ([[AppDelegate mainAppDelegate].m_sCollectionToLoad isEqualToString:SP_COLLECTION_BORN])
    {
        _m_Label_Loading.text = @"Loading Born Collection...";
    }
    
    [NSTimer scheduledTimerWithTimeInterval:1.5
                                     target:self
                                   selector:@selector(load:)
                                   userInfo:nil
                                    repeats:NO];
}
- (void) load:(NSTimer *)timer
{
    if ([[AppDelegate mainAppDelegate].m_sCollectionToLoad isEqualToString:COLLECTION_BARCELONA])
    {
        [self performSegueWithIdentifier:@"FromLoadingCollectionToBarcelona" sender:nil];
    }
    else if ([[AppDelegate mainAppDelegate].m_sCollectionToLoad isEqualToString:COLLECTION_MATERIALS])
    {
        [self performSegueWithIdentifier:@"FromLoadingCollectionToMaterials" sender:nil];
    }
    else if ([[AppDelegate mainAppDelegate].m_sCollectionToLoad isEqualToString:COLLECTION_PARIS])
    {
        [self performSegueWithIdentifier:@"FromLoadingCollectionToParis" sender:nil];
    }
    else if ([[AppDelegate mainAppDelegate].m_sCollectionToLoad isEqualToString:SP_COLLECTION_DALI])
    {
        [self performSegueWithIdentifier:@"FromLoadingCollectionToDali" sender:nil];
    }
    else if ([[AppDelegate mainAppDelegate].m_sCollectionToLoad isEqualToString:SP_COLLECTION_BORN])
    {
        [self performSegueWithIdentifier:@"FromLoadingCollectionToBorn" sender:nil];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
