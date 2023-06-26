module API
  module V1
    class Tests < Grape::API
      include API::V1::Defaults

      resource :wificlients do
        route :get, 'test' do
			#process_hello(params)
		   # puts "Hello! This is the API"
		   # mac = params[:mac]
			#puts "MAC address: #{mac}"
			#client = Wificlient.find_by(mac:mac)
			#if client 
				#render json: {status:"registered"}
			#else
			#render json: {status:"registered"}
		#	end
        end #route end

        #desc "Return a "
        #params do
         # requires :id, type: String, desc: "ID of the 
          #  wificlient"
        #end
        #get ":id", root: "wificlient" do
         # wificlients.where(id: permitted_params[:id]).first!
        #end
      end #resource end
    end # Tests ENd
  end #V1
end #API