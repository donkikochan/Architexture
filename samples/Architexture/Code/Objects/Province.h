//
//  Province
//  MutuaManresana
//
//  Created by Roser Fontseca Galceran on 14/05/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

//----IMPORTS-->
#import "BaseObjectDelegate.h"
//<-------------


//-------CLASS CountryArray:
@interface ProvinceArray : BaseObjectDelegate
{
}

@property (nonatomic, strong) NSMutableArray *provinces;

- (void) getCountries;
@end



//-------CLASS Country:
@interface Province: BaseObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *name;

@end



