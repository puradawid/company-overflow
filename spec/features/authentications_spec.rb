require 'rails_helper'
require 'support/login.rb'

describe 'Authentication' do
  include_context 'login'
  subject { page } 
  before(:all) { OmniAuth.config.test_mode = true }

  context 'sign in' do
    let(:company) { FactoryGirl::create(:company) }
    before do
      mock_omniauth
    end

    context 'using stackexchange' do
      before do
        login_user
      end

      it 'should show log out button' do 
        expect(subject).to have_content 'Log out'
      end
    end

    context 'company' do

      it 'should show log out button' do
        login_company(company.email, company.password)
        expect(subject).to have_content 'Log out'
      end

      it 'should show sign in button' do
        login_company(company.email, 'wrong_password')
        expect(subject).to have_content 'Log in'
      end
    end
  end

  context 'sign up' do
    let(:company) { FactoryGirl::build(:company) }
    
    context 'the company' do
      before do
       signup_company(company.email, company.password) 
      end

      it 'should have a new company with this email' do
        expect(Company.where(email: company.email)).not_to be_empty
      end
    end
  end
end
