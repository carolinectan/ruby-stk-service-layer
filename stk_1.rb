# Sample API endpoints: https://jsonplaceholder.typicode.com/
# Task: Create an STK layer and define stories on your own

require 'httparty'
require 'json'

class StkApiClient
  BASE_URL = "https://jsonplaceholder.typicode.com"

  def get_response(endpoint, params = {}) # endpoint is a String with leading "/"
    HTTParty.get("#{BASE_URL}#{endpoint}", query: params)
  end

  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def format_result(response, override_data = nil)
    if response.success?
      { success: true, status: response.code, data: override_data || parse_json(response) }
    else
      { success: false, status: response.code, error: response.message }
    end
  end

  ### TODOS ###
  def get_todos_by_user_id(user_id) # user_id is an integer
    response = get_response('/todos', {userId: user_id})

    result = format_result(response)
    pp result
    result
  end

  def get_todos_by_title(title) # title is a string
    response = get_response('/todos')

    unless response.success?
      result = format_result(response)
      pp result
      return result
    end

    json = parse_json(response)
    filtered = json.select { |todo| todo[:title].downcase.include?(title.downcase) }

    result = format_result(response, filtered)
    pp result
    result
  end

  def get_todos_by_status(bool)
    unless [true, false].include?(bool)
      error_obj = { success: false, status: 400, error: 'unknown status' }
      pp error_obj
      return error_obj
    end

    response = get_response('/todos', {completed: bool})

    result = format_result(response)
    pp result
    result
  end

  ### POSTS ###
  def get_posts_by_user_id(user_id) # user_id is an Integer
    response = get_response('/posts', {userId: user_id})

    result = format_result(response)
    pp result
    result
  end

  def get_post_by_post_id(post_id) # post_id is an Integer
    response = get_response("/posts/#{post_id}")

    result = format_result(response)
    pp result
    result
  end

  def get_posts_by_body(body) # body is a String
    response = get_response('/posts')

    unless response.success?
      result = format_result(response)
      pp result
      return result
    end

    json = parse_json(response)
    filtered = json.select { |post| post[:body].downcase.include?(body.downcase) }

    result = format_result(response, filtered)
    pp result
    result
  end

  def get_users_by_city(city)
    response = get_response('/users')

    unless response.success?
      result = format_result(response)
      pp result
      return result
    end

    json = parse_json(response)
    filtered = json.select { |user| user[:address][:city].downcase == city.downcase }

    result = format_result(response, filtered)
    pp result
    result
  end
end

### Single file format testing ###

# 1) Keep StkApiClient object instantiation uncommented
# 2) Uncomment the line you want to test
# 3) In your terminal, run: `ruby stk_1.rb`

stk = StkApiClient.new
# response = stk.get_response('/todos')
# json = stk.parse_json(response)
# pp json

# TODOS
  # stk.get_todos_by_user_id(9)

  # stk.get_todos_by_title("fugiat veniam minus") # full title
  # stk.get_todos_by_title("fugiat veniam") # partial title

  # stk.get_todos_by_status(true)
  # stk.get_todos_by_status(false)
  # stk.get_todos_by_status(nil)

# POSTS
  # stk.get_posts_by_user_id(2)
  # stk.get_post_by_post_id(2)
  # stk.get_posts_by_body("illum quis cupiditate provident sit magnam\nea sed aut omnis\nveniam maiores ullam consequatur atque\nadipisci quo iste expedita sit quos voluptas") # full body
  # stk.get_posts_by_body("illum quis cupiditate provident") # partial body
  stk.get_users_by_city('South Christy')