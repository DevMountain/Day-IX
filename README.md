Day-X
=====

A simple iOS app that acts as a journal with persistent store

##Objectives
Review principles of the UITableView datasource and delegate and the UITextField delegate. Add storage via NSUserDefaults, and then add custom model objects.

##Interface Builder and Text Field Delegate

###Step 1: Add a new ViewController as your root view controller
- Create a new UIViewController subclass called DetailViewController **(make sure to select "Also create XIB file")**
- Initialize and add the view controller as the root of a UINavigationController to the rootViewController of the window

###Step 2: Add a text field to the view controller
- Add an IBOutlet UITextField property to the interface in the implementation file
- Add a UITextField to the top of the view controller in your XIB
- Wire up the UITextField 'referencing outlet' to the 'textField' outlet on the view controller
- Declare the viewcontroller as a UITextFieldDelegate
- Add the textFieldShouldReturn method to the class 
- In the method have the textField resign first responder
- In the viewDidLoad method set self as the delegate of the textField

###Step 3: Add a text view to the view controller
- Add an IBOutlet UITextView property to the interface in the implementation file
- Add a UITextView just under the title field the view controller in your XIB
- Wire up the UITextView 'referencing outlet' to the 'textView' outlet on the view controller
- Declare the viewcontroller as a UITextViewDelegate
 
###Step 4: Add a clear button to the view controller
- Add a IBOutlet UIButton property to the interface in the implementation file
- Add a UIButton just to the right of the title field above the text view in the view controller in your XIB
- Wire up the UIButton 'referencing outlet' to the 'button' outlet on the view controller
- Add an IBAction method called clear to your implementation file
- Wire up the UIButton 'TouchUpInside' control event to your action
- In the action set the title field and text view's content to empty strings


##NSDictionaries and NSUserDefaults

###Step 5: Add save
- Add a save: method to DetailViewController
- In the textFieldDidEndEdinting method call save
- In the textViewDidChange method call save

###Step 6: Store title and text to NSUserDefaults
- Add a static key for entry
- Add a static key for title
- Add a static key for text
- In the save method create a dictionary with the title string for the title key and the text string for text key
- Store the dictionary in NSUserDefaults for the entry key

###Step 7: Update the view with a dictionary
- Add an updateWithDictionary method that accepts a dictionary
- Retrieve a string from the dictionary with the title key and update the title field
- Retrieve a string from the dictionary with the text key and update the text view

###Step 8: Retrieve entry from NSUserDefaults
- In the viewDidLoad method retrieve a dictionary from user defaults for the entry key
- Call the updateWithDictionary method and pass in the dictionary

##Custom Model Objects and UITableView

###Step 9: Create an Entry Object
- Create an Entry with properties:
  - Title (NSString strong)
  - Text (NSString strong)
  - Timestamp (NSDate strong)

###Step 10: Add Dictionary Representations of Entries
- Add two methods to the header of Entry
  - -(NSDictionary *)entryDictionary
  - -(id)initWithDictionary:(NSDictionary *)dictionary
- Add the methods to the implementation file
- Add a const key for each of the properties (i.e. titleKey, textKey)
- In the dictionary method create a mutable dictionary and then add each of the properties for their key
  - Note: You can't insert a nil object. So you'll want to check those objects before you add them
  - if (title != nil) { [dictionary addObject:title forKey:titleKey] }
- In the init method you'll set the properties to the values for keys from the dictionary

###Step 11: Add methods to store and retrieve Entries from NSUserDefaults
- Add two methods to the header of Entry
  - + (NSMutableArray *)loadEntriesFromDefaults
  - + (void)storeEntriesInDefaults:(NSArray *)entries
- Add the methods to the implementation file
  - For the loadFromDefaults you'll have 4 steps
    - Get the entryDictionaries from NSUserDefaults for the entryListKey
    - Create a mutable array called entries
    - Iterate through (for loop) the dictionaries in entryDictionaries and for each dictionary intialize an entry and put that entry in the mutable entries array
    - Return the mutable array
  - For the storeEntriesInDefaults method you'll have 3 steps
    - Create a mutable array called entryDictionaries
    - Iterate through (for loop) the entries passed in and for each entry add the dictionary representation to entryDictionaries
    - Save entryDictionaries to NSUserDefaults for the entryListKey

###Step 12: Create a ListViewController and add to window's rootViewController
- Create a UIViewController called ListViewController
- In the AppDelegate didFinishLaunching method initialize a UINavigationController with a listViewController instance as the rootViewController
- Make the navigationController the rootViewController of the window.

###Step 13: Add a new tableViewDatasource
- Create a NSObject subclass called ListTableViewDataSource
- In the header file, adopt the UITableViewDataSource protocol 
- Add the required UITableViewDataSource methods to the implementation file
- In numberOfRows call LoadEntriesFromDefaults and return the count
- In cellForRowAtIndexPath return a cell with the textLabel.text get the entries from LoadEntriesFromDefaults and set to Entry at indexPath.row in the array
- Add a registerTableView method that takes a tableView parameter. In that method register a UITableViewCell to the tableview 

###Step 14: Add a tableview to the view
- Add a UITableView as a property on the listViewController class
- Initialize and add the tableView as a subview of the main view
- Add a ListTableViewDataSoure as a property on the listViewController class
- Initialize a listTableViewDataSource and set it to self.dataSource
- Set self.tableView.dataSource = self.dataSource
- Register self.tableView with the datasource

###Step 17: Add a new entry button
- Create a method - (IBAction)add:(id)sender;
- In that method instatiate a detailViewController and push it on your navigationController
- Instatiate a UIBarButtonItem with the add: method as the selector. 
- Set the UIBarButtonItem as the right bar button item.

###Step 16: Handle tableViewCellSelection
- Set listViewController as the delegate of it's tableView
- in the didSelectRow method immediately deselect the cell

###Step 17: Update save in your detailViewController
- Add an Entry property to the detailViewController
- Create a right barButtonItem in the viewDidLoad method that calls save:
- In the save method check to see if self.entry == nil
- If it's nil create a new entry and set it to self.entry
- Set the properties of self.entry to the title and textfield text values
- Grab the array of entries from [Entry loadEntriesFromDefaults]
- And self.entry to the array
- Call [Entry storeEntriesInDefaults:self.entry] and pass in self.entry
- Pop the viewController

##Object Controllers

###Step 18: Create an EntryController Object
- Create an EntryController with property:
  - Entries (NSArray strong, readonly)
- And methods:
  - + (EntryController *)sharedInstance
  - - (void)addEntry:(Entry *)entry
  - - (void)removeEntry:(Entry *)entry
  - - (void)replaceEntry:(NSDictionary *)oldEntry withEntry:(NSDictionary *)newEntry
  
The shared instance method should be defined to match the gist here:
https://gist.github.com/jkhowland/89e24b5fb6e1b5048eb5

The addEntry method needs to create a mutable version of the controller's entries array, add the entry that's passed in, and then re-set the controller's Entries array.

The removeEntry method needs to do the reverse. It should create a mutable copy of the entries array, remove the entry that was passed in, and then re-set the controllers Entries array.

The replaceEntry method needs to find the index of the oldEntry and replace it if it exists. It should create a mutable copy of the entries array, check to see if it contains oldEntry, and then if it does find the index and replace object at index.

###Step 19: Update the controller to store the dictionary Entries to NSUserDefaults
- Add a method 'loadFromDefaults'
  - Add a static string for the entryListKey
  - Get an arry "entryDictionaries" from NSUserDefaults for the entryListKey
  - Set self.entries to entryDictionaries
  - Call loadFromDefaults in the sharedInstance method
- Add a method 'synchronize'
  - Save self.entries to NSUserDefaults for key entryListKey
  - Call this method at the end of addEntry and removeEntry and replaceEntry methods

###Step 20: Make the updateWithDictionary method public
- Add an NSDictionary *dictionary as a property of the detailViewController
- Add the updateWithDictionary method to the header file

###Step 21: Update the save method in DetailViewController
- Instantiate a UIBarButtonItem called saveButton with save: as the selector
- Set the UIBarButtonItem to the rightBarButtonItem of the navigationItem
- In the save method check to see if self.dictionary is nil
  - If it is nil, call [EntryController sharedInstance] addEntry 
  - If it is not nil, call [EntryController sharedInstance] replaceEntry and pass in self.dictionary as the one to be replaced

###Step 20: Update the detailViewController with an entry 
- Add @class Entry; to the header view
- Andd the method to updateWithEntry:(Entry *)entry;
- In the updateWithEntry method
  - Store the Entry passed in to the entry property
  - Set the text of your title and text to the entry's values
- In the viewDidLoad method 
  - Set the text of your title and text to the entry's values
- In the save method, update your entry object with the text and title values
- Check to see if self.entry != nil and the if it does create a new self.entry with entry



##Core Data

###Step 21: Add a Core Data model and replace Entry object
- In "File -> New" create a file called Model.xcdatamodel
- Click the add Entity button at the bottom of the window
- Name the entity Entry, and give it title, text and timestamp properties with appropriate types
- Delete the Entry files you already have
- In Editor, Create NSManagedObject subclass, export an Entry object

###Step 22: Create a Core Data stack file
- Create a file called DBStack
- Add CoreData and DBStack to the prefix.pch file
- Give DBStack a sharedInstance class method
- Give it a readonly managedObjectContext property

###Step 23: Set up your DBStack
- Create a method called setupManagedObjectContext
- You're going to need 3 things:
 - StoreURL, ModelURL and ManagedObjectModel
  - The storeURL is a URL to your documents directory with a sqlite file for you to name. I typically just name mine db.sqlite
  - The modelURL is a URL to your bundle files with the name Model (or whatever you named your core data model file) and the extension momd
  - The managedObjectModel should be a NSManagedObjectModel with the contents of modelURL
  - Then you an instantiate your self.managedObjectContext in the setupManagedObjectContext method using these values.
 - You can put them inline in your setupManagedObjectContext method, or you can separate them out
- In the init method (or sharedInstance method) call setupManagedObjectContext

###Step 24: Update your EntryController
- You need to update the add method so that it's addEntryWithTitle:(NSString *)title text:(NSString *)text date:(NSDate *)date.
 - You can keep using a dictionary if you want, but this is a bit more simple
- Remove the replace entry method. We can now update entries in place.
- Don't you love deleting code? 
 - Delete the entryListKey 
 - Delete the entries property
 - Delete the 'loadFromDefaults' method and callers
 - Delte the addEntryMethod
- Update the entries method to use a fetchRequest to get the list of entries. For now just return them all.
 - Later we could add search text as a parameter of the fetchRequest
- Add the addEntryWithTitle:text:date: method
 - Insert a new entity assign the properties and then call synchronize.
- Update the removeEntry method
 - Delete the entry from it's own managedObjectContext and then synchronize
- The synchronize method should just call save on the main managedObjectContext
- Make synchronize a public method

###Step 25: Update the save method in your detail view controller
- If there is an entry, update the properties and call synchronize
- If there isn't an entry, call addEntryWithTitle:text:date: and pass in the values. 
 
#Boom.
