//
//  AutocompletionTableView.m
//
//  Created by Gushin Arseniy on 11.03.12.
//  Copyright (c) 2012 Arseniy Gushin. All rights reserved.
//

#import "AutocompletionTableView.h"
//#import "MedInfoModel.h"
#define TABLEVIEW_MAX_HEIGHT    200

@interface AutocompletionTableView ()
@property (nonatomic, strong) NSArray *suggestionOptions; // of selected NSStrings
@property (nonatomic, strong) UITextField *textField; // will set automatically as user enters text
@property (nonatomic, strong) UIFont *cellLabelFont; // will copy style from assigned textfield

- (void) resizingTableHeight;

@end

@implementation AutocompletionTableView{
    NSMutableArray *newValueArr;
}

@synthesize suggestionsArr = _suggestionsArr;
@synthesize suggestionOptions = _suggestionOptions;
@synthesize textField = _textField;
@synthesize cellLabelFont = _cellLabelFont;
@synthesize tabDelegate = _tabDelegate;

#pragma mark - Initialization
- (UITableView *)initWithTextField:(UITextField *)textField inViewController:(UIViewController *) parentViewController withArr:(NSMutableArray *)arr
{
    self.suggestionsArr=arr;
    newValueArr=arr;
    CGRect frame;
    // frame must align to the textfield
//    frame = CGRectMake(textField.frame.origin.x,
//                       textField.frame.origin.y + textField.frame.size.height,
//                       textField.frame.size.width,
//                       TABLEVIEW_MAX_HEIGHT);
    frame = CGRectMake(10+[MyAdapter aDapter:80]+10+[MyAdapter aDapter:10],
                      10+[MyAdapter aDapter:40]+64+1,
                       WIDTH-10-[MyAdapter aDapter:80]-10-[MyAdapter aDapter:10],
                       TABLEVIEW_MAX_HEIGHT);
    
    
    
    // save the font info to reuse in cells
    self.cellLabelFont = textField.font;
    
    self = [super initWithFrame:frame
                          style:UITableViewStylePlain];
    
    self.delegate = self;
    self.dataSource = self;
    self.scrollEnabled = YES;
    self.userInteractionEnabled=YES;
    [self setBackgroundColor:[AppAppearance sharedAppearance].pageBackgroundColor];
    [self.layer setBorderColor:[AppAppearance sharedAppearance].cellLineColor .CGColor];
    [self.layer setBorderWidth:1];
    
    
    // turn off standard correction
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    // to get rid of "extra empty cell" on the bottom
    // when there's only one cell in the table
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textField.frame.size.width, 1)];
    v.backgroundColor = [UIColor lightTextColor];
    [self setTableFooterView:v];
    self.hidden = YES;
    
    //在uiview 下面
    if (textField.superview.superview == nil) {
        [parentViewController.view addSubview:self];
    } else {
        [textField.superview addSubview:self];
    }
    
    
    
//    [textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
//    [textField addTarget:self action:@selector(textFieldBeginEdit:) forControlEvents:UIControlEventEditingDidBegin];
//    [textField addTarget:self action:@selector(textFieldEndEdit:) forControlEvents:UIControlEventEditingDidEnd];
//    [textField addTarget:self action:@selector(textFieldDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
      self.textField = textField;
    
   
    
    
    return self;
}


//创建
-(void)shouldOpenAuto
{
 
    newValueArr = [NSMutableArray arrayWithArray:_suggestionsArr];
    [self reloadData];
    [self showOptionsView];
    
}


- (void) resizingTableHeight {
    NSInteger nCount = newValueArr.count;
    
    CGRect frame = self.frame;
    
    if (nCount * 44.0 < TABLEVIEW_MAX_HEIGHT) {
        frame.size.height = nCount * 44.0;
    } else {
        frame.size.height = TABLEVIEW_MAX_HEIGHT;
    }
    self.frame = frame;
}

#pragma mark - Logic staff
- (BOOL) substringIsInDictionary:(NSString *)subString
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"s_name contains [cd] %@",subString];
    newValueArr=[NSMutableArray arrayWithArray:[self.suggestionsArr filteredArrayUsingPredicate:pred]];
    if ([newValueArr count]>0)
    {
        return YES;
    }
    return NO;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newValueArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
        UIView *selectBackView = [[UIView alloc] initWithFrame:cell.frame];
        selectBackView.backgroundColor = [UIColor colorWithRed:201.0 / 255.0
                                                         green:201.0 / 255.0
                                                          blue:201.0 / 255.0
                                                         alpha:1];
        cell.selectedBackgroundView = selectBackView;
        cell.backgroundColor=[AppAppearance sharedAppearance].whiteColor;
    }
    cell.textLabel.font = self.cellLabelFont;
    cell.textLabel.adjustsFontSizeToFitWidth = NO;
//    MedInfoModel *model=[newValueArr objectAtIndex:indexPath.row];
//    cell.textLabel.text = model.s_name;
    
    cell.textLabel.text = newValueArr[indexPath.row];
    
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapcell:)];
    cell.tag=indexPath.row;
    [cell addGestureRecognizer:gesture];
    return cell;
}

#pragma mark - Table view delegate
-(void)tapcell:(UITapGestureRecognizer *)tap {
    UIView *view=tap.view;
    if (self.clickCell) {
        self.clickCell([newValueArr objectAtIndex:view.tag]);
    }
    [self hideOptionsView];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickCell) {
        self.clickCell([newValueArr objectAtIndex:indexPath.row]);
    }
    //[self.textField setText:[newValueArr objectAtIndex:indexPath.row]];
    [self hideOptionsView];
}


#pragma mark - UITextField delegate
- (void)textFieldValueChanged:(UITextField *)textField
{
    self.textField = textField;
    NSString *curString = textField.text;
    
    if (![curString length])
    {
        [self textFieldBeginEdit:textField];
        return;
    } else if ([self substringIsInDictionary:curString]) {
        [self reloadData];
        [self showOptionsView];
    } else {
        [self hideOptionsView];
    }
}

- (void) textFieldBeginEdit:(UITextField *) textField {
    if ([textField.text length] == 0) {
        newValueArr = [NSMutableArray arrayWithArray:_suggestionsArr];
        [self reloadData];
        [self showOptionsView];
        
    }
}

- (void) textFieldEndEdit:(UITextView *) textField {
    [self hideOptionsView];
}

- (void) textFieldDidEndOnExit:(UITextField *) textField {
    [self hideOptionsView];
}

#pragma mark - Options view control
- (void)showOptionsView
{
    [self resizingTableHeight];
    self.hidden = NO;
}

- (void) hideOptionsView
{
    self.hidden = YES;
}

@end
