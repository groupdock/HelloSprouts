# ===========================================================================
# Project:   HelloSprouts
# Copyright: ©2010 My Company, Inc.
# ===========================================================================

# Add initial buildfile information here
config :all, :required => :sproutcore do |c|
  c[:resources_relative] = true
  c[:url_prefix] = 'http://groupdock.com:8090'
end
