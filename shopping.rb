require 'csv'
require 'pry'
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
    Category::EXCLUDED_SUPPLIER.include?(product['Supplier'].downcase)
  end

  def upc_check(product)
    if product['Internal Notes'].to_i.to_s.length == 12
      return product['Internal Notes'].to_i
    else
      return ''
    end
  end

  def category_check(product)
    if product['Secondary categories'].length == 0
      Category::DEFAULT_CATEGORY
    else
      product['Secondary categories'].gsub('///', ' > ').split(';')[0]
    end
  end

  def image_convert(product)
    product_image = product['Detailed image']
    product_image.gsub("/var/www/vhosts/","https://www.").gsub('/httpdocs','')[/[^#]+/]
  end

  def export_feed
    convert_raw_feed
    CSV.open('product_feed.csv', "w", col_sep: "\t") do |csv|
      csv << Category::FEED_HEADER

      @feed_products.each do |row|
        csv.puts row
      end
    end
  end

  def convert_raw_feed
    exported_products = CSV.foreach(@feed, headers: true, col_sep: "\t") do |product|
      if product_active?(product) && !excluded_product?(product)
        @feed_products << [product['Product code'], product['Product name'], product['Description'], product['Product URL'], image_convert(product), 'in stock', product['Price'], Category::GOOGLE_PRODUCT_CATEGORY, category_check(product), product['Supplier'], product['Product code'], 'new', upc_check(product)]
      end
    end
  end
end

Feed.new('products_export_09182017.csv').export_feed
