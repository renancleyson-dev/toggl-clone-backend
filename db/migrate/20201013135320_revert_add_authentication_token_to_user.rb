require_relative '20200915190255_add_authentication_token_to_user'

class RevertAddAuthenticationTokenToUser < ActiveRecord::Migration[6.0]
  def change
    revert AddAuthenticationTokenToUser
  end
end
