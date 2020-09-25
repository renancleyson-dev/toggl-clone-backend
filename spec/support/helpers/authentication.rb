# frozen_string_literal: true

module AuthenticationHelper
  def sign_in(user)
    post '/login', params: {
      username: user.username,
      password: user.password
    }

    JSON.parse(response.body)['authToken']
  end
end
