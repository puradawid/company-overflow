require 'rails_helper'

describe 'Authentication' do
  subject { page } 
  before(:all) { OmniAuth.config.test_mode = true }

  context 'sign in' do
    let(:company) { FactoryGirl::create(:company) }
    before do
      OmniAuth.config.add_mock(:stackexhange,
                               credencials: { oauth_token: 123,
                                              refresh_token: 321,
                                              oauth_expires_at: Time.now + 1.day
                                            })

    end

    context 'using stackexchange' do
      before do
        visit root_path
        click_on "Sign in StackExchange"
      end

      it 'should show log out button' do 
        expect(subject).to have_content 'Log out'
      end
    end

    context 'company' do
      before do
        visit root_path
        click_on 'Sign in'
      end

      it 'should show log out button' do
        log_in(company.email, company.password)
        expect(subject).to have_content 'Log out'
      end

      it 'should show sign in button' do
        log_in(company.email, 'wrong_password')
        expect(subject).to have_content 'Log in'
      end
    end
  end

  def log_in(email, password)
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Log in'
  end

end
