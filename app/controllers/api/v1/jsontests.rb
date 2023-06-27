module API
  module V1
    class Jsontests < Grape::API
      include API::V1::Defaults

      resource :jsontests do
		route :get, 'hello' do 
			Jsontest.all
		end
      end
	  
	  
    end
  end
end