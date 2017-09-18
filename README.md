# Readme
## CS-Cart Google Shopping Feed Creator
### Setup

Category File
```
Rename 'category_example.rb' file to 'category.rb'

Populate GOOGLE_PRODUCT_CATEGORY with the preferred Google Shopping category.

Populate EXCLUDED_SUPPLIER with any suppliers or brands to be excluded from feed generation.

Populate DEFAULT_CATEGORY with preferred default product category if no 'Secondary categories' value is provided.
```

Shopping File
```
Update Feed('your_csv_file_name').export_feed to contain your filename of exported CSV data
```

In your terminal run:
```
ruby shopping.rb
```
