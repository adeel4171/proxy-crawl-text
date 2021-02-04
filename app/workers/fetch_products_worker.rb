class FetchProductsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def request_page(link)
    puts "Request called #{link}"
    uri = URI('https://api.proxycrawl.com')
    uri.query = URI.encode_www_form({token: 'Bf_2QDo3dblH29islXX5Qw', url: link})
    res = Net::HTTP.get_response(uri)
    puts "Response HTTP Status Code: #{res.code}"
    parsed_response = Nokogiri::HTML(res.body)
    return parsed_response
  end


  def get_element(col)
    column = col.text.gsub(' ','_').gsub("'","").gsub('"','').gsub('/','_').gsub('-','_').gsub("(","_").gsub(")","_").gsub(":","").downcase.squish
    value = col.next_element.children.text.squish
    return [column, value]
  end

  def get_record(row)
    column_name = row.css("th").text.gsub(' ','_').gsub("'","").gsub('"','').gsub('/','_').gsub('-','_').gsub("(","_").gsub(")","_").gsub(":","").downcase.squish rescue "-"
    column_value = row.css("td").text.squish
    [column_name, column_value]
  end


  def perform

    pp = request_page("https://www.amazon.com/")
    all_products = AmazonLink.all

    all_products.each do |product|
      product_id = product[:id]
      link = product[:url]

      data_hash = {}
      page_response =  request_page(link)
      data_hash["title"] = page_response.css("#productTitle").text.squish rescue "-"
      data_hash["ratings"] = page_response.css("#acrCustomerReviewText")[0].text.scan(/\d/).join.to_i rescue "-"
      data_hash["questions_answered"] = page_response.css("#askATFLink").text.scan(/\d/).join.to_i rescue "-"

      if page_response.css("#detailBullets_feature_div").count != 0
        puts "First Category..."
        product_details = page_response.css("#detailBullets_feature_div")[0].css("li")
        product_details.each do |info|
          col = info.css("span.a-text-bold")
          next if col.empty?
          column_name, value = get_element(col.first)
          data_hash["#{column_name}"] = value
        end
      else
        product_details = page_response.css("#prodDetails").css("tr")
        product_details.each do |info|
          column_name, column_value = get_record(info)
          data_hash["#{column_name}"] = column_value
        end
      end
      data_hash["data_source_url"] = link
      puts "data_hash -> #{data_hash}"
      product.update(product_details: data_hash, url: link);
    end
  end
end
