require 'spec_helper'

describe ElongHotelApi do
  subject{ElongHotelApi.new(cn_url_brand: $en_sample_brand)}
  describe '#brands' do
    specify{subject.brands.size.should == 11}
    specify{subject.brands.first.should == [id:"32", name:"", group_id:"0", short_name:"Home Inn", letters:"Home Inn"] }
  end
end