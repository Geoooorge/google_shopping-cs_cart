require 'csv'

feed_products = []
exported_products = CSV.foreach('all_products_10142014.csv', headers: true, col_sep: "\t") do |product|
  feed_products << [product['Product code'], product['Product name']]
end

CSV.open('product_feed.csv', "w") do |csv|
  csv << ['Product ID']

  feed_products.each do |row|
    csv.puts row
  end
end
