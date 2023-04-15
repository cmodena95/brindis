class PagesController < ApplicationController
  skip_before_action :authenticate_user!, except: [:dashboard]

  def home
    @cloud_item_left = Item.find_by(position: "Nube izquierda") || nil
    @cloud_item_center = Item.find_by(position: "Nube central") || nil
    @cloud_item_right = Item.find_by(position: "Nube derecha") || nil
    @billboard_item = Billboard.last || nil
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

  def dashboard
  end
end
