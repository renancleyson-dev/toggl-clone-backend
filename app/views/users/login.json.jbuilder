# frozen_string_literal: true

json.auth_token @token
json.partial! 'users/user', user: @user
