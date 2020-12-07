# ToolPool
CS 130 Project, Fall 2020
Discussion 1B group 8

Hannah Park, Casey Olsen, Alissa McNerney, 
Robert Geil, Han Lee, Giovanni Moya

# Description
ToolPool allows users to rent and lease household tools for a limited time. Tools can range from power tools for construction / carpenting, to cooking tools like food processors or barbeque grills. Users interested in renting can easily look up tools in the tools-for-all database, submit a request to rent, and arrange a time and place to pick up a power tool. Users interested in leasing can list their tools for rent by specifying a rental price per time period, pick up location, optional delivery range, and photo of the power tools for lease. 

Unlike other tool borrowing applications on the market, our app has a borrower-lender rating system, which provides a reliable experience. We also provide a map feature that gives convenient navigation to and from the rental location. Since our target market is US-based homeowners and DIY’ers, our marketplace will be accessible through an iOS mobile application. 

Start your next project or home repair with customer rated power tools through ToolPool.

# File Structure
    .
    ├── server                   # Contains server and database code
    |   └── ...             
    ├── ios                      # Contains frontend code
    │   ├── ToolPool             # Contains SwiftUI Views and UI code
    │   ├── ToolPoolUITests      # Contains UI tests 
    |   └── ToolPool.xcodeproj   # XCode project to build app     
    ├── schema.json              # graphql api schema in json format
    ├── schema.gql               # graphql api schema
    └── README.md

ToolPool is an iOS application written in Swift for both the front and back end. The project is oraganized with the backend code in the ```server``` file and the frontend code in the ```ios``` file. Information about how to build the server and database can be found in the README file in the ```server``` folder.

To build the app, open the ```ios/ToolPool.xcodeproj``` file. Select a simulator to run the app on (the app has been tested and is working on iPhone 8, iPhone 11 and iPhone 11 Pro). Make sure the server is running and then build the app. The chosen simulator should open with the app.

To run the UI tests, in XCode, select ```Product -> Tests``` and then the testing suite will be run on the selected simulator. In order for the tests to pass make sure in the simulator ```IO -> Keyboard -> Connect Hardware Keyboard``` is unchecked.

# Resources Used
- https://www.hackingwithswift.com/books/ios-swiftui/showing-book-details
- https://www.hackingwithswift.com/books/ios-swiftui/adding-a-custom-star-rating-component
- https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
- https://thoughtbot.com/blog/swiftui-prototype-tutorial-2-of-5-category-card-view
- https://medium.com/better-programming/launch-screen-with-swiftui-bd2958771f3b
