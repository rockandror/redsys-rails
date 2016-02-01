Rails.application.routes.draw do
  get 'redsys/form' => 'redsys/tpv#form', as: :redsys_form
end