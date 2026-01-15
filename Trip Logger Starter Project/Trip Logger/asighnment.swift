//Review and understand the existing code, especially the MapKit `Map` presented on `TripMapScreen`. You may want to review the documentation for MapKit as well.
//2. Add an "Add" button to the navigation bar in `ContentView`.
//3. Configure the Add button to present a sheet (modal) with the `NewTripScreen`. Embed it in a `NavigationStack` so that users can navigate through the three screens provided for a new trip.
//4. Add a `TextField` and a "Next" button to `NewTripScreen`. The "Next" button should be disabled when the TextField is empty.
//5. Make the "Next" button present the `PlacePinScreen`. Pass through the name the user selected and use it to create a `Trip` object.
//6. Some code has already been provided for you on `PlacePinScreen`. Create a new `JournalEntry` in the `placePin(reader:location:)` function using the `coordinate` provided and add it to the `Trip` object's collection `journalEntries`.
//7. Display a pin on the `Map` by adding a `Marker` to its closure. You can use the `Marker(item:)` initializer by accessing `journalEntry.location.mapItem`. You will need to retrieve the journal entry you just added to the `Trip` to accomplish this.
//8. Add a "Next" button that transitions to `SetUpPinScreen`, passing through the `Trip` object you created, which should now contain one `JournalEntry`.
//9. On `SetUpPinScreen`, create `TextField`s that bind directly to the journal entry's `name` and `text` properties. You most likely will need to simply force unwrap `trip.journalEntries.first` in order to achieve this efficiently, which is okay for this project.
//10. Add a `PhotoScrollView` to the screen as well. We will finish configuring this view in a moment.
//11. Add a save button. Pressing it should dismiss the presented sheet and save the `Trip` to the modelContext.
//12. In `PhotoScrollView`, use a `ForEach` to display all the photos in a `JournalEntry`. Note that the photos are stored as `Data`; use `UIImage(data:)` to convert it for display.
//13. Now, set up the `Edit` buttons in the `TripMapScreen` and its child `Journal` to allow the user to edit existing trips (including **adding more `JournalEntries` by dropping new pins on the map**, plus changing the name or deleting a trip altogether), and edit individual journal entries (change the name, text, and photos), respectively. The exact implementation of this step is up to you.
//14. Review your work and make sure the styling is complete and well configured. Use `Spacer`s and `.padding()` where needed.
//
