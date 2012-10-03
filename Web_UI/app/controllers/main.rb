require 'tilt/haml'
require '../app/models/store/user'

class Main < Sinatra::Application

  get '/profiles/:p_owner' do
    redirect '/login' unless session[:name]
    haml :user, :locals => { :time => Time.now ,
                                  :users => Store::User.all,
                                  :us => params[:p_owner]}
  end


  get '/buy/:owner/:item' do
    redirect '/login' unless session[:name]
    owner = Store::User.by_name(params[:owner])
    puts(owner)
    items = owner.items
    puts(items)
    item = items.detect {|i| i.name == params[:item]}
    user = Store::User.by_name(session[:name])
    if user.credits >= item.price  && item.active?
      user.buy(item)
      redirect '/'
    else
      redirect '/error'
    end
  end



  get "/" do

    redirect '/login' unless session[:name]
    puts(Store::User.all)
    user = Store::User.by_name(session[:name])

    haml :list_items, :locals => { :time => Time.now ,
                                      :users => Store::User.all,
                                      :current_user => user,
                                      :current_name => session[:name] }
  end


  get '/error' do
    fail "You cant buy this item"
  end

  post "/" do



  end

end