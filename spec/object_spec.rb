require 'spec_helper'

describe ElongHotelApi do
  subject{ElongHotelApi.new(url_object: $sample_object)}
  describe '#objects' do
    specify{subject.objects.first.should == [id:'01704065', updated_at: '2014-05-30 01:57:51', products: '0',status: '0']}
    specify{subject.objects.size.should == 12}
  end
end
