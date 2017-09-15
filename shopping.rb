require 'csv'

feed_header = [
  'id',
  'title',
  'description',
  'link',
  'image_link',
  'availability',
  'price',
  'google_product_category',
  'product_type',
  'brand',
  'mpn',
  'condition',
  'gtin']

feed_products = []
exported_products = CSV.foreach('all_products_10142014.csv', headers: true, col_sep: "\t") do |product|
  feed_products << [product['Product code'], product['Product name'], product['Description'], product['Product URL'], 'in stock', product['Price'], 'Furniture > Baby & Toddler Furniture > Crib & Toddler Bed Accessories', product['Category'], product['Supplier'], product['Product code'], 'new', product['Internal Notes']]
end

CSV.open('product_feed.csv', "w") do |csv|
  csv << feed_header

  feed_products.each do |row|
    csv.puts row
  end
end


# Product code	Product name	Status	Description	Category	List price	Price	Quantity	Weight	Min quantity	Shipping freight	Date added	Downloadable	Files	Ship downloadable	Inventory tracking	Out of stock actions	Free shipping	Feature comparison	Zero price action	Internal Notes	Short description	Meta keywords	Meta description	Search words	Page title	Taxes	Localizations	Secondary categories	Supplier	Product Width	Product Height	Product Length	Product Box Width	Product Box Height	Product Box Length	Product Box Weight	Free Shipping Only	Low Price Guarantee	Sample Requests	Available Since	Product Feed Available	SEO name	Internal Price	Internal Dropship Fee	Internal Shipping	Product URL	Image URL
