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
		get ":id", root:"jsontests" do
			JSON.parse(Jsontest.find_by(id: permitted_params[:id]).config_json)
			
        end
      end
	  
	  
    end
  end
end