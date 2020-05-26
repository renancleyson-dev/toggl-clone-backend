# frozen_string_literal: true

module AuthenticationHelper
  def sign_in(user)
    post '/sessions', params: {
      username: user.username,
      password: user.password
    }
  end
end
