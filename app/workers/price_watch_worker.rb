class PriceWatchWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    hourly
  end

  def perform(last_occurence, current_occurence)
    PriceWatch.all.each do |pricewatch|
      if #pricewatch's item for current_occurence != last_occurence ,call PriceWatchMailer
        # needs to do more here
      end
    end
  end
end
