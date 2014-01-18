//
//  RMViewController.m
//  MTRadialMenu
//
//  Created by Michael Timbrook on 1/14/14.
//  Copyright (c) 2014 Timbrook. All rights reserved.
//

#import <MTRadialMenu/MTRadialMenu.h>

#import "RMViewController.h"
#import "AddNote.h"
#import "AddImage.h"

@interface RMViewController ()

@property (weak, nonatomic) IBOutlet UILabel *output;

@end

@implementation RMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Create the menu, don't set a frame as it it gets overridden anyway
    MTRadialMenu *menu = [MTRadialMenu new];

    // Configure options
    // Configure before adding menu items
    menu.startingAngle = 10.0;
    menu.incrementAngle = -60.0;

    // Create some menuitems that are subclasses of MTMenuItem, and set their itentifiers
    AddNote *note = [AddNote new];
    note.identifier = @"A Note";

    AddImage *image = [AddImage new];
    image.identifier = @"An Image";

    // Now add the items to the menu, order matters
    [menu addMenuItem:note];
    [menu addMenuItem:image];

    // Register the UIControlEvents
    [menu addTarget:self action:@selector(menuSelected:) forControlEvents:UIControlEventTouchUpInside];

    // If you want to do anything when the menu appears (like bring it to the front)
    [menu addTarget:self action:@selector(menuAppear:) forControlEvents:UIControlEventTouchDown];

    // The add to the view
    [self.view addSubview:menu];
}

- (void)menuSelected:(MTRadialMenu *)sender
{
    [_output setText:sender.selectedIdentifier];
}

- (void)menuAppear:(MTRadialMenu *)sender
{
    [self.view bringSubviewToFront:sender];
}

@end
