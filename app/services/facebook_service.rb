class FacebookService

  def self.fetch_user(access_token)
    FbGraph2::User.me(access_token).fetch
  rescue => the_error
    @error = the_error.message
    puts "Error #{the_error.message}"
    return nil
  end
end