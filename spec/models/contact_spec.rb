require 'spec_helper'

describe Contact do
  it "is valid with a firstname, lastname and email" do
    contact = Contact.new( firstname: "Taro",
                           lastname: "Suzuki",
                           email: "suzuki@example.com")
    expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    expect(Contact.new(firstname: nil)).to have(1).errors_on(:firstname)
  end

  it "is invalid without a lastname" do
    expect(Contact.new(lastname: nil)).to have(1).errors_on(:lastname)
  end

  it "is invalid with a duplicate email address" do
    Contact.create(firstname: "Jiro", lastname: "Tanaka", email: "tanaka@example.com")
    contact = Contact.new(firstname: "Saburo", lastname: "Yamada", email: "tanaka@example.com")
    expect(contact).to have(1).errors_on(:email)
  end

  it "returns a contact's full name as a string" do
    contact = Contact.new(firstname: "Taro",
                          lastname: "Suzuki",
                          email: "suzuki@example.com")
    expect(contact.name).to eq("Taro Suzuki")
  end

  describe "filter last name by letter" do

    before do
      @suzuki = Contact.create(firstname: "Taro", lastname: "Suzuki", email: "suzuki@example.com")
      @sayama = Contact.create(firstname: "Jiro", lastname: "Sayama", email: "tanaka@example.com")
      @yamada = Contact.create(firstname: "Saburo", lastname: "Yamada", email: "tanaka@example.com")
    end

    context "matching letters" do
      it { expect(Contact.by_letter("S")).to eq([@sayama, @suzuki]) }
    end

    context "non-matching letters" do
      it  { expect(Contact.by_letter("S")).not_to include(@yamada) }
    end
  end
end
