# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
require 'elong_hotel_api'
path_root = Pathname.new(__dir__)
path_samples = File.join(path_root,'samples')
$cn_sample_geo = File.join(path_samples,'geo_cn.xml')
$en_sample_geo = File.join(path_samples,'geo_en.xml')
$cn_sample_brand = File.join(path_samples,'brand_cn.xml')
$en_sample_brand = File.join(path_samples,'brand_en.xml')
$sample_object = File.join(path_samples,'hotellist.xml')
