require 'sinatra'
require 'slim'
require 'sinatra/reloader'
require 'sqlite3'

 
post('/fruits/:id/delete') do #delete a fruit
#get fruit
  id = params[:id].to_i

  db = SQLite3::Database.new("db/fruits.db")

  db.execute("DELETE FROM fruits WHERE id = ?", id)
  redirect('/fruits')
end


post('/fruits/:fruit_id') do
  fruit_id = params[:fruit_id]
  "You requested fruit ##{fruit_id}"
end


post('/fruit') do
  new_fruit = params[:new_fruit]
  amount = params[:amount].to_i 

    db = SQLite3::Database.new("db/fruits.db")
    db.execute("INSERT INTO fruits (name, amount) VALUES (?,?)",[new_fruit,amount])
    redirect('/fruits')
end

get('/fruits/:id/edit') do
  db = SQLite3::Database.new("db/fruits.db")
  db.results_as_hash = true
  id = params[:id].to_i
  @special_fruit = db.execute("SELECT * FROM fruits WHERE id = ?", id).first

  #show formula for updating
  slim(:"fruits/edit")
end

post('/fruits/:id/update') do

  id = params[:id].to_i
  name = params[:name]
  amount = params[:amount].to_i

  db = SQLite3::Database.new("db/fruits.db")
  db.execute("UPDATE fruits SET name=?, amount=? WHERE id=?",[name,amount,id])
  redirect('/fruits')
end

get('/fruits') do

  query = params[:q]
  p "Yo skrev #{query}"

  #gör koppling till db
  db = SQLite3::Database.new("db/fruits.db")

  #[{},{},{}] önskar vi oss istället för [[], [],[]]
  db.results_as_hash = true

  #hämta allting från db
  @datafruit = db.execute("SELECT * FROM fruits")    

  p @datafruit

  if query && !query.empty?
    @datafruit = db.execute("SELECT * FROM fruits WHERE name LIKE ?","%#{query}%")
  else
    @datafruit = db.execute("SELECT * FROM fruits")
  end

  #visa med slim
  slim(:"fruits/index")



end

get('/fruits/new') do
    slim(:"fruits/new")

end



