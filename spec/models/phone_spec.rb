require 'spec_helper'

describe Phone do
  it "does not allow duplicate phone numbers per contact" do
    contact = Contact.create( firstname: "Taro",
                              lastname: "Suzuki",
                              email: "suzuki@example.com")
    contact.phones.create(phone_type: "home", phone: "111-111-111")
    mobile_phone = contact.phones.build(phone_type: "mobile", phone: "111-111-111")

    expect(mobile_phone).to have(1).errors_on(:phone)
  end

  it "allowes two contacts to share a phone number" do
    contact = Contact.create( firstname: "Taro",
                              lastname: "Suzuki",
                              email: "suzuki@example.com")
    contact.phones.create(phone_type: "home", phone: "111-111-111")

    other_contact = Contact.new
    other_phone = other_contact.phones.build(phone_type: "home", phone: "111-111-111")
    expect(other_phone).to be_valid
  end
end
