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
- Declare the viewcontroller as a UITextView
 
###Step 4: Add a clear button to the view controller
- Add a IBOutlet UIButton property to the interface in the implementation file
- Add a UIButton just to the right of the title field above the text view in the view controller in your XIB
- Wire up the UIButton 'referencing outlet' to the 'button' outlet on the view controller
- Add an IBAction method called clear to your implementation file
- Wire up the UIButton 'TouchUpInside' control event to your action
- In the action set the title field and text view's content to empty strings


Coming soon...

##NSDictionaries and NSUserDefaults

##Arrays and UITableView

##Custom Model Objects
