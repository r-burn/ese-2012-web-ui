require 'rubygems'
require 'sinatra'
require 'tilt/haml'
require '../app/models/store/user'
require '../app/models/store/item'
require '../app/controllers/main'
require '../app/controllers/authentication'

class App < Sinatra::Base

  use Authentication
  use Main

  enable :sessions
  set :public_folder, 'app/public'

  configure :development do
    lukas = Store::User.named('Lukas')
    rene = Store::User.named('René')
    remo = Store::User.named('Remo')
    ese = Store::User.named('ese')
    item1 = Store::Item.namedPriced('Gartentisch XL', 100, lukas)
    item2 = Store::Item.namedPriced('DVD', 10, remo)
    item3 = Store::Item.namedPriced('Bett', 50, rene)
    item4 = Store::Item.namedPriced('The Lord Of The Rings', 20, remo)
    item5 = Store::Item.namedPriced('Shoes', 10, ese)
    item1.active = true
    item2.active = true
    item3.active = true
    item4.active = true
    item5.active = true
    lukas.save()
    remo.save()
    rene.save()
    ese.save()
    puts(Store::User.all)

  end

end

# Now, run it
App.run!