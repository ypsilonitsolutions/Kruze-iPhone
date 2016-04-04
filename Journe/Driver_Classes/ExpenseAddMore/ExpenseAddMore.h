//
//  ExpenseAddMore.h
//  Journe
//
//  Created by admin on 09/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "ExpenseCell.h"
@interface ExpenseAddMore : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIView *ExpensesTypeView;
    IBOutlet UIButton *ExpensesBtn;
    IBOutlet UIView *FuelTypeView;
    IBOutlet UIView *ExpensesDetailsView;
    BOOL ExpensesBtnTapped,FuelSelected;
    IBOutlet UITableView *table;
    
    int ExpensesTypeView_x,ExpensesTypeView_y,ExpensesTypeView_w,ExpensesTypeView_h,ExpensesTypeView_IncreamentValue;
    
    
    int FuelTypeView_x,FuelTypeView_y,FuelTypeView_w,FuelTypeView_h,FuelTypeView_IncreamentValue;
    
    
    int ExpensesDetailsView_x,ExpensesDetailsView_y,ExpensesDetailsView_w,ExpensesDetailsView_h,ExpensesDetailsView_IncreamentValue;
    
    int scrollIncrementSize,newYvalueOfDetailsView,scrollViewResize;
    int imageflag;
    IBOutlet UIScrollView *scroll;
    IBOutlet UIButton *Btnsave;
    IBOutlet UIButton *BtnPetrol;
    IBOutlet UIButton *BtnDiesel;
    IBOutlet UIImageView *imgView;
    NSString *imageName,*cell_nib,*cat_selected_id,*options;
    NSData *imagedata;
    NSMutableArray *expensesTypesArray;
    
    IBOutlet UITextField *txtAmount;
    IBOutlet UITextField *txtKM;
    NSString *currentDate;
    IBOutlet UILabel *lblDate;
    IBOutlet UITextView *description;
    
    UIView *darkView1;
    UIDatePicker *datePicker;
    UIToolbar *toolBar1;
}
@end
