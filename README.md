# Journal

## Student Information
Name:

CSE netid:

email:

## Resources Used
Cite anything (website or other resource) or anyone that assisted you in creating your solution to this assignment.

Remember to include all resources you used to solve this assignment.
* Please acknowledge any help you got from TAs, instructors, or students by name.
* You do not need to include links to lecture/section material or flutter docs. However you do need to mention which Flutter classes or packages you viewed.
* You must include links to all StackOverflow, Medium, blogs, or other articles you used.
* If you used any Generative AI (ChatGPT, Gemini, CodePilot, or the like), please include the prompt(s) you used and how the result was or was not helpful.

If you did not use any resources beyond classroom/flutter docs, please state so explicitly.

Answer here: (delete this prompt)

## Design Vision

Describe the purpose of your app. 
* Identify who is a target user of your app and why it would be helpful to them (or you, if you are the target user).
* What functionality to you want in this app? 
* How do you want to make this aesthetically pleasing and easy to use? 
* What inclusive design principles did you focus on in your design? 
* What data will be stored in this app? 

Answer here: (delete this prompt)

Where in your repo can we find the design sketches that you made?

Answer here: (delete this prompt)

What was different in your final product from your original vision and sketches? If you were able to fully complete the app you designed, please list 1-2 things you would like to change in your app or add to your app if you had more time? 

Answer here: (delete this prompt)


## Metadata

Git Commit ID for end of Part 3.2:

Answer here: (delete this prompt)

## Code comprehension questions

### `JournalEntry`

The `JournalEntry` starter code includes three constructors. Explain how these three constructors fit together, and what their holistic purpose is as a set.

Answer here: (delete this prompt)

When you create the `entries` getter in `Journal`, why is copying the list alone sufficient? i.e. why don't we need to do a deep copy, i.e. making a new list with copies of all the `JournalEntry` elements?

Answer here: (delete this prompt)

What capabilities does the ensemble of `Journal`, `JournalEntry`, and `SequentialIDMaker` give us? If we wanted to (from the user's point of view) edit a `JournalEntry`, how can we do that with these classes, even though `JournalEntry` is immutable? Have you seen this pattern before or is it new to you?

Answer here: (delete this prompt)

### `JournalProvider`

How else could we have implemented `JournalProvider` and `Journal` to give the same consistency guarantees as we have but without the proxy and clone structure we implemented here? What are the pros/cons of this way vs. what you come up with?

Answer here: (delete this prompt)

### Robustness

What could go wrong when running the app prior to adding persistent data using the `Isar` system? 

Answer here: (delete this prompt)

What could go wrong with your app after adding the journal persistence? For example, given how we have implemented the persistence, what are the circumstances under which a user could lose their journal data? What are the circumstances where someone else could gain access to their data? What other issues can you think of that could be problematic? 

Answer here: (delete this prompt)

What could you do to change the design and implementation of your app to mitigate these risk?

Answer here: (delete this prompt)


## Reflection Prompts

### Learning process
What new tools, techniques, or other skills did you learn while doing this assignment? 

What part of this assignment challenged you the most? How did you overcome those challenges? 

Answer here: (delete this prompt)

### Self-Assessement

If you were to give yourself a grade for this assignment from 0 to 150, what would it be? Explain why.

Answer here: (delete this prompt)


### Stretch goals
Tell us about what stretch goal/optional challenge you did, what you learned from doing that extra work. 

If you did not do an optional stretch goal, please say what you would have done if you had the extra time, and why that option was appealing to you. 

Answer here: (delete this prompt)

### Meta

How much time (in minutes or hours of active work) did you spend working on this assignment? What parts took the longest?

Answer here: (delete this prompt)

How could the assignment be improved for future offerings of this class?

Answer here: (delete this prompt)
