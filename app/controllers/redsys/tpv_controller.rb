module Redsys
  class TpvController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:confirmation]

    #
    # Formulario de salto a la pasarela de pago
    # - amount:decimal => Importe a cobrar
    # - order:string => unique identifier of the order first 4 position should be numbers,
    # the rest up to 12 positions will be ASCII characters from these ranges:
    # 30 (0) - 39 (9), 65 (A) - 90 (Z), 97 (a) - 122 (z)
    # - language:string => '001' Español, '002' Inglés...
    # - url_ok:string => url de vuelta del tpv para pago correcto
    # - url_ko:string => url de vuelta del tpv cuando ocurre un error
    #
    def form
      amount = BigDecimal.new(params[:amount] || '0')
      order = params[:order] || '0'
      language = params[:language]
      url_ok = params[:url_ok]
      url_ko = params[:url_ko]
      merchant_url = params[:merchant_url] || redsys_notification_url if defined?(redsys_notification_url)
      merchant_name = params[:merchant_name]
      product_description = params[:product_description]
      @tpv = Redsys::Tpv.new(amount, order, language, merchant_url, url_ok, url_ko, merchant_name, product_description)
    end
    
  end
end
