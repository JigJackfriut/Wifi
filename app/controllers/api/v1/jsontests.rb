module API
  module V1
    class Jsontests < Grape::API
      include API::V1::Defaults

      resource :jsontests do
		get "", root::jsontests do 
			Jsontest.all
		end
      end
	  
	  
    end
  end
end