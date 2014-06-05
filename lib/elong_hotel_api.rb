require "elong_hotel_api/version"
require 'open-uri'
require 'xmlsimple'
class ElongHotelApi
  CnUrlGeo    = 'http://api.elong.com/xml/v2.0/hotel/geo_cn.xml'
  EnUrlGeo    = 'http://api.elong.com/xml/v2.0/hotel/geo_en.xml'
  CnUrlBrand  = 'http://api.elong.com/xml/v2.0/hotel/brand_cn.xml'
  EnUrlBrand  = 'http://api.elong.com/xml/v2.0/hotel/brand_en.xml'

  def initialize(params={})
    @lang         = params[:lang]         || 'cn'
    @url_object   = params[:url_object]   || 'http://api.elong.com/xml/v2.0/hotel/hotellist.xml'
    @url_geo      = params[:url_geo]
    @url_brand    = params[:url_brand]

    @url_geo    ||= ElongHotelApi.const_get("#{@lang.capitalize}UrlGeo")
    @url_brand  ||= ElongHotelApi.const_get("#{@lang.capitalize}UrlBrand")
  end

  #单体酒店列表
  #@return Array
  #每个元素是这样的 [id:'01704065', updated_at: '2014-05-30 01:57:51', products: '0',status: '0']
  def objects
    @objects ||= XmlSimple.xml_in(open @url_object)['Hotels'].first['Hotel'].map do |object|
      {
        id: object['HotelId'],
        status: object['Status'],
        updated_at: object['UpdatedTime'],
        products: object['Products']
      }
    end
  end

  #单体酒店详细信息
  #@return Hash
  #共4个key,分别是 :detail, :rooms, :images, :reviews
  def object(id)
    # 原始数据的key分别是["Id", "Detail", "Rooms", "Images", "Review"]
    tmp_object = XmlSimple.xml_in(open object_url(id))
    tmp_images = tmp_object['Images'].first['Image'] || []
    tmp_rooms  = tmp_object['Rooms'].first['Room'] || []
    tmp_detail = tmp_object['Detail'].first || {}
    tmp_reviews = tmp_object['Review'] || []

    detail = {}
    tmp_detail.each do |key,value|
      detail[key.to_sym] = value.first
    end

    rooms = []
    tmp_rooms.each do |room|
      rooms << room.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    end

    images = []
    tmp_images.each do |image|
      images << image.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    end

    reviews = []
    tmp_reviews.each do |review|
      reviews << review.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    end

    {
      detail: detail,
      rooms: rooms,
      images: images,
      reviews: reviews
    }
  end

  #城市列表
  #@return Array
  #每个元素是这样的 [name:"北京", id:'0101']
  def cities
    geos.map{|geo|{name:geo['CityName'],id:geo['CityCode'],parent_id:geo['ProvinceId'],parent_name:geo['ProvinceName']}}
  end

  #商圈列表
  #@return Hash
  #key是cityid 比如 '0101'
  #value是商圈列表 每个元素是这样的 [name:'安贞',id:'010186']
  def centers
    return @centers if @centers
    @centers = {}
    geos.each do |geo|
      city_id = geo['CityCode']
      @centers[city_id] = []
      tmp_centers = geo['CommericalLocations'].first['Location']
      next if tmp_centers.nil?
      tmp_centers.each do |center|
        @centers[city_id] << {id: center['Id'],name: center['Name']}
      end
    end
    @centers
  end

  #行政区列表
  #@return Hash
  #key是cityid 比如 '0101'
  #value是行政区列表 每个元素是这样的 [name:'昌平区',id:'0028']
  def districts
    return @districts if @districts
    @districts = {}
    geos.each do |geo|
      city_id = geo['CityCode']
      @districts[city_id] = []
      tmp_districts = geo['Districts'].first['Location']
      next if tmp_districts.nil?
      tmp_districts.each do |district|
        @districts[city_id] << {id: district['Id'], name: district['Name']}
      end
    end
    @districts
  end


  #地标列表
  #@return Hash
  #key是cityid 比如 '0101'
  #value是地标列表 每个元素是这样的 [name:'东方广场',id:'0005']
  def locations
    return @locations if @locations
    @locations = {}
    geos.each do |geo|
      city_id = geo['CityCode']
      @locations[city_id] = []
      tmp_locations = geo['LandmarkLocations'].first['Location']
      next if tmp_locations.nil?
      tmp_locations.each do |location|
        @locations[city_id] << {id: location['Id'], name: location['Name']}
      end
    end
    @locations
  end

  #品牌列表
  def brands
    XmlSimple.xml_in(open @url_brand)['HotelBrand'].map do |brand|
      {
        id: brand['BrandId'],
        name: brand['Name'],
        group_id: brand['GroupId'],
        short_name: brand['ShortName'],
        letters: brand['Letters']
      }
    end
  end

  private
  #所有地理位置元素的列表
  def geos
    @geo ||= XmlSimple.xml_in(open @url_geo)['HotelGeoList'].first['HotelGeo']
  end

  def object_url(id)
    "http://api.elong.com/xml/v2.0/hotel/#{@lang}/#{id[-2,2]}/#{id}.xml"
  end
end
