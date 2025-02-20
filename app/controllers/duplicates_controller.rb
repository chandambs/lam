class DuplicatesController < ApplicationController
    def index
      @village = Village.find(params[:village_id])
      @duplicates = @village.duplicates
    end
  
    def show
      @village = Village.find(params[:village_id])
      @duplicate = @village.duplicates.find(params[:id])
    end
  
    def new
      @village = Village.find(params[:village_id])
      @duplicate = @village.duplicates.build({ :duplicate_village_id => params[:duplicate_village_id]})
    end
  
    def create
      @village = Village.find(params[:village_id])
      @duplicate = @village.duplicates.build(duplicate_params)
      if @duplicate.save
        redirect_to village_duplicates_path(@village), notice: 'Duplicate was successfully created.'
      else
        render :new
      end
    end
  
    def edit
      @village = Village.find(params[:village_id])
      @duplicate = @village.duplicates.find(params[:id])
    end
  
    def update
      @village = Village.find(params[:village_id])
      @duplicate = @village.duplicates.find(params[:id])
      if @duplicate.update(duplicate_params)
        redirect_to village_duplicates_path(@village), notice: 'Duplicate was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @village = Village.find(params[:village_id])
      @duplicate = @village.duplicates.find(params[:id])
      @duplicate.destroy
      redirect_to village_duplicates_path(@village), notice: 'Duplicate was successfully deleted.'
    end
  
    private
  
    def duplicate_params
      params.require(:duplicate).permit(:duplicate_village_id, :duplicate_type)
    end
  end
  