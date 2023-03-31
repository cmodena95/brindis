class PagesController < ApplicationController
  def home
  end

  def showroom
    @contact = Contact.new
  end

  def quines_somos
  end

  def talleres
    @talleres = Workshop.all
  end

  def eventos
    @events = Event.all.sort_by(&:created_at)
  end
end
