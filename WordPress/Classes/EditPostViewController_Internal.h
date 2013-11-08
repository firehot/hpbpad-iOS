//
//  EditPostViewController_Internal.h
//  WordPress
//
//  Created by Jorge Bernal on 1/24/13.
//  Copyright (c) 2013 WordPress. All rights reserved.
//

#import "EditPostViewController.h"
#import "PostSettingsViewController.h"
#import "PostMediaViewController.h"
#import "PostPreviewViewController.h"
#import "PostSEOViewController.h"

extern NSString *const EditPostViewControllerDidAutosaveNotification;
extern NSString *const EditPostViewControllerAutosaveDidFailNotification;

@interface EditPostViewController ()
@property (nonatomic, strong) PostSettingsViewController *postSettingsViewController;
@property (nonatomic, strong) PostMediaViewController *postMediaViewController;
@property (nonatomic, strong) PostPreviewViewController *postPreviewViewController;
@property (nonatomic, strong) PostSEOViewController *postSEOViewController;
@property (nonatomic, assign) EditPostViewControllerMode editMode;
@property (nonatomic, strong) AbstractPost *apost;
@property (readonly) BOOL hasChanges;

@property (nonatomic, strong) IBOutlet UIView *tagsView;
@property (nonatomic, strong) IBOutlet UIView *categoriesView;
@property (nonatomic, strong) IBOutlet UITextView *contentTextView;
@property (nonatomic, strong) IBOutlet UIButton *hasLocation;
@property (nonatomic, strong) IBOutlet UIToolbar *toolbar;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *photoButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *movieButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *settingsButton;

- (BOOL)autosaveRemoteWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure;
- (void)refreshButtons;
- (IBAction)switchToEdit;
- (IBAction)switchToSettings;
- (IBAction)switchToMedia;
- (IBAction)switchToPreview;
- (CGRect)normalTextFrame;
@end
