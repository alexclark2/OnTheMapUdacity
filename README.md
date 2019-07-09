# OnTheMapUdacity
Student's can post their location using Apple's CoreLocation features. 

Each pin posted has a website that was selected by the Student that is opened using the iOS device's default browser after being clicked. 

Login using Udacity credentials. After entering credentials and hitting the button, the Udacity server will attempt to authenticate the user. 

To visualize this data, On The Map uses a map with pins for location and pin annotations for student names and URLs. 
After succesfully authenticating, the app displays a map with pins specifying the last 100 locations posted by students.

When the user taps a pin, it displays the pin annotation popup, with the student’s name (pulled from their Udacity profile) and the link associated with the student’s pin.

Tapping anywhere within the annotation will launch Safari and direct it to the link associated with the pin.

Incorporates a tableView for viewing the list of students. When a table is tapped, the default browser launches the link.

Built with Xcode 9 and Swift 4

