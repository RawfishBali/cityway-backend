class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? :super_admin
      can :manage, :all
    elsif user.has_role? :city_admin
      can :manage, City
    elsif user.has_role? :merchant_admin
      can [:read, :update, :destroy], Merchant, admin_id: user.id
      can :manage, Promo, id: (Promo.where('merchant_id in (?)', Merchant.where(admin_id: user.id).map(&:id))).map(&:id)
    end
  end
end
