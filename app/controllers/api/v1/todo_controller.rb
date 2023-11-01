module Api
  module V1
    class TodoController < ApiController
      # ApiController VS Application controller
      before_action :find_task, only: %i[update_todo destroy_todo]

      def add_todo
        @task = Task.new(task_params)
        if @task.save
          render json: { status: 'Todo item save' }, status: :ok
        else
          render json: { error: 'Something went wrong.' }, status: :not_found
        end
      end

      def get_todo
        @task = Task.all
        render json: @task
      end

      def update_todo
        @task.update(task_params)
        render json: { status: 'Todo item update' }, status: :ok
      end

      def destroy_todo
        @task.destroy
        render json: { status: 'Todo item deleted' }, status: :ok
      end

      private

      def task_params
        params.require(:todo).permit(:description, :completed)
      end

      def find_task
        @task = Task.find(params[:id])
      end
    end
  end
end
