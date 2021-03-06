require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'date' )
require( 'pry' )
require_relative('../models/game.rb')
require_relative('../models/publisher.rb')
require_relative('../models/sale.rb')
also_reload( '../models/*' )

get '/sales' do
  @sales = Sale.all
  @publishers = Publisher.all
  erb( :"sales/index" )
end

get '/sales/new' do
  @games = Game.all
  erb(:"sales/new")
end

post '/sales' do
  game = Game.find(params[:game_id])
  if game.stock.to_i >= params[:amount].to_i
    sale = Sale.new(params)
    sale.save
    game = sale.game
    game.stock -= params[:amount].to_i
    game.update
    redirect to ('/sales')
  else
    redirect to ('/sales/insufficient')
  end
end

get '/sales/insufficient' do
  erb(:"sales/insufficient")
end

post '/sales/:id/delete' do
  sales = Sale.find(params[:id])
  sales.delete()
  game = sales.game
  game.stock += 1
  game.update
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

get '/sales/filter/publisher' do
  @sales = Sale.all
  @filter = Publisher.find(params[:id])
  erb(:"sales/filter/publisher")
end

get '/sales/filter/genre' do
  @sales = Sale.all
  @filter = params[:genre]
  erb(:"sales/filter/genre")
end
