# Ruby STK Service Layer
A Ruby service-layer abstraction over a REST API demonstrating structured response formatting, client-side filtering, and clean separation of concerns.

This mini project wraps the public [JSONPlaceholder API](https://jsonplaceholder.typicode.com/) and standardizes responses using a consistent service-layer pattern.

## Overview
This repository demonstrates:
- Service-layer abstraction over an external REST API
- Structured response formatting
- JSON parsing with symbolized keys
- Client-side filtering where API limitations exist
- Clear separation between request handling and output
- Consistent success/error result objects

## Design Constraints

- This project was intentionally written to simulate an interview-style, single-file live coding environment (e.g., CoderPad or CoderInterview).
- `pp` is used to make return values visible without a framework or controller layer. In production, the service layer would return objects only, and logging would be handled by the caller or a dedicated logging abstraction.
- Authentication is _not_ required for this public mock API.

## Architecture
The service layer is responsible for:
- Making HTTP requests (HTTParty)
- Parsing JSON responses
- Formatting standardized result objects
- Handling success and error cases consistently
- Each method returns a structured object:

  Success example:
  ```
  {
    success: true,
    status: 200,
    data: [...]
  }
  ```
  Failure example:
  ```
  {
    success: false,
    status: 400,
    error: "error message"
  }
  ```

## Features

### Todos
- Fetch todos by user ID
- Filter todos by partial title (case-insensitive)
- Fetch todos by completion status

### Posts
- Fetch posts by user ID
- Fetch post by ID (RESTful endpoint usage)
- Filter posts by partial body match (case-insensitive)

### Users
- Filter users by city

## Future Improvements
For production, I would:
- Add request timeout handling
- Add pagination
- Add configurable base URL and HTTP client
- Add unit tests with request stubbing
- Don't use `pp`; return the object and use logging
