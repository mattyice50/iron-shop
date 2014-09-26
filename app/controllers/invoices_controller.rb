class InvoicesController < ApplicationController
  def show
    @invoice = current_user.invoices.find params[:id]
  end

  def close
    @invoice = current_user.invoices.find params[:id]
    begin
      CardProcessor.new( @invoice, params[:stripeToken] ).process
      flash[:success] = "Your payment was processed successfully"
      current_user.carts.first.clean
    rescue CardProcessor::ProcessingError => e
      flash[:error] = e.message
    end
    redirect_to @invoice
  end
end
