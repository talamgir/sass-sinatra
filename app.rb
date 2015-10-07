require "sinatra"
require "mandrill"

get '/home' do
	erb :one
end

get '/me' do
	erb :two
end

get '/array' do
	erb :array	
end

get '/oldwebsite' do
	erb :oldwebsite
end

get 'locator' do
		geocoded_by :ip_address,
  	:latitude => :lat, :longitude => :lon
	after_validation :geocode
end

get '/email' do
	erb :email
end

post '/confirm' do 
  puts params.inspect
  message = params["message"]
  mandrill = Mandrill::API.new ENV['rlt8fbn1ZKzqbfNeRkumow']
    message = {
              :subject=> "Reservation Confirmation ",
              :to=> [{
                      :email=> "#{params[:user_email]}",
                      :name=> "Your Experience",
                    }],
              :from_email=> "talamgir@law.gwu.edu",
              :html=> "<html>#{params[:user_input]}," + "you are confirmed for your reservation, your comments were " + "#{params[:user_story]}</html>"
              # :message=> "#{params[:user_name]}," + "you are confirmed for your reservation, your comments were " + "#{params[:user_story]}"
            }
            
  sending = mandrill.messages.send(message)
  puts sending

end



