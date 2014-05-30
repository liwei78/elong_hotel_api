require 'spec_helper'

describe ElongHotelApi,'#objects' do
  subject{ElongHotelApi.new(url_object: $sample_object)}
  specify{subject.objects.first.should == {id:'01704065', updated_at: '2014-05-30 01:57:51', products: '0',status: '0'}}
  specify{subject.objects.size.should == 12}
end


describe ElongHotelApi,'#object' do
  subject{ElongHotelApi.new(url_object: $sample_object).object('01704065')}
  specify{subject.keys.should == [:detail, :rooms, :images, :reviews]}
  specify{subject[:images].first[:Type].should == '6'}
  specify{subject[:detail][:Name].should == '新乡辉县苹果主题酒店'}
  specify{subject[:rooms].first.should == {:Id=>"0002", :Name=>"经济标准间", :Area=>"22", :Floor=>"15-18", :BroadnetAccess=>"1", :BroadnetFee=>"0", :Comments=>"", :Description=>"免费上网,光纤,双床（120cm*200cm）", :BedType=>"双床（120cm*200cm）"}}
  specify{subject[:reviews].first.should == {:Count=>"8", :Good=>"2", :Poor=>"2", :Score=>"50%"}}
end