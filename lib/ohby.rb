require "uri"
require "httparty"
require "ohby/version"
require "ohby/too_long_error"

# Generate "oh by" codes.
#
# @author Jan Lindblom <janlindblom@fastmail.fm>
# @version 0.1.0
module Ohby
  include HTTParty
  base_uri 'https://0x.co'

  # Generate an "oh by" code from a given payload.
  #
  # See #shorten for valid options of the +expiry+ parameter.
  #
  # @param payload [String] up to 4096 characters
  # @param expiry [String] expiration
  # @param is_public [Boolean] visibility
  # @raise [TooLongError] if the payload is to long.
  def self.code(payload=nil,expiry=0,is_public=true)
    shorten(payload,expiry,is_public,false)
  end

  # Generate an "oh by" redirect from a given payload that is a valid URI.
  #
  # See #shorten for valid options of the +expiry+ parameter.
  #
  # @param payload [String] up to 4096 characters
  # @param expiry [String] expiration
  # @param is_public [Boolean] visibility
  # @raise [TooLongError] if the payload is to long.
  def self.redirect(payload=nil,expiry=0,is_public=true)
    shorten(payload,expiry,is_public,true)
  end

  # Generate an "oh by" code or redirect from a given payload.
  #
  # Valid options for the +expiry+ parameter:
  # - +0+ - never expire
  # - +10m+ - 10 Minutes
  # - +1h+ - 1 Hour
  # - +1D+ - 1 Day
  # - +1W+ - 1 Week
  # - +1M+ - 1 Month
  # - +1Y+ - 1 Year
  #
  # @param payload [String] up to 4096 characters
  # @param expiry [String] expiration
  # @param is_public [Boolean] visibility
  # @raise [TooLongError] if the payload is to long.
  def self.shorten(payload=nil,expiry=0,is_public=true,redirect=false)
    is_url = redirect ? true : false

    begin
      uri = URI.parse(payload)
      if uri.is_a? URI::HTTP or uri.is_a? URI::HTTPS
        is_url = true
      end
    rescue URI::InvalidURIError
      is_url = false
    end

    opts = {
      body: {
        content: payload,
        expiry: expiry,
        public: is_public == true ? 1 : 0
      }
    }

    unless payload.nil?
      raise TooLongError.new("Payload to large, exceds 4096 characters.") if payload.size > 4096

      if redirect == true
        opts[:body][:redirect] = 1
      elsif redirect != false && is_url
        opts[:body][:redirect] = 1
      elsif redirect == false && is_url
        opts[:body][:redirect] = 0
      end

      opts
      #self.class.post("/shorten.html", opts)
    end
  end

end
