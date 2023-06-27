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
			Jsontest.where(id: permitted_params[:id])
        end
      end
	  
	  
    end
  end
end