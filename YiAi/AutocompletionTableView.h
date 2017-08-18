//
//  AutocompletionTableView.h
//
//  Created by Gushin Arseniy on 11.03.12.
//  Copyright (c) 2012 Arseniy Gushin. All rights reserved.
//

#import <UIKit/UIKit.h>

// Consts for AutoCompleteOptions:
//
// if YES - suggestions will be picked for display case-sensitive
// if NO - case will be ignored
#define ACOCaseSensitive @"ACOCaseSensitive"

// if "nil" each cell will copy the font of the source UITextField
// if not "nil" given UIFont will be used
#define ACOUseSourceFont @"ACOUseSourceFont"

// if YES substrings in cells will be highlighted with bold as user types in
// *** FOR FUTURE USE ***
#define ACOHighlightSubstrWithBold @"ACOHighlightSubstrWithBold"

// if YES - suggestions view will be on top of the source UITextField
// if NO - it will be on the bottom
// *** FOR FUTURE USE ***
#define ACOShowSuggestionsOnTop @"ACOShowSuggestionsOnTop"

@protocol AutocompletionTableViewDelegate;

@interface AutocompletionTableView : UITableView <UITableViewDataSource, UITableViewDelegate>
// Dictionary of NSStrings of your auto-completion terms
@property (nonatomic, strong) NSArray *suggestionsArr;




-(void)shouldOpenAuto;


//delegate
@property (nonatomic, assign) id<AutocompletionTableViewDelegate>  tabDelegate;
// Call it for proper initialization
- (UITableView *)initWithTextField:(UITextField *)textField inViewController:(UIViewController *) parentViewController withArr:(NSMutableArray *)arr;
@property (nonatomic,copy)void(^clickCell)(id model);
@end

@protocol AutocompletionTableViewDelegate <NSObject>

- (void) autoCompletionTableView:(AutocompletionTableView *) completionView
                    deleteString:(NSString *) sString;
//点击序号
- (void) autoCompletionTableView:(AutocompletionTableView *) completionView
                 didSelectString:(id) sString;




@end
