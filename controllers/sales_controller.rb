require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/game.rb')
require_relative('../models/publisher.rb')
require_relative('../models/sale.rb')
also_reload( '../models/*' )

get '/sales' do
  @sales = Sale.all
  erb( :"sales/index" )
end

get '/sales/new' do
  @games = Game.all
  erb(:"sales/new")
end

post '/sales' do
  sale = Sale.new(params)
  sale.save
  redirect to ('/sales')
end

post '/sales/:id/delete' do
  sales = Sale.find(params[:id])
  sales.delete()
  redirect to('/sales')
end

get '/sales/:id/update' do
  @games = Game.all
  @sale = Sale.find(params[:id])
  erb(:"sales/update")
end

post '/sales/:id' do
  sale = Sale.new(params)
  sale.update
  redirect to('/sales')
end
