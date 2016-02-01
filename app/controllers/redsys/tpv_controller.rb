module Redsys
  class TpvController < ApplicationController
    skip_before_filter :verify_authenticity_token, only: [:confirmation]

    #
    # Formulario de salto a la pasarela de pago
    # - amount:decimal => Importe a cobrar
    # - order:integer => identidificador del pedido/reserva, ha de ser único
    # - language:string => '001' Español, '002' Inglés...
    # - url_ok:string => url de vuelta del tpv para pago correcto
    # - url_ko:string => url de vuelta del tpv cuando ocurre un error
    #
    def form
      amount = BigDecimal.new(params[:amount] || '0')
      order = Integer(params[:order] || '0')
      language = params[:language]
      url_ok = params[:url_ok]
      url_ko = params[:url_ko]
      @tpv = Redsys::Tpv.new(amount, order, language, redsys_notification_url, url_ok, url_ko)
    end
    
  end
end