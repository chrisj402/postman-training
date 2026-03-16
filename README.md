# Postman Training Framework

A comprehensive, hands-on framework for learning and mastering API testing with Postman. This training kit includes pre-built collections, detailed guides, and practical exercises to take you from beginner to proficient API tester.

## 📚 Framework Structure

```
Postman/
├── README.md                              # This file
├── CLAUDE.md                              # AI assistant development guide
├── setup.sh                               # Automated setup for Mac/Linux
├── setup.bat                              # Automated setup for Windows
├── test-results.html                      # Visual dashboard for test results
├── collections/
│   └── 01-basics/
│       └── rest-api-basics.json          # Fundamental REST API requests with tests
├── guides/
│   ├── 01-getting-started.md             # Complete beginner's guide to Postman
│   └── 02-writing-tests.md               # Comprehensive testing tutorial
└── environments/
    └── training-local.json               # Pre-configured environment variables
```

## ✨ Features

- 🎯 **Complete Learning Path**: From basics to advanced API testing
- ✅ **100% Test Coverage**: All 12 assertions pass (verified with Newman)
- 🚀 **Automated Setup**: One-command installation for all platforms
- 📊 **Visual Dashboard**: Interactive HTML test results viewer
- 📚 **Comprehensive Guides**: 578 lines of detailed documentation
- 🔧 **CLI Testing**: Newman integration for automation
- 🌐 **Live API**: Uses JSONPlaceholder (free, reliable test API)
- 💻 **Cross-Platform**: Works on macOS, Linux, and Windows

## 🎯 What You'll Learn

- **REST API Fundamentals**: GET, POST, PUT, DELETE operations
- **Request Building**: Path parameters, query parameters, headers, body
- **Test Automation**: Writing JavaScript tests with Chai assertions
- **Variable Management**: Using environments and dynamic variables
- **Response Validation**: Status codes, headers, JSON structure
- **Workflow Chaining**: Creating end-to-end API test flows
- **Best Practices**: Organizing collections, debugging, and optimization

## 🚀 Quick Setup

### Automated Installation

Run the setup script to automatically install all dependencies:

**Mac/Linux:**
```bash
chmod +x setup.sh
./setup.sh
```

**Windows:**
```cmd
setup.bat
```

The script will:
- ✅ Check for Node.js and npm
- ✅ Install Newman (Postman CLI)
- ✅ Install Newman HTML Reporter
- ✅ Validate collection files
- ✅ Run a verification test
- ✅ Provide next steps

### Manual Installation

If you prefer manual setup:

1. Install Node.js from [nodejs.org](https://nodejs.org/)
2. Install Newman: `npm install -g newman`
3. Install Postman Desktop from [postman.com/downloads](https://www.postman.com/downloads/)

## 🧪 Running Tests

### Command Line Testing

Run the complete test suite using Newman (Postman's CLI runner):

```bash
# Install Newman globally
npm install -g newman

# Run all tests
newman run collections/01-basics/rest-api-basics.json --environment environments/training-local.json
```

### Visual Test Results

After running tests, open `test-results.html` in your browser to see an interactive dashboard with:
- 📊 Summary metrics (pass rate, assertions, response times)
- 📝 Detailed test breakdown by HTTP method
- 📈 Performance visualization with bar charts
- ✅ All assertions and their results

## 📖 Using Postman Desktop

### Import Collections and Environments

1. **Import the Collection**
   - Open Postman
   - Click **Import** (top left)
   - Navigate to `collections/01-basics/rest-api-basics.json`
   - Click **Open**

2. **Import the Environment**
   - Click **Environments** (left sidebar)
   - Click **Import**
   - Select `environments/training-local.json`
   - Click **Open**

3. **Activate the Environment**
   - Select "Training - Local" from the environment dropdown (top right)

4. **Run Your First Request**
   - Expand the "01 - REST API Basics" collection
   - Click "Simple GET Request"
   - Click the **Send** button
   - View the response and test results

🎉 **You're ready to start learning!**

## 📖 Learning Path

Follow this recommended sequence for the best learning experience:

### 1. Getting Started (30 minutes)
Read: `guides/01-getting-started.md`

- Understand the Postman interface
- Learn about collections and environments
- Make your first API requests
- Understand HTTP status codes

### 2. Writing Tests (1-2 hours)
Read: `guides/02-writing-tests.md`

- Write your first test
- Master common test patterns
- Work with JSON responses
- Learn Chai assertions
- Debug failing tests

### 3. Hands-On Practice (2-3 hours)
Work through: `collections/01-basics/rest-api-basics.json`

**Module 1: GET Requests**
- Simple GET request to retrieve all users
- GET with path parameters (retrieve specific user)
- GET with query parameters (pagination)

**Module 2: POST Requests**
- Create new user with JSON body
- Save response data to variables

**Module 3: PUT Requests**
- Update existing user
- Use saved variables from previous requests

**Module 4: DELETE Requests**
- Remove user from system
- Validate success responses

### 4. Advanced Exercises

Once you've completed the basics:
1. Create your own collection for a real API
2. Write comprehensive test suites
3. Chain requests to create workflows
4. Experiment with pre-request scripts
5. Use Collection Runner for bulk testing

## 🧪 What's Included

### Collections

#### 01 - REST API Basics
**7 requests** covering the fundamental HTTP methods with real-world examples:
- ✅ All requests include working tests
- ✅ Uses JSONPlaceholder (free test API)
- ✅ Demonstrates best practices
- ✅ Variable chaining between requests

### Environments

#### Training - Local
Pre-configured variables:
- `baseUrl`: https://jsonplaceholder.typicode.com
- `userId`: Dynamic (set during test execution)
- `postId`: Reserved for future use
- `commentId`: Reserved for future use

### Guides

#### 01-getting-started.md (210 lines)
Complete introduction covering:
- Postman installation and setup
- Interface walkthrough
- Core concepts (collections, environments, variables)
- Request types and when to use them
- Status codes reference
- Troubleshooting tips

#### 02-writing-tests.md (368 lines)
Comprehensive testing guide:
- Test structure and syntax
- Common test patterns
- Working with JSON
- Advanced patterns (schema validation, conditionals)
- Chai assertion reference
- Debugging techniques
- Best practices

## 🎓 Who Is This For?

- **QA Engineers** new to API testing
- **Developers** learning to test their APIs
- **Students** studying web development
- **Teams** standardizing on Postman for API testing
- **Anyone** wanting to learn API testing fundamentals

## 💡 Tips for Success

1. **Work Through Sequentially**: Start with guide 01, then guide 02, then practice
2. **Experiment Freely**: Modify requests, break things, learn from errors
3. **Use the Console**: View detailed request/response data (View → Show Postman Console)
4. **Save Your Work**: Create your own workspace to preserve your experiments
5. **Practice Regularly**: Consistency beats intensity for learning
6. **Ask Questions**: Use Postman Community forums if you get stuck

## 🔧 Troubleshooting

### Collection Import Issues
- Ensure you're importing a `.json` file
- Try using "Import Folder" instead of "Import File"
- Check file isn't corrupted (should be valid JSON)

### Environment Not Working
- Verify environment is selected in top-right dropdown
- Check variable names match exactly (case-sensitive)
- Use `{{variableName}}` syntax with double curly braces

### API Requests Failing
- Check internet connection
- Verify JSONPlaceholder is accessible: https://jsonplaceholder.typicode.com
- Look at status code and error message in response
- Check Postman Console for detailed logs

### Tests Failing
- Read the actual vs. expected values in test results
- Verify response structure matches test expectations
- Check if API behavior has changed
- Look for console errors in Postman Console

## 🌐 External Resources

- [Postman Learning Center](https://learning.postman.com/)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)
- [Chai Assertion Library](https://www.chaijs.com/api/bdd/)
- [HTTP Status Codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)
- [REST API Tutorial](https://restfulapi.net/)

## 📝 Practice Exercises

After completing the framework, try these challenges:

1. **Add PATCH request** to partially update a user
2. **Create a posts collection** using `/posts` endpoint
3. **Add authentication tests** (simulate with headers)
4. **Build a workflow** that creates, reads, updates, then deletes a user
5. **Add schema validation** to all GET requests
6. **Create error test cases** for 404 and 400 responses
7. **Use Collection Runner** to run all tests 10 times

## 🤝 Contributing

Found an issue or want to improve this framework?
- Report issues or suggest improvements
- Add more collections or guides
- Share your learning experience

## 📄 License

This training framework is provided as-is for educational purposes. The JSONPlaceholder API is a free resource provided by [typicode](https://github.com/typicode).

## 🙏 Acknowledgments

- **JSONPlaceholder** for providing a free, reliable test API
- **Postman** for creating an excellent API development platform
- The API testing community for best practices and patterns

---

**Ready to start?** Open `guides/01-getting-started.md` and begin your API testing journey! 🚀

**Questions?** Check the troubleshooting section above or consult the Postman Learning Center.

**Happy Testing!** 🧪✨
