require 'spec_helper'

RSpec.describe Cryptoexchange::Models::OrderBook do
  let(:new_order_book) { described_class.new }
  it { expect(new_order_book.bids).to be_empty }
  it { expect(new_order_book.asks).to be_empty }
end
