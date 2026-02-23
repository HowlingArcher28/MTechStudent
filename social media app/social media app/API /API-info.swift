//
//  API-info.swift
//  social media app
//
//  Created by Zachary Jensen on 2/4/26.
//

//All endpoints accept and return `application/json`. All protected routes require `userSecret` in the request body.
//
//Whereever a colon appears in an endpoint (such as `GET /calendar/:id/`), an appropriate value is expected in place of that parameter (such as "ryanplitt.com/calendar/402BDBA5-7EFB-4107-84B0-0EE586FFE0E4").
//
//---
//
//## 🔐 Auth Routes
//
//Routes for logging in to both the Calendar and Social Media services. Upon successful login, a user secret will be returned, which will then be required to authenticate all further requests on either service.
//
//### `GET /auth/test`
//
//Test if the server is responsive.
//
//**Request:** No body required
//**Response:**
//```text
//"Test"
//```
//
//---
//
//### `POST /auth/login`
//
//Authenticate user with email and password.
//
//**Request Body:**
//```json
//{
//  "email": "user@example.com",
//  "password": "password123"
//}
//```
//
//**Response Body:** [`SignInResponseDTO`](#signinresponsedto)
//```json
//{
//  "firstName": "Jane",
//  "lastName": "Doe",
//  "email": "jane@example.com",
//  "userUUID": "UUID",
//  "secret": "UUID",
//  "userName": "jane_doe"
//}
//```
//
//---
//
//## 👤 Social Media User Routes
//
//Used for receiving and displaying information about users of the social media service.
//
//### `GET /user/:userID`
//
//Fetch a user's profile.
//
//**Request Body:**
//```json
//{
//  "userSecret": "UUID"
//}
//```
//
//**Response Body:** [`UserProfileResponseDTO`](#userprofileresponsedto)
//
//---
//
//### `POST /user/update-profile`
//
//Update the logged-in user's profile.
//
//**Request Body:**
//```json
//{
//  "userSecret": "UUID",
//  "profile": {
//    "userName": "newName",
//    "bio": "Optional bio",
//    "techInterests": "Optional interests"
//  }
//}
//```
//
//**Response Body:** [`UserProfileResponseDTO`](#userprofileresponsedto)
//
//---
//
//## 📝 Post Routes
//
//Used for fetching and creating posts on the social media service.
//
//### `GET /posts`
//### `GET /posts/:pageNumber`
//
//Returns paginated list of posts (10 per page).
//
//**Request Body:**
//```json
//{
//  "userSecret": "UUID"
//}
//```
//
//**Response Body:** Array of [`PostResponseDTO`](#postresponsedto)
//
//---
//
//### `POST /post`
//
//Create a new post.
//
//**Request Body:**
//```json
//{
//  "userSecret": "UUID",
//  "post": {
//    "title": "New post",
//    "body": "Content of the post"
//  }
//}
//```
//
//**Response Body:** [`PostResponseDTO`](#postresponsedto)
//
//---
//
//### `POST /post/edit/:postID`
//
//Update an existing post owned by the user.
//
//**Request Body:**
//```json
//{
//  "userSecret": "UUID",
//  "post": {
//    "title": "Updated title",
//    "body": "Updated body"
//  }
//}
//```
//
//**Response Body:** [`PostResponseDTO`](#postresponsedto)
//
//---
//
//### `DELETE /post/:postID`
//
//Soft delete a post.
//
//**Request Body:**
//```json
//{
//  "userSecret": "UUID"
//}
//```
//
//**Response:**
//```http
//200 OK
//```
//
//---
//
//## 💬 Comment Routes
//
//Used for fetching and posting comments on posts.
//
//### `GET /post/:postID/comments?pageNumber=Int`
//
//Get paginated comments for a post.
//
//**Request Body:**
//```json
//{
//  "userSecret": "UUID"
//}
//```
//
//**Query Items**
//
//```
//"pageNumber": Int
//```
//
//**Response Body:** Array of [`CommentResponseDTO`](#commentresponsedto)
//
//---
//
//### `POST /post/:postID/comments`
//
//Create a comment on a post.
//
//**Request Body:**
//```json
//{
//  "postid": "UUID",
//  "userSecret": "UUID",
//  "comment": "This is a comment"
//}
//```
//
//**Response Body:** [`CommentResponseDTO`](#commentresponsedto)
//
//---
//
//## ❤️ Like Routes
//
//Used for adding a like to a post.
//
//### `POST /post/:postID/like`
//
//Toggle like/unlike for a post.
//
//**Request Body:**
//```json
//{
//  "userSecret": "UUID"
//}
//```
//
//**Response Body:** [`PostResponseDTO`](#postresponsedto)
//
//---
//
//## 📦 Social Media Service DTO Schemas
//
//Expected response structure for each type of data.
//
//### `SignInResponseDTO`
//```json
//{
//  "firstName": "string",
//  "lastName": "string",
//  "email": "string",
//  "userUUID": "UUID",
//  "secret": "UUID",
//  "userName": "string"
//}
//```
//
//---
//
//### `UserProfileResponseDTO`
//```json
//{
//  "firstName": "string",
//  "lastName": "string",
//  "userName": "string",
//  "userUUID": "UUID",
//  "bio": "string?",
//  "techInterests": "string?",
//  "posts": [/* PostResponseDTO[] */]
//}
//```
//
//---
//
//### `PostResponseDTO`
//```json
//{
//  "postID": "UUID",
//  "title": "string",
//  "body": "string",
//  "authorUserName": "string",
//  "authorUserId": "UUID",
//  "likes": 0,
//  "userLiked": true,
//  "numComments": 0,
//  "createdDate": "2025-06-30T00:00:00Z"
//}
//```
//
//---
//
//### `CommentResponseDTO`
//```json
//{
//  "commentId": "UUID",
//  "body": "string",
//  "userName": "string",
//  "userId": "UUID",
//  "createdDate": "2025-06-30T00:00:00Z"
//}
//```
//
//## 📆 Calendar Schedule Routes
//
//Used for fetching and displaying information about the schedule for a particular calendar date.
//
//### `GET /calendar/today`
//
//Retrieve information on today's lesson and schedule.
//
//**Request Body:**
//```json
//{
//  "userSecret": "UUID",
//  "cohort": "fall2025"
//}
//```
//
//**Response Body:** [`CalendarEntryResponseDTO`](#calendarentryresponsedto)
//
//---
//
//### `GET /calendar/all`
//
//Retrieve the entire calendar for a cohort. Response data will only include ID, Date, Holiday, dayID, lessonName, lessonID, and dueAssignments. To get further information, use `GET /calendar/:id`.
//
//**Request Body:**
//```json
//{
//  "userSecret": "UUID",
//  "cohort": "fall2025"
//}
//```
//
//**Response Body:** Array of [`CalendarEntryResponseDTO`](#calendarentryresponsedto)
//
//---
//
//## 📄 Calendar Assignment Routes
//
//Used for fetching and displaying assignments
//
//### `GET /assignment/:id?includeProgress=true?includeFAQs=true`
//
//Display a single assignment. The id for assignments can be retrieved either by using the all assignments endpoint or from the calendar date on which the assignment appears.
//
//**Query Items**
//These query parameters can customzie whether assingment progress and user generated FAQs are returned with each assignment. FAQs will be an empty array if excluded.
//
//```
//"includeProgress": Bool
//"includeFAQs": Bool
//```
//
//**Request Body:**
//```json
//{
//  "userSecret": "UUID"
//}
//```
//
//**Response Body:** [`AssignmentResponseDTO`](#assignmentresponsedto)
//
//---
//
//### `GET /assignment/all?includeProgress=true?includeFAQs=true`
//
//Display all assignments for a cohort.
//
//**Query Items**
//These query parameters can customzie whether assingment progress and user generated FAQs are returned with each assignment. FAQs will be an empty array if excluded.
//
//```
//"includeProgress": Bool
//"includeFAQs": Bool
//```
//
//**Request Body:**
//```json
//{
//  "userSecret": "UUID",
//  "cohort": "fall2025"
//}
//```
//
//**Response Body:** Array of [`AssignmentResponseDTO`](#assignmentresponsedto)
//
//---
//
//### `POST /assignment/progress`
//
//Update the user's stored progress on an assignment. Valid progress strings are "notStarted", "inProgress", and "complete".
//
//**Request Body:**
//```json
//{
//  "userSecret": "UUID",
//  "assignmentID": "UUID",
//  "progress": "String"
//}
//```
//
//**Response Body:** [`AssignmentResponseDTO`](#userprofileresponsedto)
//_Will include the user's new saved progress state_.
//
//---
//
//### `DELETE /assignment/progress`
//
//Completely clear a user's progress on an assignment.
//
//**Request Body:**
//```json
//{
//  "userSecret": "UUID",
//  "assignmentID": "UUID"
//}
//```
//
//**Response Body:** HTTPResponseStatus (`200 - Okay` if successful)
//
//---
//
//## FAQ Routes
//
//Used for posting FAQs to assignments.
//
//### `POST /faq`
//
//**Request Body:**
//```json
//{
//  "userSecret": "UUID",
//  "assignmentID": "UUID",
//  "question": "string",
//  "answer": "string"
//}
//```
//
//**Response Body:** HTTPResponseStatus (`200 - Okay` if successful)
//_Will include the user's new saved progress state_.
//
//---
//
//## 📦 Calendar Service DTO Schemas
//
//### `CalendarEntryResponseDTO`
//
//Properties marked ? are optional and will not always be present. Cases where these values will be omitted are on holidays, where data is missing, or in the endpoint for fetching all calendar data.
//
//```json
//    "id": "UUID",
//    "date": "2025-06-30T00:00:00Z",
//    "holiday": false,
//    "dayID": "string"?,
//    "lessonName": "string"?,
//    "lessonID": "UUID"?,
//    "mainObjective": "string"?,
//    "readingDue": "string"?,
//    "assignmentsDue": [AssignmentResponseDTO],
//    "newAssignments": [AssignmentResponseDTO],
//    "dailyCodeChallengeName": "string"?,
//    "wordOfTheDay": "string"?
//```
//
//
//### `AssignmentResponseDTO`
//```json
//{
//  "id": "UUID",
//  "name": "string",
//  "assignmentType": "string",
//  "body": "UUID",
//  "assignedOn": "2025-06-30T00:00:00Z"
//  "dueOn": "2025-06-30T00:00:00Z"
//  "userProgress": "string"
//  "faqs": [FAQResponseDTO]
//}
//```
//
//### `FAQResponseDTO`
//```json
//{
//  "id": "UUID",
//  "assignmentID": "UUID",
//  "lessonID": "UUID",
//  "question": "How do I submit my final project?",
//  "answer": "You can submit your final project by uploading it through the student portal under the 'Assignments' tab.",
//  "lastEditedOn": "2026-01-27T14:32:00Z",
//  "lastEditedBy": "username"
//}
//```
