//
//  Notes.swift
//  iTunesSearch
//
//  Created by Zachary Jensen on 11/14/25.
//

//Step 1 - Import Your Playground Code
//- Open the “iTunes Search” playground you created in the previous two lessons.
//- Create a **`StoreItem.swift`** file and copy your `StoreItem` structure definition into the file. Also copy your intermediary `SearchResponse` struct into this file, outside the declaration of `StoreItem`.
//- Create a **`StoreItemController.swift`** file and define a new `StoreItemController` class. Copy your `fetchMatchingItems` function into the controller.
//
//### Step 2 - Add the Request to the View
//Remember that the `StoreItemList` has already implemented the code for the segmented picker and the search bar and for supplying data to the list. But right now, the list is set up to use an array of String instances. You’ll update the view model to use the `StoreItemController` to fetch items based on the media type selected in the segmented picker and the query in the search bar. Once the items are returned, you’ll put them in the items array and the view will redraw to display them.
//
//When the user enters text in the search bar, the keyboard will display "search" where the return key normally is thanks to the `.submitLabel` modifier. What happens when they press that button? If you look above that modifier, there is a closure provided to the text field's `onCommit` property. When the user taps the Search button, this closure will be triggered. The view model's `fetchMatchingItems()` function can use the text from the search bar and the selected media type from the segmented picker.
//
//You’ll code the `fetchItems()` function to set up a query dictionary and make the network request.
//
//Here’s how to go about it:
//
//- Add a new `StoreItemController` property to the list view model. You’ll use this instance to run the network request to fetch the matching `StoreItem` objects.
//- Update the `items` array to be the `[StoreItem]` type.
//- Update the `ItemCellView` struct to use a `StoreItem` to provide the name and artist. We will update the image to work properly later.
//- In the `fetchMatchingItems()` function, within the if `!searchTerm.isEmpty` braces, set up a query dictionary, setting the `"term"` and `"media"` keys to their respective values. You might also want to use the `"limit"` key to limit the number of results or the `"lang": "en_us"` key-value pair to limit results to items in U.S. English.
//- Call the `fetchItems(matching:)` method on the `StoreItemController` instance, passing the query dictionary in a do/catch statement within a `Task`. In the case for success, set the returned `[StoreItem]` as the `self.items` property on the view controller and reload the table. In the case for failure, print the associated `Error` to the console.
//
//### Step 3 - Review Your Progress
//At this stage, when the user types text into the search bar and taps the Search button, your app should trigger a network request and return an array of `StoreItem` objects. When your table view is reloaded, it should display the results.
//- Run the app in Simulator to verify that it works as expected. If it doesn’t, try to figure out why. Use breakpoints and the debugging console to find out whether the network request was executed and whether the completion handler is getting called.
//
//### Step 4 - Display Images in the Cells
//You’ll need to set the ItemCellView's name, artist, and artwork image. The name and artist can be easily loaded from the `StoreItem` property. But in this case, you don’t have the image. You only have an image URL. So you’ll need to fetch the image in order to display it.
//
//Fortunately, SwiftUI makes this fairly straightforward thanks to the `AsyncImage` type. In the body of `ItemCellView`, we will first need to unwrap the image's address using an if-let. If the image data hasn't loaded yet or there is no artwork, it would look strange to have it be blank.
//
//The current `Image(systemName: "photo")` will be our fallback if the StoreItem has no image address, so put it in the `else` clause of your if let. Once it does have an address, we can simply pass that to `AsyncImage(url:)`, and the UI element will helpfully handle the asynchronous concerns itself.
//
//### Step 5 - Add Previews
//Often times, after searching for a piece of music we will want to hear or see a preview of it. The API provides a `previewUrl` key with music results that awill allow you to access a 30 second preview file.
//First revise StoreItem and StoreItemController to decode and the `previewUrl` key when possible.
//
//In `ItemCellView`, a commented-out button has been provided to you that only displays if the store item's previewUrl value is not equal to nil. Uncomment the button.
//
//In the button's closure, we will want to fetch the media file from the provided URL. But before we can do that, we need to consider what happens if multiple play buttons are pressed. The user will expect that starting another preview will stop the current one, and if we start downloading another preview, we should cancel the one currently downloading.
//
//To make this possible, we'll need to handle this logic in the `StoreItemListView`, where all the buttons can be managed at once. Add a property to `ItemCellView` of type `() -> Void` called `onPlayButtonPressed`. Then, in `StoreItemListView`, add a trailing closure to satisify the new requirements for `ItemCellView`'s initializer.
//
//To download the preview, we will need to run a Task. As mentioned, it's a good idea to cancel this task when it's no longer needed. In the `StoreItemListViewModel`, add the following property:
//
//```swift
//var previewTask: Task<Void, Never>? = nil
//```
//
//Now, when the play button is pressed, we will start up a Task to retrieve the media file. Since we're storing it in the view model, we'll have access to cancel it later the next time a button is pressed. Add the following code to the `onPlayButtonPressed` closure of `ItemCellView`:
//
//```swift
//ItemCellView(item: item) {
//    if let previewTask = viewModel.previewTask {
//        previewTask.cancel()
//    }
//
//    viewModel.previewTask = Task {
//        // Code to fetch the preview data using the URL
//                            
//        // Once the task is complete, return the stored task value to nil
//    viewModel.previewTask = nil
//    }
//}
//```
//
//Getting the data for the file is like any other network retrieval: using `URLSession.shared.data(from:)`, we can retrieve the raw binary for the audio files. In order to make these actually playable requires a few extra steps that go beyond the scope of this lesson, so if you would like to leave your app here you may. If you would like to actually play the previews, continue with the Black Diamond steps below.
//
//## Black Diamond
//
//### Step 6 - AVFoundation
//
//Apple offers a framework called AVFoundation that supports playback of audio and video files. Its most relevant feature to us today is the AVPlayer. In order to play the media file, we will first need to add an AVPlayer to our view model. Start by importing AVFoundation, then in your view model, add:
//
//```swift
//var previewPlayer: AVPlayer?
//```
//
//By storing this as a property we are able to start and stop playback at any time.
//
//In order to play a file, AVPlayback needs it to be stored locally on disk. Using FileManager, we will store the data we received from the preview URL in the temporary directory. In the `onPlayButtonPressed` closure, add the following:
//
//```swift
//let tempDirectory = FileManager.default.temporaryDirectory
//let tempFileUrl = tempDirectory.appendingPathComponent(previewUrl.lastPathComponent) // Naming the file the same as what was provided by the API
//
//try data.write(to: tempFileUrl)
//```
//
//(You wil need to wrap your code in a do/catch statement as well.)
//
//Now that we have the audio file stored to the disk, we are ready to play it. Create a new AVPlayer, using the url of the data we just stored to initialize it:
//
//```swift
//viewModel.previewPlayer = AVPlayer(url: tempFileUrl)
//```
//
//And finally, hit "play" on the player:
//
//```swift
//viewModel.previewPlayer.play()
//```
//
//You should now be able to play the audio file retrieved from the source. If the user presses another play button, we should stop any currently playing audio, so at the top of the `onPlayButtonPressed` closure, call `viewModel.previewPlayer.stop` and then set the player to nil before beginning a new playback task.
//
//### Step 7 - Caching URL Results
//
//Caching the results of your URL requests reduces the number of requests that need to be made to the server and improves your app’s user experience by making certain data from the server more readily available—even when the user is offline, experiencing a slow network connection, or requesting a large piece of data that would typically take time to download, such as an image or video. The shared URLSession (URLSession.shared) will by default use URLCache.shared, which is preconfigured—but sometimes its a good idea to increase its capacity.
//
//If you cache audio files in this app, they will load significantly faster after the first time they’ve been downloaded from the server, because they won’t need to be downloaded a second time. To increase the cache capacity, all you need to do is put the following code in the `init` function of the top level of your App, the `iTunesSearchApp` file.
//
//```swift
//URLCache.shared.memoryCapacity = 25_000_000URLCache.shared.diskCapacity = 50_000_000
//```
//
//This adjusts the default system-provided cache instance so that memoryCapacity and diskCapacity are 25 megabytes and 50 megabytes, respectively. Depending on your app and its data, you can decide what values provide the best user experience.
//
//Congratulations! You’ve made a more complex app that fetches a list of iTunes store items, loads their respective images, and displays them in a table view. Be sure to save it to your project folder for future reference.
