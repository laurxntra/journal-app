# Journal

## Student Information
Name: Lauren Tra

CSE netid: laurxnt

email: laurxnt@uw.edu

## Resources Used
Cite anything (website or other resource) or anyone that assisted you in creating your solution to this assignment.

Remember to include all resources you used to solve this assignment.
* Please acknowledge any help you got from TAs, instructors, or students by name.
* You do not need to include links to lecture/section material or flutter docs. However you do need to mention which Flutter classes or packages you viewed.
* You must include links to all StackOverflow, Medium, blogs, or other articles you used.
* If you used any Generative AI (ChatGPT, Gemini, CodePilot, or the like), please include the prompt(s) you used and how the result was or was not helpful.

If you did not use any resources beyond classroom/flutter docs, please state so explicitly.

What I asked ChatGPT:
- I am having issues where when I am typing in the textbox of my app (it is a textformfield), the bottom is overflowed by 35 pixels but it is only the keyboard portion, not a number pad
  - Ah, the infamous "Bottom overflowed by X pixels" Flutter issue—it’s a classic! Since you mentioned it only happens with the keyboard and not a number pad, it's likely due to how Flutter handles screen resizing when the keyboard appears.
  Potential Fixes:
  1. Wrap in a SingleChildScrollView The keyboard might be causing a layout overflow. Try wrapping your entire screen in a SingleChildScrollView:
  SingleChildScrollView(
    child: Column(
      children: [
        TextFormField(),
        // Other widgets
      ],
    ),
  )
  2. Use resizeToAvoidBottomInset: true in Scaffol Ensure your Scaffold has:
  Scaffold(
    resizeToAvoidBottomInset: true, // Helps prevennt overflow
    body: MyWidget(),
  )
  - This was actually incredibly helpful, I did both because Scaffold does not automatically shift content unless it is scrollable (which, I totally forgot to do), and allowing the layout to be resized for the bottom portion

- What is a good color scheme to use for a workout journal tracker?
  - For a workout journal tracker, you want a color scheme that feels motivating and energetic, yet easy on the eyes for reading and reflecting. Here’s a good approach:

  Primary Colors:

  Energetic and Vibrant (Accent colors): Consider using shades of orange, red, or yellow to invoke energy and motivation. These colors are often associated with physical activity and enthusiasm.

  Calming and Focused (Background colors): Use light gray, soft blues, or light greens for the background or general page areas. These colors are calming and easy on the eyes, which helps keep users focused.

- This was not very helpful, I ended up looking up on google for better design colors, link is provided to the website for reference below



- https://api.flutter.dev/flutter/widgets/PopScope-class.html
- https://api.flutter.dev/flutter/material/AppBar-class.html
- https://stackoverflow.com/questions/71480865/xcode-failed-to-register-bundle-identifier

I had a lot of issues with my XCode from AS5 and currently.. these websites helped me debug what was going on :'). Confused because the app works fine on my ipad but on my phone it does not work. References I used in case possibly others are facing the same type of errors I was getting and can be good reference!
- https://stackoverflow.com/questions/4770751/xcode-organizer-can-not-use-iphone-dyld-shared-cache-extract-dylibs-failed
- https://stackoverflow.com/questions/62487008/xcode-stuck-on-copying-cache-files-from-device-tvos
- https://discussions.apple.com/thread/255530174
- https://www.figma.com/resource-library/color-combinations/
- https://mypersonaltrainerwebsite.com/blog/how-to-use-color-psychology-to-create-the-perfect-fitness-website
- https://dart.dev/language/functions
- https://stackoverflow.com/questions/60222500/how-to-return-bool-value-with-navigator-pop
- https://stackoverflow.com/questions/77357118/getting-the-other-values-in-a-record-if-given-the-id-in-isar-database-using-flut
- https://api.flutter.dev/flutter/material/FloatingActionButton-class.html
- https://docs.flutter.dev/ui/navigation
- https://stackoverflow.com/questions/66279804/flutter-navigator-2-0-how-to-return-data-from-a-screen
- https://stackoverflow.com/questions/65029049/navigator-pop-with-argument
- https://isar.dev/tutorials/quickstart.html
- 



- All other resources are from lecture/section

## Design Vision

Describe the purpose of your app. 
* Identify who is a target user of your app and why it would be helpful to them (or you, if you are the target user).
* What functionality to you want in this app? 
* How do you want to make this aesthetically pleasing and easy to use? 
* What inclusive design principles did you focus on in your design? 
* What data will be stored in this app? 
- Purpose: 
  - Workout tracker

- Targeted users: 
  - People who enjoy fitness --> Want simple ways to track workouts
  - Beginners --> people who want an easy, beginner friendly logging system
  - Me --> I would love to create my own fitness tracker journey (have it be my own!!)

- Functionality:
  - The workout journal tracker should allow users to log different types of workouts by recording the title of the exercise day, exercise name, sets, reps, duration (for cardio), and weights used. It should also allow users to add notes for details (was not implemented in my app). Users should also be able to view, edit, and add entries easily

- Aesthetics:
  - I wanted the app to mainly be simple and easy to use with minimal color schemes that also helped motivates users (I referenced online what color schemes would go along with workouts). 

- Inclusive Design Principles:
  - I wanted to make sure that there will be semantics labeling for those that rely on VoiceOver while using the app, also making sure that the color scheme used is easy for those that may have some sort of vision impairments.

- Data Design: 
  - String exerciseName --> name of exercise
  - int sets --> number of sets done
  - int reps --> number of repetitions done
  - int duration --> how long (for runners)
  - String notes --> Additional notes (did not implement in app)
  - DateTime createAt --> time when entry was created
  - DateTime editedAt --> time when entry was edited
  - int weight --> number of weight added 


Where in your repo can we find the design sketches that you made?
- Folder named "prototype" will have my sketches in there

Answer here: (delete this prompt)

What was different in your final product from your original vision and sketches? If you were able to fully complete the app you designed, please list 1-2 things you would like to change in your app or add to your app if you had more time? 
- One thing that was different from my original vision compared to my final product was adding the notes feature. I did not have time to implement this.
- I would definitely add the notes section that intended on planning if I had more time as well as maybe a search/filter at the top of the page to allow users to filter through their workouts based off the type of "day" they wrote down

## Metadata

Git Commit ID for end of Part 3.2:
- At some point I had 2 as6-journal-laurxnt because I was having A LOT of issues with xcode.. praying that this one that I commited is the one where I had all the journal mockups in... if not.. I SWEAR I DID IT! I just don't know if I commited/pushed the wrong one :') (gitlab shows its the correct one... so i'm hoping my dumb mistake did not ruin this portion lol)
- d6119af8


## Code comprehension questions

### `JournalEntry`

The `JournalEntry` starter code includes three constructors. Explain how these three constructors fit together, and what their holistic purpose is as a set.
- These constructors work hand in hand by handling data. It allows users to have a blank journal entry, as well as allowing for manual entry for when they create, as well as modification and preserving the previous data that was jotted down.

When you create the `entries` getter in `Journal`, why is copying the list alone sufficient? i.e. why don't we need to do a deep copy, i.e. making a new list with copies of all the `JournalEntry` elements?
- Copying the list alone is sufficient because the JournalEntry objects are final, so once the entry is created it can not be changed, but can be edited by creating a new instance and updating the values using upsertEntry()

What capabilities does the ensemble of `Journal`, `JournalEntry`, and `SequentialIDMaker` give us? If we wanted to (from the user's point of view) edit a `JournalEntry`, how can we do that with these classes, even though `JournalEntry` is immutable? Have you seen this pattern before or is it new to you?
- JournalEntry gives us a single entry with a unique ID, exercise name, sets, reps, etc.
- Journal allows us to store multiple JournalEntryies, it uses _entries list to manage any edits or additions to the journal entry
- SequentialIDMaker automatically assigns ids, allowing each entry to be unique and easier to manage.

- Since JournalEntry fields are final, we can not modify directly, so what we're doing is creating a new JournalEntry instance with the modified values by using upsertEntry(), we are replacing the old entry with the new one with the same id, just different data. 

- I have seen this pattern before in my previous data classes that I have taken at UW.

### `JournalProvider`

How else could we have implemented `JournalProvider` and `Journal` to give the same consistency guarantees as we have but without the proxy and clone structure we implemented here? What are the pros/cons of this way vs. what you come up with?
- Another way to set up JournalProvider and Journal without using a proxy or clone is to make the journal something you can not change directly and replace it completely whenever someone updates the journal. 
- Pros:
  - Easier to track when changes happen since we always need to replace the whole thing
  - Works well with Provider and other management tools
- Cons:
  - Less efficient, has to build the entire journal over and over again rather than one element
  - Less convenient


### Robustness

What could go wrong when running the app prior to adding persistent data using the `Isar` system? 
- When running the app prior to adding persistent data using the Isar system, data could be lost during restart. Since there is no persistent storage, any of the user entered data can be lost when the app is closed/restarted during this process.


What could go wrong with your app after adding the journal persistence? For example, given how we have implemented the persistence, what are the circumstances under which a user could lose their journal data? What are the circumstances where someone else could gain access to their data? What other issues can you think of that could be problematic? 
- A circumstand which users could lose their journal data is possibly by uninstalling the app. This would delete all the stored workout journal entries. 
- If someone's device was stolen they could possibly extract those data files from the user's workout journal (not really sure why anyone would want that though unless they are gatekeeping their workout ;p, but in other more~ important cases!! Their data would not be secure unless there is additional security on the app)
- If a user puts down too many journal entries or uses it frequently, the speed of the reloading the exercises could slow down the app
 

What could you do to change the design and implementation of your app to mitigate these risk?
- Have automatic backups stored of the journal entries
- Have secure login/passwords similar to a social media account
- Avoid loading all data at once, do a limited amount (kind of like a book, go to the next page to view the other entries)


## Reflection Prompts

### Learning process
What new tools, techniques, or other skills did you learn while doing this assignment? 
- Some new tools I learned while using this is practicing how to use Navigator.push to help navigate to a new screen and wait until that screen pops up.
- I also practiced working with Isar more, practicing more on adding, updating, and reading data using Isar's methods


What part of this assignment challenged you the most? How did you overcome those challenges? 
- The most challenging part of this assignment was honestly, handling navigation where I needed to pass data back from one screen to the previous screen and have the app update the app's state. I was struggling on making sure the data would return after navigating back.
- I overcame this by learning how to await the result from a Navigator.push and capturing the provider before the async call so it could update the data safely. Adding keys to the widgets also helped with testing the interaction!

### Self-Assessement

If you were to give yourself a grade for this assignment from 0 to 150, what would it be? Explain why.
- I would probably give myself roughly around 120 for this assignment. I was able to implement many of the core functionality. However, there were a lot of challenges I faced and testing out the interactions, also the app itself is not the best looking and definitely could look a lot better


### Stretch goals
Tell us about what stretch goal/optional challenge you did, what you learned from doing that extra work. 

If you did not do an optional stretch goal, please say what you would have done if you had the extra time, and why that option was appealing to you. 

- I did not complete an optional stretch goal. What I would do if I had more time is definitely implement the delete an entry functionality. This option is most appealing to me because while testing I accumulated A LOTTTT of entries either by accident or just purely testing and it makes the app look a lot more messier in my opinion. I do think it is a good feature to have though, to be able to delete an entry.

### Meta

How much time (in minutes or hours of active work) did you spend working on this assignment? What parts took the longest?
- I would say roughly 48-36 hours (on and off). It took roughly 3-4 days, but I did not really count the hours, worked on the assignment.
- I want to say what took the longest was making the aesthetic exactly what I wanted. A lot of trial and error occurred as to how I wanted the app to look like. (A lot of debugging had to happen with my xcode too so that took forever).

How could the assignment be improved for future offerings of this class?
- I think this was a well structured assignment, so I can not really think of any improvements that this one needs
