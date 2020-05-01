# Plate Beacon

A new Flutter application.

## Getting Started

Please make detail messages when updating the project
# main.dart
This is the entry point to the app and will redirect user to the right dashboard if they are already logged in and will show a login and register buttons if the user isn't logged in

# register.dart
this file will be the next step in using the app because the user has to create an account to gain access to the app

# login.dart
this file will be the next step if the user already has an account because the user has to have an account to use the app

# pickup.dart
this file reads back a donation list from firestore 

# RestaurantMain.dart
The user shall be presented with this page if they are logged in as a restaurant. this file has a drawer with restaurant specific items in it

# ShelterMain.dart
The user shall be presented with this page if they are logged in as a shelter. this file has a drawer with shelter specific items in it

# Home.dart
This file will be the first thing the user sees when they login. it will contain where the shelter user can see the next pickup date and the restaurant user can set a date for a new donation

# pickup.dart
this file will be displayed if the user navigates to the third item in the bottom navigation bar. it will show how many donation have been set by the restaurant user. items can also be deleted by pressing the icon to the right

# Notifications.dart
You will be able to choose the notification method like email , message and calls to receive notifications in your order from plate beacon.
And also you can select all methods for receiving notifications.

# Events.dart
You can check all your future events.You will be able to post events showing restaurants the perfect time to donate and volunteer.
The more people who know your needs, the more funds you will receive.

# Help.dart
You can see contact details like email and phone number which will help you to reach out to the plate beacon.

# restaurant/shelter settings
Find all detailed settings here.You can edit your profile,payment options,subscriptions,notifications, about

# map.dart
Shows nearby shelters/restaurants and user’s current location

# Analytics
The main purpose of the analytics sections is to allow the user to have to their disposal a way to understand how their shelter or restaurant is performing with the help of Plate Beacon. To accomplish this goal the Analytics section provides functionality which has been developed specifically for each type of user. As a restaurant user they will have three types of functionality: Earnings, Rating, and Savings. Saving feature main implementation consist of a graphical chart which will display data with regards to the overall savings gained with the use of Plate Beacon. Further in, the user will have the option to view this data into three main categories: Weekly, Monthly, and Yearly. To accomplish this the user will have to their disposal three bottoms on top of the graph which they can interact with to shift between the three previously mentioned categories. The ranking section main functionality allows the user to view where they stand in terms of food donation between the restaurant forming plate beacon network. The purpose of this section is to motivate competition between restaurant. The last feature is the earnings, this feature implementation is similar to the one found in the saving functionality. It's main purpose is to allow the user to have a graphical representation of the earning that the restaurant is making through out the Plate Beacon app. This is a future implementation which aims to find a way to make Plate Beacon more appealing.

The Shelter analytics sections functionality is very similar to the one found in the restaurant. The user will have to their disposal three main functions: Food Donations, Top Contributors, and Food Request. Food Donations main functionality consist a graphical representation of the amount of donations that have being received so far. The chart can be updated in a matter that it will display data in a weekly, monthly, or yearly. This update can be performed by the user with the three available bottoms on top of the chart. Top Contributors main functionality consist in displaying an ordered list from top to button with information in regards to which restaurant has donated more to their shelter. The objective is to allow the user to have an understanding of the type of donations that are most likely to get. The last functionality is the Food Request, in terms of implementation this feature is similar to the one found in the Food Donations. It's main purpose is to provide the user with a graphical representation of the type of food that is being consumed the most at their respective shelter. With this the user will be able to more easily understand which types of products are beings consumed at that specific location.

