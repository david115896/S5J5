class ContactsController < ApplicationController
    skip_before_action :only_signed_in, only: [:new, :create]

    def new

    end

    def create
    
    
    end
end