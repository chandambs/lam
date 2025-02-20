class CensusVillagesController < ApplicationController
    def index
      @census_villages = CensusVillage.order(:district, :subdivision, :name).page params[:page]
      @census_villages = @census_villages.where("name ILIKE ?", "%#{params[:name]}%")
      @census_villages = @census_villages.where("subdivision ILIKE ?", "%#{params[:subdivision]}%")
      @census_villages = @census_villages.where("district ILIKE ?", "%#{params[:district]}%")
    end
  
    def show
      @census_village = CensusVillage.find(params[:id])
    end
  
    def new
      @census_village = CensusVillage.new
    end
  
    def create
      @census_village = CensusVillage.new(census_village_params)
      if @census_village.save
        flash[:success] = "Census Village was successfully created."
        redirect_to census_villages_path
      else
        render 'new'
      end
    end
  
    def edit
      @census_village = CensusVillage.find(params[:id])
    end
    
    def update
      @census_village = CensusVillage.find(params[:id])
      
      if @census_village.update(census_village_params)
        flash[:success] = "Census Village was successfully updated."
        redirect_to census_villages_path
      else
        render :edit
      end
    end

    def upload
      file = params[:file]
  
      if file
        CSV.foreach(file.path, headers: true) do |row|
          CensusVillage.create!(
            name: row['name'],
            subdivision: row['subdivision'],
            district: row['district'],
            code: row['code']
          )
        end

        flash[:success] = "CSV file successfully uploaded and processed."
      else
        flash[:error] = "Please upload a valid CSV file."
      end
  
      redirect_to census_villages_path
    end
  
    def destroy
      @census_village = @village.census_villages.find(params[:id])
      @census_village.destroy
      redirect_to census_villages_path, notice: 'CensusVillage was successfully deleted.'
    end
  
    private
  
    def census_village_params
      params.require(:census_village).permit(:code, :name, :subdivision, :district)
    end
  end
  