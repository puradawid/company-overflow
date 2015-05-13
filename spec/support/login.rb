shared_context 'login' do
  def login_company(email, password)
    visit root_path
    click_on 'Sign in'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Log in'
  end

  def login_user()
    visit root_path
    click_on 'Sign in StackExchange'
  end

  def signup_company(email, password)
    visit root_path
    click_on 'Sign up'
    fill_in 'Email', with: company.email
    fill_in 'Password', with: company.password
    fill_in 'Password confirmation', with: company.password
    click_on 'Sign up'
  end

  def mock_omniauth
    credentials_hash = { oauth_token: 123,
                         refresh_token: 321,
                         oauth_expires_at: Time.now + 1.day }
    OmniAuth.config.add_mock(:stackexchange,
                             credentials: credentials_hash)
  end
end
