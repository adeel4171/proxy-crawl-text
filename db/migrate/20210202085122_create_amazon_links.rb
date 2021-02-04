class CreateAmazonLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :amazon_links do |t|
      t.text :url
      t.json :product_details
      t.timestamps
    end
  end
end
