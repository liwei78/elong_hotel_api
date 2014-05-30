require "elong_hotel_api/version"
require 'open-uri'
require 'xmlsimple'
class ElongHotelApi
  def initialize(params={})
    cn_url_geo = params[:cn_url_geo] || 'http://api.elong.com/xml/v2.0/hotel/geo_cn.xml'
    en_url_geo = params[:en_url_geo] || 'http://api.elong.com/xml/v2.0/hotel/geo_en.xml'
    lang = params[:lang]||'cn'
    @url_geo =  case lang
                when 'cn'
                  cn_url_geo
                when 'en'
                  en_url_geo
                end
  end

  #城市列表
  #@return Array
  #每个元素是这样的 [name:"北京", id:'0101']
  def cities
    geos.map{|geo|[name:geo['CityName'],id:geo['CityCode']]}
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
        @centers[city_id] << [id: center['Id'],name: center['Name']]
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
        @districts[city_id] << [id: district['Id'], name: district['Name']]
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
        @locations[city_id] << [id: location['Id'], name: location['Name']]
      end
    end
    @locations
  end

  private
  #所有地理位置元素的列表
  def geos
    @geo ||= XmlSimple.xml_in(open @url_geo)['HotelGeoList'].first['HotelGeo']
  end
end