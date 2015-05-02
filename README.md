Day-X
=====

A simple iOS app that acts as a journal with persistent store. 

#### Looking for Day-X? This repository will still be used as solution code for some concepts, but for the initial build of Day-X, use the [new repository and README](http://github.com/devmountain/day-x).

##Objectives
Review principles of the UITableView datasource and delegate and the UITextField delegate. Add storage via NSUserDefaults, and then add custom model objects.

##Interface Builder and Text Field Delegate

###Step 1: Add a new ```DetailViewController``` as your root view controller
- Create an empty Storyboard file using File -> New File -> User Interface -> Storyboard
- Add a new View Controller object to the Storyboard canvas, embed it in a UINavigationController, and set the UINavigationController as the Initial View Controller in the Storyboard
- Create a new UIViewController subclass called ```DetailViewController```, and set the class of the View Controller in your Storyboard to your ```DetailViewController```
- Initialize and add the view controller as the root of a UINavigationController to the ```rootViewController``` of the window

```self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateInitialViewController]```

###Step 2: Add a text field to the view controller
- Add a UITextField to the top of the view controller in your XIB
- Add an IBOutlet UITextField property to the interface in the implementation file
- Wire up the UITextField 'referencing outlet' to the 'textField' outlet on the view controller
- Wire up the UITextField to the DetailViewController as the delegate
- Add the ```textFieldShouldReturn``` method to the class 
- In the method, have the ```textField``` resign first responder
- In the ```viewDidLoad``` method set ```self``` as the delegate of the ```textField```

###Step 3: Add a text view to the view controller
- Add an IBOutlet UITextView property to the interface in the implementation file
- Add a UITextView just under the title field the view controller in your XIB
- Wire up the UITextView 'referencing outlet' to the 'textView' outlet on the view controller
- Declare the viewcontroller as a ```<UITextViewDelegate>```
 
###Step 4: Add a clear button to the view controller
- Add a IBOutlet UIButton property to the interface in the implementation file
- Add a UIButton just to the right of the title field above the text view in the view controller in your XIB
- Add an IBAction method called ```clear``` to your implementation file
- Wire up the UIButton 'TouchUpInside' control event to your action
- In the action set the title field and text view's content to empty strings


##NSDictionaries and NSUserDefaults

###Step 5: Add save
- Add a ```save``` method to ```DetailViewController```
- Implement the ```textFieldDidEndEditing``` delegate method and, in the ```textFieldDidEndEditing``` method, call save
- Repeat with ```textViewDidChange``` delegate method
- *Don't forget to set the UITextView's ```delegate``` to ```self```*

###Step 6: Store title and body text to NSUserDefaults
- Add a static key for entry
- Add a static key for title
- Add a static key for body text
- In the ```save``` method, create a dictionary with the title string for the title key and the body text string for body text key
- Store the dictionary in NSUserDefaults for the entry key

###Step 7: Update the view with a dictionary
- Add an ```updateViewWithDictionary:``` method that accepts a dictionary
- Retrieve a string from the parameter dictionary with the title key and update the title field
- Retrieve a string from the parameter dictionary with the text key and update the text view

###Step 8: Retrieve entry from NSUserDefaults
- In the ```viewDidLoad``` method retrieve a dictionary from user defaults for the entry key
- Call the ```updateWithDictionary:``` method and pass in the dictionary retrieved above

##Custom Model Objects and UITableView

###Step 9: Create an Entry Object
- Create an ```Entry``` subclass (of NSObject) with public properties:
  - ```title``` (NSString*  strong)
  - ```bodyText``` (NSString*  strong)
  - ```timestamp``` (NSDate* strong)

###Step 10: Add Dictionary Representations of Entries
- Add two methods to the header of Entry
  - ```-(NSDictionary *)entryDictionary;```
  - ```-(id)initWithDictionary:(NSDictionary *)dictionary;```
- Add the methods to the implementation file
- Add a static key for each of the properties (i.e. ```titleKey```, ```bodyKey```)
- In the ```entryDictionary``` method, create a mutable dictionary and then add each of the properties for their key
  - Note: You can't insert a nil object. So you'll want to check those objects before you add them
  - ```if (title != nil) { [dictionary addObject:title forKey:titleKey] }```
- In the ```initWithDictionary:``` method you'll set the properties to the values for keys from the dictionary parameter

###Step 11: Add methods to store and retrieve Entries from NSUserDefaults
- Add two methods to the header of ```Entry```
  - ```+ (NSMutableArray *)loadEntriesFromDefaults;````
  - ```+ (void)storeEntriesInDefaults:(NSArray *)entries;````
- Add the methods to the implementation file
  - For the ```loadEntriesFromDefaults``` you'll have 4 steps
    1. Get the ```dictionaryOfEntries``` from NSUserDefaults for the ```entryKey```
    2. Create a mutable array called ```entriesArray```
    3. Iterate through (for loop) the dictionaries in ```dictionaryOfEntries``` and for each: intialize an entry and put that entry in the mutable entries array
    4. Return the mutable array, ```entriesArray```
  - For the ```storeEntriesInDefaults:``` method you'll have 3 steps
    1. Create a mutable array called ```arrayOfEntryDictionaries```
    2. Iterate through (for loop) the entries passed in and for each entry add the dictionary representation to ```arrayOfEntryDictionaries```
    3. Save ```arrayOfEntryDictionaries``` to NSUserDefaults for the ```entryKey```

###Step 12: Create a ```ListViewController``` and add to window's rootViewController
- Create a UIViewController called ```ListViewController```
- In the ```AppDelegate``` ```didFinishLaunching``` method initialize a UINavigationController with a ```listViewController``` instance as the ```rootViewController```
- Make the ```navigationController``` the ```rootViewController``` of the window.

###Step 13: Add a new tableViewDatasource
- Create an NSObject subclass called ```ListTableViewDataSource```
- In the header file, adopt the ```<UITableViewDataSource>``` protocol 
- Add the required ```<UITableViewDataSource>``` methods to the implementation file
- In ```tableView:numberOfRowsInSection:``` call ```loadEntriesFromDefaults``` and return the ```count```
- In ```tableView:cellForRowAtIndexPath:``` return a cell with the ```textLabel.text``` set to the ```title``` of Entry
 - HINT: get the entries from ```loadEntriesFromDefaults``` and get the ```Entry``` at ```indexPath.row``` in the array
- Add a public ```registerTableView:``` method that takes a UITableView parameter. 
- In that method, register a UITableViewCell to the tableView 

###Step 14: Add a tableview to the view
- Add a UITableView as a property on the ```ListViewController``` class
- Initialize and add the ```tableView``` as a subview of the main view
- Add a ```ListTableViewDataSource``` as a property on the ```ListViewController``` class
- Initialize a ```listTableViewDataSource``` and set it to ```self.dataSource```
- Set ```self.tableView.dataSource = self.dataSource```
- Register ```self.tableView``` with the ```dataSource```

###Step 15: Add a new entry button
- Create a method ```- (void)addNewEntry;```
- In that method instatiate a ```DetailViewController``` and ```push``` it on your navigationController
- Instatiate a UIBarButtonItem with the ```addNewEntry``` method as the selector. 
- Set the UIBarButtonItem as the right bar button item.

###Step 16: Handle tableViewCellSelection
- Set ```ListViewController``` as the ```delegate``` of it's tableView
- In the ```tableView:didSelectRowAtIndexPath``` method immediately deselect the cell

###Step 17: Update save in your ```DetailViewController```
- Add an Entry property to the ```DetailViewController```
- Create a right barButtonItem in the ```viewDidLoad``` method that calls save:
- In the save method check to see ```if (self.entry == nil)```
- If it's nil create a new entry and set it to ```self.entry```
- Set the properties of ```self.entry``` to the title and textfield text values
- Grab the array of entries from ```[Entry loadEntriesFromDefaults]```
- And ```self.entry``` to the array
- Call ```[Entry storeEntriesInDefaults:self.entry]``` and pass in self.entry
- ```Pop``` the viewController
- 
###Step 18: Remove code
- Remove ```NSDictionary *entryDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:entryKey]; [self updateViewWithDictionary:entryDictionary];``` from your ```DetailViewController``` ```viewDidLoad``` method
- Remove the call to ```save``` in the ```textFieldDidEndEditing:``` and ```textViewDidEndEditing```


##Object Controllers

An Object Controller should be the source of valid data for the entire app. In this case we will create an EntryController to manage our Entry objects and to handle communication between the view controllers and NSUserDefaults. The EntryController will be a shared instance with an NSArray property that holds all of the entries the app has saved. We will migrate our saveToDefaults and loadEntriesFromDefaults methods from the Entry object to the EntryController object as helper methods that will save our Entry objects as NSDictionaries into NSUserDefaults, and grab NSDictionaries from NSUserDefaults and convert them into Entry objects. 

###Step 19: Create an EntryController Object
- Create an EntryController with property:
  - Entries (NSArray strong, readonly)
- And methods:
  - + (EntryController *)sharedInstance
  - - (void)addEntry:(Entry *)entry
  - - (void)removeEntry:(Entry *)entry

The shared instance method should be defined to match the gist here:
https://gist.github.com/jkhowland/89e24b5fb6e1b5048eb5

The addEntry method needs to create a mutable version of the controller's entries array, add the entry that's passed in, and then re-set the controller's Entries array.

The removeEntry method needs to do the reverse. It should create a mutable copy of the entries array, remove the entry that was passed in, and then re-set the controllers Entries array.

The replaceEntry method needs to find the index of the oldEntry and replace it if it exists. It should create a mutable copy of the entries array, check to see if it contains oldEntry, and then if it does find the index and replace object at index.

###Step 20: Update the controller to store the dictionary Entries to NSUserDefaults
- Add a method 'loadFromDefaults' (similar to the loadFromDefaults method currently on Entry)
  - Add a static string for the entryListKey
  - Get an arry "entryDictionaries" from NSUserDefaults for the entryListKey
  - Set self.entries to entryDictionaries
  - Call loadFromDefaults in the sharedInstance method
- Add a method 'synchronize' (similar to the saveToDefaults method currently on Entry)
  - Save self.entries to NSUserDefaults for key entryListKey
  - This method will need to convert from Entry objects to NSDictionaries before saving to NSUserDefaults (entryDictionary)
  - Call this method at the end of addEntry and removeEntry and replaceEntry methods

###Step 21: Update the save method in DetailViewController
- Instantiate a UIBarButtonItem called saveButton with save: as the selector
- Set the UIBarButtonItem to the rightBarButtonItem of the navigationItem
- In the save method check to see if self.dictionary is nil
  - If it is nil, call [EntryController sharedInstance] addEntry 
  - If it is not nil, call [EntryController sharedInstance] replaceEntry and pass in self.dictionary as the one to be replaced

###Step 22: Update the detailViewController with an entry 
- Add @class Entry; to the header view (this is similar to importing, but we already imported Entry in the .m file, so we can use @class in the header)
- Add a method updateWithEntry:(Entry *)entry that will update the detail view
- Update your listViewController's didSelectRowAtIndexPath method to use the updateWithEntry method instead of updateWithDictionary
- In the updateWithEntry method
  - Store the Entry passed in to the entry property (self.entry)
  - Set the text of your title textField and text textView to the values from the entry object
- In the viewDidLoad method 
  - Set the text of your title and text to the entry's values
- In the save method, update your entry object with the text and title values
- Check to see if self.entry != nil and the if it does create a new self.entry with entry

##Core Data

###Step 23: Add a Core Data model and replace Entry object
- In "File -> New" create a file called Model.xcdatamodel
- Click the add Entity button at the bottom of the window
- Name the entity Entry, and give it title, text and timestamp properties with appropriate types
- Delete the Entry files you already have
- In Editor, Create NSManagedObject subclass, export an Entry object

###Step 24: Create a Core Data stack file
- Create a file called DBStack
- Add CoreData and DBStack to the prefix.pch file
- Give DBStack a sharedInstance class method
- Give it a readonly managedObjectContext property

###Step 25: Set up your DBStack
- Create a method called setupManagedObjectContext
- You're going to need 3 things:
 - StoreURL, ModelURL and ManagedObjectModel
  - The storeURL is a URL to your documents directory with a sqlite file for you to name. I typically just name mine db.sqlite
  - The modelURL is a URL to your bundle files with the name Model (or whatever you named your core data model file) and the extension momd
  - The managedObjectModel should be a NSManagedObjectModel with the contents of modelURL
  - Then you an instantiate your self.managedObjectContext in the setupManagedObjectContext method using these values.
 - You can put them inline in your setupManagedObjectContext method, or you can separate them out
- In the init method (or sharedInstance method) call setupManagedObjectContext

###Step 26: Update your EntryController
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

###Step 27: Update the save method in your detail view controller
- If there is an entry, update the properties and call synchronize
- If there isn't an entry, call addEntryWithTitle:text:date: and pass in the values. 

#Boom.
