require 'spec_helper'

describe ContactMailer do
  let(:taro) { FactoryGirl.create(:contact,
      firstname: 'taro',
      lastname: 'yamada',
      email: 'taro@example.com')
  }

  subject(:sent_mail) { ContactMailer.welcome_email(taro).deliver }

  describe "mail test" do
    it { expect(sent_mail).to be_delivered_from 'noreply@example.com' }
    it { expect(sent_mail).to be_delivered_to 'taro@example.com' }
    it { expect(sent_mail).to have_subject 'welcome to my site.' }
  end

end
