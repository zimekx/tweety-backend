class FacebookService

  def self.fetch_user(access_token)
    user = FbGraph::User.me(access_token).fetch

    (user && user.email) ? user : nil
  rescue => the_error
    @error = the_error.message
    puts "Error #{the_error.message}"
    return nil
  end
end