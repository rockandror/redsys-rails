Rails.application.routes.draw do
  get  'redsys_tpv/form' 					=> 'redsys_tpv#form', 				as: :redsys_tpv_form
  post 'redsys_tpv/confirmation' 	=> 'redsys_tpv#confirmation', as: :redsys_tpv_confirmation
end