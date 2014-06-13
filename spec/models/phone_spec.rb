require 'spec_helper'

describe Phone do
  it "does not allow duplicate phone numbers per contact" do
    contact = create(:contact)
    create(:home_phone, contact: contact, phone: '111-111-111')
    mobile_phone = build(:mobile_phone, contact: contact, phone: '111-111-111')
    expect(mobile_phone).to have(1).errors_on(:phone)
  end

  it "allowes two contacts to share a phone number" do
    create(:home_phone, phone: '222-222-222')
    expect(build(:home_phone, phone: '222-222-222')).to be_valid
  end
end
