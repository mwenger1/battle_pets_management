module V1
  class TrainersController < ApplicationController
    ERROR_MESSAGE_404 = "record not found"

    before_action :set_trainer, only: [:show, :update, :destroy]

    def index
      @trainers = Trainer.all

      render json: @trainers
    end

    def show
      render json: @trainer
    end

    def create
      @trainer = Trainer.new(trainer_params)

      if @trainer.save
        render json: @trainer, status: :created, location: v1_trainer_url(@trainer)
      else
        render json: @trainer.errors, status: :unprocessable_entity
      end
    end

    def update
      if @trainer.update(trainer_params)
        render json: @trainer
      else
        render json: @trainer.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @trainer.destroy
    end

    private

    def set_trainer
      unless @trainer = Trainer.find_by(name: params[:name])
        render json: {error: ERROR_MESSAGE_404, status: 404}, status: 404
      end
    end

    def trainer_params
      params.require(:trainer).permit(:name, :class)
    end
  end
end
