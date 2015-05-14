require 'rails_helper'
require 'support/login.rb'

describe 'Manage company users' do
  include_context 'login'
  subject { page } 
  before(:all) { OmniAuth.config.test_mode = true }

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
      link = %r{http(s*)://(\S*)}.match(mail.body.to_s)[0]
      visit link
      expect(page.status_code).to eq '200'
    end
  end
end
