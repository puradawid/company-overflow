require 'rails_helper'
require 'support/login.rb'

describe 'Manage company users' do
  include_context 'login'
  subject { page } 
  before(:all) do 
    OmniAuth.config.test_mode = true
    Rails.application.routes.default_url_options[:host] = 'localhost'
  end

  context 'add' do
    let(:company) { FactoryGirl::create(:company) }
    let(:mail) { ActionMailer::Base.deliveries.last }

    before do
      login_company(company.email, company.password)
      visit members_path
      fill_in "Email", with: 'example@email.com'
      click_on "Invite"
    end

    it 'does send invite email to user' do
      expect(ActionMailer::Base.deliveries).not_to be_empty
    end

    it 'does send a links to app with confirmation link' do
      expect(mail.body.to_s).to include "http://"
    end

    it 'allows register into group by clicking the link' do
      log_out
      mail_page = Capybara.string(mail.body.to_s)
      visit mail_page.find('a').text
      expect(page.status_code).to eq 200
    end
  end
end
