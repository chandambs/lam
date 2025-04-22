class OrdersController < ApplicationController
    def index
      @orders_all = Order.all
      @orders = @orders_all.page params[:page]
    end
  
    def show
      @order = Order.find(params[:id])
      @villages = @order.villages.order(:district, :subdivision, :name).page params[:page]
    end
  
    def new
      @order = Order.new
    end

    def compare
      @order1 = Order.find(params[:order1_id])
      @order2 = Order.find(params[:order2_id])

    end

    def report
      @order1 = Order.find(params[:order1_id])
      @order2 = Order.find(params[:order2_id])
      @order3 = Order.find(params[:order3_id])
      @order4 = Order.find(params[:order4_id])

      @matching_data = []
      matched_villages_order1 = []
      matched_villages_order2 = []
      matched_villages_order3 = []
      matched_villages_order4 = []

      CensusVillage.find_each do |census_village|
        dupe_villages = Village.with_similar_name(census_village.name, 0).where(order_id: @order1.id).limit(1)
        if dupe_villages.empty?
          matched_village_order1 = nil
        else
          matched_villages_order1 << dupe_villages[0].id
          matched_village_order1= dupe_villages[0].name
        end

        dupe_villages2 = Village.with_similar_name(census_village.name, 0).where(order_id: @order2.id).limit(1)
        if dupe_villages2.empty?
          matched_village_order2 = nil
        else
          matched_villages_order2 << dupe_villages2[0].id
          matched_village_order2= dupe_villages2[0].name
        end

        dupe_villages3 = Village.with_similar_name(census_village.name, 0).where(order_id: @order3.id).limit(1)
        if dupe_villages3.empty?
          matched_village_order3 = nil
        else
          matched_villages_order3 << dupe_villages3[0].id
          matched_village_order3 = dupe_villages3[0].name
        end

        dupe_villages4 = Village.with_similar_name(census_village.name, 0).where(order_id: @order4.id).limit(1)
        if dupe_villages4.empty?
          matched_village_order4 = nil
        else
          matched_villages_order4 << dupe_villages4[0].id
          matched_village_order4= dupe_villages4[0].name
        end

        @matching_data << {
          census_village: census_village.name,
          matched_village_order1: matched_village_order1,
          matched_village_order2: matched_village_order2,
          matched_village_order3: matched_village_order3,
          matched_village_order4: matched_village_order4
        }
      end

      @order1.villages.where.not(id: matched_villages_order1).find_each do |unmatched_village|
        dupe_villages2 = Village.with_similar_name(unmatched_village.name, 0).where(order_id: @order2.id).limit(1)
        if dupe_villages2.empty?
          matched_village_order2 = nil
        else
          matched_villages_order2 << dupe_villages2[0].id
          matched_village_order2= dupe_villages2[0].name
        end

        dupe_villages3 = Village.with_similar_name(unmatched_village.name, 0).where(order_id: @order3.id).limit(1)
        if dupe_villages3.empty?
          matched_village_order3 = nil
        else
          matched_villages_order3 << dupe_villages3[0].id
          matched_village_order3 = dupe_villages3[0].name
        end

        dupe_villages4 = Village.with_similar_name(unmatched_village.name, 0).where(order_id: @order4.id).limit(1)
        if dupe_villages4.empty?
          matched_village_order4 = nil
        else
          matched_villages_order4 << dupe_villages4[0].id
          matched_village_order4= dupe_villages4[0].name
        end

        @matching_data << {
          census_village: nil,
          matched_village_order1: unmatched_village.name,
          matched_village_order2: matched_village_order2,
          matched_village_order3: matched_village_order3,
          matched_village_order4: matched_village_order4
        }
      end
      
      @order2.villages.where.not(id: matched_villages_order2).find_each do |unmatched_village|
        dupe_villages3 = Village.with_similar_name(unmatched_village.name, 0).where(order_id: @order3.id).limit(1)
        if dupe_villages3.empty?
          matched_village_order3 = nil
        else
          matched_villages_order3 << dupe_villages3[0].id
          matched_village_order3 = dupe_villages3[0].name
        end

        dupe_villages4 = Village.with_similar_name(unmatched_village.name, 0).where(order_id: @order4.id).limit(1)
        if dupe_villages4.empty?
          matched_village_order4 = nil
        else
          matched_villages_order4 << dupe_villages4[0].id
          matched_village_order4= dupe_villages4[0].name
        end

        @matching_data << {
          census_village: nil,
          matched_village_order1: nil,
          matched_village_order2: unmatched_village.name,
          matched_village_order3: matched_village_order3,
          matched_village_order4: matched_village_order4
        }
      end

      @order3.villages.where.not(id: matched_villages_order3).find_each do |unmatched_village|
        dupe_villages4 = Village.with_similar_name(unmatched_village.name, 0).where(order_id: @order4.id).limit(1)
        if dupe_villages4.empty?
          matched_village_order4 = nil
        else
          matched_villages_order4 << dupe_villages4[0].id
          matched_village_order4= dupe_villages4[0].name
        end

        @matching_data << {
          census_village: nil,
          matched_village_order1: nil,
          matched_village_order2: nil,
          matched_village_order3: unmatched_village.name,
          matched_village_order4: matched_village_order4
        }
      end

      @order4.villages.where.not(id: matched_villages_order4).find_each do |unmatched_village|
        @matching_data << {
          census_village: nil,
          matched_village_order1: nil,
          matched_village_order2: nil,
          matched_village_order3: nil,
          matched_village_order4: unmatched_village.name
        }
      end
    end

    def create
      @order = Order.new(order_params)
      if @order.save
        flash[:success] = "Order was successfully created."
        redirect_to @order
      else
        render :new
      end
    end
  
    def edit
      @order = Order.find(params[:id])
    end
  
    def update
      @order = Order.find(params[:id])
      if @order.update(order_params)
        flash[:success] = "Order was successfully updated."
        redirect_to orders_path
      else
        render :edit
      end
    end
  
    def destroy
      @order = Order.find(params[:id])
      @order.destroy
      flash[:success] = "Order was successfully deleted."
      redirect_to orders_path
    end
  
    private
  
    def order_params
      params.require(:order).permit(:name, :date)
    end
  end
  