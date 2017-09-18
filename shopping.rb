require 'csv'
require_relative './category'

class Feed

  def initialize(feed)
    @feed = feed
    @feed_products = []
  end

  def product_active?(product)
    product['Status'] == "A"
  end

  def excluded_product?(product)
    Category::EXCLUDED_SUPPLIER.include?(product['Supplier'])
  end

  def export_feed
    convert_raw_feed
    CSV.open('product_feed.csv', "w") do |csv|
      csv << Category::FEED_HEADER

      @feed_products.each do |row|
        csv.puts row
      end
    end
  end

  def convert_raw_feed
    exported_products = CSV.foreach(@feed, headers: true, col_sep: "\t") do |product|
      if product_active?(product) && !excluded_product?(product)
        @feed_products << [product['Product code'], product['Product name'], product['Description'], product['Product URL'], 'in stock', product['Price'], Category::GOOGLE_PRODUCT_CATEGORY, product['Category'], product['Supplier'], product['Product code'], 'new', product['Internal Notes']]
      end
    end
  end
end

Feed.new('all_products_10142014.csv').export_feed





# Product code	Product name	Status	Description	Category	List price	Price	Quantity	Weight	Min quantity	Shipping freight	Date added	Downloadable	Files	Ship downloadable	Inventory tracking	Out of stock actions	Free shipping	Feature comparison	Zero price action	Internal Notes	Short description	Meta keywords	Meta description	Search words	Page title	Taxes	Localizations	Secondary categories	Supplier	Product Width	Product Height	Product Length	Product Box Width	Product Box Height	Product Box Length	Product Box Weight	Free Shipping Only	Low Price Guarantee	Sample Requests	Available Since	Product Feed Available	SEO name	Internal Price	Internal Dropship Fee	Internal Shipping	Product URL	Image URL
