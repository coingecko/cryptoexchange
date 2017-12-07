require 'spec_helper'

RSpec.describe Cryptoexchange::Models::AccountInfo do
  let(:account_info) { Cryptoexchange::Models::AccountInfo.new(currency: 'btc', address: 'address', market: 'market') }

  it { expect(account_info.currency).to eq 'btc' }
  it { expect(account_info.address).to eq 'address' }
  it { expect(account_info.market).to eq 'market' }
end
