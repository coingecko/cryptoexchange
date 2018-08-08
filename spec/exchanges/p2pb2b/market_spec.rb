require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::P2pb2b::Market do
  it { expect(Cryptoexchange::Exchanges::P2pb2b::Market::NAME).to eq 'p2pb2b' }
  it { expect(Cryptoexchange::Exchanges::P2pb2b::Market::API_URL).to eq 'https://p2pb2b.io/api/v2' }
end
