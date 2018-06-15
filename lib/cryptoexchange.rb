require "cryptoexchange/version"
require "cryptoexchange/credentials"
require "cryptoexchange/client"
require "cryptoexchange/lru_ttl_cache"
require "cryptoexchange/helpers/string_helper"
require "cryptoexchange/helpers/numeric_helper"
require "cryptoexchange/helpers/hash_helper"
require "cryptoexchange/models/ticker"
require "cryptoexchange/models/market_pair"
require "cryptoexchange/services/market"
require "cryptoexchange/services/pairs"
require "cryptoexchange/services/authentication"

path_files = Dir[File.join(File.dirname(__dir__), 'lib', 'cryptoexchange', '**', '*.rb')]

path_files.sort_by!{ |file_name| file_name.downcase }.each do |path|
  require_relative path
end

require "http"
require "lru_redux"
