require 'spec_helper'

describe Contact do
  it "has a valid factory" do
    expect(build(:contact)).to be_valid
  end

  it "is valid with a firstname, lastname and email" do
    contact = build(:contact,
      firstname: "Taro",
      lastname: "Suzuki",
      email: "suzuki@example.com")
    expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    contact = build(:contact, firstname: nil)
    expect(contact).to have(1).errors_on(:firstname)
  end

  it "is invalid without a lastname" do
    contact = build(:contact, lastname: nil)
    expect(contact).to have(1).errors_on(:lastname)
  end

  it "is invalid without an email address" do
    contact = build(:contact, email: nil)
    expect(contact).to have(1).errors_on(:email)
  end

  it "is invalid with a duplicate email address" do
    create(:contact, email: "tanaka@example.com")
    contact = build(:contact, email: "tanaka@example.com")
    expect(contact).to have(1).errors_on(:email)
  end

  it "returns a contact's full name as a string" do
    contact = build(:contact, firstname: "Taro", lastname: "DJ")
    expect(contact.name).to eq("Taro DJ")
  end

  it "has three phone numbers" do
    expect(create(:contact).phones.count).to eq(3)
  end

  describe "filter last name by letter" do

    before do
      @suzuki = create(:contact, firstname: "Taro", lastname: "Suzuki", email: "suzuki@example.com")
      @sayama = create(:contact, firstname: "Jiro", lastname: "Sayama", email: "sayama@example.com")
      @yamada = create(:contact, firstname: "Saburo", lastname: "Yamada", email: "yamada@example.com")
    end

    context "matching letters" do
      it { expect(Contact.by_letter("S")).to eq([@sayama, @suzuki]) }
    end

    context "non-matching letters" do
      it  { expect(Contact.by_letter("S")).not_to include(@yamada) }
    end
  end
end
