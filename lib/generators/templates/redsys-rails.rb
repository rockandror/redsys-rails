#
# * Valores proporcionados por su entidad financiera
#
Rails.configuration.redsys_rails = {
  url: '',                            # * Url TPV
  sha_256_key: '',                    # * Clave para firma HMAC SHA256
  merchant_code: '',                  # * Código de comercio
  merchant_terminal: '',              # * Terminal
  merchant_transaction_type: '',      # * Tipo de transacción
  merchant_currency: '978',           # * 978: euro, 840: dólares, 826: libras, 392: yenes
  signature_version: 'HMAC_SHA256_V1' # Versión firma HMAC SHA256
}