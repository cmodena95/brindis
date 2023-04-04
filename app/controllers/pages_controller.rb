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
    @events_upcoming = Event.where("date <= ?", Date.today).sort_by(&:date)
    @events_past = Event.where("date >= ?", Date.today).sort_by(&:date)
  end

  def tienda
  end

  def home2
  end
end
