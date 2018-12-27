# Redsys::Rails

**Esta no es la gema oficial de redsys para ruby y no esta bajo mantenimiento en la actualidad**

Redsys-Rails es una pequeña solución para integrar de forma rápida y sencilla la pasarela de pago de [Redsys.es](http://www.redsys.es/).

**Importante:** Esta gema está actualmente en fase de desarrollo. Se aceptan todo tipo de sugerencias.

## Requerimientos
- Esta gema solo proporciona las herramientas necesarias para integrar la opción de redirección desde la página web del comercio al TPV virtual contratado.
- Es necesario disponer de las claves de acceso que la entidad financiera habrá proporcionado al comercio para poder instalar esta gema.

## Instalación

Añade la siguiente línea al Gemfile de tu aplicación:

```ruby
gem 'redsys-rails'
```

Ejecuta:

    $ bundle

O instala la gema tu mismo:

    $ gem install redsys-rails

Genera el inicializador ejecutando el generador:

    $ rails g redsys:install

Por último, configura los parámetros del TPV virtual en [config/initializers/redsys-rails.rb](lib/generators/templates/redsys-rails.rb)

## Utilización

En el controlador donde realice el tratamiento de su pedido, una vez obtenido el id único del mismo, 
redireccione al formulario de salto del tpv virtual mediante el siguiente código.

```ruby
redirect_to redsys_form_path(amount: '', order: '', language: '')
```

Un ejemplo:

```ruby
redirect_to redsys_form_path(amount: '20.35', order: '0001', language: '001')
```

#### Códigos de idioma

Castellano-001, Inglés-002, Catalán-003, Francés-004, Alemán-005, Holandés-006, Italiano-007, Sueco-008, Portugués-009,
Valenciano-010, Polaco-011, Gallego-012 y Euskera-013

#### URL de retorno

Si no ha configurado las url's de retorno para transacción correcta y para transacción fallida en el panel de control de su comercio,
puede proporcionarlas en la redirección mediante los parámetros url_ok y url_ko.

Un ejemplo:

```ruby
redirect_to redsys_form_path(amount: '20.35', order: '0001', language: '001', url_ok: 'http://misite.com/pedido_ok', url_ko: 'http://misite.com/pedido_error')
```

#### Datos de prueba

Con sus credenciales de desarrollo puede realizar pruebas con los siguientes datos:

```
# Tarjeta correcta
Num. tarjeta: 4548812049400004
Caducidad:    12/20
Código CVV2:  123
Código CIP:   123456
```

```
# Tarjeta errónea
Num. tarjeta: 1111111111111117
Caducidad:    12/20
```

## Notificación on-line

Instalación del webhook para la notificación online.

    $ rails g redsys:notifications

El módulo es funcional y hace accesible una ruta para que el TPV virtual pueda notificar la transacción. Es aquí donde el comercio
ha de realizar las acciones necesarias, como por ejemplo actualizar el estado de su pedido confirmando el pago.

rails g redsys:notifications que te creará un controlador 'notifications_controller' con una acción post 'notification'. La entidad financiera realizará una llamada a esa ruta cuando el usuario realice el pago, ahí podrás actualizar el pedido, enviar un email al usuario... etc..

Si quieres debuggear lo que ocurre en ese callback te sugiero utilices una aplicación estilo ngrok que te redirecciona localhost a una dirección accesible desde el exterior y en el formulario de salto a la pasarela sustituyas la url de notifications por la generada. Un ejemplo:
redsys_form_path(amount: @amount, order: @order.id, merchant_url: 'http://5696c509.ngrok.io/redsys/notification')

Cuando lo subas a producción acuérdate de quitar el parámetro merchant_url para que pille la url por defecto.

*Falta una explicación más detallada de esta funcionalidad.*

## Contribuir

1. Fork ( https://github.com/[my-github-username]/redsys-rails/fork )
2. Crea la rama de tu funcionalidad (`git checkout -b my-new-feature`)
3. Commita tus cambios (`git commit -am 'Add some feature'`)
4. Push a la rama (`git push origin my-new-feature`)
5. Crea un nuevo Pull Request
