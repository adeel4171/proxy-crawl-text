ActiveAdmin.register AmazonLink do

  collection_action :fetch_products_ama, method: :post do
    year = params[:dump][:year]
    VehicleModel.sync(year)
    flash[:notice] = "Vehicle models updation in progress for year #{year}"
    redirect_to action: :index
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :url
  #
  # or
  #
  # permit_params do
  #   permitted = [:url]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
