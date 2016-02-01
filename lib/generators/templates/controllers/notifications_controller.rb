module Redsys
  class NotificationsController < ApplicationController
    skip_before_filter :verify_authenticity_token

    #
    # Tratamiento para la notificación online
    # - Ds_Response == "0000" => Transacción correcta
    #
    def notification
      json_params = JSON.parse(Base64.strict_decode64(params[:Ds_MerchantParameters]))
      if json_params["Ds_Response"].present? && json_params["Ds_Response"] == "0000"
        status = :ok
      else
        status = :bad_request
      end
      render nothing: true, layout: false, status: status
    end
  end
end