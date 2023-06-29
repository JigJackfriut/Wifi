require 'json'
module API
  module V1
    class Jsontests < Grape::API
      include API::V1::Defaults

      resource :jsontests do
	        #route :get, 'hello' do 
		#	Jsontest.all
		#end
	        params do
			requires :id, type: String, desc: "ID of the wificlient"
        end
		post ":id", root:"jsontests" do
			render json: JSON.parse(Jsontest.find_by(id: permitted_params[:id]).config_json)
        end
        puts "JSONTESTS"
        puts "PARAMS #{params}"
			
      end
	  
	  
    end
  end
end
