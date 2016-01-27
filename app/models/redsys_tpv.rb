require 'openssl'
require 'base64'
require 'json'

class RedsysTpv
  attr_accessor :amount, :language, :order, :currency, :merchant_code, :terminal,
                :transaction_type, :merchant_url, :url_ok, :url_ko, :sha1, :signature

  def initialize(amount, order, language)
    @amount = (amount * 100).to_i.to_s
    @language = (language == :es) ? '001' : '002'
    @order = order.to_s.rjust(4, '0')
    
    @currency = Rails.application.secrets.tpv_merchant_currency
    @merchant_code = Rails.application.secrets.tpv_merchant_code
    @terminal = Rails.application.secrets.tpv_merchant_terminal
    @transaction_type = Rails.application.secrets.tpv_merchant_transaction_type
    
    #@merchant_url = "#{Rails.application.secrets.tpv_merchant_url}?booking_id=#{booking.id}&language=#{I18n.locale}"
  end

  def merchant_params
    Base64.strict_encode64(merchant_params_json)
  end

  def merchant_params_json
    merchant_parameters = { 
      :DS_MERCHANT_AMOUNT => @amount,
      :DS_MERCHANT_ORDER => @order,
      :DS_MERCHANT_MERCHANTCODE => @merchant_code,
      :DS_MERCHANT_CURRENCY => @currency,
      :DS_MERCHANT_TRANSACTIONTYPE => @transaction_type,
      :DS_MERCHANT_TERMINAL => @terminal,
      :DS_MERCHANT_MERCHANTURL => @merchant_url,
      :DS_MERCHANT_URLOK => @url_ok,
      :DS_MERCHANT_URLKO => @url_ko 
    }
    JSON.generate(merchant_parameters)
  end

  def merchant_signature_3des
    Base64.strict_encode64(encrypt_3DES(@order, Base64.strict_decode64(Rails.application.secrets.tpv_sha_256_key)))
  end

  def merchant_signature
    key = Base64.strict_decode64(Rails.application.secrets.tpv_sha_256_key)
    key = encrypt_3DES(@order, key)
    encrypt_mac256(merchant_params, key)
  end

  private

    def encrypt_mac256(data, key)
      Base64.strict_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), key, data))
    end
  
    def encrypt_3DES(data, key)
      cipher = OpenSSL::Cipher::Cipher.new('DES3')
      cipher.encrypt
      cipher.key = key
      cipher.padding = 0
      block_length = 8
      data_str = data
      data_str += "\0" until data_str.bytesize % block_length == 0
      output = cipher.update(data_str)
      output << cipher.final
      output
    end
end