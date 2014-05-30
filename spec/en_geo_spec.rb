require 'spec_helper'

describe ElongHotelApi do
  subject{ElongHotelApi.new(en_url_geo: $en_sample_geo,lang: 'en')}
  describe '#cities' do
    specify{subject.cities.size.should == 3}
    specify{subject.cities.first.should == [name:"Beijing", id:'0101']}
  end

  describe '#districts' do
    specify{subject.districts.size.should == 3}
    specify{subject.districts['0101'].first.should == [name:'Changping',id:'0028']}
  end

  describe '#centers' do
    specify{subject.centers.size.should == 3}
    specify{subject.centers['0101'].first.should == [name:'Anzhen',id:'010186']}
  end

  describe '#locations' do
    specify{subject.locations.size.should == 3}
    specify{subject.locations['0101'].first.should == [id:'0005',name:'Oriental Plaza']}
  end
end