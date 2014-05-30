Day-X
=====

A simple iOS app that acts as a journal with persistent store

##Objectives
Review principles of the UITableView datasource and delegate and the UITextField delegate.

###Step 1: Add a new ViewController as your root view controller
- Create a new List view controller
- Add the view controller in nav controller to the rootViewController of the window

###Step 2: Add a tableview to the list view with a datasource
- Create a new ListTableViewDataSource object
- Copy the Entry and EntryController classes from your [previous project](https://github.com/DevMountain/Entries)
- Add the TableViewDataSource methods to your ListTableViewDataSource
	- The numberOfRows should return the number of entries in the EntryController sharedInstance
	- The cellForRow should set the title of the cell to the tile of the entry at the index path in the EntryController sharedInstance's array of entries
- Add tableview and datasource properties your List view controller
- Initialize the tableview and add it to your view controller's view
- Initialize the datasource and set it to the tableview's datasource
- Register the cells on the tableview in the datasource
- Set the viewController as the delegate to the tableview

###Step 3: Add an entry (detail) view controller
- Create an EntryViewController with an XIB file
- Add an Entry property on the view controller
- Add a TextView and TextField as IBOutlet properties on the ViewController
- Add the TextView and TextField to the XIB file and wire them to their outlets
- Wire the delegate of the TextView and TextField to File's Owner as well
- Add the TextView delegate method to the viewController's implementation file: 
	- textViewDidChange should save the text to self.entry.note
- Add the TextField delegate methods to the viewController's implementation file:
	- shouldReturn should resign the first responder in that method
	- shouldEndEditing should save the text to self.entry.title
- In the viewDidLoad method
	- Update the titleField to the title of the self.entry
	- Update the notesView to the notes of the self.entry
	
###Step 4: Add a plus button to add another Entry
- Create a UIBarButtonItem with a type of SystemItemAdd and newEntry selector
- Create a newEntry method 
- In the newEntry method add a blank entry to the EntryController sharedInstance
  - Entry *entry = [Entry new];
  - [[EntryController sharedInstance] addEntry:entry];
  - Initialize an EntryViewController, set the entry property to the one you just created and push.
- Have the list viewcontroller reload it's data every time it appears:
	- In the viewWillAppear method (you may have to add it)
		- call synchronize on the entryController
		- reload the tableView's data

###Step 5: Load the entry view when a user taps a cell
- Add the didSelectRowAtIndexPath method to your list view controller
- In that method instantiate an entryViewController
- Get the entry from the EntryController sharedInstance's entries at that indexPath.row
- Set the entryViewController's entry to the retrieved entry
- Push the entryViewController
