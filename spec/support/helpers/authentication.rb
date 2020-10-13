# frozen_string_literal: true

module AuthenticationHelper
  def sign_in(user)
    post '/login', params: {
      email: user.email,
      password: user.password
    }

    JSON.parse(response.body)['authToken']
  end
end
