require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Xbit::Market do
  it { expect(Cryptoexchange::Exchanges::Xbit::Market::NAME).to eq 'xbit' }
  it { expect(Cryptoexchange::Exchanges::Xbit::Market::API_URL).to eq 'https://xbit.com.ec/api' }
end
