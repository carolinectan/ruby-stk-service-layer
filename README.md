# Ruby STK Service Layer
A Ruby service-layer abstraction over a REST API demonstrating structured response formatting, client-side filtering, and clean separation of concerns.

This project wraps the public [JSONPlaceholder API](https://jsonplaceholder.typicode.com/) and standardizes responses using a consistent service-layer pattern.

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
  ```ruby
  {
    success: true,
    status: 200,
    data: [...]
  }
  ```
  Failure example:
  ```ruby
  {
    success: false,
    status: 400,
    error: "error message"
  }
  ```

## Features

### Todos
- Fetch todos by user ID
  ```ruby
  stk = StkApiClient.new
  stk.get_todos_by_user_id(9)
  ```
  Return value
  ```ruby
  {
    success: true,
    status: 200,
    data: [
      {
        userId: 9,
        id: 161,
        title: "ex hic consequuntur earum omnis alias ut occaecati culpa",
        completed: true
      },
      ...
    ]
  }
  ```
- Filter todos by partial/full title (case-insensitive)
  ```ruby
  stk = StkApiClient.new
  stk.get_todos_by_title("fugiat veniam")
  ```
  Return value
  ```ruby
  {
    success: true,
    status: 200,
    data: [
      {
        userId: 1,
        id: 3,
        title: "fugiat veniam minus",
        completed: false
      }
    ]
  }
  ```
- Fetch todos by completion status
  ```ruby
  stk = StkApiClient.new
  stk.get_todos_by_status(true)
  ```
  Return value
  ```ruby
  {
    success: true,
    status: 200,
    data: [
      {
        userId: 1,
        id: 4,
        title: "et porro tempora",
        completed: true
      },
      ...
    ]
  }
  ```

### Posts
- Fetch posts by user ID
  ```ruby
  stk = StkApiClient.new
  stk.get_posts_by_user_id(2)
  ```
  Return value
  ```ruby
  {
    success: true,
    status: 200,
    data: [
      {
        userId: 2,
        id: 11,
        title: "et ea vero quia laudantium autem",
        body: "delectus reiciendis molestiae occaecati non minima eveniet qui voluptatibus\n" + "accusamus in eum beatae sit\n" + "vel qui neque voluptates ut commodi qui incidunt\n" + "ut animi commodi"
      },
      ...
    ]
  }
  ```
- Fetch post by ID (RESTful endpoint usage)
  ```ruby
  stk = StkApiClient.new
  stk.get_post_by_post_id(2)
  ```
  Return value
  ```ruby
  {
    success: true,
    status: 200,
    data: {
      userId: 1,
      id: 2,
      title: "qui est esse",
      body: "est rerum tempore vitae\n" + "sequi sint nihil reprehenderit dolor beatae ea dolores neque\n" + "fugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\n" + "qui aperiam non debitis possimus qui neque nisi nulla"
    }
  }
  ```
- Filter posts by full/partial body match (case-insensitive)
  ```ruby
  stk = StkApiClient.new
  stk.get_posts_by_body("illum quis cupiditate provident")
  ```
  Return value
  ```ruby
  {
    success: true,
    status: 200,
    data: [
      {
        userId: 2,
        id: 19,
        title: "adipisci placeat illum aut reiciendis qui",
        body: "illum quis cupiditate provident sit magnam\n" + "ea sed aut omnis\n" + "veniam maiores ullam consequatur atque\n" + "adipisci quo iste expedita sit quos voluptas"
      }
    ]
  }
  ```

### Users
- Filter users by city
  ```ruby
  stk = StkApiClient.new
  stk.get_users_by_city('South Christy')
  ```
  Return value
  ```ruby
  {
    success: true,
    status: 200,
    data: [
      {
        id: 6,
        name: "Mrs. Dennis Schulist",
        username: "Leopoldo_Corkery",
        email: "Karley_Dach@jasper.info",
        address: {
          street: "Norberto Crossing",
          suite: "Apt. 950",
          city: "South Christy",
          zipcode: "23505-1337",
          geo: {
            lat: "-71.4197",
            lng: "71.7478"
          }
        },
        phone: "1-477-935-8478 x6430",
        website: "ola.org",
        company: {
          name: "Considine-Lockman",
          catchPhrase: "Synchronised bottom-line interface",
          bs: "e-enable innovative applications"
        }
      }
    ]
  }
  ```

## Future Improvements
For production, I would:
- Add request timeout handling
- Add pagination
- Add configurable base URL and HTTP client
- Add unit tests with request stubbing
- Remove `pp`; return objects and use logging
