# frozen_string_literal: true

json.token @user_session.token
json.full_name @user_session.user.full_name
json.email @user_session.user.email
