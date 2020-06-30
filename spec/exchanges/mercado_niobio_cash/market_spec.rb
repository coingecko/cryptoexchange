require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::MercadoNiobioCash::Market do
  it { expect(described_class::API_URL).to eq 'https://www.mercadoniobiocash.com.br/public_api/' }
end
