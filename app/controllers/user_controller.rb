class UserController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def self.anonymous_user
    find_or_create_by(email: 'anonymous@example.com') do |user|
      user.first_name = 'Anonymous'
      user.last_name = 'User'
    end
  end

end
