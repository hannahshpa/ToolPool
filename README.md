# ToolPool
CS 130 Project, Fall 2020
Discussion 1B group 8

Hannah Park, Casey Olsen, Alissa McNerney, 
Robert Geil, Han Lee, Giovanni Moya

# Description
ToolPool allows users to rent and lease household tools for a limited time. Tools can range from power tools for construction/ carpenting, to cooking tools like food processors or barbeque grills. Users interested in renting can easily look up tools in the tools-for-all database, submit a request to rent and arrange a time and place to pick up a power tool. Users interested in leasing can list their tools for rent by specifying a rental price per time period, pick up location, optional delivery range and photo of the power tools for lease. Unlike other tool borrowing applications on the market, our app has a borrower-lender rating system, which provides a reliable experience. We also provide a map feature that gives convenient navigation to and from the rental location. Since our target market is US based homeowners and DIY’ers our marketplace will be accessible through an iOS mobile application. Start your next project or home repair with customer rated power tools through ToolPool.

# File Structure
    .
    ├── server                 # Contains server and database code
    |   └── ...             
    ├── ios                    # Contains UI code
    |   └── ...               
    ├── schema.json            # graphql api schema in json format
    ├── schema.gql             # graphql api schema
    └── README.md

ToolPool is an iOS application written in Swift for both the front and back end. The project is oraganized with the backend code in the ```server``` file and the frontend code in the ```ios``` file. Information about each part can be found in the README files in the respective folders. 
