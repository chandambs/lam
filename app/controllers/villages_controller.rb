class VillagesController < ApplicationController
    def index
      @villages = Village.where("name ILIKE ?", "%#{params[:name]}%")
      @villages = @villages.where("subdivision ILIKE ?", "%#{params[:subdivision]}%")
      @villages = @villages.where("district ILIKE ?", "%#{params[:district]}%")
      @villages = @villages.order(:district, :subdivision, :name).page params[:page]
     
    end
  
    def show
      @village = Village.find(params[:id])
      @similar_villages = Village.with_similar_name(@village)
      @similar_census_villages = CensusVillage.with_similar_name(@village.name)
    end
  
    def new
      @village = Village.new
    end
  
    def create
      @village = Village.new(village_params)
      if @village.save
        flash[:success] = "Village was successfully created."
        redirect_to villages_path
      else
        render 'new'
      end
    end
  
    def edit
      @village = Village.find(params[:id])
      unless params[:census_village_id].nil?
        @village.census_village = CensusVillage.find(params[:census_village_id])
      end
      
    end
  
    def update
      @village = Village.find(params[:id])

      
      if @village.update(village_params)
        flash[:success] = "Village was successfully updated."
        redirect_to villages_path
      else
        render 'edit'
      end
    end

    def upload
      file = params[:file]
      order = nil
      unless params['order_id'].nil? 
        order = Order.find(params['order_id'])
      end

      if file
        CSV.foreach(file.path, headers: true) do |row|
          Village.create!(
            name: row['name'],
            subdivision: row['subdivision'],
            district: row['district'],
            order: order
          )
        end

        flash[:success] = "CSV file successfully uploaded and processed."
      else
        flash[:error] = "Please upload a valid CSV file."
      end
      
      redirect_to order_path(order)
    end
  
    def destroy
      @village = Village.find(params[:id])
      @village.destroy
      redirect_to villages_path
    end
  
    private
  
    def village_params
      params.require(:village).permit(:name, :subdivision, :district, :order_id, :census_village_id, :remarks, :hamlet)
    end
  end
  