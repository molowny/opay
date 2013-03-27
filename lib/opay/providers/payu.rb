require 'net/http'
require 'uri'

module Opay
  module Providers

    class Payu
      URL = 'https://www.platnosci.pl/paygw'

      def self.process(pos_id, session_id, ts, sig)
      end

      private
      def self.create_sig(*values)
        Digest::MD5.hexdigest(values.join + Opay.config.key1)
      end

      def self.verify_sig(sig, *values)
        sig == Digest::MD5.hexdigest(values.join + Opay.config.key2)
      end
    end

  end
end
