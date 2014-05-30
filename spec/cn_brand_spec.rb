require 'spec_helper'

describe ElongHotelApi do
  subject{ElongHotelApi.new(url_brand: $cn_sample_brand)}
  describe '#brands' do
    specify{subject.brands.size.should == 18}
    specify{subject.brands.first.should == [id:"32", name:"如家酒店集团", group_id:"0", short_name:"如家", letters:"RJ"] }
  end
end