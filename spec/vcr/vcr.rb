VCR.configure do |vcr|
  vcr.cassette_library_dir = 'spec/vcr/fixtures/cassettes'
  vcr.hook_into :webmock
  vcr.configure_rspec_metadata!
end
