# ElongHotelApi

Elong API http://open.elong.com

## Installation

Add this line to your application's Gemfile:

    gem 'elong_hotel_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elong_hotel_api

## Usage

### 简单用法
```ruby
elong = ElongHotelApi.new
p elong.cities
p elong.districts
p elong.centers
p elong.locations
p elong.brands
```

### 多语言环境用法
```ruby
elong_en = ElongHotelApi.new(lang: 'en')
p elong_en.cities
p elong_en.districts
p elong_en.centers
p elong_en.locations
p elong_en.brands
```

### 读取本地xml文件用法
```ruby
elong = ElongHotelApi.new(cn_url_geo: '/path/to/your/xml')
p elong.cities
p elong.districts
p elong.centers
p elong.locations
p elong.brands
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/elong_hotel_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
