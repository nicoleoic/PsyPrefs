//
//  ViewController.m
//  PsyPrefs
//
//  Created by Nicole Alana Grace on 2018-07-04.
//  Copyright © 2018 The O.I.C., FOSS under GPL.
//

#import "ViewController.h"


@implementation ViewController

@synthesize updateDropdown, updateStr, iTunesDropdown, iTunesStr, ssFiletypeDropdown, ssFiletypeArray, ssFiletypeStr, ssLocationStr, ssBrowseButton, ssLocationField, defaults;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // set up the Apple Update objects + views.
    [self setupUpdate];
    
    // set up the iTunes objects + views.
    [self setupiTunes];
    
    // set up the Screenshot objects + views.
    [self setupSS];
    
    // set up the user preferences.
    [self setupPrefs];
    
}

- (void) setupUpdate {
    
    // add on/off to update dropdown
    [updateDropdown addItemsWithTitles:[NSArray arrayWithObjects:@"On",@"Off",nil]];
    [updateDropdown setAction:@selector(changeUpdateSettings:)];
    [updateDropdown setTarget:self];
    
}

- (void) setupiTunes {
    
    // add on/off to update dropdown
    [iTunesDropdown addItemsWithTitles:[NSArray arrayWithObjects:@"On",@"Off",nil]];
    [iTunesDropdown setAction:@selector(changeiTunesSettings:)];
    [iTunesDropdown setTarget:self];
    
}


- (void) setupSS {
    
    // define the supported filetypes for
    // screenshots. these won't change
    // unless MacOS changes them.
    ssFiletypeArray = [NSArray arrayWithObjects:@".png",@".jpg",@".gif",@".pdf",@".tiff", nil];
    // add the filetypes to the drop down.
    [ssFiletypeDropdown addItemsWithTitles:ssFiletypeArray];
    // add actions to the drop down.
    [ssFiletypeDropdown setAction:@selector(changeSSFiletype:)];
    [ssFiletypeDropdown setTarget:self];
    
    
    
}

- (IBAction)changeUpdateSettings:(id)sender {
    
    // set the path for the AppleScripts.
    NSString *path;
    
    // determine which AppleScript to use based on selection.
    if([[sender titleOfSelectedItem] containsString:@"On"]){
        path = [[NSBundle mainBundle] pathForResource:@"updates-enable" ofType:@"scpt"];
        updateStr = @"On";
    } else if([[sender titleOfSelectedItem] containsString:@"Off"]){
        path = [[NSBundle mainBundle] pathForResource:@"updates-disable" ofType:@"scpt"];
        updateStr = @"Off";
    }
    
    [defaults setObject:updateStr forKey:@"updateStr"];
    [self executeAppleScript:path];
    
}

- (IBAction)changeiTunesSettings:(id)sender {
    
    // set the path for the AppleScripts.
    NSString *path;
    
    // determine which AppleScript to use based on selection.
    if([[sender titleOfSelectedItem] containsString:@"On"]){
        path = [[NSBundle mainBundle] pathForResource:@"itunes-enable" ofType:@"scpt"];
        iTunesStr = @"On";
    } else if([[sender titleOfSelectedItem] containsString:@"Off"]){
        path = [[NSBundle mainBundle] pathForResource:@"itunes-disable" ofType:@"scpt"];
        iTunesStr = @"Off";
    }
    
    [defaults setObject:iTunesStr forKey:@"iTunesStr"];
    [self executeAppleScript:path];
    
}

- (IBAction)changeSSFiletype:(id)sender {

    // set the path for the AppleScripts.
    NSString *path;
    
    // determine which AppleScript to use based on selection.
    if([[sender titleOfSelectedItem] containsString:@"png"]){
        path = [[NSBundle mainBundle] pathForResource:@"ss-png" ofType:@"scpt"];
        ssFiletypeStr = @".png";
    } else if([[sender titleOfSelectedItem] containsString:@"jpg"]){
        path = [[NSBundle mainBundle] pathForResource:@"ss-jpg" ofType:@"scpt"];
        ssFiletypeStr = @".jpg";
    } else if([[sender titleOfSelectedItem] containsString:@"pdf"]){
        path = [[NSBundle mainBundle] pathForResource:@"ss-pdf" ofType:@"scpt"];
        ssFiletypeStr = @".pdf";
    } else if([[sender titleOfSelectedItem] containsString:@"gif"]){
        path = [[NSBundle mainBundle] pathForResource:@"ss-gif" ofType:@"scpt"];
        ssFiletypeStr = @".gif";
    } else if([[sender titleOfSelectedItem] containsString:@"tiff"]){
        path = [[NSBundle mainBundle] pathForResource:@"ss-tiff" ofType:@"scpt"];
        ssFiletypeStr = @".tiff";
    }
    
    [defaults setObject:ssFiletypeStr forKey:@"ssFiletypeStr"];
    [self executeAppleScript:path];
    
}

- (void) executeAppleScript:(NSString *)path {
    
    // run the AppleScript.
    NSURL* url = [NSURL fileURLWithPath:path];
    NSDictionary* errors = [NSDictionary dictionary];
    NSAppleScript* appleScript = [[NSAppleScript alloc] initWithContentsOfURL:url error:&errors];
    NSDictionary *dict = nil;
    NSAppleEventDescriptor *descriptor = [appleScript executeAndReturnError:&dict];
    
    NSLog(@"%@", descriptor);
    NSLog(@"%@", dict);
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void) setupPrefs {
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"updateStr"]){
        updateStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"updateStr"];
        [updateDropdown setTitle:updateStr];
    } else {
        updateStr = @"On";
        [[NSUserDefaults standardUserDefaults] setObject:updateStr forKey:@"updateStr"];
        [updateDropdown setTitle:updateStr];
    }
    
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"iTunesStr"]){
        iTunesStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"iTunesStr"];
        [iTunesDropdown setTitle:iTunesStr];
    } else {
        iTunesStr = @"On";
        [[NSUserDefaults standardUserDefaults] setObject:iTunesStr forKey:@"iTunesStr"];
        [iTunesDropdown setTitle:iTunesStr];
    }
    
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"ssFiletypeStr"]){
        ssFiletypeStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"ssFiletypeStr"];
        [ssFiletypeDropdown setTitle:ssFiletypeStr];
    } else {
        ssFiletypeStr = @".png";
        [[NSUserDefaults standardUserDefaults] setObject:ssFiletypeStr forKey:@"ssFiletypeStr"];
    }
    
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"ssLocationStr"]){
        ssLocationStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"ssLocationStr"];
        [ssLocationField setStringValue:ssLocationStr];
    } else {
        ssLocationStr = @"~/Desktop";
        [[NSUserDefaults standardUserDefaults] setObject:ssLocationStr forKey:@"ssLocationStr"];
        [ssLocationField setStringValue:ssLocationStr];
    }
    
    
}

// open a dialog to choose a new screenshot location
- (IBAction)changeSSLocation:(id)sender {
    
    // Create the File Open Dialog class.
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    // Disable the selection of files in the dialog.
    [openDlg setCanChooseFiles:NO];
    // Multiple files not allowed
    [openDlg setAllowsMultipleSelection:NO];
    // We should only be able to select directories.
    [openDlg setCanChooseDirectories:YES];
    // And we should allow the user to create a new one.
    [openDlg setCanCreateDirectories:YES];
    
    // Display the dialog and process user input.
    if ( [openDlg runModal] == NSModalResponseOK )
    {
        // Get the folder's URL.
        NSString *url = [[openDlg URL] absoluteString];
        // It returns with file://, so let's remove that.
        if([url containsString:@"file://"]) {
            url = [url stringByReplacingOccurrencesOfString:@"file://" withString:@""];
        }
        
        // We'll compose our AppleScript here, inline,
        // as we need to generate the NSString in real-time to
        // add our URL.
        NSString *appleScriptStr = [NSString stringWithFormat:@"do shell script \"defaults write com.apple.screencapture location %@ jpg;killall SystemUIServer\" with administrator privileges",url];
        NSLog(@"AppleScript: %@",appleScriptStr);
        // Create an AppleScript object.
        NSAppleScript* scriptObject = [[NSAppleScript alloc] initWithSource:appleScriptStr];
        NSDictionary* errorDict;
        NSAppleEventDescriptor* returnDescriptor = NULL;
        // Execute the AppleScript.
        returnDescriptor = [scriptObject executeAndReturnError: &errorDict];
        // And update the UI.
        ssLocationStr = url;
        [[NSUserDefaults standardUserDefaults] setObject:ssLocationStr forKey:@"ssLocationStr"];
        [ssLocationField setStringValue:ssLocationStr];
        
    }
    
}

@end
