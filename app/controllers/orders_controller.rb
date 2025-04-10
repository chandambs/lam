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
  