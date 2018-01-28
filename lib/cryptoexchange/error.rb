module Cryptoexchange
  class Error < StandardError
  end

  class HttpResponseError < Error
  end

  class HttpConnectionError < Error
  end

  class HttpTimeoutError < Error
  end

  class JsonParseError < Error
  end

  class TypeFormatError < Error
  end
end
