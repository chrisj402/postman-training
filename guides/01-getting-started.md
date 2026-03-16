# Getting Started with Postman Training Framework

## Welcome! 👋

This guide will help you get started with the Postman Training Framework. Whether you're new to APIs or looking to enhance your testing skills, this framework provides a structured learning path.

## Prerequisites

### What You Need
- **Postman Desktop App** or Postman Web (free account)
- Basic understanding of HTTP and web applications
- Text editor (for viewing scripts)

### Installing Postman
1. Visit [postman.com/downloads](https://www.postman.com/downloads/)
2. Download for your operating system
3. Install and create a free account
4. Sign in to sync your work

## Your First Steps

### 1. Import Your First Collection

1. Open Postman
2. Click the **Import** button (top left)
3. Navigate to `collections/01-basics/rest-api-basics.json`
4. Click **Import**

You should now see the "REST API Basics" collection in your sidebar.

### 2. Setup Environment

1. Click on **Environments** (left sidebar)
2. Click **Import**
3. Select `environments/training-local.json`
4. Select the environment from the dropdown (top right)

### 3. Run Your First Request

1. Expand the "REST API Basics" collection
2. Click on "01 - Simple GET Request"
3. Click the blue **Send** button
4. Observe the response in the bottom panel

🎉 Congratulations! You've made your first API request!

## Understanding the Interface

### Request Builder (Top Panel)
- **Method dropdown**: GET, POST, PUT, DELETE, etc.
- **URL field**: Enter your API endpoint
- **Params tab**: Query parameters
- **Headers tab**: HTTP headers
- **Body tab**: Request payload (for POST/PUT)

### Response Viewer (Bottom Panel)
- **Body tab**: API response content
- **Headers tab**: Response headers
- **Test Results**: Test execution status
- **Status**: HTTP status code (200, 404, 500, etc.)

## Key Concepts

### Collections
Collections are groups of API requests. Think of them as folders that organize related API calls.

**Example Structure:**
```
My API Collection/
├── User Management/
│   ├── Get All Users
│   ├── Get User by ID
│   ├── Create User
│   └── Delete User
└── Authentication/
    ├── Login
    └── Refresh Token
```

### Environments
Environments store variables that can be reused across requests. This allows you to switch between different setups (dev, staging, production) without changing your requests.

**Common Variables:**
- `baseUrl`: API base URL
- `apiKey`: Authentication key
- `userId`: Dynamic values from responses

### Variables
Access variables using double curly braces: `{{variableName}}`

**Example:**
```
{{baseUrl}}/users/{{userId}}
```

## Working with Requests

### GET Requests
Retrieve data from the server.

**Use Cases:**
- Fetch list of items
- Get details of a specific item
- Search or filter data

**Example:**
```
GET {{baseUrl}}/users
GET {{baseUrl}}/users/123
GET {{baseUrl}}/users?role=admin&status=active
```

### POST Requests
Send data to create new resources.

**Use Cases:**
- Create new user
- Submit a form
- Upload data

**Example:**
```
POST {{baseUrl}}/users
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com"
}
```

### PUT Requests
Update existing resources completely.

**Use Cases:**
- Update user profile
- Replace configuration
- Modify settings

### DELETE Requests
Remove resources from the server.

**Use Cases:**
- Delete user account
- Remove item from cart
- Clear cache

## Common Status Codes

### Success Codes (2xx)
- **200 OK**: Request succeeded
- **201 Created**: Resource created successfully
- **204 No Content**: Success but no data to return

### Client Error Codes (4xx)
- **400 Bad Request**: Invalid request format
- **401 Unauthorized**: Authentication required
- **403 Forbidden**: No permission
- **404 Not Found**: Resource doesn't exist

### Server Error Codes (5xx)
- **500 Internal Server Error**: Server malfunction
- **503 Service Unavailable**: Server is down

## Next Steps

Now that you understand the basics:

1. **Complete the Basic Collection**: Work through all requests in `01-basics/rest-api-basics.json`
2. **Experiment**: Try modifying request parameters and body
3. **Read the Testing Guide**: Learn how to write automated tests (see `02-writing-tests.md`)
4. **Create Your Own Collection**: Practice with a real API you use

## Troubleshooting

### Request Failed
- Check your internet connection
- Verify the URL is correct
- Ensure the API is available
- Check if authentication is required

### Variable Not Resolving
- Make sure the environment is selected (top-right dropdown)
- Verify variable name spelling (case-sensitive)
- Check if the variable exists in the environment

### Tests Failing
- Review the test assertions
- Check response format matches expectations
- Verify status codes are as expected
- Look at the actual response data

## Practice Exercises

1. **Exercise 1**: Make a GET request to retrieve all users
2. **Exercise 2**: Create a new user with POST
3. **Exercise 3**: Update the user you created
4. **Exercise 4**: Delete the user
5. **Exercise 5**: Chain these requests in order

## Tips for Success

- **Start Simple**: Master GET requests before moving to POST/PUT
- **Use the Console**: Check the Postman Console for detailed request/response info
- **Save Examples**: Save successful responses as examples for reference
- **Organize Well**: Use folders and descriptive names
- **Comment Your Code**: Add descriptions to help future you

Ready to write tests? Check out the [Writing Tests guide](02-writing-tests.md)!
