require 'spec_helper'

describe ElongHotelApi do
  subject{ElongHotelApi.new(url_geo: $cn_sample_geo)}
  describe '#cities' do
    specify{subject.cities.size.should == 3}
    specify{subject.cities.first.should == {name:"北京", id:'0101',parent_id:"0100", parent_name: "北京"}}
  end

  describe '#districts' do
    specify{subject.districts.size.should == 3}
    specify{subject.districts['0101'].first.should == {name:'昌平区',id:'0028'}}
  end

  describe '#centers' do
    specify{subject.centers.size.should == 3}
    specify{subject.centers['0101'].first.should == {name:'安贞',id:'010186'}}
  end

  describe '#locations' do
    specify{subject.locations.size.should == 3}
    specify{subject.locations['0101'].first.should == {id:'0005',name:'东方广场'}}
  end
end