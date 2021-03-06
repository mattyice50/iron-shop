class CardProcessor
  class ProcessingError < StandardError ; end

  def initialize invoice, token
    @invoice, @token = invoice, token
  end

  def process
    begin
      @customer = get_Stripe_customer @invoice.shopper
      ## apply_coupon
      process_charge! @customer
    rescue Stripe::CardError => e
      raise ProcessingError, e.message
    end
    note_payment
  end

  def get_Stripe_customer shopper
    unless shopper.payment_info.nil?
      customer = Stripe::Customer.retrieve( shopper.payment_info )
    else
      customer = Stripe::Customer.create(
          :email => @invoice.shopper.email,
          :card  => @token
        )
      shopper.payment_info = customer.id
      customer
    end
  end

  def process_charge! customer
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @invoice.amount_in_cents,
      :description => 'Iron Shop customer',
      :currency    => 'usd'
    )
  end

  def note_payment
    @invoice.paid = true
    @invoice.save!
  end

  def send_receipt
    ## InvoiceMailler.receipt(@invoice).deliver
    MailReceiptWorker.perform_async @invoice.id
  end

  def self.token_for_card number
    token = Stripe::Token.create(card: {
      number: number,
      exp_month: 1,
      exp_year:  2015,
      cvc:       '777'
    })
    token.id
  end
  def self.valid_card
    token_for_card '4242424242424242'
  end

  def self.declined_card
    token_for_card '4000000000000002'
  end
end
