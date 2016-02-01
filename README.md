# Redsys::Rails

Redsys-Rails es una pequeña solución para integrar de forma rápida y sencilla la pasarela de pago de [Redsys.es](http://www.redsys.es/).

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

Por último, configura los parámetros del TPV virutal en [config/initializers/redsys-rails.rb](lib/generators/templates/redsys-rails.rb)

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

## Contribuir

1. Fork ( https://github.com/[my-github-username]/redsys-rails/fork )
2. Crea la rama de tu funcionalidad (`git checkout -b my-new-feature`)
3. Commita tus cambios (`git commit -am 'Add some feature'`)
4. Push a la rama (`git push origin my-new-feature`)
5. Crea un nuevo Pull Request
