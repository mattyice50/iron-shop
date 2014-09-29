class PriceWatchWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    hourly
  end

  def perform  # (last_occurence, current_occurence)
    PriceWatch.all.each do |pricewatch|
      # The rest, but this method logic, should work for background workers and checking hourly
      
      # if #pricewatch's item for current_occurence != last_occurence ,call PriceWatchMailer
      #   # needs to do more here
      #   # or without using last_occurence, current_occurence, put another column on price_watches
      #   # and have a boolean to check whether email is sent or not
      #   # Perhaps, have another column called recent prices when a customer clicked and then
      #   # here compare item.price and item.last_price here
      #   if # price changes
      #     PriceWatchMailer.price_alert(item).deliver
      #   end
      # end
    end
  end
end
