module Redsys
  class TpvController < ApplicationController
    skip_before_filter :verify_authenticity_token, only: [:confirmation]

    #
    # Formulario de salto a la pasarela de pago
    # - amount:decimal => Importe a cobrar
    # - order:integer => identidificador del pedido/reserva, ha de ser único
    # - language:string => '001' Español, '002' Inglés
    #
    def form
      amount = Decimal(params[:amount])
      order = Integer(params[:order])
      language = params[:language]
      @tpv = Redsys::Tpv.new(amount, order, language)
    end
    
  end
end