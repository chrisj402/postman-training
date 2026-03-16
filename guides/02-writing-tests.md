# Writing Tests in Postman

## Introduction

Tests in Postman are JavaScript code that runs after a response is received. They help you verify that your API behaves as expected.

## The Basics

### Your First Test

In the **Tests** tab of any request, add:

```javascript
pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});
```

Click **Send** and check the **Test Results** tab. You should see a green checkmark! ✅

## Test Structure

Every test follows this pattern:

```javascript
pm.test("Test description", function () {
    // Your assertion here
});
```

- `pm.test()`: Creates a new test
- **First parameter**: Human-readable description
- **Second parameter**: Function containing your assertions

## Common Test Patterns

### 1. Status Code Tests

```javascript
// Exact status code
pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});

// One of multiple codes
pm.test("Status code is 200 or 201", function () {
    pm.expect(pm.response.code).to.be.oneOf([200, 201]);
});

// Range of codes
pm.test("Status code is 2xx", function () {
    pm.response.to.be.success;
});
```

### 2. Response Time Tests

```javascript
pm.test("Response time is less than 500ms", function () {
    pm.expect(pm.response.responseTime).to.be.below(500);
});
```

### 3. Response Body Tests

```javascript
// Check if response is JSON
pm.test("Response is JSON", function () {
    pm.response.to.be.json;
});

// Parse JSON and check properties
pm.test("Response has required fields", function () {
    const jsonData = pm.response.json();
    pm.expect(jsonData).to.have.property('id');
    pm.expect(jsonData).to.have.property('name');
    pm.expect(jsonData).to.have.property('email');
});

// Check specific values
pm.test("Email format is correct", function () {
    const jsonData = pm.response.json();
    pm.expect(jsonData.email).to.match(/^[^@]+@[^@]+.[^@]+$/);
});

// Check array length
pm.test("Returns 10 items", function () {
    const jsonData = pm.response.json();
    pm.expect(jsonData).to.be.an('array');
    pm.expect(jsonData).to.have.lengthOf(10);
});
```

### 4. Header Tests

```javascript
pm.test("Content-Type is JSON", function () {
    pm.response.to.have.header('Content-Type');
    pm.expect(pm.response.headers.get('Content-Type')).to.include('application/json');
});
```

## Working with JSON Responses

### Accessing Nested Data

```javascript
pm.test("Check nested properties", function () {
    const jsonData = pm.response.json();

    // Access nested objects
    pm.expect(jsonData.user.profile.age).to.equal(30);

    // Access array items
    pm.expect(jsonData.items[0].name).to.equal('First Item');

    // Loop through arrays
    jsonData.items.forEach(item => {
        pm.expect(item).to.have.property('id');
    });
});
```

### Extracting Data for Later Use

Save response data to variables for use in subsequent requests:

```javascript
pm.test("Save user ID", function () {
    const jsonData = pm.response.json();
    pm.environment.set('userId', jsonData.id);
    pm.environment.set('userEmail', jsonData.email);
});
```

## Advanced Test Patterns

### 1. Schema Validation

```javascript
const schema = {
    type: 'object',
    required: ['id', 'name', 'email'],
    properties: {
        id: { type: 'number' },
        name: { type: 'string' },
        email: { type: 'string', format: 'email' },
        age: { type: 'number', minimum: 0, maximum: 150 }
    }
};

pm.test("Response matches schema", function () {
    pm.response.to.have.jsonSchema(schema);
});
```

### 2. Multiple Assertions in One Test

```javascript
pm.test("Complete user validation", function () {
    const jsonData = pm.response.json();

    // All these must pass for the test to pass
    pm.expect(jsonData.name).to.be.a('string').and.not.empty;
    pm.expect(jsonData.email).to.include('@');
    pm.expect(jsonData.age).to.be.a('number').and.above(0);
    pm.expect(jsonData.status).to.equal('active');
});
```

### 3. Conditional Tests

```javascript
pm.test("Verify pagination if present", function () {
    const jsonData = pm.response.json();

    if (jsonData.pagination) {
        pm.expect(jsonData.pagination).to.have.property('page');
        pm.expect(jsonData.pagination).to.have.property('totalPages');
        pm.expect(jsonData.pagination.page).to.be.a('number');
    }
});
```

### 4. Testing Arrays

```javascript
pm.test("All users have required fields", function () {
    const users = pm.response.json();

    pm.expect(users).to.be.an('array').and.not.empty;

    users.forEach(user => {
        pm.expect(user).to.have.all.keys('id', 'name', 'email');
        pm.expect(user.id).to.be.a('number');
        pm.expect(user.name).to.be.a('string').and.not.empty;
    });
});
```

## Using Chai Assertions

Postman uses the Chai assertion library. Here are common assertions:

### Equality
```javascript
pm.expect(value).to.equal(expected);
pm.expect(value).to.eql(expected);  // Deep equality for objects
pm.expect(value).to.not.equal(unexpected);
```

### Type Checking
```javascript
pm.expect(value).to.be.a('string');
pm.expect(value).to.be.a('number');
pm.expect(value).to.be.a('boolean');
pm.expect(value).to.be.an('array');
pm.expect(value).to.be.an('object');
```

### Comparisons
```javascript
pm.expect(number).to.be.above(5);
pm.expect(number).to.be.below(10);
pm.expect(number).to.be.within(5, 10);
```

### Strings
```javascript
pm.expect(string).to.include('substring');
pm.expect(string).to.match(/regex/);
pm.expect(string).to.have.lengthOf(10);
```

### Objects/Arrays
```javascript
pm.expect(obj).to.have.property('key');
pm.expect(obj).to.have.all.keys('key1', 'key2');
pm.expect(array).to.include(item);
pm.expect(array).to.be.empty;
pm.expect(array).to.have.lengthOf(5);
```

## Pre-request Scripts

Run code BEFORE sending a request:

```javascript
// Set dynamic timestamp
pm.environment.set('timestamp', new Date().toISOString());

// Generate random email
pm.environment.set('randomEmail', `user${Date.now()}@example.com`);

// Clear old variables
pm.environment.unset('oldVariable');
```

## Debugging Tests

### Console Logging

```javascript
console.log('Response:', pm.response.json());
console.log('Status:', pm.response.code);
console.log('Headers:', pm.response.headers);
```

View output in **View → Show Postman Console**

### Visualizing Responses

```javascript
const template = `
    <h1>User Details</h1>
    <p>Name: {{name}}</p>
    <p>Email: {{email}}</p>
`;

pm.visualizer.set(template, pm.response.json());
```

## Best Practices

1. **Write Descriptive Test Names**: "User has valid email format" not "Test 1"
2. **Test One Thing Per Test**: Makes failures easier to diagnose
3. **Test Happy and Sad Paths**: Success cases AND error cases
4. **Use Meaningful Assertions**: Be specific about what you're checking
5. **Clean Up After Tests**: Unset temporary variables
6. **Order Matters**: Run tests in logical sequence
7. **Don't Over-Test**: Focus on critical functionality

## Common Patterns

### Pattern 1: Create-Read-Update-Delete Flow

```javascript
// 1. Create (POST)
pm.test("User created", function () {
    pm.response.to.have.status(201);
    pm.environment.set('userId', pm.response.json().id);
});

// 2. Read (GET)
pm.test("User retrieved", function () {
    pm.response.to.have.status(200);
    pm.expect(pm.response.json().id).to.equal(pm.environment.get('userId'));
});

// 3. Update (PUT)
pm.test("User updated", function () {
    pm.response.to.have.status(200);
});

// 4. Delete (DELETE)
pm.test("User deleted", function () {
    pm.expect(pm.response.code).to.be.oneOf([200, 204]);
});
```

### Pattern 2: Error Handling

```javascript
pm.test("Returns 404 for non-existent user", function () {
    pm.response.to.have.status(404);
    const error = pm.response.json();
    pm.expect(error).to.have.property('message');
    pm.expect(error.message).to.include('not found');
});
```

### Pattern 3: Authentication Check

```javascript
pm.test("Requires authentication", function () {
    if (pm.response.code === 401) {
        const error = pm.response.json();
        pm.expect(error).to.have.property('error');
        pm.expect(error.error).to.equal('Unauthorized');
    } else {
        pm.response.to.have.status(200);
    }
});
```

## Practice Exercises

1. Write a test that checks if response time is under 1 second
2. Create a test that validates all users have an "@" in their email
3. Write a test that saves the first user's ID to an environment variable
4. Create a test that counts how many users have "status: active"
5. Write a schema validation test for a user object

## Next Steps

- Practice writing tests for the Basic collection
- Experiment with different assertions
- Try the Collection Runner to run all tests at once
- Learn about test automation and CI/CD integration

## Resources

- [Postman Learning Center - Testing](https://learning.postman.com/docs/writing-scripts/test-scripts/)
- [Chai Assertion Library](https://www.chaijs.com/api/bdd/)
- [JavaScript Reference](https://developer.mozilla.org/en-US/docs/Web/JavaScript)

Happy Testing! 🧪
