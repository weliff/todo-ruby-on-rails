class TasksController < ApplicationController
    def index
        @tasks = Task.all
        @nome = "weliff"
    end
end