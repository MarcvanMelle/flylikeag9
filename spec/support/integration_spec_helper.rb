module IntegrationSpecHelper
  def login_with_oauth(service = :github)
    visit "users/auth/#{service}"
  end
end
