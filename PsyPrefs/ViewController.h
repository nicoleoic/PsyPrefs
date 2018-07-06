//
//  ViewController.h
//  PsyPrefs
//
//  Created by Nicole Alana Grace on 2018-07-04.
//  Copyright © 2018 The O.I.C., FOSS under GPL.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSMenuDelegate> {
    
    // user defaults
    NSUserDefaults *defaults;
    
    // Dropdown for Apple Update notifications.
    NSPopUpButton *updateDropdown;
    // String for Apple Update notifications.
    NSString *updateStr;
    
    // Dropdown for iTunes preference.
    NSPopUpButton *iTunesDropdown;
    // String for Apple Update notifications.
    NSString *iTunesStr;
    
    // array for screenshot file types
    NSArray *ssFiletypeArray;
    // dropdown for screenshot file types
    NSPopUpButton *ssFiletypeDropdown;
    // string for current screenshot file type
    NSString *ssFiletypeStr;
    // string for current screenshot location
    NSString *ssLocationStr;
    // text box for screenshot location
    NSTextField *ssLocationField;
    // button for screenshot location browse
    NSButton *ssBrowseButton;
    
}

@property (nonatomic,retain) NSUserDefaults *defaults;

// TODO: these don't need to be synthesized.
// i'm just too old-school for my own good.
@property (nonatomic,retain) IBOutlet NSPopUpButton *updateDropdown;
@property (nonatomic,retain) NSString *updateStr;
@property (nonatomic,retain) IBOutlet NSPopUpButton *iTunesDropdown;
@property (nonatomic,retain) NSString *iTunesStr;
@property (nonatomic,retain) NSString *ssFiletypeStr;
@property (nonatomic,retain) NSString *ssLocationStr;
@property (nonatomic,retain) NSArray *ssFiletypeArray;
@property (nonatomic,retain) IBOutlet NSPopUpButton *ssFiletypeDropdown;
@property (nonatomic,retain) IBOutlet NSTextField *ssLocationField;
@property (nonatomic,retain) IBOutlet NSButton *ssBrowseButton;

// IBActions for linking to the Interface builder storyboard.
- (IBAction)changeUpdateSettings:(id)sender;
- (IBAction)changeiTunesSettings:(id)sender;
- (IBAction)changeSSFiletype:(id)sender;
- (IBAction)changeSSLocation:(id)sender;


@end

