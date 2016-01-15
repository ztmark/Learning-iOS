//
//  DetailViewController.m
//  Homepwner
//
//  Created by Mark on 16/1/10.
//  Copyright © 2016年 Mark. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "ImageStore.h"
#import "ItemStore.h"

@interface DetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;
@property (strong, nonatomic) UIPopoverController *imagePickerPopover;

@end

@implementation DetailViewController

- (IBAction)backgroundTapped:(UIControl *)sender {
    [self.view endEditing:YES];
}

- (IBAction)takePicture:(UIBarButtonItem *)sender {

    if ([self.imagePickerPopover isPopoverVisible]) {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
        return;
    }

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
//    [self presentViewController:imagePicker animated:YES completion:nil];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        self.imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        self.imagePickerPopover.delegate = self;
        [self.imagePickerPopover presentPopoverFromBarButtonItem:sender
                                        permittedArrowDirections:UIPopoverArrowDirectionAny
                                                        animated:YES];
    } else {
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self prepareViewsForSize:self.view.frame.size];

    BNRItem *item = self.item;
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];

    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItem) UIBarButtonItemStylePlain
                                                                                           target:self
                                                                                           action:@selector(hideKeyboard)];
    NSString *itemKey = self.item.itemKey;
    UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:itemKey];
    self.imageView.image = imageToDisplay;
}


- (void)hideKeyboard {
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.view endEditing:YES];

    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (void)setItem:(BNRItem *)item {
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (instancetype)initForNewItem:(BOOL)isNew {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                      target:self
                                                                                      action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                        target:self
                                                                                        action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
    }
    return self;
}

- (void)cancel:(id)cancel {
    [[ItemStore sharedStore] removeItem:self.item];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

- (void)save:(id)save {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];

}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"Use initForNewItem" userInfo:nil];
    return nil;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    image = info[UIImagePickerControllerEditedImage];
    [[ImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    self.imageView.image = image;
//    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.imagePickerPopover) {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *iv = [[UIImageView alloc] initWithImage:nil];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    iv.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:iv];
    self.imageView = iv;

    NSDictionary *nameMap = @{@"imageView": self.imageView, @"dateLabel": self.dateLabel, @"toolbar": self.toolbar};
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:nameMap];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[dateLabel]-8-[imageView]-8-[toolbar]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:nameMap];
    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:verticalConstraints];
    [self.imageView setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisVertical];
    [self.imageView setContentCompressionResistancePriority:700 forAxis:UILayoutConstraintAxisVertical];
}



- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self prepareViewsForSize:size];
}

- (void)prepareViewsForSize:(CGSize)size {
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return;
    }
    if (size.width > size.height) {
        self.imageView.hidden = YES;
        self.cameraButton.enabled = NO;
    } else {
        self.imageView.hidden = NO;
        self.cameraButton.enabled = YES;
    }
}


- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    NSLog(@"User dismissed popover");
    self.imagePickerPopover = nil;
}



@end



















