require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Novaexchange::Market do
  it { expect(Cryptoexchange::Exchanges::Novaexchange::Market::NAME).to eq 'novaexchange' }
  it { expect(Cryptoexchange::Exchanges::Novaexchange::Market::API_URL).to eq 'https://novaexchange.com/remote/v2' }
end
