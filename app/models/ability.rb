# frozen_string_literal: true

class Ability
  include CanCan::Ability

def initialize(user)

    user ||= User.new 

    if user.role == 'vendor'
      can :create, Order 
      can :index, Order
      can :destroy, Order
      can :update, Order
      can :create, LineItem
      can :update, LineItem
      can :index, LineItem
      can :destroy, LineItem
      

    else
      can :index, Order
      can :index, LineItem
    end
  end
end
