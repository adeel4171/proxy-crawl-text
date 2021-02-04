class AmazonLink < ApplicationRecord

  def self.fetch_products
    FetchProductsWorker.perform_async
  end

end
