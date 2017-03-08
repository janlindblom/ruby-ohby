require 'uri'
require 'httparty'
require 'ohby/version'
require 'ohby/too_long_error'
require 'ohby/wrong_code_format_error'
require 'ohby/code'

# Generate "oh by" (0x) codes.
#
# @author Jan Lindblom <janlindblom@fastmail.fm>
# @version 0.0.1
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
  # @since 0.0.1
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
  # @since 0.0.1
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
  # @since 0.0.1
  def self.shorten(payload=nil,expiry=0,is_public=true,redirect=false)
    is_url = redirect ? true : false

    # Check if the message is a URL to decide whether or not to set redirect.
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
        public: is_public ? 1 : 0
      }
    }

    unless payload.nil?
      raise TooLongError.new(
        "Payload too long, exceds 4096 characters.") if payload.size > 4096

      if redirect == true
        opts[:body][:redirect] = 1
      elsif redirect != false && is_url
        opts[:body][:redirect] = 1
      elsif redirect == false && is_url
        opts[:body][:redirect] = 0
      end

      opts
      #post("/shorten.html", opts)
    end
  end

  # Look up an existing 0x-code to see what it contains.
  #
  # @param code [String] the code to look up
  def self.lookup(code=nil)
    require 'strscan'
    raise WrongCodeFormatError.new(
      "Bad code format, should be a simple String.") unless code.is_a? String
    raise WrongCodeFormatError.new("Bad code, cannot be nil.") if code.nil?

    # Strip any "0x" from the supplied string.
    payload = code.start_with?("0x") ? code.slice(2..-1) : code

    # Perform lookup by posting to form, this way we get an empty xml back if
    # the code is not found.
    response = post("/lookup_redir.html", { body: { qrdcode: code } })

    code_section = response.gsub(/\n/,'').match(
      /\<script.*id=\"code\".*application\/xml.*\>.*\<\/script\>/)[0]
    scanner = StringScanner.new(code_section)
    scanner.skip(/\<script.*\"application\/xml\"\>/)
    response_xml = scanner.scan_until(/\<\/script\>/)
    response_xml.gsub!(/\<\/script\>/,'').strip!
    require 'rexml/document'
    document = REXML::Document.new "<ohby>" + response_xml + "</ohby>"
    response_hash = {}
    code_object = Ohby::Code.new

    document.root.elements.each do |element|
      setter = element.name.to_s + "="
      case element.name
      when "code", "message", "hash"
        code_object.send(setter, process_text(element))
      when "date"
        code_object.send(setter,
                         process_string_into_datetime(process_text(element)))
      when "expires"
        code_object.send(setter,
                         process_text(element) == "" ?
                         "0" : process_text(element))
      when "visibility", "redirect"
        code_object.send(setter,
                         process_string_into_boolean(process_text(element)))
      end
    end
    code_object
  end

  private

  def self.process_text(element)
    element.has_text? ? element.get_text.to_s : ""
  end

  def self.process_string_into_datetime(text)
    DateTime.parse(text + " PST")
  end

  def self.process_string_into_boolean(text)
    return true if text == "1"
    false
  end

end
