require 'rails_helper'

describe CardProcessor do
  before :each do
    @invoice = create :invoice
  end

  it "can remeber a previous customer" do
    @user = create :user
    processor = CardProcessor.new @invoice, CardProcessor.valid_card
    @invoice.shopper = @user
    stripe_user = processor.get_Stripe_customer @user
    expect( stripe_user ).to match processor.get_Stripe_customer @user
  end

  it 'marks the invoice as paid' do
    processor = CardProcessor.new @invoice, CardProcessor.valid_card
    processor.process

    expect( @invoice.paid? ).to be true
  end

  it 'handles declined cards' do
    processor = CardProcessor.new @invoice,  CardProcessor.declined_card
    expect do
      processor.process
    end.to raise_error CardProcessor::ProcessingError

    expect( @invoice.paid? ).to be false
  end
end
